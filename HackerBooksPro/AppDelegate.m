//
//  AppDelegate.m
//  HackerBooksPro
//

#import "Settings.h"
#import "AppDelegate.h"
#import "AGTSimpleCoreDataStack.h"
#import "AGFMasterViewController.h"
#import "AGFDetailViewController.h"
#import "AGFInitViewController.h"
#import "AGFBook.h"
#import "AGFTag.h"

@import Foundation;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Se crea una instancia del stack de CoreData
    self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"Model"];
    
    // Se obtiene una instancia del notification center
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *firstTime = [defaults objectForKey:FIRST_TIME_KEY];
    
    if ([firstTime isEqual: @"YES"]) {
        
        // La app ya se ha iniciado y los datos estan en las tablas
        [self displayData];
        [self autoSave];
        
    } else {
        
        // Guardar la propiedad firstTime a YES para indicar que se ha iniciado la app por primera vez
        [defaults setObject:@"YES" forKey:FIRST_TIME_KEY];
        
        // Obtener y parsear los datos
        [self obtainAndParseData:JSON_BOOKS_URL];
        AGFDetailViewController *detailVC = [AGFDetailViewController new];
        self.window.rootViewController = detailVC;
        
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Utils
- (void)obtainAndParseData:(NSString *) url{
    
    // Descargar los datos de la URL en segundo plano
    dispatch_queue_t download = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(download, ^{
        NSURL *resourcesURL = [NSURL URLWithString:url];
        NSData *booksJSON = [NSData dataWithContentsOfURL:resourcesURL];
        
        // Una vez descargado se ejecuta lo siguiente en la cola principal
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *err = nil;
            NSArray *books = [NSJSONSerialization JSONObjectWithData:booksJSON options:NSJSONReadingAllowFragments error:&err];
            
            if (!books) {
                NSLog(@"Error al parsear el JSON: %@", err);
                
            } else {
                
                // Recorrer el diccionario para crear y almacenar los libros
                for (NSDictionary *item in books) {
                    
                    NSArray *authors = [[item objectForKey:@"authors"] componentsSeparatedByString:@","];
                    NSArray *tags = [[item objectForKey:@"tags"] componentsSeparatedByString:@","];
                    
                    [AGFBook bookWithTitle:[item objectForKey:@"title"]
                                    pdfURL:[item objectForKey:@"pdf_url"]
                                  photoURL:[item objectForKey:@"image_url"]
                                   authors:authors
                                      tags:tags
                                   context:self.model.context];
                    
                }
                
                // Guardar contexto
                [self autoSave];
                
                // Mostrar los datos
                [self displayData];
                
            }
        });
    });
    
}

-(void)displayData{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGFTag entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGFTagAttributes.name
                                                          ascending:YES selector:@selector(caseInsensitiveCompare:)]];
    
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                              managedObjectContext:self.model.context
                                                                                sectionNameKeyPath:AGFTagAttributes.name
                                                                                         cacheName:nil];
    AGFMasterViewController *masterVC = [[AGFMasterViewController alloc] initWithFetchedResultsController:results
                                                                                                    style:UITableViewStylePlain];
    
    AGFDetailViewController *detailVC = [AGFDetailViewController new];
    AGFInitViewController *initVC = [AGFInitViewController new];
    BOOL initView = NO;
    
    // Recuperación del último libro en local
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *uri = [defaults objectForKey:BOOK_SELECTED_KEY];

    if (uri != nil) {
        AGFBook *book = [AGFBook objectWithArchivedURIRepresentation:uri context:self.model.context];
        if (book) {
            detailVC = [[AGFDetailViewController alloc] initWithBook:book context:self.model.context];
            initView = YES;
        }
    }
    
    UINavigationController *rightNavController = nil;
    UINavigationController *leftNavController = [[UINavigationController alloc] initWithRootViewController:masterVC];
    if (initView == NO) {
        rightNavController = [[UINavigationController alloc] initWithRootViewController:initVC];
        
    } else {
        rightNavController = [[UINavigationController alloc] initWithRootViewController:detailVC];
        
    }
    
    // Se crea el SplitViewController
    UISplitViewController *splitVC = [UISplitViewController new];
    splitVC.viewControllers = [NSArray arrayWithObjects:leftNavController, rightNavController, nil];
    
    self.window.rootViewController = splitVC;
}

#pragma mark - Save

-(void) autoSave{
    
    if (AUTO_SAVE_MODEL) {
        
        [self.model saveWithErrorBlock:^(NSError *error) {
            NSLog(@"Error al guardar %s \n\n %@", __func__, error);
        }];
        
        [self performSelector:@selector(autoSave)
                   withObject:nil
                   afterDelay:AUTO_SAVE_DELAY_IN_SECONDS];
    }
}
@end

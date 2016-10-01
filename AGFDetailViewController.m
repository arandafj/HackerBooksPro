//
//  AGFDetailViewController.m
//  HackerBooksPro
//

#import "AGFDetailViewController.h"
#import "AGFSimplePDFViewController.h"
#import "AGFNotesViewController.h"
#import "AGFBook.h"
#import "AGFPhoto.h"
#import "AGFAuthor.h"
#import "AGFTag.h"
#import "AGFAnnotation.h"

@interface AGFDetailViewController ()

@property (strong, nonatomic) AGFBook *selectedBook;
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation AGFDetailViewController

#pragma mark - Class Methods
+ (NSString *)favoriteSwitchChangeKey {return @"favoriteSwitchChangeKey";}

#pragma mark -Init
- (id) initWithBook:(AGFBook *) book context:(NSManagedObjectContext *)context{
    
    if (self = [self init]) {
        _selectedBook = book;
        _context = context;
    }
    return self;
}

#pragma mark - View LifeCycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.titleBook.text = self.selectedBook.title;
    self.cover.image = self.selectedBook.photo.photo;
    
    self.authors.text = [[self.selectedBook obtainAuthors] componentsJoinedByString:@","];
    self.tags.text = [[self.selectedBook obtainTags] componentsJoinedByString:@","];
    
    if (self.selectedBook.isFavoriteValue == YES) {
        [self.isFavorite setOn:YES animated:YES];
    } else {
        [self.isFavorite setOn:NO animated:YES];
    }

    self.title = @"Details";
    
}

#pragma mark -Actions
- (IBAction)obtainPDF:(id)sender {
    
    AGFSimplePDFViewController *pdf = [[AGFSimplePDFViewController alloc] initWithBook:self.selectedBook];
    
    [self.navigationController pushViewController:pdf animated:YES];
}

- (IBAction)changeFavorite:(id)sender {
    
    if (self.isFavorite.on  == YES) {
        [self.selectedBook addFavoriteInContext:self.context];
        
    }
    
    if (self.isFavorite.on == NO) {
        [self.selectedBook removeFavoriteInContext:self.context];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[AGFDetailViewController favoriteSwitchChangeKey] object:self];
    
    
}

-(void)downloadCover{
    // Se crea una cola para ejecutar la descarga
    dispatch_queue_t downloadImage = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(downloadImage, ^{
        NSURL *url = [NSURL URLWithString:self.selectedBook.photoURL];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        
        UIImage *img = [UIImage imageWithData:imgData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            AGFPhoto *photo = [AGFPhoto photoWithImage:img
                                        context:self.selectedBook.managedObjectContext];
            
            self.selectedBook.photo = photo;
            
            self.cover.image = photo.photo;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:[AGFDetailViewController favoriteSwitchChangeKey] object:self];
            
            [self.cover setNeedsDisplay];
            
        });
    });

}
- (IBAction)takeNotes:(id)sender {
    
    // Fetch request
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGFAnnotation entityName]];
    req.sortDescriptors = @[[NSSortDescriptor
                             sortDescriptorWithKey:AGFAnnotationAttributes.title
                             ascending:YES],
                            [NSSortDescriptor
                             sortDescriptorWithKey:AGFAnnotationAttributes.modificationDate
                             ascending:NO],
                            [NSSortDescriptor
                             sortDescriptorWithKey:AGFAnnotationAttributes.creationDate
                             ascending:NO]];
    
    req.predicate = [NSPredicate predicateWithFormat:@"book == %@", self.selectedBook];
    
    // Fetched Results Controller
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.selectedBook.managedObjectContext
                                      sectionNameKeyPath:nil
                                      cacheName:nil];
    
    // Layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(140, 150);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // View controller
    AGFNotesViewController *notes = [AGFNotesViewController coreDataCollectionViewControllerWithFetchedResultsController:fc
                                                                                                                  layout:layout];
    notes.book = self.selectedBook;
    
    [self.navigationController pushViewController:notes
                                         animated:YES];
}


@end

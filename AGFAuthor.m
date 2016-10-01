#import "AGFAuthor.h"

@interface AGFAuthor ()

// Private interface goes here.

@end

@implementation AGFAuthor

#pragma mark - Class Methods
+(instancetype) authorWithString:(NSString *)author
                         context:(NSManagedObjectContext *)context {
    
    AGFAuthor *auth = nil;
    
    //Se comprueba si ya existe el autor
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGFAuthor entityName]];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name == %@", author];
    req.predicate = pred;
    
    NSError *err = nil;
    NSArray *results = [context executeFetchRequest:req
                                              error:&err];
    
    if (err) {
        NSLog(@"Error al recuperar el autor");
        return nil;
    }
    
    //Si no existe, se crea el autor
    if (results.count == 0) {
        auth = [NSEntityDescription insertNewObjectForEntityForName:[AGFAuthor entityName]
                                             inManagedObjectContext:context];
        auth.name = author;
    } else {
        //Si ya existe, se recupera y se retorna
        auth = (AGFAuthor *)results[0];
    }
    
    return auth;
}

@end

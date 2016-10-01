#import "AGFBook.h"
#import "AGFAuthor.h"
#import "AGFTag.h"

@interface AGFBook ()

// Private interface goes here.

@end

@implementation AGFBook

#pragma mark - Class Methods

+(instancetype) bookWithTitle:(NSString *)title
                       pdfURL:(NSString *)pdfURL
                     photoURL:(NSString *)photoURL
                      authors:(NSArray *)authors
                         tags:(NSArray *)tags
                      context:(NSManagedObjectContext *)context {
    
    AGFBook *book = [NSEntityDescription insertNewObjectForEntityForName:[AGFBook entityName]
                                                  inManagedObjectContext:context];
    
    book.title = title;
    book.pdfURL = pdfURL;
    book.photoURL = photoURL;
    
    
    //Se agregan los tags y los autores al libro. De la inversa ya se encarga CoreData
    for (NSString *author in authors) {
        AGFAuthor *auth = [AGFAuthor authorWithString:author context:context];
        [book addAuthorsObject:auth];
    }
    
    for (NSString *tag in tags) {
        AGFTag *t = [AGFTag tagWithString:tag context:context];
        [book addTagsObject:t];
    }
    
    return book;
    
}

+(instancetype) objectWithArchivedURIRepresentation:(NSData *)archivedURI
                                            context:(NSManagedObjectContext *)context {
    
    NSURL *uri = [NSKeyedUnarchiver unarchiveObjectWithData:archivedURI];
    if (uri == nil) {
        return nil;
    }
    
    NSManagedObjectID *nid = [context.persistentStoreCoordinator managedObjectIDForURIRepresentation:uri];
    
    if (nid == nil) {
        return nil;
    }
    
    NSManagedObject *obj = [context objectWithID:nid];
    if (obj.isFault) {
        return (AGFBook *)obj;
    } else {
        NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:obj.entity.name];
        req.predicate = [NSPredicate predicateWithFormat:@"SELF = %@", obj];
        
        NSError *err;
        NSArray *res = [context executeFetchRequest:req
                                              error:&err];
        
        if (res == nil) {
            return nil;
        } else {
            return res.lastObject;
        }
    }
    
}
#pragma mark - Utils
-(NSArray *)obtainAuthors{
    
    NSMutableArray *authorsArray = [NSMutableArray new];
    
    for (AGFAuthor *detail in self.authors) {
        [authorsArray addObject:detail.name];
    }
    
    return authorsArray;
    
}
-(NSArray *)obtainTags{
    
    NSMutableArray *tagsArray = [NSMutableArray new];
    
    for (AGFTag *detail in self.tags) {
        
        NSString *formatName = detail.name;
        formatName = [formatName stringByReplacingOccurrencesOfString:@"Z" withString:@" "];
        formatName = [formatName stringByReplacingOccurrencesOfString:@"A" withString:@" "];
        
        [tagsArray addObject:formatName];
    }
    
    return tagsArray;
    
}

-(void)addFavoriteInContext:(NSManagedObjectContext *)context{
    
    //Se crea el Tag de favoritos
    AGFTag *tag = [AGFTag tagWithString:@"favorites" context:self.managedObjectContext];
    
    //Se agrega el libro al tag de favoritos
    [self addTagsObject:tag];
    self.isFavoriteValue = YES;
}

-(void)removeFavoriteInContext:(NSManagedObjectContext *)context{
    
    //Se elimina el libro del tag de favoritos
    NSArray *results = [AGFTag obtainTagByName:@"Afavorites" context:self.managedObjectContext];
    AGFTag *favorite = (AGFTag *)results[0];
    [self removeTagsObject:favorite];
    if (favorite.books.count == 0) {
        [self.managedObjectContext deleteObject:favorite];
    }
    self.isFavoriteValue = NO;
    
}

-(NSData *)archiveURIRepresentation{
    
    NSURL *uri = self.objectID.URIRepresentation;
    return [NSKeyedArchiver archivedDataWithRootObject:uri];
    
}
@end

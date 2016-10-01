#import "AGFTag.h"

@interface AGFTag ()

// Private interface goes here.

@end

@implementation AGFTag

#pragma mark - Class Methods
+(instancetype) tagWithString:(NSString *)tag
                      context:(NSManagedObjectContext *)context {
    
    AGFTag *t = nil;
    
    //Se elimina el caracter en blanco del principio del String
    if ([tag hasPrefix:@" "]) {
        tag = [tag substringFromIndex:1];
    }
    
    if ([tag isEqualToString:@"favorites"]) {
        tag = [@"A" stringByAppendingString:tag];
    } else {
        tag = [@"Z" stringByAppendingString:tag];
    }
    
    // Se comprueba si ya existe el tag
    NSArray *results = [AGFTag obtainTagByName:tag
                                       context:context];
    
    // Si no existe, se crea el tag
    if (results.count == 0) {
        t = [NSEntityDescription insertNewObjectForEntityForName:[AGFTag entityName]
                                          inManagedObjectContext:context];
        t.name = tag;
    } else {
        // Si ya existe, se recupera y se retorna
        t = (AGFTag *)results[0];
    }
    
    return t;
}

+(NSArray *)obtainTagByName:(NSString *)name context:(NSManagedObjectContext *)context{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGFTag entityName]];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name == %@", name];
    req.predicate = pred;
    
    NSError *err = nil;
    NSArray *results = [context executeFetchRequest:req
                                              error:&err];
    
    if (err){
        NSLog(@"Error al recuperar tag");
        return nil;
    } else {
        return results;
    }
    
}

@end

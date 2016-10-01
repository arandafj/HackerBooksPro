#import "AGFPhoto.h"
#import "AGFBook.h"

@interface AGFPhoto ()

// Private interface goes here.

@end

@implementation AGFPhoto

#pragma mark - Properties
-(void)setPhoto:(UIImage *)photo {
    
    //Sincronizar con photoData
    self.photoData = UIImagePNGRepresentation(photo);
    
}

-(UIImage *) photo{
    
    return [UIImage imageWithData:self.photoData];
    
}

#pragma mark - Class Methods
+(instancetype) photoWithImage:(UIImage *)image
                       context:(NSManagedObjectContext *)context{
    
    AGFPhoto *p = [NSEntityDescription insertNewObjectForEntityForName:[AGFPhoto entityName]
                                                      inManagedObjectContext:context];
    
    p.photoData = UIImageJPEGRepresentation(image, 0.9);
    
    return p;
    
}

@end

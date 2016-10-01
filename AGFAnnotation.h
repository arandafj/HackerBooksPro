#import "_AGFAnnotation.h"

@interface AGFAnnotation : _AGFAnnotation {}

@property (nonatomic, readonly) BOOL hasLocation;

+(instancetype) annotationWithTitle:(NSString *)title
                               book:(AGFBook *)book
                            context:(NSManagedObjectContext *)context;

@end

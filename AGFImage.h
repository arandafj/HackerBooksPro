#import "_AGFImage.h"
@import UIKit;

@interface AGFImage : _AGFImage {}

@property (strong, nonatomic) UIImage *img;

+(instancetype) annotationPhotoWithImage:(UIImage *)image
                                 context:(NSManagedObjectContext *)context;

@end

#import "_AGFPhoto.h"
@import UIKit;

@interface AGFPhoto : _AGFPhoto {}

@property (strong, nonatomic) UIImage *photo;

+(instancetype) photoWithImage:(UIImage *)image
                       context:(NSManagedObjectContext *)context;

@end

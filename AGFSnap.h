#import "_AGFSnap.h"

@class AGFLocation;
@import UIKit;

@interface AGFSnap : _AGFSnap {}

@property (nonatomic, strong) UIImage *image;

+(instancetype) mapSnapshotForLocation:(AGFLocation*) location;

@end

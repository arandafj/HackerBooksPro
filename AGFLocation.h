#import "_AGFLocation.h"

@class AGFAnnotation;

@import CoreLocation;
@import MapKit;

@interface AGFLocation : _AGFLocation <MKAnnotation> {}

+(instancetype) locationWithCLLocation:(CLLocation*)location forAnnotation:(AGFAnnotation *) note;

@end

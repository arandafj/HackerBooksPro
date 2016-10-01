//
//  AGFLocationViewController.h
//  HackerBooksPro
//

#import <UIKit/UIKit.h>
@class AGFLocation;
@import MapKit;

@interface AGFLocationViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

-(id)initWithLocation:(AGFLocation *)location;

- (IBAction)standardMap:(id)sender;
- (IBAction)satelliteMap:(id)sender;
- (IBAction)HybridMap:(id)sender;

@end

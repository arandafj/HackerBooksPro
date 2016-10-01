//
//  AGFLocationViewController.m
//  HackerBooksPro
//

#import "AGFLocationViewController.h"
#import "AGFLocation.h"

@interface AGFLocationViewController ()
@property (nonatomic, strong) AGFLocation *model;
@end

@implementation AGFLocationViewController

-(id)initWithLocation:(AGFLocation *)location{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = location;
    }
    return self;
}

- (IBAction)standardMap:(id)sender {
    self.mapView.mapType = MKMapTypeStandard;
}

- (IBAction)satelliteMap:(id)sender {
    self.mapView.mapType = MKMapTypeSatellite;
}

- (IBAction)HybridMap:(id)sender {
    self.mapView.mapType = MKMapTypeHybrid;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Se añade a mapview
    [self.mapView addAnnotation:self.model];
    
    MKCoordinateRegion big = MKCoordinateRegionMakeWithDistance(self.model.coordinate, 2000000, 2000000);
    [self.mapView setRegion:big];
    
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // Cambiamos la región con animación
    MKCoordinateRegion small = MKCoordinateRegionMakeWithDistance(self.model.coordinate, 500, 500);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mapView setRegion:small animated:YES];
    });
}
@end

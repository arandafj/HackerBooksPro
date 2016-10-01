#import "AGFAnnotation.h"
#import "AGFLocation.h"

@import CoreLocation;

@interface AGFAnnotation () <CLLocationManagerDelegate>
// Private interface goes here.

@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation AGFAnnotation
@synthesize locationManager=_locationManager;

-(BOOL)hasLocation{
    return (nil != self.location);
}

#pragma mark - Class Methods
+(instancetype) annotationWithTitle:(NSString *)title
                               book:(AGFBook *)book
                            context:(NSManagedObjectContext *)context {
    
    AGFAnnotation *annotation = [NSEntityDescription insertNewObjectForEntityForName:[AGFAnnotation entityName]
                                                              inManagedObjectContext:context];
    
    annotation.title = title;
    annotation.creationDate = [NSDate date];
    annotation.modificationDate = [NSDate date];
    annotation.book = book;
    
    return annotation;
    
}

#pragma mark - Init
-(void) awakeFromInsert{
    [super awakeFromInsert];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (((status == kCLAuthorizationStatusAuthorizedAlways) || (status == kCLAuthorizationStatusNotDetermined) || (status == kCLAuthorizationStatusAuthorizedWhenInUse))
        && [CLLocationManager locationServicesEnabled]) {
        
        // Tenemos acceso a localización
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.locationManager.distanceFilter=kCLDistanceFilterNone;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startMonitoringSignificantLocationChanges];
        [self.locationManager setPausesLocationUpdatesAutomatically:NO];
        [self.locationManager startUpdatingLocation];
        
        // Se para el locationManager
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self zapLocationManager];
        });
    }
    
}

#pragma mark - CLLocationManagerDelegate
-(void) locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    
    // Paramos location manager, que consume mucha bateria
    [self zapLocationManager];
    
    if (self.location == nil) {
        // Cogemos la última
        CLLocation *loc = [locations lastObject];
        
        // Creamos una location
        self.location = [AGFLocation locationWithCLLocation:loc
                                              forAnnotation:self];
    }else{
        NSLog(@"No debe ocurrir");
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"Fallo en el location");
}

#pragma mark - Utils
-(void)zapLocationManager{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}

@end

#import "AGFLocation.h"
#import "AGFAnnotation.h"
#import "AGFSnap.h"

@import AddressBookUI;

@interface AGFLocation ()

// Private interface goes here.

@end

@implementation AGFLocation

+(instancetype) locationWithCLLocation:(CLLocation*)location forAnnotation:(AGFAnnotation *)note{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGFLocation entityName]];
    NSPredicate *latitude = [NSPredicate predicateWithFormat:@"abs(latitude) - abs(%lf) < 0.001",
                             location.coordinate.latitude];
    NSPredicate *longitude = [NSPredicate predicateWithFormat:@"abs(longitude) - abs(%lf) < 0.001",
                              location.coordinate.longitude];
    req.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitude, longitude]];
    
    NSError *err;
    NSArray *results = [note.managedObjectContext executeFetchRequest:req
                                                                error:&err];
    
    NSAssert(results, @"¡Error al buscar una AGTLocation!");
    
    if ([results count]) {
        
        // Aprovechamos lo encontrado
        AGFLocation *found = [results lastObject];
        [found addAnnotationsObject:note];
        return found;
        
    }else{
        // Creamos uno de cero
        AGFLocation *loc = [self insertInManagedObjectContext:note.managedObjectContext];
        loc.latitudeValue = location.coordinate.latitude;
        loc.longitudeValue = location.coordinate.longitude;
        [loc addAnnotationsObject:note];
        
        // Dirección
        CLGeocoder *coder = [[CLGeocoder alloc]init];
        [coder reverseGeocodeLocation:location
                    completionHandler:^(NSArray *placemarks, NSError *error) {
                        
                        if (error) {
                            NSLog(@"Error while obtaining address!\n%@", error);
                        }else{
                            loc.address = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
                            NSLog(@"Address is %@", loc.address);
                        }
                    }];
        
        // Snapshot
        loc.snap = [AGFSnap mapSnapshotForLocation:loc];
        
        return loc;
    }
}


#pragma mark - MKAnnotation
-(NSString*) title{
    return @"I wrote a note here!";
}

-(NSString *) subtitle{
    NSArray *lines = [self.address componentsSeparatedByString:@"\n"];
    NSMutableString *concat = [@"" mutableCopy];
    for (NSString *line in lines) {
        [concat appendFormat:@"%@ ", line];
    }
    
    return concat;
}

-(CLLocationCoordinate2D)coordinate{
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(self.latitudeValue, self.longitudeValue);
    return coord;
}
@end

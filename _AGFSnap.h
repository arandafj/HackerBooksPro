// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFSnap.h instead.

#import <CoreData/CoreData.h>

extern const struct AGFSnapAttributes {
	__unsafe_unretained NSString *snapshotData;
} AGFSnapAttributes;

extern const struct AGFSnapRelationships {
	__unsafe_unretained NSString *location;
} AGFSnapRelationships;

@class AGFLocation;

@interface AGFSnapID : NSManagedObjectID {}
@end

@interface _AGFSnap : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGFSnapID* objectID;

@property (nonatomic, strong) NSData* snapshotData;

//- (BOOL)validateSnapshotData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGFLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@end

@interface _AGFSnap (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveSnapshotData;
- (void)setPrimitiveSnapshotData:(NSData*)value;

- (AGFLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(AGFLocation*)value;

@end

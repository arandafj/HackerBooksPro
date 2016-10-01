// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFPhoto.h instead.

#import <CoreData/CoreData.h>

extern const struct AGFPhotoAttributes {
	__unsafe_unretained NSString *photoData;
} AGFPhotoAttributes;

extern const struct AGFPhotoRelationships {
	__unsafe_unretained NSString *book;
} AGFPhotoRelationships;

@class AGFBook;

@interface AGFPhotoID : NSManagedObjectID {}
@end

@interface _AGFPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGFPhotoID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGFBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _AGFPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhotoData;
- (void)setPrimitivePhotoData:(NSData*)value;

- (AGFBook*)primitiveBook;
- (void)setPrimitiveBook:(AGFBook*)value;

@end

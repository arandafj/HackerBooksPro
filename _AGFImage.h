// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFImage.h instead.

#import <CoreData/CoreData.h>

extern const struct AGFImageAttributes {
	__unsafe_unretained NSString *imageData;
} AGFImageAttributes;

extern const struct AGFImageRelationships {
	__unsafe_unretained NSString *annotacion;
} AGFImageRelationships;

@class AGFAnnotation;

@interface AGFImageID : NSManagedObjectID {}
@end

@interface _AGFImage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGFImageID* objectID;

@property (nonatomic, strong) NSData* imageData;

//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGFAnnotation *annotacion;

//- (BOOL)validateAnnotacion:(id*)value_ error:(NSError**)error_;

@end

@interface _AGFImage (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (AGFAnnotation*)primitiveAnnotacion;
- (void)setPrimitiveAnnotacion:(AGFAnnotation*)value;

@end

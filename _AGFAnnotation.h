// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFAnnotation.h instead.

#import <CoreData/CoreData.h>

extern const struct AGFAnnotationAttributes {
	__unsafe_unretained NSString *creationDate;
	__unsafe_unretained NSString *modificationDate;
	__unsafe_unretained NSString *text;
	__unsafe_unretained NSString *title;
} AGFAnnotationAttributes;

extern const struct AGFAnnotationRelationships {
	__unsafe_unretained NSString *book;
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *location;
} AGFAnnotationRelationships;

@class AGFBook;
@class AGFImage;
@class AGFLocation;

@interface AGFAnnotationID : NSManagedObjectID {}
@end

@interface _AGFAnnotation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGFAnnotationID* objectID;

@property (nonatomic, strong) NSDate* creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* modificationDate;

//- (BOOL)validateModificationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGFBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGFImage *image;

//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGFLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@end

@interface _AGFAnnotation (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;

- (NSDate*)primitiveModificationDate;
- (void)setPrimitiveModificationDate:(NSDate*)value;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (AGFBook*)primitiveBook;
- (void)setPrimitiveBook:(AGFBook*)value;

- (AGFImage*)primitiveImage;
- (void)setPrimitiveImage:(AGFImage*)value;

- (AGFLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(AGFLocation*)value;

@end

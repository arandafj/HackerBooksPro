// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFTag.h instead.

#import <CoreData/CoreData.h>

extern const struct AGFTagAttributes {
	__unsafe_unretained NSString *name;
} AGFTagAttributes;

extern const struct AGFTagRelationships {
	__unsafe_unretained NSString *books;
} AGFTagRelationships;

@class AGFBook;

@interface AGFTagID : NSManagedObjectID {}
@end

@interface _AGFTag : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGFTagID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _AGFTag (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(AGFBook*)value_;
- (void)removeBooksObject:(AGFBook*)value_;

@end

@interface _AGFTag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end

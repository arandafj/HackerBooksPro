// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFAuthor.h instead.

#import <CoreData/CoreData.h>

extern const struct AGFAuthorAttributes {
	__unsafe_unretained NSString *name;
} AGFAuthorAttributes;

extern const struct AGFAuthorRelationships {
	__unsafe_unretained NSString *books;
} AGFAuthorRelationships;

@class AGFBook;

@interface AGFAuthorID : NSManagedObjectID {}
@end

@interface _AGFAuthor : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGFAuthorID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _AGFAuthor (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(AGFBook*)value_;
- (void)removeBooksObject:(AGFBook*)value_;

@end

@interface _AGFAuthor (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end

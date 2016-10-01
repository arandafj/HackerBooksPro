// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFPDF.h instead.

#import <CoreData/CoreData.h>

extern const struct AGFPDFAttributes {
	__unsafe_unretained NSString *pdfData;
} AGFPDFAttributes;

extern const struct AGFPDFRelationships {
	__unsafe_unretained NSString *book;
} AGFPDFRelationships;

@class AGFBook;

@interface AGFPDFID : NSManagedObjectID {}
@end

@interface _AGFPDF : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGFPDFID* objectID;

@property (nonatomic, strong) NSData* pdfData;

//- (BOOL)validatePdfData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGFBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _AGFPDF (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePdfData;
- (void)setPrimitivePdfData:(NSData*)value;

- (AGFBook*)primitiveBook;
- (void)setPrimitiveBook:(AGFBook*)value;

@end

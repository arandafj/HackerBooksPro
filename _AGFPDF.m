// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFPDF.m instead.

#import "_AGFPDF.h"

const struct AGFPDFAttributes AGFPDFAttributes = {
	.pdfData = @"pdfData",
};

const struct AGFPDFRelationships AGFPDFRelationships = {
	.book = @"book",
};

@implementation AGFPDFID
@end

@implementation _AGFPDF

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PDF" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PDF";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PDF" inManagedObjectContext:moc_];
}

- (AGFPDFID*)objectID {
	return (AGFPDFID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic pdfData;

@dynamic book;

@end


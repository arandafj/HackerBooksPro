// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFAnnotation.m instead.

#import "_AGFAnnotation.h"

const struct AGFAnnotationAttributes AGFAnnotationAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.text = @"text",
	.title = @"title",
};

const struct AGFAnnotationRelationships AGFAnnotationRelationships = {
	.book = @"book",
	.image = @"image",
	.location = @"location",
};

@implementation AGFAnnotationID
@end

@implementation _AGFAnnotation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Annotation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Annotation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:moc_];
}

- (AGFAnnotationID*)objectID {
	return (AGFAnnotationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic text;

@dynamic title;

@dynamic book;

@dynamic image;

@dynamic location;

@end


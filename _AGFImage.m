// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFImage.m instead.

#import "_AGFImage.h"

const struct AGFImageAttributes AGFImageAttributes = {
	.imageData = @"imageData",
};

const struct AGFImageRelationships AGFImageRelationships = {
	.annotacion = @"annotacion",
};

@implementation AGFImageID
@end

@implementation _AGFImage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Image";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Image" inManagedObjectContext:moc_];
}

- (AGFImageID*)objectID {
	return (AGFImageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic imageData;

@dynamic annotacion;

@end


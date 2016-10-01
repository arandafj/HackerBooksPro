// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFPhoto.m instead.

#import "_AGFPhoto.h"

const struct AGFPhotoAttributes AGFPhotoAttributes = {
	.photoData = @"photoData",
};

const struct AGFPhotoRelationships AGFPhotoRelationships = {
	.book = @"book",
};

@implementation AGFPhotoID
@end

@implementation _AGFPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Photo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:moc_];
}

- (AGFPhotoID*)objectID {
	return (AGFPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic photoData;

@dynamic book;

@end


// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGFSnap.m instead.

#import "_AGFSnap.h"

const struct AGFSnapAttributes AGFSnapAttributes = {
	.snapshotData = @"snapshotData",
};

const struct AGFSnapRelationships AGFSnapRelationships = {
	.location = @"location",
};

@implementation AGFSnapID
@end

@implementation _AGFSnap

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Snap" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Snap";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Snap" inManagedObjectContext:moc_];
}

- (AGFSnapID*)objectID {
	return (AGFSnapID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic snapshotData;

@dynamic location;

@end


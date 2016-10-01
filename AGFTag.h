#import "_AGFTag.h"

@interface AGFTag : _AGFTag {}

+(instancetype) tagWithString:(NSString *)tag
                      context:(NSManagedObjectContext *)context;

+(NSArray *)obtainTagByName:(NSString *)name context:(NSManagedObjectContext *)context;

@end

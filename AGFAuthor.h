#import "_AGFAuthor.h"

@interface AGFAuthor : _AGFAuthor {}

+(instancetype) authorWithString:(NSString *)author
                         context:(NSManagedObjectContext *)context;

@end

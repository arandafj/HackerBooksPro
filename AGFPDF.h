#import "_AGFPDF.h"

@interface AGFPDF : _AGFPDF {}

+(instancetype) pdfWithData:(NSData *)data
                    context:(NSManagedObjectContext *)context;

@end

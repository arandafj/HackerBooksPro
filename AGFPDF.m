#import "AGFPDF.h"

@interface AGFPDF ()

// Private interface goes here.

@end

@implementation AGFPDF

#pragma mark - Class Methods
+(instancetype) pdfWithData:(NSData *)data
                    context:(NSManagedObjectContext *)context{
    
    AGFPDF *pdf = [NSEntityDescription insertNewObjectForEntityForName:[AGFPDF entityName]
                                                      inManagedObjectContext:context];
    
    pdf.pdfData = data;
    
    return pdf;
}

@end

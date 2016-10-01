//
//  AGFSimplePDFViewController.m
//  HackerBooksPro
//

#import "AGFSimplePDFViewController.h"
#import "AGFBook.h"
#import "AGFPDF.h"

@interface AGFSimplePDFViewController ()

@property (strong, nonatomic) AGFBook *book;

@end

@implementation AGFSimplePDFViewController

#pragma mark - Init
-(id) initWithBook:(AGFBook *)book {
    
    if (self = [self init]) {
        _book = book;
    }
    return self;
    
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    // Descarga asíncrona del pdf
    if (self.book.pdf == nil) {
        dispatch_queue_t downloadPdf = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_async(downloadPdf, ^{
            NSURL *url = [NSURL URLWithString:self.book.pdfURL];
            NSData *pdf = [NSData dataWithContentsOfURL:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
    
                [self.pdfView loadData:pdf
                              MIMEType:@"application/pdf"
                      textEncodingName:@"utf-8"
                               baseURL:nil];
                
                AGFPDF *pdfEntity = [AGFPDF pdfWithData:pdf
                                                            context:self.book.managedObjectContext];
                
                self.book.pdf = pdfEntity;
                
            });
        });
    } else {
        [self.pdfView loadData:self.book.pdf.pdfData
                      MIMEType:@"application/pdf"
              textEncodingName:@"utf-8"
                       baseURL:nil];
    }

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"PDF";

}

@end

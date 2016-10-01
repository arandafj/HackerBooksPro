//
//  AGFSimplePDFViewController.h
//  HackerBooksPro
//

#import <UIKit/UIKit.h>
@class AGFBook;

@interface AGFSimplePDFViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *pdfView;

-(id) initWithBook:(AGFBook *)book;
@end

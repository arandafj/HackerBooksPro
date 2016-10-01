//
//  AGFNoteViewController.h
//  HackerBooksPro
//

#import <UIKit/UIKit.h>
@class AGFBook;

@interface AGFNoteViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *titleView;

@property (weak, nonatomic) IBOutlet UILabel *creationDate;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *mapSnapshot;
@property (weak, nonatomic) IBOutlet UITextView *text;

-(id) initWithModel:(id) model;
-(id) initForNewAnnotationInBook: (AGFBook *) book;

@end

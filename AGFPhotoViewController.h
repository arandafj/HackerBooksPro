//
//  AGFPhotoViewController.h
//  HackerBooksPro
//

#import <UIKit/UIKit.h>

@interface AGFPhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoView;

-(id)initWithModel:(id)model;
- (IBAction)takePicture:(id)sender;
- (IBAction)deletePhoto:(id)sender;
@end

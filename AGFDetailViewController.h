//
//  AGFDetailViewController.h
//  HackerBooksPro
//

#import <UIKit/UIKit.h>
@class AGFBook;

@interface AGFDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleBook;
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *authors;
@property (weak, nonatomic) IBOutlet UILabel *tags;
@property (weak, nonatomic) IBOutlet UISwitch *isFavorite;


+ (NSString *)favoriteSwitchChangeKey;
- (id) initWithBook:(AGFBook *) book context:(NSManagedObjectContext *)context;
- (IBAction)obtainPDF:(id)sender;
- (IBAction)changeFavorite:(id)sender;
- (IBAction)takeNotes:(id)sender;

-(void)downloadCover;

@end

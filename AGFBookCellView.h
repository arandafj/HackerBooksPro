//
//  AGFBookCellView.h
//  HackerBooksPro
//

#import <UIKit/UIKit.h>

@interface AGFBookCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *authors;

+(NSString *)cellId;

@end

//
//  AGFCollectionViewCell.h
//  HackerBooksPro
//

#import <UIKit/UIKit.h>

@interface AGFCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDate;
@property (weak, nonatomic) IBOutlet UILabel *title;

+(NSString *)cellId;

@end

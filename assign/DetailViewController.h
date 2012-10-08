//
//  DetailViewController.h
//  Twitter Test


#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController {
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *tweetLabel;
}
- (void)configureView;

@property (strong, nonatomic) id detailItem;






@end

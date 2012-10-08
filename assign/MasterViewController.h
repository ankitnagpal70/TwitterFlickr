//
//  MasterViewController.h
//  Twitter Test
//


#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController {
    NSArray *tweets;
}

- (NSArray *)fetchTweets:(NSString *)nameString;
@property (strong,nonatomic) NSString *input;
-(NSString *)methodForUnitTest:(NSString*)name;

@end

//
//  inpViewController.h
//  Twitter Test
//
//  Created by Optimus Information on 01/10/12.
//
//

#import <UIKit/UIKit.h>

@interface inpViewController : UIViewController
{
    IBOutlet UITextField *inputField;

}
@property (strong,retain) UITextField *inputField;
-(IBAction)return:(id)sender;

@end

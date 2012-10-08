//
//  flickr2ViewController.h
//  flickr2
//
//  Created by Optimus Information on 01/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface flickr2ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    //titles of images
    NSMutableArray  *Titles;
    //data of (thumbnail) images
    NSMutableArray  *SmallImageData;
    //URL of larger images
    NSMutableArray  *LargeImageURLs;
    //IBOutlet UIImageView *imageView;
    IBOutlet UITextField * searchName;
    IBOutlet UITableView *tableView;
    //UIActivityIndicatorView *activityIndicator;
    IBOutlet UIImageView *imageView;
    IBOutlet UITextField *numberField;
}
@property (strong,nonatomic) NSMutableArray *Titles;


- (NSMutableArray *)searchPhotos:(NSString *)text numberOfImages:(int)numberOfImages;

-(IBAction)return:(id)sender;
- (void)textFieldShouldReturn:(UITextField *)textField;



@end

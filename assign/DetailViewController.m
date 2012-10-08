//
//  DetailViewController.m
//  Twitter Test


#import "DetailViewController.h"
#import "SBJson.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize detailItem;


/*
 Method to configure the page.
 
*/
- (void)configureView
{
    if (self.detailItem) {
        NSDictionary *tweet = self.detailItem;
        
        NSString *text = [[tweet objectForKey:@"user"] objectForKey:@"name"];
        NSString *name = [tweet objectForKey:@"text"];
        
        tweetLabel.numberOfLines = 0;

        nameLabel.text = text;
        tweetLabel.text = name;
        
        NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        profileImage.image = [UIImage imageWithData:data];
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
  
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

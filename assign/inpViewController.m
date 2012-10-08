//
//  inpViewController.m
//  Twitter Test
//
//  Created by Optimus Information on 01/10/12.
//
//

#import "inpViewController.h"
#import "MasterViewController.h"

@interface inpViewController ()

@end

@implementation inpViewController
@synthesize inputField;
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"inputSegue"])
    {
       
        
        MasterViewController *master=segue.destinationViewController;
               
        master.input=inputField.text;
    }
}
-(IBAction)return:(id)sender
{
    [inputField resignFirstResponder];
    NSString *string=[NSString stringWithFormat:@"http://www.google.com"];
    
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:string]];
    if(data==nil)
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:@"Connection failed" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}


@end

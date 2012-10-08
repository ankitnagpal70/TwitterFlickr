//
//  MasterViewController.m
//  Twitter Test


#import "MasterViewController.h"
#import "DetailViewController.h"

@implementation MasterViewController
@synthesize input;



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self fetchTweets:self.input];
}

/*
 Method to fetch tweets for a particular user.
 
*/

- (NSArray *)fetchTweets:(NSString *)nameString
{
    if(self.input==[NSString stringWithFormat:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Enter Name" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else{
   NSString *string=[NSString stringWithFormat:@"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@",nameString];

    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
    
        NSLog(@"data  is %@",data);
              
        if(data==nil && self.input!=[NSString stringWithFormat:@""])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Name does not exist" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        //else if (string1)
        else{
  
        NSError* error;

        tweets = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions 
                                                   error:&error];
        
       
            [self.tableView reloadData];
             }
    }
    
        return tweets;
}
-(NSString *)methodForUnitTest:(NSString *)name
{
    NSString *string=[NSString stringWithFormat:@"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@",name];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
    
    
    NSError *error;
    tweets = [NSJSONSerialization JSONObjectWithData:data
                                             options:kNilOptions
                                               error:&error];
    NSDictionary*tweet=[tweets objectAtIndex:0];
    return [tweet objectForKey:@"text"];
    

  
}
/*
 Method to set number of rows
 
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];    
    NSString *text = [tweet objectForKey:@"text"];
    NSString *name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
    
    cell.textLabel.numberOfLines=0;
    cell.textLabel.text = text;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"by %@", name];
  NSString *stringImage=[[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
    NSData *dataImage=[NSData dataWithContentsOfURL:[NSURL URLWithString:stringImage]];

    
    UIImage *img=[UIImage imageWithData:dataImage];
    cell.imageView.image=img;

    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tweet=[tweets objectAtIndex:indexPath.row];
    NSString *text=[tweet objectForKey:@"text"];
    UIFont *font=[UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize=CGSizeMake(280.0f, MAXFLOAT);
    CGSize size=[text sizeWithFont:font constrainedToSize:constraintSize];
    return size.height+100;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTweet"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *tweet = [tweets objectAtIndex:row];
        NSLog(@"%@",tweet);
        
        DetailViewController *detailController = segue.destinationViewController;
        detailController.detailItem = tweet;
    }
}


@end

//
//  flickr2ViewController.m
//  flickr2
//
//  Created by Optimus Information on 01/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import "flickr2ViewController.h"
#import "SBJson.h"

@interface flickr2ViewController ()

@end
NSString *const flickrAPIKey = @"00c1dfba52dfd5e71d97857b5667cc36";

@implementation flickr2ViewController
@synthesize Titles;

/*
  Method to remove last data(elements of the array) and call the searchPhotos method.
 
*/
- (void)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
    
    [Titles removeAllObjects];
    [SmallImageData removeAllObjects];
    [LargeImageURLs removeAllObjects];
    NSLog(@"yo is%@",searchName.text);
    //if(searchName.text==[NSString stringWithFormat:@""])
    if([searchName.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Enter object" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    //if(numberField.text!=)
    //[self searchPhotos:searchName.text];
    [self searchPhotos:searchName.text numberOfImages:[numberField.text intValue]];
}


/*
 Method to send request to the server and access received data.
*/

-(NSMutableArray *)searchPhotos:(NSString *)text numberOfImages:(int)numberOfImages
{    
    //int numberOfImages=[numberField.text intValue];
    Titles = [[NSMutableArray alloc] init];
  
    
    // String to call flickrAPI
	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=%d&format=json&nojsoncallback=1", flickrAPIKey, text,numberOfImages];
     
    NSURL *url = [NSURL URLWithString:urlString];
    
    //NSLog(@"url is%@",url);
    NSData* data = [NSData dataWithContentsOfURL:url];
    NSLog(@"data is %@",data);
 
    if(data==nil)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Connection failed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
        
    NSString *JSONString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
   
   // NSLog(@"%@",JSONString);

    
    
    // Creation of a dictionary from the JSON string
	NSDictionary *results = [JSONString JSONValue];
    //NSLog(@"%@",results);
    
    // Build an array from the dictionary
	NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    
    // Loop through each entry in the dictionary
	for (NSDictionary *photo in photos)
    {
        
		NSString *title = [photo objectForKey:@"title"];
        
        // Save the title to the photo titles array
		[Titles addObject:(title.length > 0 ? title : @"Untitled")];
    
		
        // Build the URL to where the image is stored (see the Flickr API)
        // In the format http://farmX.static.flickr.com/server/id/secret
        // Notice the "_s" which requests a "small" image 75 x 75 pixels
		NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        NSLog(@"photoURLString: %@", photoURLString);
        
		[SmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
        
        // Build and save the URL to the large image
        
		photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
		[LargeImageURLs addObject:[NSURL URLWithString:photoURLString]];
        
        NSLog(@"photoURLsLareImage: %@\n\n", photoURLString);
     
        [tableView reloadData];
	
    }
    if(data!=nil &&[Titles count]==0 && searchName.text!=[NSString stringWithFormat:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"No results found" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    NSLog(@"titles count %d",Titles.count);
        return Titles;

}
/*
 Method which is called when textfield is entered.
 
*/


-(IBAction)return:(id)sender
{
    [searchName resignFirstResponder];
    [self textFieldShouldReturn:numberField];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [Titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"flickrCell"];
   
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"flickrCell"];
    }
        cell.textLabel.text = [Titles objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];

    
    NSData *imageData = [SmallImageData objectAtIndex:indexPath.row];
    

    cell.imageView.image = [UIImage imageWithData:imageData];


    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSData *data=[NSData dataWithContentsOfURL:[LargeImageURLs objectAtIndex:indexPath.row]];
    UIImage *image=[UIImage imageWithData:data];
    NSLog(@"%@",data);
    if(data==nil)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Connection failed" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    imageView.image=image;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    tableView.delegate=self;
    tableView.dataSource=self;    
    SmallImageData = [[NSMutableArray alloc] init];
    LargeImageURLs = [[NSMutableArray alloc] init];
    
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end

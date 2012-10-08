//
//  assignTests.m
//  assignTests
//
//  Created by Optimus Information on 01/10/12.
//  Copyright (c) 2012 Optimus Information. All rights reserved.
//

#import "assignTests.h"

@implementation assignTests
/*-(void)testSearchPhotos
{
    flickr2ViewController *flickr=[[flickr2ViewController alloc]init];
    
   NSMutableArray *ttitles=[flickr searchPhotos:@"obama" numberOfImages:2];
        
    NSLog(@"ttitles %@",ttitles);
    NSArray *testTitles =[[NSArray alloc]initWithObjects:@"Leader's Edge Election Cover",
                          "Presidential Debates: Quotes from both Candidates", nil];
                          
    STAssertEqualObjects(ttitles,testTitles,@"hello");   
}*/
/*-(void)testFetchTweets
{
    MasterViewController *masterView=[[MasterViewController alloc]init];
    NSArray *ttweets=[masterView fetchTweets:@"ankitnagpal70"];
    NSArray *testTweets=[[NSArray alloc]initWithObjects:@"Hello World!",@"Hello!!!", nil];
    NSLog(@"YO");

    NSLog(@"ttweets %@",ttweets);
    STAssertEqualObjects(ttweets, testTweets, @"hello");
}*/
-(void)testMethodForUnitTest
{
    MasterViewController *masterV=[[MasterViewController alloc]init];
    NSString *ttext=[masterV methodForUnitTest:@"ankitnagpal70"];
   NSString*testText=@"Hello World!";
    STAssertEqualObjects(ttext, testText, @"Hello");
    
    
}

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

/*- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in assignTests");
}*/

@end

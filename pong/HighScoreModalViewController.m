//
//  HighScoreModalViewController.m
//  pong
//
//  Created by Harrison Jackson on 4/13/12.
//  Copyright (c) 2012 Harrison Jackson. All rights reserved.
//

#import "HighScoreModalViewController.h"

@implementation HighScoreModalViewController
@synthesize score1;
@synthesize score2;
@synthesize score3;
@synthesize score4;
@synthesize score5;
@synthesize score6;
@synthesize score7;
@synthesize score8;
@synthesize score9;
@synthesize score10;

@synthesize delegate = _delegate;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        highScoreUpdater = [[HighScoreUpdater alloc] init];
        highScoreUpdater.delegate = self;
    }
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
-(void)HighScoreUpdater:(HighScoreUpdater *)updater loadedNewScores:(NSArray *)newTopTen{
    NSLog(@"Score was updated");
    scores = newTopTen;
    if([scores count] >0){
        //NSLog(@"Setting label - %@", scores);
        NSDictionary * obj = [scores objectAtIndex:0];
        NSLog(@"Obj - %@", obj);
                              
        
        [score1 setText:[NSString stringWithFormat:@"%@ %@",[[scores objectAtIndex:0] objectForKey:@"initials"], [[scores objectAtIndex:0] objectForKey:@"score"]]];
        
        [score2 setText:[NSString stringWithFormat:@"%@ %@",[[scores objectAtIndex:1] objectForKey:@"initials"], [[scores objectAtIndex:1] objectForKey:@"score"]]];
        
        [score3 setText:[NSString stringWithFormat:@"%@ %@",[[scores objectAtIndex:2] objectForKey:@"initials"], [[scores objectAtIndex:2] objectForKey:@"score"]]];
        
        [score4 setText:[NSString stringWithFormat:@"%@ %@",[[scores objectAtIndex:3] objectForKey:@"initials"], [[scores objectAtIndex:3] objectForKey:@"score"]]];
        
        [score5 setText:[NSString stringWithFormat:@"%@ %@",[[scores objectAtIndex:4] objectForKey:@"initials"], [[scores objectAtIndex:4] objectForKey:@"score"]]];
        
        [score6 setText:[NSString stringWithFormat:@"%@ %@",[[scores objectAtIndex:5] objectForKey:@"initials"], [[scores objectAtIndex:5] objectForKey:@"score"]]];
        
        [score7 setText:[NSString stringWithFormat:@"%@ %@",[[scores objectAtIndex:6] objectForKey:@"initials"], [[scores objectAtIndex:6] objectForKey:@"score"]]];
        
        [score8 setText:[NSString stringWithFormat:@"%@ %@",[[scores objectAtIndex:7] objectForKey:@"initials"], [[scores objectAtIndex:7] objectForKey:@"score"]]];
        
        [score9 setText:[NSString stringWithFormat:@"%@ %@",[[scores objectAtIndex:8] objectForKey:@"initials"], [[scores objectAtIndex:8] objectForKey:@"score"]]];
        
        [score10 setText:[NSString stringWithFormat:@"%@ %@",[[scores objectAtIndex:9] objectForKey:@"initials"], [[scores objectAtIndex:9] objectForKey:@"score"]]];
        
    }else{
        NSLog(@"No scores");
        
    }
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    if([scores count] >0){
        [score1 setText:[NSString stringWithFormat:@"",[[scores objectAtIndex:0] objectForKey:@"initials"], [[scores objectAtIndex:0] objectForKey:@"score"]]];
        
    }
    
}


- (void)viewDidUnload
{
    [self setScore1:nil];
    [self setScore2:nil];
    [self setScore3:nil];
    [self setScore4:nil];
    [self setScore6:nil];
    [self setScore5:nil];
    [self setScore5:nil];
    [self setScore6:nil];
    [self setScore7:nil];
    [self setScore8:nil];
    [self setScore9:nil];
    [self setScore10:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)backPushed:(id)sender {
    
    [self.delegate BackWasPushedInHighScoreModalViewController:self];
}


@end

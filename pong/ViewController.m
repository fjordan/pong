//
//  ViewController.m
//  pong
//
//  Created by Forrest Jordan on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#define GAME_STATE_PAUSED   1
#define GAME_STATE_RUNNING  2

#define STAR_SPEED_X 6
#define STAR_SPEED_Y 6

#define COMP_MOVE_SPEED 3

#define SCORE_TO_WIN 3

@implementation ViewController

@synthesize star;
@synthesize star_shadow;
@synthesize paddle_red;
@synthesize paddle_blue;
@synthesize player_score;
@synthesize computer_score;
@synthesize star_velocity;
@synthesize game_state;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];

    paddle_red.center = CGPointMake(location.x, paddle_red.center.y);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(game_state == GAME_STATE_PAUSED) {
        start_message.hidden = YES;
        game_state = GAME_STATE_RUNNING;
    } else if(game_state == GAME_STATE_RUNNING) {
        [self touchesMoved:touches withEvent:event];
    }
}

- (void)gameLoop {
    if(game_state == GAME_STATE_RUNNING) {
        star.center = CGPointMake(star.center.x + star_velocity.x, star.center.y + star_velocity.y);
        star_shadow.center = CGPointMake(star.center.x + star_velocity.x, star.center.y + star_velocity.y);
        
        if(star.center.x > self.view.bounds.size.width || star.center.x < 0) {
            star_velocity.x = -star_velocity.x;     
        }
        if(star.center.y > self.view.bounds.size.height || star.center.y < 0) {
            star_velocity.y = -star_velocity.y;
        }
        
        if(CGRectIntersectsRect(star.frame, paddle_blue.frame)) {
            if(star.center.y > paddle_blue.center.y) {
                NSLog(@"%fl", star_velocity.x);
                star_velocity.y = -star_velocity.y;
                NSLog(@"%fl %fl", star.center.x, paddle_blue.center.x);
                
                
                if(star_velocity.x) {
                    // Left to Right -->
                    if(star.center.x > paddle_blue.center.x) {
                        star_velocity.x = -star_velocity.x;
                    }
                } else {
                    // Right to Left <--
                    if(star.center.x < paddle_blue.center.x) {
                        star_velocity.x = -star_velocity.x;
                    }
                }

            }
        }
        
        if(CGRectIntersectsRect(star.frame, paddle_red.frame)) {
            if(star.center.y < paddle_red.center.y) {
                NSLog(@"%fl", star_velocity.x);
                star_velocity.y = -star_velocity.y;
                NSLog(@"%fl %fl", star.center.x, paddle_red.center.x);
                

                if(star_velocity.x) {
                    // Left to Right -->
                    if(star.center.x > paddle_red.center.x) {
                        star_velocity.x = -star_velocity.x;
                    }
                } else {
                    // Right to Left <--
                    if(star.center.x < paddle_red.center.x) {
                        star_velocity.x = -star_velocity.x;
                    }
                }
            }
        }
        
        // Computer side of the court
        if(star.center.y <= self.view.center.y) {
            if(star.center.x > paddle_blue.center.x) {
                paddle_blue.center = CGPointMake(paddle_blue.center.x + COMP_MOVE_SPEED, paddle_blue.center.y);
            }
            if(star.center.x < paddle_blue.center.x) {
                paddle_blue.center = CGPointMake(paddle_blue.center.x - COMP_MOVE_SPEED, paddle_blue.center.y);
            }

        }
    } else {
        if(start_message.hidden) {
            start_message.hidden = NO;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.game_state = GAME_STATE_PAUSED;
    star_velocity = CGPointMake(STAR_SPEED_X, STAR_SPEED_Y);
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end

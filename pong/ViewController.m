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

#define STAR_SPEED_X 4
#define STAR_SPEED_Y 4

#define COMP_MOVE_SPEED 2

#define SCORE_TO_WIN 3

@implementation ViewController

@synthesize star;
@synthesize star_shadow;
@synthesize paddle_red;
@synthesize paddle_blue;

@synthesize victorious;
@synthesize victorious_back;
@synthesize defeat;
@synthesize defeat_back;

@synthesize player_score;
@synthesize player_score_back;
@synthesize computer_score;
@synthesize computer_score_back;
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
        computer_score_back.hidden = YES;
        player_score_back.hidden = YES;
        defeat_back.hidden = YES;
        defeat.hidden = YES;
        victorious_back.hidden = YES;
        victorious.hidden = YES;
        
        
        game_state = GAME_STATE_RUNNING;
    } else if(game_state == GAME_STATE_RUNNING) {
        [self touchesMoved:touches withEvent:event];
    }
}

- (void)gameLoop {
    if(game_state == GAME_STATE_RUNNING) {
        star.center = CGPointMake(star.center.x + star_velocity.x, star.center.y + star_velocity.y);
        star_shadow.center = CGPointMake(star.center.x + star_velocity.x, star.center.y + star_velocity.y);
        
        //Separate this collision detection so that you can move the star back into play
        //fixes the bug where it sometimes get stuck going straight up one of the walls
        if(star.center.x > self.view.bounds.size.width - star.frame.size.width/2){
            star_shadow.center = CGPointMake(self.view.bounds.size.width - star.frame.size.width/2, star.center.y);
            star_velocity.x = -star_velocity.x;     
        }else if(star.center.x < 0+ star.frame.size.width/2) {
            star_shadow.center = CGPointMake(0 +  star.frame.size.width/2, star.center.y);
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
                
                
                if(star_velocity.x > 0) {
                    if(star.center.x < paddle_blue.center.x) {
                        star_velocity.x = -star_velocity.x;
                    }
                } else {
                    if(star.center.x > paddle_blue.center.x) {
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
                

                if(star_velocity.x > 0) {
                    if(star.center.x < paddle_red.center.x) {
                        star_velocity.x = -star_velocity.x;
                    }
                } else {
                    if(star.center.x > paddle_red.center.x) {
                        star_velocity.x = -star_velocity.x;
                    }
                }
            }
        }
        
        // Simple AI
        if(star.center.y <= self.view.center.y) {
            if(star.center.x > paddle_blue.center.x) {
                paddle_blue.center = CGPointMake(paddle_blue.center.x + COMP_MOVE_SPEED, paddle_blue.center.y);
            }
            if(star.center.x < paddle_blue.center.x) {
                paddle_blue.center = CGPointMake(paddle_blue.center.x - COMP_MOVE_SPEED, paddle_blue.center.y);
            }

        }
        
        // Scoring 
        if(star.center.y <= 0) {
            player_score_value++;
            player_score_back.hidden = NO;
            [self reset:(player_score_value >= SCORE_TO_WIN)];
        }
        if(star.center.y >= self.view.bounds.size.height) {
            computer_score_value++;
            computer_score_back.hidden = NO;
            [self reset:(computer_score_value >= SCORE_TO_WIN)];
        }

        
        
    } else {
        if(start_message.hidden) {
            start_message.hidden = NO;
        }
    }
}

- (void)reset:(BOOL)newGame {
    self.game_state = GAME_STATE_PAUSED;
    star.center = self.view.center;
    star_shadow.center = CGPointMake(self.view.center.x - 5, self.view.center.y - 5);
    
    if(newGame) {
        if(computer_score_value > player_score_value) {
            defeat_back.hidden = NO;
            defeat.hidden = NO;
        } else {
            victorious_back.hidden = NO;
            victorious.hidden = NO;
        }

        computer_score_value = 0;
        player_score_value = 0;
    } else {
        start_message.text = @"Tap To Begin!";
    }
    player_score.text = [NSString stringWithFormat:@"%d", player_score_value];
    computer_score.text = [NSString stringWithFormat:@"%d", computer_score_value];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.game_state = GAME_STATE_PAUSED;
    star_velocity = CGPointMake(STAR_SPEED_X, STAR_SPEED_Y);
    [NSTimer scheduledTimerWithTimeInterval:0.018 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
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

//
//  ViewController.h
//  pong
//
//  Created by Forrest Jordan on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UIImageView *star;
    IBOutlet UIImageView *star_shadow;
    IBOutlet UIImageView *paddle_red;
    IBOutlet UIImageView *paddle_blue;
    
    IBOutlet UIImageView *victorious;
    IBOutlet UIImageView *victorious_back;
    IBOutlet UIImageView *defeat;
    IBOutlet UIImageView *defeat_back;
    
    IBOutlet UILabel *player_score;
    IBOutlet UIImageView *player_score_back;
    IBOutlet UILabel *computer_score;    
    IBOutlet UIImageView *computer_score_back;
    IBOutlet UILabel *start_message;
    
    CGPoint star_velocity;
    
    NSInteger game_state;
    
    NSInteger player_score_value;
    NSInteger computer_score_value;
}

@property(strong, nonatomic) IBOutlet UIImageView *star;
@property(strong, nonatomic) IBOutlet UIImageView *star_shadow;
@property(strong, nonatomic) IBOutlet UIImageView *paddle_red;
@property(strong, nonatomic) IBOutlet UIImageView *paddle_blue;

@property(strong, nonatomic) IBOutlet UIImageView *victorious;
@property(strong, nonatomic) IBOutlet UIImageView *victorious_back;
@property(strong, nonatomic) IBOutlet UIImageView *defeat;
@property(strong, nonatomic) IBOutlet UIImageView *defeat_back;

@property(strong, nonatomic) IBOutlet UILabel *start_message;
@property(strong, nonatomic) IBOutlet UILabel *player_score;
@property(strong, nonatomic) IBOutlet UIImageView *player_score_back;
@property(strong, nonatomic) IBOutlet UILabel *computer_score;
@property(strong, nonatomic) IBOutlet UIImageView *computer_score_back;

@property(nonatomic) CGPoint star_velocity;
@property(nonatomic) NSInteger game_state;

- (void)reset:(BOOL)newGame;

@end

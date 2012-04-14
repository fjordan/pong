//
//  HighScoreModalViewController.h
//  pong
//
//  Created by Harrison Jackson on 4/13/12.
//  Copyright (c) 2012 Harrison Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreUpdater.h"


@protocol HighScoreModalViewControllerDelegate;

@interface HighScoreModalViewController : UIViewController<HighScoreUpdaterDelegate>{
    UIImageView * _background;
    NSArray * scores;
    
    HighScoreUpdater * highScoreUpdater;
    
    
    __weak id <HighScoreModalViewControllerDelegate> _delegate;
}

@property (weak) id <HighScoreModalViewControllerDelegate> delegate;

-(void)getScores;
-(void)getLocalScores;

- (IBAction)backPushed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *score1;
@property (weak, nonatomic) IBOutlet UILabel *score2;
@property (weak, nonatomic) IBOutlet UILabel *score3;
@property (weak, nonatomic) IBOutlet UILabel *score4;
@property (weak, nonatomic) IBOutlet UILabel *score5;
@property (weak, nonatomic) IBOutlet UILabel *score6;
@property (weak, nonatomic) IBOutlet UILabel *score7;
@property (weak, nonatomic) IBOutlet UILabel *score8;
@property (weak, nonatomic) IBOutlet UILabel *score9;
@property (weak, nonatomic) IBOutlet UILabel *score10;

-(void)HighScoreUpdater:(HighScoreUpdater *)updater loadedNewScores:(NSArray *)newTopTen;


@end

@protocol HighScoreModalViewControllerDelegate <NSObject>

-(void)BackWasPushedInHighScoreModalViewController:(HighScoreModalViewController *)highScoreView;

@end

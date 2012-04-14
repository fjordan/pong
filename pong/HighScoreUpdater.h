//
//  HighScoreUpdater.h
//  pong
//
//  Created by Harrison Jackson on 4/13/12.
//  Copyright (c) 2012 Harrison Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kTopScoresURL [NSURL URLWithString:@"http://www.howtoprogramgames.com/sandbox/highscores/topten.php"]
#define kAddScoresURL @"http://www.howtoprogramgames.com/sandbox/highscores/addscore.php"

@protocol HighScoreUpdaterDelegate;

@interface HighScoreUpdater : NSObject{
    NSArray * _topTenLocal;
    NSArray * _topTen;
    __weak id <HighScoreUpdaterDelegate> _delegate;
}

@property (weak) id <HighScoreUpdaterDelegate> delegate;
@property(nonatomic, strong) NSArray * topTen;
@property(nonatomic, strong) NSArray * topTenLocal;

-(void)updateWithScore:(NSNumber *)score andInitials:(NSString *)Initials;

-(BOOL)isNetworkHighScore:(NSNumber*)score;


-(void)getScores;
-(void)getLocalScores;
-(void)fetchedData:(NSData *)data;
-(void)fetchedData2:(NSData *)data;


@end

@protocol HighScoreUpdaterDelegate <NSObject>

@required
-(void)HighScoreUpdater:(HighScoreUpdater *)updater loadedNewScores:(NSArray *)newTopTen;
-(void)HighScoreUpdater:(HighScoreUpdater *)updater failedToLoadNewScores:(NSError *)error;

@optional
-(void)HighScoreUpdaterBeganUpdating:(HighScoreUpdater *)updater;
-(void)HighScroreUpdaterCancelledUpdating:(HighScoreUpdater *)updater;


@end    
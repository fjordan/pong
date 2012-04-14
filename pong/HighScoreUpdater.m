//
//  HighScoreUpdater.m
//  pong
//
//  Created by Harrison Jackson on 4/13/12.
//  Copyright (c) 2012 Harrison Jackson. All rights reserved.
//

#import "HighScoreUpdater.h"
#import "Score.h"



@implementation HighScoreUpdater
@synthesize topTen = _topTen;
@synthesize topTenLocal = _topTenLocal;
@synthesize delegate = _delegate;

-(id)init{
    self = [super init];
    if(self){
        dispatch_async(kBgQueue, ^{
            NSData* data = [NSData dataWithContentsOfURL: kTopScoresURL];
            [self performSelectorOnMainThread:@selector(fetchedData:) 
                                   withObject:data waitUntilDone:YES];
        });
        
    }
    
    return self;
}

-(void)fetchedData:(NSData *)data{
    //parse out the json data
    NSError* error;
    NSArray* topScores = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    
    
    if([topScores count] > 0){
        self.topTen = topScores;
        
        [self.delegate HighScoreUpdater:self loadedNewScores:self.topTen];
        
    }
    
    NSLog(@"scores: %@", topScores);
    
}



-(void)getScores{
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: kTopScoresURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) 
                               withObject:data waitUntilDone:YES];
    });
    
}

-(void)updateWithScore:(NSNumber *)score andInitials:(NSString *)Initials{
    NSLog(@"Adding score:%@ and initials: %@ to network", score, Initials);
    
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://www.howtoprogramgames.com/sandbox/highscores/addscore.php?score=%@&initials=%@", score, Initials]]];
        
        [self performSelectorOnMainThread:@selector(fetchedData2:) 
                               withObject:data waitUntilDone:YES];
    });
    
    
}

-(void)fetchedData2:(NSData *)data{
    //parse out the json data
    NSError* error;
    NSDictionary* response = [NSJSONSerialization 
                          JSONObjectWithData:data
                          options:kNilOptions 
                          error:&error];
    
    
    if([[response objectForKey:@""] isEqualToString:@"1"]){
        [self getScores];
    }
    
}

-(BOOL)isNetworkHighScore:(NSNumber*)scoreIn{
    NSLog(@"Is high score?");
    BOOL isHigh = NO;
    if([self.topTen count] > 0){
        for(NSDictionary * dic in self.topTen){

            if([scoreIn intValue] > [[dic objectForKey:@"score"] intValue]){
                NSLog(@"Score: %@ is a highscore", scoreIn);
                isHigh = YES;
            }else{
                NSLog(@"%@ is smaller than %@", scoreIn,[dic objectForKey:@"score"]);
                
            }
        }
        
    }else{
        NSLog(@"No scores");
    }
    return isHigh;
}


@end

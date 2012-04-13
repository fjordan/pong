//
//  Score.m
//  pong
//
//  Created by Harrison Jackson on 4/13/12.
//  Copyright (c) 2012 Harrison Jackson. All rights reserved.
//

#import "Score.h"

@implementation Score
@synthesize score = _score;
@synthesize initials = _initials;


-(id)initWithScore:(NSNumber *)scoreIn andInitials:(NSString *)initialsIn{
    self = [super init];
    if(self){
        self.score = scoreIn;
        self.initials = initialsIn;
        
    }
    
    return self;
    
}


-(BOOL)isGreaterThan:(Score *)rightScore{
    return self.score > rightScore.score;
    
}

@end

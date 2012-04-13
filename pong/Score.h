//
//  Score.h
//  pong
//
//  Created by Harrison Jackson on 4/13/12.
//  Copyright (c) 2012 Harrison Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject{
    NSNumber * _score;
    NSString * _initials;
    
}

@property(nonatomic, strong) NSNumber * score;
@property(nonatomic, strong) NSString * initials;

-(id)initWithScore:(NSNumber *)score andInitials:(NSString *)initials;


-(BOOL)isGreaterThan:(Score *)rightScore;



@end

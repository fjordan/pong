//
//  ViewController.h
//  pong
//
//  Created by Harrison Jackson on 4/13/12.
//  Copyright (c) 2012 Harrison Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"
#import "HighScoreModalViewController.h"

@interface ViewController : UIViewController<HighScoreModalViewControllerDelegate>{
    
    
}

-(void)BackWasPushedInHighScoreModalViewController:(HighScoreModalViewController *)highScoreView;

@end

//
//  GameViewController.h
//  DarkMatter
//
//  Created by Babak Keradman on 5/11/09.
//  Copyright 2009 Zarboo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBoardView.h"

@interface GameViewController : UIViewController {
	GameBoardView *gameBoard;
}

@property (nonatomic) IBOutlet GameBoardView *gameBoard;

@end

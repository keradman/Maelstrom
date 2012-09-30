//
//  GameViewController.h
//  DarkMatter
//
//  Created by Babak Keradman on 5/11/09.
//  Copyright 2012 Maestro Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBoardView.h"
#import "MaelstromModel.h"
#import "ShipView.h"

@interface GameViewController : UIViewController {
	GameBoardView *gameBoard;
}

@property (nonatomic) IBOutlet GameBoardView *gameBoard;

@property (strong, nonatomic) MaelstromModel *model;
@property (strong, nonatomic) NSArray *ships;

@property (weak, nonatomic) ShipView *draggedShip;
@property (nonatomic) CGRect startingFrame;

- (void)addShips;
- (void)draggingShip:(UIPanGestureRecognizer*)sender;

@end

//
//  GameBoardView.h
//  DarkMatter
//
//  Created by Babak Keradman on 5/11/09.
//  Copyright 2009 Zarboo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBoardZone.h"
#import "Explosion.h"
#import "SoundEffect.h"

@interface GameBoardView : UIView {
	UIImage *backgroundImage;
	BOOL showGrid;
@private
	NSMutableArray *zones;
	CGMutablePathRef gridLinesPath;
	NSMutableArray *fogOfWar;
	Explosion *explosion;
	SoundEffect *boomSound;
	GameBoardZone *explodingZone;
}

@property (nonatomic, retain) UIImage *backgroundImage;
@property (readwrite) BOOL showGrid;

- (GameBoardZone *)getZoneAtLocation:(CGPoint)location;

@end

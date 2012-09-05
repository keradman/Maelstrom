//
//  Explosion.h
//  DarkMatter
//
//  Created by Babak Keradman on 5/12/09.
//  Copyright 2012 Maestro Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Explosion : UIView {
	int step;
	int numSteps;
	NSTimer *animationTimer;
	UIImage *texture;
	
	id delegate;
}

@property (nonatomic) id delegate;

- (void)startExplosion;

@end

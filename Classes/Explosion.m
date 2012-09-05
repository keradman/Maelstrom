//
//  Explosion.m
//  DarkMatter
//
//  Created by Babak Keradman on 5/12/09.
//  Copyright 2012 Maestro Studios. All rights reserved.
//

#import "Explosion.h"

@implementation Explosion

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self setBackgroundColor:[UIColor clearColor]];
		texture = [UIImage imageNamed:@"explosion.png"];
		step = 0;
		numSteps = 16;
        [NSTimer scheduledTimerWithTimeInterval:(1.0 / 15.0) target:self selector:@selector(animationLoop) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)startExplosion {
	step = 1;
	[self setNeedsDisplay];
}

- (void)animationLoop {
	if(step > 0 && step <= numSteps) {
		[self setNeedsDisplay];
		step++;
	}
}

- (void)drawRect:(CGRect)rect {
	//setup CGContext
	if(step > 0 && step <= numSteps) {
		int stepAdjust = step - 1;
		int rowCount = stepAdjust / 4;
		int columnCount = (stepAdjust % 4);
		int y = rowCount * -64;
		int x = columnCount * -64;
		CGPoint point = CGPointMake(x, y);
		//NSLog(@"step:%i, row:%i, column:%i, x:%i, y:%i", step, rowCount, columnCount, x, y);
		[texture drawAtPoint:point];
	}
}

- (void)dealloc {
	[animationTimer invalidate];
}

@end

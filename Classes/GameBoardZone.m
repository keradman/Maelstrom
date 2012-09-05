//
//  GameBoardZone.m
//  DarkMatter
//
//  Created by Babak Keradman on 5/11/09.
//  Copyright 2012 Maestro Studios. All rights reserved.
//

#import "GameBoardZone.h"


@implementation GameBoardZone

@synthesize rect;
@synthesize isActive;
@synthesize isConcealed;
@synthesize isHitMarker;

- (id)init {
	if(self = [super init]) {
		rect = CGRectZero;
		isActive = YES;
		isConcealed = YES;
		isHitMarker = NO;
	}
	return self;
}

@end

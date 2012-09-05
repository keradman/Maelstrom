//
//  GameBoardZone.h
//  DarkMatter
//
//  Created by Babak Keradman on 5/11/09.
//  Copyright 2012 Maestro Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameBoardZone : NSObject {
	CGRect rect;
	BOOL isActive;
	BOOL isConcealed;
	BOOL isHitMarker;
}

@property (assign) CGRect rect;
@property (assign) BOOL isActive;
@property (assign) BOOL isConcealed;
@property (assign) BOOL isHitMarker;

@end

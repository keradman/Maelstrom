//
//  GameBoardView.m
//  DarkMatter
//
//  Created by Babak Keradman on 5/11/09.
//  Copyright 2009 Zarboo Software. All rights reserved.
//

#import "GameBoardView.h"

const CGFloat kGridHorizontalOffset = 0.0;// 6.0;
const CGFloat kGridVerticalOffset = 0.0;// 4.0;
const CGFloat kGridBlockSize = 32.0;// 26.0;

#define FOG_OF_WAR_COLOR {0.1, 0.1, 0.1, 0.6}
#define GRID_COLOR {0.8, 0.8, 0.8, 0.5}

@interface GameBoardView(PrivateMethods)

- (void)initializeGameBoard;
- (void)buildGridLinesPath;
- (void)buildGameBoardZones;

@end

@implementation GameBoardView

@synthesize backgroundImage;
@synthesize showGrid;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		[self initializeGameBoard];
    }
    return self;
}

- (void)awakeFromNib {
	[self initializeGameBoard];
}

- (void)initializeGameBoard {
	showGrid = YES;
	[self buildGameBoardZones];
	[self buildGridLinesPath];
	fogOfWar = [[NSMutableArray alloc] initWithArray:zones];
	boomSound = [[SoundEffect alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"boom" ofType:@"wav"]];
	[boomSound setDelegate:self];
	explosion = [[Explosion alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
	[self addSubview:explosion];
}

- (void)buildGameBoardZones {
	zones = [[NSMutableArray alloc] init];
	CGFloat x, y;
	y = kGridVerticalOffset;
	while (y < self.frame.size.height - kGridVerticalOffset) {
		x = kGridHorizontalOffset;
		while (x < self.frame.size.width - kGridHorizontalOffset) {
			GameBoardZone *zone = [[GameBoardZone alloc] init];
			[zone setRect:CGRectMake(x, y, kGridBlockSize, kGridBlockSize)];
			[zones addObject:zone];
			x = x + kGridBlockSize;
		}
		y = y + kGridBlockSize;
	}
	//top border
	GameBoardZone *topBorderZone = [[GameBoardZone alloc] init];
	[topBorderZone setIsActive:NO];
	[topBorderZone setRect:CGRectMake(0, 0, self.frame.size.width, kGridVerticalOffset)];
	[zones addObject:topBorderZone];
	//bottom border
	GameBoardZone *bottomBorderZone = [[GameBoardZone alloc] init];
	[bottomBorderZone setIsActive:NO];
	[bottomBorderZone setRect:CGRectMake(0, self.frame.size.height - kGridVerticalOffset, self.frame.size.width, kGridVerticalOffset)];
	[zones addObject:bottomBorderZone];
	//left border
	GameBoardZone *leftBorderZone = [[GameBoardZone alloc] init];
	[leftBorderZone setIsActive:NO];
	[leftBorderZone setRect:CGRectMake(0, kGridVerticalOffset, kGridHorizontalOffset, self.frame.size.height - (2 * kGridVerticalOffset))];
	[zones addObject:leftBorderZone];
	//right border
	GameBoardZone *rightBorderZone = [[GameBoardZone alloc] init];
	[rightBorderZone setIsActive:NO];
	[rightBorderZone setRect:CGRectMake(self.frame.size.width - kGridHorizontalOffset, kGridVerticalOffset, kGridHorizontalOffset, self.frame.size.height - (2 * kGridVerticalOffset))];
	[zones addObject:rightBorderZone];
}

- (void)buildGridLinesPath {
	//setup
	gridLinesPath = CGPathCreateMutable();
	CGFloat minX = kGridHorizontalOffset - kGridBlockSize;
	CGFloat maxX = self.frame.size.width + kGridBlockSize;
	CGFloat currentX = minX;
	CGFloat minY = kGridVerticalOffset - kGridBlockSize;
	CGFloat maxY = self.frame.size.height + kGridBlockSize;
	CGFloat currentY = minY;
	CGPathMoveToPoint(gridLinesPath, NULL, minX, minY);
	//verticle lines
	while (currentX < maxX) {
		CGPathAddLineToPoint(gridLinesPath, NULL, currentX, minY);
		CGPathAddLineToPoint(gridLinesPath, NULL, currentX, maxY);
		currentX = currentX + kGridBlockSize;
		CGPathAddLineToPoint(gridLinesPath, NULL, currentX, maxY);
		CGPathAddLineToPoint(gridLinesPath, NULL, currentX, minY);
		currentX = currentX + kGridBlockSize;
	}
	//move back to origin
	CGPathMoveToPoint(gridLinesPath, NULL, minX, minY);
	//horizontal lines
	while (currentY < maxY) {
		CGPathAddLineToPoint(gridLinesPath, NULL, minX, currentY);
		CGPathAddLineToPoint(gridLinesPath, NULL, maxX, currentY);
		currentY = currentY + kGridBlockSize;
		CGPathAddLineToPoint(gridLinesPath, NULL, maxX, currentY);
		CGPathAddLineToPoint(gridLinesPath, NULL, minX, currentY);
		currentY = currentY + kGridBlockSize;
	}
	//move back to origin
	CGPathMoveToPoint(gridLinesPath, NULL, minX, minY);
	//close
	CGPathCloseSubpath(gridLinesPath);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	if ([touch tapCount] == 2) {
		showGrid = !showGrid;
	}
	CGPoint location = [touch locationInView:self];
	GameBoardZone *zone = [self getZoneAtLocation:location];
	if([zone isActive]) {
		[zone setIsConcealed:NO];
		[fogOfWar removeObject:zone];
		[boomSound play];
		[explosion setFrame:CGRectMake(zone.rect.origin.x + (zone.rect.size.width / 2) - 32, zone.rect.origin.y + (zone.rect.size.height / 2) - 32, 64, 64)];
		[explosion startExplosion];
	}
	[self setNeedsDisplay];
}

- (GameBoardZone *)getZoneAtLocation:(CGPoint)location {
	int row = (location.y - kGridVerticalOffset) / kGridBlockSize;
	int column = ((location.x - kGridHorizontalOffset) / kGridBlockSize) + 1;
	int columnCount = (self.frame.size.width - (2 * kGridHorizontalOffset)) / kGridBlockSize;
	int index = -1;
	if(row > 0) {
		index = index + columnCount * row;
	}
	index = index + column;
	if(index < 0) {
		return nil;
	}
	return (GameBoardZone *)[zones objectAtIndex:index];
}

- (void)soundEffectDidFinishPlaying:(id)sound {
	if(explodingZone != nil) {
		[explodingZone setIsConcealed:NO];
		[fogOfWar removeObject:explodingZone];
		[self setNeedsDisplay];
	}
}

- (void)drawRect:(CGRect)rect {
	//background image
	[backgroundImage drawInRect:self.frame];
	//setup CGContext
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);	
	//fog of war
	CGRect rects[[fogOfWar count]];
	for (int i = 0; i < [fogOfWar count]; i++) {
		GameBoardZone *zone = [fogOfWar objectAtIndex:i];
		rects[i] = zone.rect;
	}
	CGContextClipToRects(context, rects, [fogOfWar count]);
	CGFloat fogOfWarColorComponents[4] = FOG_OF_WAR_COLOR;
	CGContextSetFillColor(context, fogOfWarColorComponents);
	CGContextFillRect(context, self.frame);
	CGContextRestoreGState(context);
	//grid lines
	if(showGrid) {
		CGFloat gridColorComponents[4] = GRID_COLOR;
		CGContextSetStrokeColor(context, gridColorComponents);
		CGContextAddPath(context, gridLinesPath);
		CGContextDrawPath(context, kCGPathStroke);
	}
}

- (void)dealloc {
	CGPathRelease(gridLinesPath);
}

@end

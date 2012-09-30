//
//  ShipView.m
//  Maelstrom
//
//  Created by Zack Buckley on 9/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShipView.h"
#import "Constants.h"

#define NUM(x) [NSNumber numberWithInt:x]

@implementation ShipView

@synthesize occupiedSquares = _occupiedSquares, type;

- (id)initWithFrame:(CGRect)frame andType:(ShipType)aType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = aType;
    }
    return self;
}

- (NSArray *)occupiedSquares
{
    if (!_occupiedSquares) {
        switch (self.type) {
            case Small:
                _occupiedSquares = [NSArray arrayWithObjects:NUM(1), NUM(2), NUM(3), nil];
                break;
            case Medium:
                _occupiedSquares = [NSArray arrayWithObjects:NUM(1), NUM(2), NUM(3), NUM(4), nil];
                break;
            case Large:
                _occupiedSquares = [NSArray arrayWithObjects:NUM(1), NUM(2), NUM(3), NUM(4), NUM(5), nil];
                break;
        }
    }
    
    return _occupiedSquares;
}

- (void)drawRect:(CGRect)rect
{
    UIColor *color = [UIColor lightGrayColor];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    [color setFill];
    [path fill];
}

- (NSArray *)calcCenterPoints
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    
    CGPoint p = CGPointZero;
    p.x += kGridBlockSize/2;
    p.y += kGridBlockSize/2;
    int counter = 1;
    
    while ([self pointInside:p withEvent:nil]) {
        CGPoint rowP = p;
        while ([self pointInside:rowP withEvent:nil]) {
            if ([self.occupiedSquares containsObject:NUM(counter)]) {
                CGPoint pointInSuper = [self convertPoint:rowP toView:[self superview]];
                [array addObject:[NSValue valueWithCGPoint:pointInSuper]];
            }
            rowP.x += kGridBlockSize;
        }
        p.y += kGridBlockSize;
    }
    
    return array;
}

@end

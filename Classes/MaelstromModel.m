//
//  MaelstromModel.m
//  Maelstrom
//
//  Created by Zack Buckley on 9/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaelstromModel.h"

@implementation MaelstromModel

@synthesize player1Ship1Locations, player1Ship2Locations, player1Ship3Locations, player1Ship4Locations, player1TargetedSquares, player2Ship1Locations, player2Ship2Locations, player2Ship3Locations, player2Ship4Locations, player2TargetedSquares;

- (id)init
{
    self = [super init];
    if (self) {
        self.player1Ship1Locations = [NSMutableSet setWithCapacity:5];
        self.player1Ship2Locations = [NSMutableSet setWithCapacity:5];
        self.player1Ship3Locations = [NSMutableSet setWithCapacity:5];
        self.player1Ship4Locations = [NSMutableSet setWithCapacity:5];
        self.player1TargetedSquares = [NSMutableSet setWithCapacity:32];
        
        self.player2Ship1Locations = [NSMutableSet setWithCapacity:5];
        self.player2Ship2Locations = [NSMutableSet setWithCapacity:5];
        self.player2Ship3Locations = [NSMutableSet setWithCapacity:5];
        self.player2Ship4Locations = [NSMutableSet setWithCapacity:5];
        self.player2TargetedSquares = [NSMutableSet setWithCapacity:32];
    }
    return self;
}

@end

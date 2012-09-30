//
//  MaelstromModel.h
//  Maelstrom
//
//  Created by Zack Buckley on 9/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MaelstromModel : NSObject

@property (strong, nonatomic) NSMutableSet *player1Ship1Locations;
@property (strong, nonatomic) NSMutableSet *player1Ship2Locations;
@property (strong, nonatomic) NSMutableSet *player1Ship3Locations;
@property (strong, nonatomic) NSMutableSet *player1Ship4Locations;

@property (strong, nonatomic) NSMutableSet *player1TargetedSquares;

@property (strong, nonatomic) NSMutableSet *player2Ship1Locations;
@property (strong, nonatomic) NSMutableSet *player2Ship2Locations;
@property (strong, nonatomic) NSMutableSet *player2Ship3Locations;
@property (strong, nonatomic) NSMutableSet *player2Ship4Locations;

@property (strong, nonatomic) NSMutableSet *player2TargetedSquares;

- (id)init;

@end

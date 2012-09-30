//
//  ShipView.h
//  Maelstrom
//
//  Created by Zack Buckley on 9/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Small,
    Medium,
    Large
} ShipType;

@interface ShipView : UIView

@property (strong, readonly, nonatomic) NSArray *occupiedSquares;
@property (nonatomic) ShipType type;
    
- (id)initWithFrame:(CGRect)frame andType:(ShipType)aType;
- (NSArray *)calcCenterPoints;

@end

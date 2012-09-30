//
//  GameViewController.m
//  DarkMatter
//
//  Created by Babak Keradman on 5/11/09.
//  Copyright 2012 Maestro Studios. All rights reserved.
//

#import "GameViewController.h"
#import "Constants.h"

@implementation GameViewController

@synthesize gameBoard, model, ships, draggedShip, startingFrame;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.model = [[MaelstromModel alloc] init];
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[gameBoard setBackgroundImage:[UIImage imageNamed:@"nebula.png"]];
    [self addShips]; 
    
    UIPanGestureRecognizer *pgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(draggingShip:)];  
    [self.view addGestureRecognizer:pgr];
    
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)addShips {
    CGRect ship1Frame = CGRectMake(2 * kGridBlockSize, 2 * kGridBlockSize, kGridBlockSize, 3 * kGridBlockSize);
    ShipView *ship1 = [[ShipView alloc] initWithFrame:ship1Frame];
    
    CGRect ship2Frame = CGRectMake(5 * kGridBlockSize, 2 * kGridBlockSize, kGridBlockSize, 4 * kGridBlockSize);
    ShipView *ship2 = [[ShipView alloc] initWithFrame:ship2Frame];
    
    CGRect ship3Frame = CGRectMake(8 * kGridBlockSize, 2 * kGridBlockSize, kGridBlockSize, 4 * kGridBlockSize);
    ShipView *ship3 = [[ShipView alloc] initWithFrame:ship3Frame];
    
    CGRect ship4Frame = CGRectMake(11 * kGridBlockSize, 2 * kGridBlockSize, kGridBlockSize, 5 * kGridBlockSize);
    ShipView *ship4 = [[ShipView alloc] initWithFrame:ship4Frame];
    
    self.ships = [NSArray arrayWithObjects:ship1, ship2, ship3, ship4, nil];
    
    for (ShipView *s in self.ships) {
        [self.view addSubview:s];
    }
}

- (void)draggingShip:(UIPanGestureRecognizer*)recognizer {
    if (recognizer.state ==UIGestureRecognizerStateBegan) {  
            for (ShipView *ship in self.ships) {
                CGPoint pointInShipView = [recognizer locationInView:ship];  
                BOOL pointInsideShip = [ship pointInside:pointInShipView withEvent:nil];  
                if (pointInsideShip) {  
                    self.draggedShip = ship;
                    self.startingFrame = ship.frame;
                    NSLog(@"started dragging an object");  
                    
                    break;
                } else {  
                    NSLog(@"started drag outside drag subjects");  
                }  
            }  
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        self.draggedShip = nil;
        // TODO: determine if suitable spot
        self.startingFrame = CGRectZero;
    }
        
    if (self.draggedShip) {
        CGPoint translate = [recognizer translationInView:self.view];
        
        CGRect frame = self.startingFrame;
        frame.origin.x += translate.x;
        frame.origin.y += translate.y;
        self.draggedShip.frame = frame;
        
        NSArray *centerPoints = [self.draggedShip calcCenterPoints];
        [self.gameBoard highlightZones:centerPoints];
    }
}




@end

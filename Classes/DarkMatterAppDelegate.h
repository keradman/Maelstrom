//
//  DarkMatterAppDelegate.h
//  DarkMatter
//
//  Created by Babak Keradman on 5/11/09.
//  Copyright Zarboo Software 2009. All rights reserved.
//
#import "GameViewController.h"

typedef enum {
	kDMGameState_Paused		= 0,
	kDMGameState_Running	= 1
} DMGameState;

@interface DarkMatterAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

    UIWindow *window;
	GameViewController *gameViewController;
	
	DMGameState gameState;
	NSTimer *gameLoopTimer;
	
	BOOL soundEffectsOn;
}

- (IBAction)saveAction:sender;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, readonly) NSString *applicationDocumentsDirectory;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GameViewController *gameViewController;

@property (nonatomic) DMGameState gameState;

@property (nonatomic, assign) BOOL soundEffectsOn;

@end


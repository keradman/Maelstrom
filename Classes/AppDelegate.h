//
//  AppDelegate.h
//  Maelstrom
//
//  Created by Babak Keradman on 5/11/09.
//  Copyright 2012 Maestro Studios. All rights reserved.
//
#import "GameViewController.h"

typedef enum {
	kDMGameState_Paused		= 0,
	kDMGameState_Running	= 1
} DMGameState;

@interface AppDelegate : NSObject <UIApplicationDelegate> {

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

@property (nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (weak, nonatomic, readonly) NSString *applicationDocumentsDirectory;

@property (nonatomic) IBOutlet UIWindow *window;
@property (nonatomic) IBOutlet GameViewController *gameViewController;

@property (nonatomic) DMGameState gameState;

@property (nonatomic, assign) BOOL soundEffectsOn;

@end


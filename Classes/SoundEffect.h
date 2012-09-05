//
//  SoundEffect.h
//  SpeakEasy
//
//  Created by Babak Keradman on 5/1/08.
//  Copyright 2012 Maestro Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface SoundEffect : NSObject {
	NSString *filePath;
	id delegate;
@private
    SystemSoundID _soundID;
}

@property (nonatomic) NSString *filePath;
@property (nonatomic) id delegate;

- (id)initWithContentsOfFile:(NSString *)path;
- (void)play;

@end

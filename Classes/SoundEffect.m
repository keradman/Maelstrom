//
//  SoundEffect.m
//  SpeakEasy
//
//  Created by Babak Keradman on 5/1/08.
//  Copyright 2008 Zarboo Software. All rights reserved.
//

#import "SoundEffect.h"

void SoundCompletionProc (SystemSoundID ssID, void *clientData)
{
	SoundEffect *sound = (SoundEffect *)clientData;
	if(sound.delegate != nil) {
		if([sound.delegate respondsToSelector:@selector(soundEffectDidFinishPlaying:)]){
			[sound.delegate performSelector:@selector(soundEffectDidFinishPlaying:) withObject:sound];
		}
	}
}

@implementation SoundEffect

@synthesize filePath;
@synthesize delegate;

- (id)initWithContentsOfFile:(NSString *)path {    
    if (self = [super init]) {
		filePath = nil;
		delegate = nil;
		self.filePath = path;
		
		NSURL *aFileURL = [NSURL fileURLWithPath:filePath isDirectory:NO];
		if (aFileURL != nil)  {
			SystemSoundID aSoundID;
			OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef)aFileURL, &aSoundID);
			
			if (error == kAudioServicesNoError) { // success
				_soundID = aSoundID;
				AudioServicesAddSystemSoundCompletion(_soundID, NULL, NULL, SoundCompletionProc, self);
			} else {
				NSLog(@"Error %d loading sound at path: %@", error, filePath);
				[self release], self = nil;
			}
		} else {
			NSLog(@"NSURL is nil for path: %@", filePath);
			[self release], self = nil;
		}
    }
    return self;
}

-(void)play {
	if([APPLICATION soundEffectsOn] && _soundID != 0) {
		AudioServicesPlaySystemSound(_soundID);
	} else {
		if(delegate) {
			if([delegate respondsToSelector:@selector(soundEffectDidFinishPlaying:)]) {
				[delegate performSelector:@selector(soundEffectDidFinishPlaying:) withObject:self];
			}
		}
	}
}

-(void)dealloc {
	[filePath release];
	filePath = nil;
	[delegate release];
	delegate = nil;
	if(_soundID != 0) {
		AudioServicesDisposeSystemSoundID(_soundID);
	}
    [super dealloc];
}

@end

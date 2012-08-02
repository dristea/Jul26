//
//  OrsonAppDelegate.h
//  Orson
//
//  Created by NYU User on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>  //for AVAudioPlayer

@interface OrsonAppDelegate: UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> {
	UIWindow *_window;
	AVAudioPlayer *audioPlayer;
	NSURL *videoUrl;
	NSString *last;
}

@property (strong, nonatomic) UIWindow *window;
@end

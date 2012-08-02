//
//  OrsonAppDelegate.m
//  Orson
//
//  Created by NYU User on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "OrsonAppDelegate.h"

@implementation OrsonAppDelegate
@synthesize window = _window;

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions
{
	UIScreen *screen = [UIScreen mainScreen];
	self.window = [[UIWindow alloc] initWithFrame: screen.bounds];
	// Override point for customization after application launch.

	NSBundle *bundle = [NSBundle mainBundle];
	videoUrl = [NSURL URLWithString:@"http://trailers.apple.com/movies/wb/matrix/matrix-ref.mov"];

	NSArray *controllers = [NSArray arrayWithObjects:
		[[UIViewController alloc] initWithNibName: nil bundle: nil],        //"Text"
		[[UIViewController alloc] initWithNibName: nil bundle: nil],        //"Still"
		[[MPMoviePlayerViewController alloc] initWithContentURL: videoUrl], //"Video"
		[[UIViewController alloc] initWithNibName: nil bundle: nil],        //"Theme"
		[[UIViewController alloc] initWithNibName: nil bundle: nil],        //"Web"
		nil
	];

	//The first view is a UITextView.

	UIViewController *viewController = [controllers objectAtIndex: 0];
	viewController.title = @"Text";
	viewController.tabBarItem.image = [UIImage imageNamed: @"Text.png"];
	viewController.view = [[UITextView alloc] initWithFrame: screen.applicationFrame];
	viewController.view.backgroundColor = [UIColor blackColor];

	((UITextView *)viewController.view).editable = NO;
	((UITextView *)viewController.view).textColor = [UIColor whiteColor];
	((UITextView *)viewController.view).font = [UIFont fontWithName: @"Times New Roman" size: 20];

	((UITextView *)viewController.view).text =	//Graham Greene
		@"Fate, it seems, is not without a sense of irony.\n\n"
		@"What is \"real\"? How do you define \"real\"?\n\n"
		@"This is your last chance. After this, there is no turning back. You take the blue pill -- the story ends, you wake up in your bed and believe whatever you want to believe. You take the red pill -- you stay in Wonderland and I show you how deep the rabbit-hole goes.\n\n"
		@"I'm trying to free your mind, Neo. But I can only show you the door. You're the one that has to walk through it.\n\n"
		@"Have you ever had a dream, Neo, that you were so sure was real? What if you were unable to wake from that dream, Neo? How would you know the difference between the dream world and the real world?\n\n"
		@"The Matrix is the world that has been pulled over your eyes to blind you from the truth.\n\n "
		@"What you know you can't explain, but you feel it. You've felt it your entire life, that there's something wrong with the world. You don't know what it is, but it's there, like a splinter in your mind, driving you mad.\n\n"
		@"Unfortunately, no one can be told what the Matrix is. You have to see it for yourself.\n\n"
		@"If real is what you can feel, smell, taste and see, then 'real' is simply electrical signals interpreted by your brain.\n\n "
		@"The Matrix is a system, Neo. That system is our enemy. But when you're inside, you look around, what do you see? Businessmen, teachers, lawyers, carpenters. The very minds of the people we are trying to save. But until we do, these people are still a part of that system and that makes them our enemy. You have to understand, most of these people are not ready to be unplugged. And many of them are so inert, so hopelessly dependent on the system that they will fight to protect it.\n\n"
		@"There is a difference between knowing the path and walking the path.\n\n "
		@"***Start of Dialogue***\n\n"
		@"Trinity: I know why you're here, Neo. I know what you've been doing... why you hardly sleep, why you live alone, and why night after night, you sit by your computer. You're looking for him. I know because I was once looking for the same thing. And when he found me, he told me I wasn't really looking for him. I was looking for an answer. It's the question that drives us, Neo. It's the question that brought you here. You know the question, just as I did. \n\n"
		@"Neo: What is the Matrix? \n\n"
		@"Trinity: The answer is out there, Neo, and it's looking for you, and it will find you if you want it to.\n\n"
		@"***End of Dialogue***";

	//The second view is a UIImageView.

	viewController = [controllers objectAtIndex: 1];
	viewController.title = @"Still";
	viewController.tabBarItem.image = [UIImage imageNamed: @"Still.png"];
	viewController.view = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"morph_neo.jpeg"]];
	viewController.view.contentMode = UIViewContentModeCenter;

	/*
	The third view is not a view at all.  But it has a MPMoviePlayerController.

	"After all, it's not that awful.  But what the fellow says, in Italy for thirty years
	under the Borgias they had warfare, terror, murder, bloodshed, but they produced Michaelangelo,
	Leonardo da Vinci, and the Renaissance.  In Switzerland, they had brotherly love.  They had five
	hundred years of democracy and peace.  And what did that produce?  The cuckoo clock."
	*/

	viewController = [controllers objectAtIndex: 2];
	viewController.title = @"Video";
	viewController.tabBarItem.image = [UIImage imageNamed: @"Video.png"];

	((MPMoviePlayerViewController *)viewController).moviePlayer.shouldAutoplay = NO;
	((MPMoviePlayerViewController *)viewController).moviePlayer.initialPlaybackTime = 3.27;
	[((MPMoviePlayerViewController *)viewController).moviePlayer prepareToPlay];

	//There is no fourth view.  But there is a fourth view controller.  Its view property is nil.

	viewController = [controllers objectAtIndex: 3];
	viewController.title = @"Theme";
	viewController.tabBarItem.image = [UIImage imageNamed: @"Theme.png"];

	NSURL *audioUrl = [NSURL fileURLWithPath: [bundle pathForResource: @"RainMan" ofType: @"mp3"]];
	
	
	
	NSError *error = nil;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: audioUrl error: &error];
	if (audioPlayer == nil) {
		NSLog(@"error == %@", error);
		return YES;
	}
	audioPlayer.numberOfLoops = -1; //infinite

	//The fifth view is a UIWebView.  The m. in the url stands for "mobile".

	viewController = [controllers objectAtIndex: 4];
	viewController.tabBarItem.image = [UIImage imageNamed: @"Postericon.png"];
	viewController.title = @"Web";
	UIWebView *webView = [[UIWebView alloc] initWithFrame: screen.applicationFrame];
	viewController.view = webView;
	webView.scalesPageToFit = YES;

	NSURL *webUrl = [NSURL URLWithString: @"http://en.wikipedia.org/wiki/The_Matrix"];
	NSData *data = [NSData dataWithContentsOfURL: webUrl];
	
	if (data == nil) {
		NSLog(@"could not load URL %@", webUrl);
		return YES;
	}
	[webView loadData: data MIMEType: @"text/html" textEncodingName: @"NSUTF8StringEncoding" baseURL: webUrl];

	UITabBarController *tabBarController = [[UITabBarController alloc] init];
	self.window.rootViewController = tabBarController;
	tabBarController.viewControllers = controllers;
	tabBarController.delegate = self;
	last = ((UIViewController *)[tabBarController.viewControllers objectAtIndex: 0]).title;
	[self.window makeKeyAndVisible];
	return YES;
}

- (void) applicationWillResignActive: (UIApplication *) application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void) applicationDidEnterBackground: (UIApplication *) application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void) applicationWillEnterForeground: (UIApplication *) application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void) applicationDidBecomeActive: (UIApplication *) application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void) applicationWillTerminate: (UIApplication *) application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}



#pragma mark -
#pragma mark Protocol UITabBarControllerDelegate

- (void) tabBarController: (UITabBarController *)
	tabBarController didSelectViewController: (UIViewController *) viewController {

	if ([last isEqualToString: @"Video"] && ![viewController.title isEqualToString: @"Video"]) {
		//We are leaving the Video tab.

		MPMoviePlayerViewController *moviePlayerViewController =
			[tabBarController.viewControllers objectAtIndex: 2];

		MPMoviePlayerController *moviePlayerController = moviePlayerViewController.moviePlayer;
		NSTimeInterval currentPlaybackTime = moviePlayerController.currentPlaybackTime;
		moviePlayerController.contentURL = videoUrl;
		moviePlayerController.initialPlaybackTime = currentPlaybackTime;
		[moviePlayerController prepareToPlay];
	}

	if ([viewController.title isEqualToString: @"Theme"]) {
		//We are arriving at the Audio tab.
		[audioPlayer play];
	} else if ([last isEqualToString: @"Theme"]) {
		//We are leaving the Audio tab.
		[audioPlayer pause];
	}

	last = viewController.title;
}


@end

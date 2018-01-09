//
//  AppDelegate.m
//  Wave
//
//  Created by Hardik Hadwani on 10/12/16.
//  Copyright © 2016 HardikHadwani. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabViewController.h"
#import "LandingPageController.h"

@interface AppDelegate ()
{
    MainTabViewController *tab;
    LandingPageController *landingPage;
    BOOL isInternetOn;

}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    tab = [[MainTabViewController alloc] initWithNibName:@"MainTabViewController" bundle:nil];
    
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setBackgroundColor:DEFAULT_COLOR_NAV_Tint];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD setFont:[UIFont fontWithName:App_Font size:16]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent
                                                animated:YES];
    if ([self Check_NetworkStatus_FirstTime] == TRUE)
    {
        isInternetOn = TRUE;
    }
    else
    {
        isInternetOn = FALSE;
        
    }
    
    self.internetConnectionReach = [Reachability reachabilityForInternetConnection];
    
    self.internetConnectionReach.reachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@" InternetConnection Says Reachable(%@)", reachability.currentReachabilityString];
        NSLog(@"%@", temp);
        
        
    };
    
    self.internetConnectionReach.unreachableBlock = ^(Reachability * reachability)
    {
        NSString * temp = [NSString stringWithFormat:@"InternetConnection Block Says Unreachable(%@)", reachability.currentReachabilityString];
        
        NSLog(@"%@", temp);
        
    };
    [self.internetConnectionReach startNotifier];

    [self goToLandingPage];

    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}
-(void)goToLandingPage
{
    landingPage = [[LandingPageController alloc] initWithNibName:@"LandingPageController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:landingPage];
    nav.navigationBar.hidden=true;
    self.window.rootViewController = nav;
    
    
    [self.window makeKeyAndVisible];
}

-(void)goToHome
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tab];
    self.window.rootViewController = nav;
    nav.navigationBar.hidden=true;
    [self.window makeKeyAndVisible];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)reachabilityChanged:(NSNotification*)notification
{
    Reachability* reachability = notification.object;
    if(reachability.currentReachabilityStatus == NotReachable)
    {
        NSLog(@"Internet off");
        
        isInternetOn = FALSE;
        
        [SVProgressHUD dismiss];
        
        //[self InternetDownError];
        
    }
    else
    {
        NSLog(@"Internet on");
        
        isInternetOn = TRUE;
        
        //LoadNewChats and Chat Messages
        // [self GetChatUserList_In_Background_Start_Appdelegate];
        // [self LoadNewChatMessages_Appdelegate];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateTopbar_Chat" object:nil userInfo:nil];
    
    
    
}


- (BOOL) Check_NetworkStatus
{
    if (isInternetOn == TRUE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
    
    return FALSE;
    
}

- (BOOL) Check_NetworkStatus_FirstTime
{
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    switch (internetStatus) {
            
        case NotReachable:
        {
            
            return FALSE;
            
            break;
        }
            
        case ReachableViaWiFi:
        {
            
            return TRUE;
            
            break;
        }
        case ReachableViaWWAN:
        {
            
            return TRUE;
            
            break;
        }
            
        default:
            break;
    }
    
    return FALSE;
    
}

#pragma mark.. Uitextfield component
-(void)textFieldPadding:(UITextField *)txtField
{
    //    CALayer *border = [CALayer layer];
    //    CGFloat borderWidth = 1;
    //    border.borderColor = [UIColor darkGrayColor].CGColor;
    //    border.frame = CGRectMake(0,  txtField.frame.size.height - borderWidth, txtField.frame.size.width, txtField.frame.size.height);
    //    border.borderWidth = borderWidth;
    //    [txtField.layer addSublayer:border];
    [txtField setTextColor:[UIColor whiteColor]];
    
    [txtField setFont:[UIFont fontWithName:App_Font_Medium size:16]];
    
    [txtField setTextAlignment:NSTextAlignmentCenter];
    [txtField setTintColor:[UIColor blackColor]];
    
    [txtField setBackground:[UIImage imageNamed:@"emply_textfield"]];
    [txtField setBackgroundColor:[UIColor clearColor]];
    [txtField setValue:[UIColor colorWithWhite:0.8 alpha:1]
            forKeyPath:@"_placeholderLabel.textColor"];
    
    txtField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //    [txtField.layer setBorderWidth:1];
    //    [txtField.layer setBorderColor:DEFAULT_COLOR_NAV.CGColor];
    //    txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString: txtField.placeholder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    //    white bg , dark grey border(1.0) and corner radius(3)
}
@end

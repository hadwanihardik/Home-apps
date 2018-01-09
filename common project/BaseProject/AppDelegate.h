//
//  AppDelegate.h
//  Wave
//
//  Created by Hardik Hadwani on 10/12/16.
//  Copyright © 2016 HardikHadwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong) Reachability * internetConnectionReach,*WifiConnectionReach;
- (BOOL) Check_NetworkStatus;
-(void)goToHome;
-(void)textFieldPadding:(UITextField *)txtField;


@end


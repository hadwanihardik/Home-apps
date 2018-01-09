//
//  MainTabViewController.h
//  HomeCheifApp
//
//  Created by Hardik Hadwani on 18/10/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
@interface MainTabViewController : UITabBarController <UITabBarDelegate>
{

}
@property(nonatomic,retain)HomeViewController *home;
@property(nonatomic,retain)HomeViewController *home1;
@property(nonatomic,retain)HomeViewController *home2;

@end

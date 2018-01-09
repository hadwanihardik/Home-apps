//
//  MainTabViewController.m
//  HomeCheifApp
//
//  Created by Hardik Hadwani on 18/10/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//

#import "MainTabViewController.h"
@interface MainTabViewController ()
{
    NSMutableArray *arrayViewControllers;
}
@end

@implementation MainTabViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.home1 = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.home2 = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
   
  
   // UITabBar.appearance().tintColor = UIColor.whiteColor()
    // Sets the default color of the background of the UITabBar
    //UITabBar.appearance().barTintColor = UIColor.init(colorLiteralRed: 55/255.0, green: 60/255.0, blue: 73/255.0, alpha: 1.0)
     [[UITabBar appearance] setTintColor:[UIColor  colorWithRed:243/255.0 green:122/255.0 blue:34/255.0 alpha:1 ]];
     [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    
    self.home.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"Settings_navbar_icon"] tag:1];
     self.home1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"Settings_navbar_icon"] tag:2];
     self.home2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"Settings_navbar_icon"] tag:3];
    

    arrayViewControllers = kMutableArray;
//    [self.allDishes viewWillAppear:YES];
    [arrayViewControllers addObject:self.home];
    [arrayViewControllers addObject:self.home1];
    [arrayViewControllers addObject:self.home2];
  

    self.viewControllers = arrayViewControllers;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

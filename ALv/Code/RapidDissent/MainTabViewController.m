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
    self.feedPage = [[FeedViewController alloc] initWithNibName:@"FeedViewController" bundle:nil];
    self.home1 = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.profileView = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    self.createFeed = [[CreateFeedViewController alloc] initWithNibName:@"CreateFeedViewController" bundle:nil];

    self.groupPage = [[GroupListViewController alloc] initWithNibName:@"GroupListViewController" bundle:nil];
  
   // UITabBar.appearance().tintColor = UIColor.whiteColor()
    // Sets the default color of the background of the UITabBar
    //UITabBar.appearance().barTintColor = UIColor.init(colorLiteralRed: 55/255.0, green: 60/255.0, blue: 73/255.0, alpha: 1.0)

    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
    
    if ([[UITabBar appearance] respondsToSelector:@selector(setUnselectedItemTintColor:)])
    {
        [[UITabBar appearance] setUnselectedItemTintColor:[UIColor whiteColor]];
    }

  //  [[UITabBar appearance] setBarTintColor:[UIColor  colorWithRed:100/255.0 green:28/255.0 blue:30/255.0 alpha:1 ]];
//    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor  colorWithRed:106/255.0 green:29/255.0 blue:33/255.0 alpha:1 ]];
    
    [self.tabBar setSelectionIndicatorImage :[UIImage imageNamed:@"tabActive"]];
    
    UIImage *selTab = [[UIImage imageNamed:@"tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CGSize tabSize = CGSizeMake(CGRectGetWidth(self.view.frame)/4, self.tabBar.frame.size.height);
    UIGraphicsBeginImageContext(tabSize);
    [selTab drawInRect:CGRectMake(0, 0, tabSize.width, tabSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.tabBar setBackgroundImage:reSizeImage];

    
     self.feedPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"feed"] tag:1];
     self.groupPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"group"] tag:2];

    self.createFeed.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"camera"] tag:4];
    self.profileView.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"user"] tag:3];



    arrayViewControllers = kMutableArray;
//    [self.allDishes viewWillAppear:YES];
    [arrayViewControllers addObject:self.feedPage];
    [arrayViewControllers addObject:self.groupPage];
    [arrayViewControllers addObject:self.createFeed];
    [arrayViewControllers addObject:self.profileView];



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

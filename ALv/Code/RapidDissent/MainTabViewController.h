//
//  MainTabViewController.h
//  HomeCheifApp
//
//  Created by Hardik Hadwani on 18/10/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "CreateFeedViewController.h"
#import "ProfileViewController.h"
#import "GroupListViewController.h"


#import "FeedViewController.h"
@interface MainTabViewController : UITabBarController <UITabBarDelegate>
{

}

@property(nonatomic,retain) ProfileViewController *profileView;
@property(nonatomic,retain)HomeViewController *home1,*home2;
@property(nonatomic,retain)CreateFeedViewController *createFeed;
@property(nonatomic,retain)FeedViewController *feedPage;
@property(nonatomic,retain)GroupListViewController *groupPage;

@end

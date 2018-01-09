//
//  ProfileViewController.h
//  RapidDissent
//
//  Created by Hardik on 2/26/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentViewController.h"

@interface ProfileViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIImageView *imgProfilePic;
    IBOutlet UILabel *lblUserName;
    NSMutableArray *arrayFeeds;
    CommentViewController *commentView;


}
@property (weak, nonatomic) IBOutlet UITableView *tblFeed;

@end

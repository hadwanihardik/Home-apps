//
//  FeedViewController.h
//  RapidDissent
//
//  Created by Hardik on 3/1/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentViewController.h"

@interface FeedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    UIRefreshControl *refreshControl;
    NSMutableArray *arrayFeeds;
    CommentViewController *commentView;
}
@property (weak, nonatomic) IBOutlet UITableView *tblFeed;

@end

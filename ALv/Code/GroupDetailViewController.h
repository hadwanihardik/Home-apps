//
//  GroupDetailViewController.h
//  RapidDissent
//
//  Created by Hardik on 5/22/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{

}
@property (nonatomic,retain) NSMutableDictionary *selectedGroup;
@property (nonatomic,retain) IBOutlet UITableView *tblGroupDetail;

@end

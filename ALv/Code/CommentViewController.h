//
//  CommentViewController.h
//  RapidDissent
//
//  Created by Hardik on 4/27/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrayComments;
}
@property(nonatomic,retain) NSString *postId;
@property (weak, nonatomic) IBOutlet UILabel *lblErrorMessage;
@property (weak, nonatomic) IBOutlet UITextView *txtComment;
@property (weak, nonatomic) IBOutlet UITableView *tblComments;
@end

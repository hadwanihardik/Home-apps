//
//  FeedCellWithoutImage.h
//  RapidDissent
//
//  Created by Hardik on 6/15/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCellWithoutImage : UITableViewCell
{

}
@property (weak, nonatomic) IBOutlet UIButton *btnProfile;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPhotos;
@property (weak, nonatomic) IBOutlet UILabel *postTime;
@property (weak, nonatomic) IBOutlet UILabel *postText;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;

@property (nonatomic, retain)  NSMutableDictionary *dictData;
- (IBAction)sharePost:(id)sender;

@end

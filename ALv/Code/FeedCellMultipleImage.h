//
//  FeedCell.h
//  RapidDissent
//
//  Created by Hardik on 3/9/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCellMultipleImage : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnProfile;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPhotos;
@property (weak, nonatomic) IBOutlet UILabel *postTime;
@property (weak, nonatomic) IBOutlet UILabel *postText;
@property (weak, nonatomic) IBOutlet UIImageView *postImage1;
@property (weak, nonatomic) IBOutlet UIImageView *postImage2;
@property (nonatomic, retain)  NSMutableDictionary *dictData;

- (IBAction)sharePost:(id)sender;
@end

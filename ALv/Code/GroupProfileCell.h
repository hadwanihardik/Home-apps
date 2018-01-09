//
//  GroupProfileCell.h
//  RapidDissent
//
//  Created by Hardik on 5/26/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imvCoverImage;
@property (weak, nonatomic) IBOutlet UIImageView *imvGroupProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupTagLine;
@property (weak, nonatomic) IBOutlet UIButton *btnMembers;
@property (weak, nonatomic) IBOutlet UIButton *btnPhotos;
@property (weak, nonatomic) IBOutlet UIButton *btnVideos;

@end

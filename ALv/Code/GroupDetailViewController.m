//
//  GroupDetailViewController.m
//  RapidDissent
//
//  Created by Hardik on 5/22/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import "GroupDetailViewController.h"
#import "GroupProfileCell.h"
#import "FeedCellOneImage.h"
@interface GroupDetailViewController ()

@end

@implementation GroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.selectedGroup);
    [self.tblGroupDetail registerNib:[UINib nibWithNibName:@"FeedCellOneImage" bundle:nil] forCellReuseIdentifier:@"FeedCellOneImage"];
    [self.tblGroupDetail registerNib:[UINib nibWithNibName:@"GroupProfileCell" bundle:nil] forCellReuseIdentifier:@"GroupProfileCell"];

    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(id)sender {
    kPopView();
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;//[self.selectedGrpup objectForKey:@"comments"];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *feedCellWithOneImage = @"FeedCellOneImage";
    static NSString *groupProfileCell = @"GroupProfileCell";

    // static NSString *feedCell = @"FeedCell";
    
   // NSDictionary *feedDict = [arrayFeeds objectAtIndex:indexPath.row];
  
    if(indexPath.row == 0 )
        {
            GroupProfileCell *cell = (GroupProfileCell *)[tableView dequeueReusableCellWithIdentifier:groupProfileCell];
            
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GroupProfileCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
                           cell = (GroupProfileCell *)[tableView dequeueReusableCellWithIdentifier:groupProfileCell];
                
            cell.lblGroupName.text = [self.selectedGroup valueForKey:kName];
            cell.lblGroupTagLine.text = [self.selectedGroup valueForKey:kDescription];
            cell.imvGroupProfileImage.clipsToBounds = YES;
            cell.imvGroupProfileImage.layer.cornerRadius = 70 ;
            cell.imvGroupProfileImage.layer.borderWidth = 2;
            cell.imvGroupProfileImage.layer.borderColor = [UIColor whiteColor].CGColor;
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:GetImageURL([self.selectedGroup valueForKey:kImage])] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image && finished) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^
                     {
                         [cell.imvGroupProfileImage setImage:image];
                         // Cache image to disk or memory
                         [[SDImageCache sharedImageCache] storeImage:image forKey:[self.selectedGroup valueForKey:kImage] toDisk:YES];
                     }];
                }
            }];
            return cell;

            
        }
    else
        {
            FeedCellOneImage *cell = (FeedCellOneImage *)[tableView dequeueReusableCellWithIdentifier:groupProfileCell];
            
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FeedCellOneImage" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell = (FeedCellOneImage *)[tableView dequeueReusableCellWithIdentifier:feedCellWithOneImage];
            return cell;

        }
    
    
//    cell.dictData = feedDict;
//    cell.tag = indexPath.row;
//    cell.postText.text = [feedDict valueForKey:kPostText];
//    cell.postTime.text = [MyMacros timtSince:[feedDict valueForKey:kInsertedTime]];
//    cell.profileName.text = [feedDict valueForKey:kFeedUserName];
//    
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:GetImageURL([feedDict valueForKey:kUserPhoto])] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//        if (image && finished) {
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^
//             {
//                 [cell.btnProfile setImage:image forState:UIControlStateNormal];
//                 // Cache image to disk or memory
//                 [[SDImageCache sharedImageCache] storeImage:image forKey:[feedDict valueForKey:kUserPhoto] toDisk:YES];
//             }];
//        }
//    }];
    
//    if([[feedDict valueForKey:kFileName] length] !=  0)
//    {
//        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:GetImageURL([feedDict valueForKey:kFileName])] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//            if (image && finished) {
//                [[NSOperationQueue mainQueue] addOperationWithBlock:^
//                 {
//                     cell.postImage1.image = image;
//                     [[SDImageCache sharedImageCache] storeImage:image forKey:[feedDict valueForKey:kFileName] toDisk:YES];
//                 }];
//            }
//        }];
//    }
//    else
//    {
//        cell.heightOfPostImage.constant = 0;
//        [cell layoutSubviews];
//    }
//    
//    [cell.btnComment addTarget:self action:@selector(commentPost:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 280.0;
    }
    else
    {
        return 284.0;
    }
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

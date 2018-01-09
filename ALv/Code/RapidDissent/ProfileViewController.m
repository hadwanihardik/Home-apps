//
//  ProfileViewController.m
//  RapidDissent
//
//  Created by Hardik on 2/26/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import "ProfileViewController.h"
#import "FeedCellWithoutImage.h"
#import "FeedCellOneImage.h"
@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePic;
@property (weak, nonatomic) IBOutlet UIImageView *imgCoverImage;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblTagLine;
@property (weak, nonatomic) IBOutlet UITableView *taableViewFeed;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayFeeds = [NSMutableArray new];
    commentView = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];

    imgProfilePic.layer.cornerRadius = 60;//_btnProfilePic.frame.size.width/2; // this value vary as per your desire
    imgProfilePic.clipsToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getUserData];
    self.lblUserName.text = [[kPref valueForKey:kUserData] valueForKey:@"username"];
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:GetImageURL(getUserDataFromPref(kPhoto))] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//        if (image && finished) {
//            self.imgProfilePic.image = image;
//            // Cache image to disk or memory
//            [[SDImageCache sharedImageCache] storeImage:image forKey:(getUserDataFromPref(kUserPhoto)) toDisk:YES];
//        }
//    }];

}
- (IBAction)btnPhotosTapped:(id)sender {
}
- (IBAction)btnVideoTapped:(id)sender {
}
- (IBAction)btnCreateVoiceTapped:(UIButton *)sender {
}
- (IBAction)btnFriendRequestTapped:(id)sender {
}
- (IBAction)btnFriendsTapped:(id)sender {
}

-(void)getUserData
{
 //   [[kPref valueForKey:kUserData] valueForKey:@"username"]
    
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:[[kPref valueForKey:kUserData] valueForKey:@"username"] forKey:@"username"];
    
      ShowProgress(msgLoading)
    apiHandler.responseWithDict=^(NSDictionary *dict)
    {
        NSLog(@"CheckUsername Reponse :%@",dict);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             [self getFeeds];
             HideProgress()
                  [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:GetImageURL([[[dict valueForKey:kRecords] objectAtIndex:0] valueForKey:@"photo"])] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                 if (image && finished) {
                     imgProfilePic.image = image;
                     // Cache image to disk or memory
                     [[SDImageCache sharedImageCache] storeImage:image forKey:[[[dict valueForKey:kRecords] objectAtIndex:0] valueForKey:@"photo"] toDisk:YES];
                 }
             }];

         }];
    };
    
    apiHandler.responseFailMessage = ^(NSString *errorMessage)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress()
             ShowErrorMessageL(errorMessage);
             
         }];
    };
    apiHandler.responseFail=^()
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress()
             ShowErrorMessageL(FailedToConnect(CheckUsername));

         }];
        
    };
    
    [apiHandler postApiCallOfUrl:GetURL(CheckUsername) parameter:dict];
}

-(void)getFeeds
{
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:getUserDataFromPref(kId) forKey:kUserid];
    
    apiHandler.responseWithDict=^(NSDictionary *dict)
    {
        //NSLog(@"PostFeed Reponse :%@",dict);
        arrayFeeds =  [dict valueForKey:kRecords];
        NSLog(@"feelLsit : %@",arrayFeeds);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             [self.tblFeed reloadData];
             HideProgress()
             if(arrayFeeds.count==0)
             {
                 ShowErrorMessageL(NoFeeds);
                 
             }
         }];
        
    };
    apiHandler.responseFailMessage = ^(NSString *errorMessage)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress()
             ShowErrorMessageL(errorMessage);
             
         }];
    };
    
    apiHandler.responseFail=^()
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress()
             ShowErrorMessageL(FailedToConnect(GetPosts));
         }];
        
    };
    
    [apiHandler postApiCallOfUrl:GetURL(GetPosts) parameter:dict];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayFeeds.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *feedCellWithOneImage = @"FeedCellOneImage";
    static NSString *feedCellNoImage = @"FeedCellWithoutImage";
    
    NSDictionary *feedDict = [arrayFeeds objectAtIndex:indexPath.row];
    if([[feedDict valueForKey:kFileName] length] !=  0)
    {
        
        FeedCellOneImage *cell = [tableView dequeueReusableCellWithIdentifier:feedCellWithOneImage];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FeedCellOneImage" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.dictData = feedDict;
        cell.tag = indexPath.row;
        cell.postText.text = [feedDict valueForKey:kPostText];
        cell.postTime.text = [MyMacros timtSince:[feedDict valueForKey:kInsertedTime]];
        cell.profileName.text = [feedDict valueForKey:kFeedUserName];
        
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:GetImageURL([feedDict valueForKey:kUserPhoto])] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image && finished) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^
                 {
                     [cell.btnProfile setImage:image forState:UIControlStateNormal];
                     // Cache image to disk or memory
                     [[SDImageCache sharedImageCache] storeImage:image forKey:[feedDict valueForKey:kUserPhoto] toDisk:YES];
                 }];
            }
        }];
        
        if([[feedDict valueForKey:kFileName] length] !=  0)
        {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:GetImageURL([feedDict valueForKey:kFileName])] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image && finished) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^
                     {
                         cell.postImage1.image = image;
                         [[SDImageCache sharedImageCache] storeImage:image forKey:[feedDict valueForKey:kFileName] toDisk:YES];
                     }];
                }
            }];
        }
        
        [cell.btnComment addTarget:self action:@selector(commentPost:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    else
    {
        FeedCellWithoutImage *cell = [tableView dequeueReusableCellWithIdentifier:feedCellNoImage];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FeedCellWithoutImage" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.dictData = feedDict;
        cell.tag = indexPath.row;
        cell.postText.text = [feedDict valueForKey:kPostText];
        cell.postTime.text = [MyMacros timtSince:[feedDict valueForKey:kInsertedTime]];
        cell.profileName.text = [feedDict valueForKey:kFeedUserName];
        
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:GetImageURL([feedDict valueForKey:kUserPhoto])] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image && finished) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^
                 {
                     [cell.btnProfile setImage:image forState:UIControlStateNormal];
                     // Cache image to disk or memory
                     [[SDImageCache sharedImageCache] storeImage:image forKey:[feedDict valueForKey:kUserPhoto] toDisk:YES];
                 }];
            }
        }];
        
        [cell.btnComment addTarget:self action:@selector(commentPost:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
    
}

- (void)commentPost:(UIButton *)sender {
    [commentView didMoveToParentViewController:self];
    [commentView.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    commentView.postId= [[arrayFeeds objectAtIndex:[[[sender superview] superview] superview].tag] valueForKey:kId];
    [self.view addSubview:commentView.view];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[subview]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:@{ @"subview" : commentView.view}]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[subview]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:@{ @"subview" : commentView.view}]];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[arrayFeeds objectAtIndex:indexPath.row] valueForKey:kFileName] length] !=  0)
    {
        return 284.0;
    }
    else
    {
        return 160.0;
    }
}




- (IBAction)logout:(id)sender {
        
    [kPref setValue:false forKey:kIsLogin];
    [kAppDelegate goToLandingPage];
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

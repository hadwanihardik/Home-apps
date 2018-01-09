 //
//  FeedViewController.m
//  RapidDissent
//
//  Created by Hardik on 3/1/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedCellWithoutImage.h"
#import "FeedCellOneImage.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor whiteColor];
    refreshControl.tintColor = [UIColor blackColor];
    [refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
    [_tblFeed addSubview:refreshControl];
    commentView = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
    arrayFeeds = [NSMutableArray new];
    // Do any additional setup after loading the view from its nib.
    ShowProgress(msgLoading)

}
- (void)viewWillAppear:(BOOL)animated
{
    [self getFeeds];

}
- (void)reloadData
{
    // Reload table data
    [self getFeeds];
    
    // End the refreshing
    if (refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;
        
    }
}
-(void)getFeeds
{
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:getUserDataFromPref(kId) forKey:kUserid];
    
    apiHandler.responseWithDict=^(NSDictionary *dict)
    {
        //NSLog(@"PostFeed Reponse :%@",dict);
        [arrayFeeds removeAllObjects];
        for(NSDictionary *dictData in [dict valueForKey:kRecords])
        {

            NSMutableArray *dict1  =  [dictData mutableCopy];
            NSString *jsonString = [dictData valueForKey:kLikers];
            [dict1 setValue:@"1" forKey:kIsLiked];

            if(jsonString.length != 2)
            {
                NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSArray *likers=[json allKeys];
                
                if([likers containsObject:getUserDataFromPref(kId)])
                {
                    [dict1 setValue:@"0" forKey:kIsLiked];
                }
            }
            
            [arrayFeeds addObject:dict1];
        }
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             [refreshControl endRefreshing];
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
             [refreshControl endRefreshing];
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
        cell.tag = indexPath.row;
        cell.postText.text = [feedDict valueForKey:kPostText];
        cell.postTime.text = [MyMacros timtSince:[feedDict valueForKey:kInsertedTime]];
        cell.profileName.text = [feedDict valueForKey:kFeedUserName];
        
        if([[feedDict valueForKey:kIsLiked] isEqualToString:@"0"])
        {
            [cell.btnLike setImage:[UIImage imageNamed:@"likeS"] forState:UIControlStateNormal];
            [cell.btnLike setImage:[UIImage imageNamed:@"likeS"] forState:UIControlStateSelected];
        }
        else
        {
            [cell.btnLike setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
            [cell.btnLike setImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
        }

       
        
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
        [cell.btnLike addTarget:self action:@selector(likePost:) forControlEvents:UIControlEventTouchUpInside];

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
        cell.tag = indexPath.row;
        cell.postText.text = [feedDict valueForKey:kPostText];
        cell.postTime.text = [MyMacros timtSince:[feedDict valueForKey:kInsertedTime]];
        cell.profileName.text = [feedDict valueForKey:kFeedUserName];
        cell.dictData = [feedDict mutableCopy];

        if([[feedDict valueForKey:kIsLiked] isEqualToString:@"0"])
        {
            [cell.btnLike setImage:[UIImage imageNamed:@"likeS"] forState:UIControlStateNormal];
            [cell.btnLike setImage:[UIImage imageNamed:@"likeS"] forState:UIControlStateSelected];
        }
        else
        {
            [cell.btnLike setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
            [cell.btnLike setImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
        }

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
        [cell.btnLike addTarget:self action:@selector(likePost:) forControlEvents:UIControlEventTouchUpInside];

        return cell;

    }
    
}
- (void)likePost:(UIButton *)sender {
    
    NSDictionary *dictData =  [arrayFeeds objectAtIndex:[[[sender superview] superview] superview].tag];
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:getUserDataFromPref(kId) forKey:kUserid];
    [dict setValue:[dictData valueForKey:kId] forKey:kPostId];
    //    ShowProgress(msgLoading)
    apiHandler.responseWithDict=^(NSDictionary *dict)
    {
        NSLog(@"PostFeed Reponse :%@",dict);
    };
    
    apiHandler.responseFail=^()
    {
        
    };
    
    if([[dictData valueForKey:kIsLiked] isEqualToString:@"0"])
    {
        [apiHandler postApiCallOfUrl:GetURL(UnLikeComment) parameter:dict];
        [sender setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [dictData setValue:@"1" forKey:kIsLiked];


    }
    else
    {
        [apiHandler postApiCallOfUrl:GetURL(LikeComment) parameter:dict];
        [sender setImage:[UIImage imageNamed:@"likeS"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"likeS"] forState:UIControlStateNormal];
        [dictData setValue:@"0" forKey:kIsLiked];

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

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if([[[arrayFeeds objectAtIndex:indexPath.row] valueForKey:kFileName] length] !=  0)
//    {
//        return 284.0;
//    }
//    else
//    {
//        return 150.0;
//    }
//}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[arrayFeeds objectAtIndex:indexPath.row] valueForKey:kFileName] length] !=  0)
            {
                return 284.0;
            }
            else
            {
                return 150.0;
            }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
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

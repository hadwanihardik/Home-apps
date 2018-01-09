//
//  GroupListViewController.m
//  RapidDissent
//
//  Created by Bunti Nizama on 5/3/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import "GroupListViewController.h"
#import "GroupCell.h"
#import "GroupDetailViewController.h"
@interface GroupListViewController ()

@end

@implementation GroupListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.collectionViewGroups.registerNib(UINib(nibName: "your_xib_name", bundle: nil), forCellWithReuseIdentifier: "your_reusable_identifier")
    [self.collectionViewGroups registerNib:[UINib nibWithNibName:@"GroupCell" bundle:nil] forCellWithReuseIdentifier:@"GroupCell"];
    arrayGroups = kMutableArray;
    ShowProgress(msgLoading)

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getGroups];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getGroups
{
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:getUserDataFromPref(kId) forKey:kUserid];
    
    apiHandler.responseWithDict=^(NSDictionary *dict)
    {
        //NSLog(@"PostFeed Reponse :%@",dict);
        arrayGroups =  [[dict valueForKey:kGroups] valueForKey:kRecords];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             [self.collectionViewGroups reloadData];
             HideProgress()
             if(arrayGroups.count==0)
             {
                 ShowErrorMessageL(NoGroup);
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
             ShowErrorMessageL(FailedToConnect(GetGroupsList));
         }];
        
    };
    
    [apiHandler postApiCallOfUrl:GetURL(GetGroupsList) parameter:dict];
}

#pragma mark : Collection View Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arrayGroups.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(collectionView.frame.size.width/3 -2, collectionView.frame.size.width/3 + 35);
}

- (GroupCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupCell" forIndexPath:indexPath];
    cell.imgGroupIcon.clipsToBounds = YES;
    cell.imgGroupIcon.layer.cornerRadius = (collectionView.frame.size.width/3 -32) / 2 ;
    cell.imgGroupIcon.layer.borderWidth = 1;
    cell.imgGroupIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    //Add your cell Values here
    NSDictionary *groupDict = [arrayGroups objectAtIndex:indexPath.row];
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:GetImageURL([groupDict valueForKey:kImage])] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if (image && finished) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^
             {
                 cell.imgGroupIcon.image = image;
                 [[SDImageCache sharedImageCache] storeImage:image forKey:[groupDict valueForKey:kImage] toDisk:YES];
             }];
        }
    }];
    cell.lblGroupName.text = [NSString stringWithFormat:@"%@",[groupDict valueForKey:kName]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupDetailViewController *groupDetail = [[GroupDetailViewController alloc] initWithNibName:@"GroupDetailViewController" bundle:nil];
    groupDetail.selectedGroup = [arrayGroups objectAtIndex:indexPath.row];
    kPushView(groupDetail);
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

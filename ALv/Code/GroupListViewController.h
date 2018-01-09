//
//  GroupListViewController.h
//  RapidDissent
//
//  Created by Bunti Nizama on 5/3/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupListViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *arrayGroups;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewGroups;

@end

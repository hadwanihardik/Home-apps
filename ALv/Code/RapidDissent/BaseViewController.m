//
//  BaseViewController.m
//
//  Created by Hardik Hadwani on 18/10/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   [[[NSBundle mainBundle] loadNibNamed:@"BaseViewController" owner:self options:nil] objectAtIndex:0];

    // Do any additional setup after loading the view from its nib.
}



-(void)addToContainerView:(UIView *)newView
{

    newView.translatesAutoresizingMaskIntoConstraints = false;
    [self.containerView addSubview:newView];
    NSMutableDictionary *viewBindingsDict = [[NSMutableDictionary alloc] init];
    [viewBindingsDict setObject:newView forKey:@"newView"];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[newView]|" options:0 metrics:nil views:viewBindingsDict]];
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[newView]|" options:0 metrics:nil views:viewBindingsDict]];

    
    
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

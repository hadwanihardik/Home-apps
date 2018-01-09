//
//  LandingPageController.m
//  Wave
//
//  Created by Hardik Hadwani on 10/12/16.
//  Copyright © 2016 HardikHadwani. All rights reserved.
//

#import "LandingPageController.h"
#import "SignInViewController.h"
#import "SignUpViewController.h"

@interface LandingPageController ()

@end

@implementation LandingPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)handlerSignIn:(id)sender {
    SignInViewController *signin=[[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
    kPushView(signin);
    
}

- (IBAction)handlerSignUp:(id)sender {
    SignUpViewController *signup=[[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    kPushView(signup);
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

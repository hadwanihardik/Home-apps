//
//  ForgotPasswordViewController.m
//  Created by Hardik Hadwani on 10/20/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//


#import "ForgotPasswordViewController.h"
#import "AppDelegate.h"
#import "UIView+firstResponder.h"

@interface ForgotPasswordViewController ()
{
    NSMutableData *registerData;
    NSURLConnection *registerConnection;

}
@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.txtusername.font = [UIFont fontWithName:App_Font size:16];
    self.txtusername.placeholder=Localized(kEmailAddress);
    self.SubmitBtn.layer.cornerRadius = 3;
    self.SubmitBtn.titleLabel.font = [UIFont fontWithName:App_Font size:15];
    [self.SubmitBtn setTitle:Localized(kContinue)forState:UIControlStateNormal];
    [self.txtusername setTintColor:[UIColor blackColor]];
    [kAppDelegate textFieldPadding:self.txtusername];

}



#pragma mark - ForgotPassword_Start Method

-(IBAction)ForgotPassword_Start:(id)sender
{
    if (![MyMacros ValidateEmail:_txtusername.text])
    {
        ShowErrorMessage(InValidEmail);
        return;
    }
    
    
}

- (IBAction)btnCancelTapped:(id)sender {
    kPopView();
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

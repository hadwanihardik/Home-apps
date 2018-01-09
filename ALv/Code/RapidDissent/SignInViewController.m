//
//  SignInViewController.m
//  HomeCheifApp
//
//  Created by Hardik Hadwani on 18/10/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//

#import "SignInViewController.h"
#import "ForgotPasswordViewController.h"
#import "SignUpViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    txtEmailAddress.placeholder=Localized(kEmailAddress);
    txtPassword.placeholder=Localized(kPassword);
    
    // Do any additional setup after lxoading the view from its nib.
}


-(void) viewDidAppear:(BOOL)animated
{
    txtEmailAddress.text=@"";
    txtPassword.text=@"";
    [super viewDidAppear:animated];
}


- (IBAction)btnSignInTapped:(id)sender {
    
//    txtEmailAddress.text=@"k@k.com";
//    txtPassword.text=@"k";
//    if (![MyMacros ValidateEmail:txtEmailAddress.text])
//    {
//        ShowErrorMessage(InValidEmail);
//        return;
//    }
//    if (txtPassword.text.length < 6)
//    {
//        ShowErrorMessageL(EmptyField(kPassword));
//        return;
//    }

    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:txtEmailAddress.text forKey:kEmail];
    [dict setValue:txtPassword.text forKey:kPassword];
    
    //[kAppDelegate goToHome];

    ShowProgress(msgLoading)
    apiHandler.responseWithDict=^(NSDictionary *dict)
    {
        NSLog(@"login Reponse :%@",dict);
        
        if ([[dict valueForKey:kStatus] isEqualToString:kSuccess])
        {
            [kPref setObject:[[dict valueForKey:kRecords] objectAtIndex:0]  forKey:kUserData];
            [kPref synchronize];
            [kPref setBool:true forKey:kIsLogin];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^
             {
                 HideProgress()
                 [kAppDelegate goToHome];
             }];
         }
        else
        {
            ShowErrorMessageL([dict valueForKey:@"status_error"]);
        }
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
            ShowErrorMessageL(FailedToConnect(LogInApiName));

         }];
        
    };
    
    [apiHandler postApiCallOfUrl:GetURL(LogInApiName) parameter:dict];
}

- (IBAction)btnSignUpTapped:(id)sender
{
    SignUpViewController *signUp=[[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    kPushView(signUp);
}

- (IBAction)btnForgotPasswordTapped:(id)sender
{
    ForgotPasswordViewController *forgot=[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    kPushView(forgot);
}
- (IBAction)btnCancelTapped:(id)sender {
    kPopView();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

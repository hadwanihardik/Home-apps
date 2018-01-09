//
//  SignInViewController.m
//  HomeCheifApp
//
//  Created by Hardik Hadwani on 18/10/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//

#import "SignInViewController.h"
#import "ForgotPasswordViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [kAppDelegate textFieldPadding:txtEmailAddress];
    [kAppDelegate textFieldPadding:txtPassword];

    
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
    
    if (![MyMacros ValidateEmail:txtEmailAddress.text])
    {
        ShowErrorMessage(InValidEmail);
        return;
    }
    if (txtPassword.text.length < 6)
    {
        ShowErrorMessageL(EmptyField(kPassword));
        return;
    }

    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:txtEmailAddress.text forKey:kEmail];
    [dict setValue:txtPassword.text forKey:kPassword];
    
    [kAppDelegate goToHome];

   // ShowProgress(msgLoading)
    return;
    apiHandler.response=^(id dict)
    {
        NSLog(@"login Reponse :%@",dict);
        [kPref setValue:[dict  valueForKey:kToken]  forKey:kToken];
        [kPref setValue:[dict valueForKey:kUserId]  forKey:kUserId];
        [kPref setBool:true forKey:kIsLogednIn];
        [kPref synchronize];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
            HideProgress()
         }];

        [kAppDelegate goToHome];
    };
    
    apiHandler.responseFail=^()
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
            HideProgress()
         }];
        
        self.view.userInteractionEnabled = true;
        ShowErrorMessageL(FailedToConnect(LogInApiName));
    };
    
    [apiHandler postApiCallOfUrl:GetURL(LogInApiName) parameter:dict];
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

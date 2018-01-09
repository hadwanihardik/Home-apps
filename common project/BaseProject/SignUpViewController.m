//
//  SignUpViewController.m
//  HomeCheifApp
//
//  Created by Hardik Hadwani on 10/20/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _txtName.placeholder=Localized(kUserName);
    _txtEmail.placeholder=Localized(kEmailAddress);
    _txtPassword.placeholder=Localized(kPassword);
    _txtConfirmPassword.placeholder=Localized(kRePassword);
    
    [kAppDelegate textFieldPadding:_txtEmail];
    [kAppDelegate textFieldPadding:_txtPassword];
    [kAppDelegate textFieldPadding:_txtConfirmPassword];
    [kAppDelegate textFieldPadding:_txtName];

    // Do any additional setup after loading the view from its nib.
}


- (IBAction)btnSignUpTapped:(id)sender {
  
    if (_txtName.text.length == 0)
    {
        ShowErrorMessageL(EmptyField(kUserName));
        return;
    }
    if (![MyMacros ValidateEmail:_txtEmail.text])
    {
        ShowErrorMessage(InValidEmail);
        return;
    }
    if (_txtPassword.text.length == 0)
    {
        ShowErrorMessageL(EmptyField(kPassword));
        return;
    }
    if (![_txtPassword.text isEqualToString:_txtConfirmPassword.text])
    {
        ShowErrorMessage(PasswordMismatch);
        return;
    }
    [kAppDelegate goToHome];

}

- (IBAction)btnClose:(id)sender {
    kPopView();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

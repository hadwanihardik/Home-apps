//
//  SignInViewController.h
//  
//
//  Created by Hardik Hadwani on 18/10/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController
{
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet UITextField *txtEmailAddress;
}
- (IBAction)btnSignInTapped:(id)sender;
- (IBAction)btnForgotPasswordTapped:(id)sender;

@end

//
//  AppConstant.h

//
//  Created by Hardik Hadwani on 20/10/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//

#ifndef AppConstant_h
#define AppConstant_h


#pragma mark URLS 

#define DEFAULT_COLOR_NAV [UIColor colorWithRed:0/255.0f green:122/255.0f blue:181/255.0f alpha:1.0]
#define DEFAULT_COLOR_NAV_Tint [UIColor whiteColor]

#define GetURL(apiName)  [NSString stringWithFormat:@"http://homechefqa.us-east-1.elasticbeanstalk.com/api/v1/%@",apiName]
#define GetImageURL(ImageName)  [NSString stringWithFormat:@"http://homechefqa.us-east-1.elasticbeanstalk.com%@",ImageName]

#define LogInApiName @"login"
#define PasswordReset @"passwordreset"


#define Localized(string)       NSLocalizedString(string, string)
#define App_Font  @"SFUIDisplay-Medium"
#define App_Font_Bold  @"SFUIDisplay-Bold"
#define App_Font_Medium  @"SFUIDisplay-Medium"
#define App_Font_SemiBold  @"SFUIDisplay-Semibold"
#define App_Font_NavigationBar  @"SFUIDisplay-Semibold"


#pragma mark Messages

#define EmptyField(value) [NSString stringWithFormat:@"Please enter %@.",value]

#define InValidUserName @"Please enter valid user name"
#define InValidEmail @"Please enter valid email address."
#define InValidPassword @"Please enter valid password."
#define LoginFailed @"Login Failed. Please check username and password."
#define InValidPhoneNumber @"Please Enter valid phone number."
#define PasswordMismatch @"Password and confirm password must be same"

#define Error @"Error"

#define FailedToConnect(apiName)  [NSString stringWithFormat:@"Failed to connect %@",apiName]

#define kUserName @"User Name"
#define kEmailAddress @"Email Address"
#define kRePassword @"Retype password"
#define kForgotPassword @"Forgot your password?"
#define kContinue @"Continue"


#pragma mark ApiKeys

#define kStatus @"status"

#pragma mark SignIn Keys

#define kMobile @"mobile"
#define kPassword @"password"
#define kUserId @"uid"
#define kToken @"token"
#define kIsLogednIn @"LogednIn"
#define kEmail @"email"
#define Alldishes @""

#define msgLoading @"Loading..."





#endif /* AppConstant_h */

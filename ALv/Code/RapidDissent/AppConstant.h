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

#define GetURL(apiName)  [NSString stringWithFormat:@"http://project.maahi.it/rapid_dissent/api.php?action=%@",apiName]
#define GetImageUploadURL(imageData) [NSString stringWithFormat:@"http://project.maahi.it/rapid_dissent/api_fileupload.php=%@",imageData]

#define GetImageURL(ImageName)  [NSString stringWithFormat:@"http://project.maahi.it/rapid_dissent/upload/images/%@",ImageName]
#define FileUploadURL  [NSString stringWithFormat:@"http://project.maahi.it/rapid_dissent/api_fileupload.php"]


#define LogInApiName @"userlogin"
#define SighUpApiName @"registration"
#define PasswordReset @"passwordreset"
#define PostFeed @"addpost"
#define UpdatePost @"updatepost"
#define GetPosts @"getpost"
#define AddComment @"addcomment"
#define GetComments @"getcomments"

#define UpdateUser @"updateuser"
#define CheckUsername @"checkusername"
#define LikeComment @"like"
#define UnLikeComment @"unlike"




#define GetGroupsList @"getgroupslist"





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

#define EmptyFeeds @"Please add some text or select media to post."

#define MaxChars @"Max 250 characters are allowed."
#define EmptyComment @"Can not post empty comment."
#define CommentSuccess @"Comment posted successfully."


#define NoFeeds @"Please post some feeds and come back again."
#define NoGroup @"No Groups Availble."

#define Error @"Error"

#define FailedToConnect(apiName)  [NSString stringWithFormat:@"Failed to connect %@",apiName]

#define kUserName @"User Name"
#define kEmailAddress @"Email"
#define kRePassword @"Retype password"
#define kForgotPassword @"Forgot your password?"
#define kContinue @"Continue"


#pragma mark ApiKeys

#define kStatus @"status"
#define kSuccess @"success"


#pragma mark SignIn Keys

#define kMobile @"mobile"
#define kPassword @"password"
#define kId @"id"
#define kToken @"token"
#define kEmail @"email"


#pragma mark SignUp Keys

#define kFirstName @"first_name"
#define kRecord_id @"record_id"
#define kPhoto @"photo"
#define kUplodedFileName @"uploded_file_name"


#pragma mark Add post keys

#define kUserid @"userid"
#define kPostText @"post_text"
#define kFileType @"file_type"
#define kFileName @"file_name"
#define kPrivacy @"privacy"
#define kGroupId @"group_id"
#define kImage @"image"
#define kPublic @"Public"
#define kPrivate @"Private"

//userid=122&post_text=good morning guys&file_type=image&file_name=234546451231231_DEC_00023.jpg&privacy=public&group_id=0&status=active


#pragma  mark Feed Page keys

#define kPostId @"post_id"
#define kPostText @"post_text"
#define kLikers @"likers"
#define kUpdatedTime @"updated_time"
#define kInsertedTime @"inserted_time"
#define kIsLiked @"liked"

#define kPrivate @"Private"
#define kPrivate @"Private"
#define kUserPhoto @"user_photo"
#define kFeedUserName @"username"

#define kComment @"comment"



/* deleted = no;
 "file_name" = "create-voice__4464427090715.png";
 "file_type" = image;
 "group_id" = 0;
 id = 13;
 "inserted_time" = "2017-03-01 06:25:44";
 likers = "";
 "post_text" = "Post with image";
 privacy = public;
 status = active;
 "updated_time" = "2017-03-01 06:25:44";
 "user_id" = 1;
*/


#define msgLoading @"Loading..."
#define kRecords @"records"
#define kGroups @"groups"

/* Group details
 
 description = "This group is for those that want to assure that animals are treated in an ethical manner.";
 id = 9;
 image = "123123234211231213Animal_ights.png";
 "inserted_time" = "0000-00-00 00:00:00";
 member = 0;
 name = "Animal Rights";
 status = active;
 "updated_time" = "2017-05-17 18:57:15";
 */
#define kDescription @"description"
#define kMember @"member"
#define kName @"name"



#define kUserData @"UserData"
#define kIsLogin @"IsLogin"





#endif /* AppConstant_h */

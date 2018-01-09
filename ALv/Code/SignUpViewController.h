//
//  SignUpViewController.h
//  RapidDissent
//
//  Created by Hardik on 4/4/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController <UIImagePickerControllerDelegate>
{
    BOOL isProfilePicSelected;
    UIImage *selectedImage;

}

@property (weak, nonatomic) IBOutlet UIButton *btnProfilePic;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@end

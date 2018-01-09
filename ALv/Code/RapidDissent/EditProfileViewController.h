//
//  SignUpViewController.h
//
//
//  Created by Hardik Hadwani on 10/20/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface EditProfileViewController : UIViewController <UIImagePickerControllerDelegate>
{
    BOOL isProfilePicSelected;
    UIImage *selectedImage;
    IBOutlet UIView *viewDatePicker;
    
    NSDateFormatter *dateFormatter;
}
@property (weak, nonatomic) IBOutlet UIButton *btnProfilePic;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtBirthDate;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtZipCode;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


- (IBAction) pickImage:(id)sender;
@end

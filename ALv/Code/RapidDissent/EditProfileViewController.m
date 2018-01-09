//
//  SignUpViewController.m
//  HomeCheifApp
//
//  Created by Hardik Hadwani on 10/20/16.
//  Copyright © 2016 Hardik Hadwani. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    http://project.maahi.it/rapid_dissent/api.php?action=registration&first_name=mukesh&last_name=tiwari&dob=2016-11-21&address=ceo-house,alkapuri,vadodara&city=vadodara&zip_code=390012&state=gujrat&country=india&mobile=9898098980&email=m@t.com&username=mt&password=mt123&photo=imagename.jpg
    
    
    isProfilePicSelected = false;
    
    _txtName.placeholder=Localized(kUserName);
    _txtEmail.placeholder=Localized(kEmailAddress);
    _txtPassword.placeholder=Localized(kPassword);
    _txtConfirmPassword.placeholder=Localized(kRePassword);
    
    [kAppDelegate textFieldPadding:_txtEmail];
    [kAppDelegate textFieldPadding:_txtPassword];
    [kAppDelegate textFieldPadding:_txtConfirmPassword];
    [kAppDelegate textFieldPadding:_txtName];
    [kAppDelegate textFieldPadding:_txtFirstName];
    [kAppDelegate textFieldPadding:_txtLastName];
    [kAppDelegate textFieldPadding:_txtPhoneNumber];
    [kAppDelegate textFieldPadding:_txtBirthDate];
    [kAppDelegate textFieldPadding:_txtCity];
    [kAppDelegate textFieldPadding:_txtState];
    [kAppDelegate textFieldPadding:_txtCountry];
    [kAppDelegate textFieldPadding:_txtZipCode];

    
    _btnProfilePic.layer.cornerRadius = 50;//_btnProfilePic.frame.size.width/2; // this value vary as per your desire
    _btnProfilePic.clipsToBounds = YES;
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-mm-dd"];
    
      // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnCancelTapped:(id)sender {
    kPopView();
}

-(IBAction)btnSelectDate:(id)sender
{
    [self closeKeybouad];
    viewDatePicker.hidden = false;
}

-(void)closeKeybouad
{
    [self.view endEditing:true];
//    [_txtPassword resignFirstResponder];
//    [_txtName resignFirstResponder];
//    [_txtLastName resignFirstResponder];
//    [_txtFirstName resignFirstResponder];
//    [_txtPhoneNumber resignFirstResponder];
//    [_txtBirthDate resignFirstResponder];
//    [_txtCity resignFirstResponder];
//    [_txtState resignFirstResponder];
//    [_txtCountry resignFirstResponder];
//    [_txtZipCode resignFirstResponder];
//    

}

-(IBAction)btnDoneTapped:(id)sender
{
    _txtBirthDate.text = [dateFormatter stringFromDate:_datePicker.date];
    viewDatePicker.hidden = true;

}

- (IBAction) pickImage:(id)sender{
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]
                                                 init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    selectedImage = image;
    isProfilePicSelected = true;
    [self.btnProfilePic setTitle:@"" forState:UIControlStateNormal];
    [self.btnProfilePic setImage:image forState: UIControlStateNormal];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)uploadImage
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:FileUploadURL]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    // file
    NSData *imageData = UIImageJPEGRepresentation(selectedImage,90);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: attachment; name=\"uploaded_file\"; filename=\"myImage.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // set request body
    [request setHTTPBody:body];
    //return and test
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:&error];
    if ([[json valueForKey:kStatus] isEqualToString:kSuccess]) {
        [self updateUplodedFileName:[json valueForKey:kUplodedFileName]];
    }
}

-(void)updateUplodedFileName:(NSString *)fileName
{
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:fileName forKey:@"photo"];
    [dict setValue:[kPref valueForKey:kUserid] forKey:@"update_user_id"];
    
    ShowProgress(msgLoading)
    apiHandler.responseWithDict=^(id dict)
    {
        NSLog(@"UpdateUser Reponse :%@",dict);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress();
             
             if ([[dict valueForKey:kStatus] isEqualToString:kSuccess])
             {
                  [self btnCancelTapped:nil];
             }
         }];
        
        //[kAppDelegate goToHome];
    };
    
    apiHandler.responseFail=^()
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress()
         }];
        
        self.view.userInteractionEnabled = true;
        ShowErrorMessageL(FailedToConnect(UpdateUser));
    };
    
    [apiHandler postApiCallOfUrl:GetURL(UpdateUser) parameter:dict];

}

- (IBAction)btnSignUpTapped:(id)sender {
    
    if (![MyMacros ValidateEmail:_txtEmail.text] || _txtEmail.text.length == 0)
    {
        ShowErrorMessage(InValidEmail);
        [_txtEmail becomeFirstResponder];
        
        return;
    }
    
    if (_txtName.text.length == 0)
    {
        ShowErrorMessageL(EmptyField(kUserName));
        [_txtName becomeFirstResponder];
        return;
    }
   
    if (_txtPassword.text.length == 0)
    {
        ShowErrorMessageL(EmptyField(kPassword));
        [_txtPassword becomeFirstResponder];

        return;
    }
    
//    if (![_txtPassword.text isEqualToString:_txtConfirmPassword.text])
//    {
//        ShowErrorMessage(PasswordMismatch);
//        return;
//    }
//    [kAppDelegate goToHome];
    
    [self closeKeybouad];

    
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:_txtFirstName.text forKey:@"first_name"];
    [dict setValue:_txtLastName.text forKey:@"last_name"];
    [dict setValue:_txtBirthDate.text forKey:@"dob"];
    [dict setValue:_txtCity.text forKey:@"city"];
    [dict setValue:_txtZipCode.text forKey:@"zip_code"];
    [dict setValue:_txtState.text forKey:@"state"];
    [dict setValue:_txtCountry.text forKey:@"country"];
    [dict setValue:_txtPhoneNumber.text forKey:@"mobile"];
    [dict setValue:_txtEmail.text forKey:@"email"];
    [dict setValue:_txtName.text forKey:@"username"];
    [dict setValue:_txtPassword.text forKey:@"password"];

    //[kAppDelegate goToHome];
    
    ShowProgress(msgLoading)
    apiHandler.responseWithDict=^(id dict)
    {
        NSLog(@"SighUp Reponse :%@",dict);
//        [kPref setValue:dict  forKey:kUserData];
//        [kPref synchronize];
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress();

             if ([[dict valueForKey:kStatus] isEqualToString:kSuccess])
             {
                 [kPref setValue:[dict valueForKey:kRecord_id] forKey:kUserid];
                 if (isProfilePicSelected == true)
                 {
                      [self uploadImage];
                 }
                 else
                 {
                     [self btnCancelTapped:nil];
                 }
             }
         }];
        
        //[kAppDelegate goToHome];
    };
    
    apiHandler.responseFail=^()
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress()
         }];
        
        self.view.userInteractionEnabled = true;
        ShowErrorMessageL(FailedToConnect(SighUpApiName));
    };
    
    [apiHandler postApiCallOfUrl:GetURL(SighUpApiName) parameter:dict];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

//
//  SignUpViewController.m
//  RapidDissent
//
//  Created by Hardik on 4/4/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isProfilePicSelected = false;
    
    _txtName.placeholder=Localized(kUserName);
    _txtEmail.placeholder=Localized(kEmailAddress);
    _txtPassword.placeholder=Localized(kPassword);

    [kAppDelegate textFieldPadding:_txtEmail];
    [kAppDelegate textFieldPadding:_txtPassword];
    [kAppDelegate textFieldPadding:_txtName];
    
    _btnProfilePic.layer.cornerRadius = 50;//_btnProfilePic.frame.size.width/2; // this value vary as per your desire
    _btnProfilePic.clipsToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnCancelTapped:(id)sender {
    kPopView();
}

-(void)closeKeybouad
{
    [self.view endEditing:true];
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
    

    
    [self closeKeybouad];
    
    
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

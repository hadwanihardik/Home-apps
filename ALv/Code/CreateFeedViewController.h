//
//  CreateFeedViewController.h
//  RapidDissent
//
//  Created by Hardik Hadwani on 22/02/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CreateFeedViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImage *selectedImage;
    NSString *currentPostID;
    NSString *videoPath;
    bool  isVideoSelected;

    UIImagePickerController *pickerController;


}
@property (weak, nonatomic) IBOutlet UITextView *txtFeedText;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *lblErrorCharacterLimit;
@property (weak, nonatomic) IBOutlet UIImageView *imagePreview;
@property (weak, nonatomic) IBOutlet UIImageView *imagePreviewFullscreen;

@property (weak, nonatomic) IBOutlet UILabel *taggedFriends;
- (IBAction)addPhoto:(id)sender;
- (IBAction)addVideo:(id)sender;
- (IBAction)tagFriends:(id)sender;
- (IBAction)postFeed:(id)sender;

@end

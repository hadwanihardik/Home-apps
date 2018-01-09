//
//  CreateFeedViewController.m
//  RapidDissent
//
//  Created by Hardik Hadwani on 22/02/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import "CreateFeedViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface CreateFeedViewController ()
{
    NSFileManager *fm;
    MPMoviePlayerController *moviplayer;
}
@end

@implementation CreateFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedImage = nil;
    
    videoPath = @"";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    fm = [NSFileManager defaultManager];
    videoPath = [documentsDirectory stringByAppendingPathComponent:@"temp.mov"];
    pickerController = [[UIImagePickerController alloc]
                        init];
    pickerController.delegate = self;
    self.txtFeedText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.txtFeedText.layer.borderWidth = 1;

    moviplayer =[[MPMoviePlayerController alloc] init];

    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:GetImageURL(getUserDataFromPref(kPhoto))] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if (image && finished) {
            self.userIcon.image = image;
            // Cache image to disk or memory
            [[SDImageCache sharedImageCache] storeImage:image forKey:(getUserDataFromPref(kUserPhoto)) toDisk:YES];
        }
    }];
    
    self.userName.text = getUserDataFromPref(kFeedUserName);
    UITapGestureRecognizer *previewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(preview)];
    [self.imagePreview addGestureRecognizer:previewTap];
    
    UITapGestureRecognizer *closepreview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePreview)];
    [self.imagePreviewFullscreen addGestureRecognizer:closepreview];
    
    // Do any additional setup after loading the view from its nib.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addPhoto:(id)sender {
    isVideoSelected =  false;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)addVideo:(id)sender {
    isVideoSelected =  true;
    pickerController.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
    pickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    pickerController.videoQuality = UIImagePickerControllerQualityTypeLow;
    [self presentViewController:pickerController animated:YES completion:nil];

}

- (IBAction)tagFriends:(id)sender {
}

- (IBAction)postFeed:(id)sender {
 
    [self.view endEditing:true];
    if([_txtFeedText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0)
    {        ShowErrorMessageL(EmptyFeeds);
        [_txtFeedText becomeFirstResponder];
        return;
    }
    
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:getUserDataFromPref(kId) forKey:kUserid];
    [dict setValue:self.txtFeedText.text forKey:kPostText];
    [dict setValue:kImage forKey:kFileType];
   // [dict setValue:kImage forKey:kFileName];
    [dict setValue:kPublic forKey:kPrivacy];
    [dict setValue:@"0" forKey:kGroupId];
    
    //[kAppDelegate goToHome];
    
    ShowProgress(msgLoading)
    apiHandler.responseWithDict=^(NSDictionary *dict)
    {
        NSLog(@"PostFeed Reponse :%@",dict);
        currentPostID = [dict valueForKey:kPostId];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress()
         }];
        if(selectedImage!=nil)
        {
            [self uploadImage];
        }
        else
        {
            ShowInfoMessage(@"Voice Created Successfully.")
            [self.tabBarController setSelectedIndex:0];
            self.txtFeedText.text = @"";
            self.imagePreview.image = nil;
        }
        
    };
    
    apiHandler.responseFail=^()
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress()
         }];
        
        ShowErrorMessageL(FailedToConnect(PostFeed));
    };
    
    [apiHandler postApiCallOfUrl:GetURL(PostFeed) parameter:dict];
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    BOOL isImage = UTTypeConformsTo((__bridge CFStringRef)mediaType,
                                    kUTTypeImage) != 0;
    if(isImage)
    {
        selectedImage =  [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.imagePreview setImage:selectedImage];
    }
    else
    {
        NSError *error;
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"VideoURL = %@", videoURL);
        [fm removeItemAtPath:videoPath error:&error];
        [fm copyItemAtPath:videoURL.path toPath:videoPath error:&error];
        MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
        selectedImage = [player thumbnailImageAtTime:0.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        [player stop];
        [self chunkVideo];
        [self.imagePreview setImage:selectedImage];

    }
    [picker dismissViewControllerAnimated:YES completion:nil];

}

-(void)preview
{
    if(isVideoSelected)
    {
        NSURL *streamURL = [NSURL fileURLWithPath:videoPath];
        [moviplayer setContentURL:streamURL];
        [moviplayer prepareToPlay];
        [moviplayer.view setFrame: self.view.bounds];
        [self.view addSubview: moviplayer.view];
        moviplayer.fullscreen = YES;
        moviplayer.shouldAutoplay = YES;
        moviplayer.repeatMode = MPMovieRepeatModeNone;
        moviplayer.movieSourceType = MPMovieSourceTypeFile;
        [moviplayer play];
        
        
        // Register this class as an observer instead
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:moviplayer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(doneButtonClick:)
                                                     name:MPMoviePlayerWillExitFullscreenNotification
                                                   object:nil];
    }
    else
    {
        self.imagePreviewFullscreen.image = selectedImage;
        self.imagePreviewFullscreen.hidden =  false;
    }
}
-(void)closePreview
{
    self.imagePreviewFullscreen.image = selectedImage;
    self.imagePreviewFullscreen.hidden =  true;
}
- (void)movieFinishedCallback:(NSNotification*)aNotification
{
    MPMoviePlayerController *moviePlayer = [aNotification object];
    
    // Remove this class from the observer
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:moviePlayer];
    
    if ([moviePlayer
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [moviePlayer.view removeFromSuperview];
    }
}
-(void)doneButtonClick:(NSNotification*)aNotification
{
    // Obtain the reason why the movie playback finished
    MPMoviePlayerController *moviePlayer = [aNotification object];
    
    // Remove this class from the observer
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:moviePlayer];
    
    if ([moviePlayer
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [moviePlayer.view removeFromSuperview];
    }
}



- (void)chunkVideo {
    NSData *myBlob = [NSData dataWithContentsOfFile:videoPath];
    NSUInteger length = [myBlob length]; // total size of data
    NSUInteger chunkSize = 1024 * 1000; // divide data into 10 mb
    NSUInteger offset = 0;
    NSUInteger index = 0;
    int n=0;
    do {
        // get the chunk location
        NSUInteger thisChunkSize = length - offset > chunkSize ? chunkSize : length - offset;
        // get the chunk
        NSData* chunk = [NSData dataWithBytesNoCopy:(char *)[myBlob bytes] + offset length:thisChunkSize freeWhenDone:NO];
        // do something what you need to do with this chunks
        // assume here we are writing pieces into different files
        NSLog(@"chunk number %d",++n);
        // update the offset
        offset += thisChunkSize;
    } while (offset < length);
    
}
-(void)uploadImage
{
    ShowProgress(msgLoading)

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
    HideProgress();

    if ([[json valueForKey:kStatus] isEqualToString:kSuccess]) {
        [self updateUplodedFileName:[json valueForKey:kUplodedFileName]];
    }
}

-(void)updateUplodedFileName:(NSString *)fileName
{
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:fileName forKey:kFileName];
    [dict setValue:kImage forKey:kFileType];
    [dict setValue:[kPref valueForKey:kUserid] forKey:kUserid];
    [dict setValue:currentPostID forKey:kPostId];

    ShowProgress(msgLoading)
    apiHandler.responseWithDict=^(id dict)
    {
        NSLog(@"UpdateUser Reponse :%@",dict);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress();
             selectedImage = nil;
             if ([[dict valueForKey:kStatus] isEqualToString:kSuccess])
             {
                 //Photo uploaded
                 ShowInfoMessage(@"Voice Created Successfully.")
                 self.txtFeedText.text = @"";
                 self.imagePreview.image = nil;
             }
         }];
        
        //[kAppDelegate goToHome];
    };
    apiHandler.responseFailMessage = ^(NSString *errorMessage)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress()
             ShowErrorMessageL(errorMessage);
             
         }];
    };
    apiHandler.responseFail=^()
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress()
             self.view.userInteractionEnabled = true;
             ShowErrorMessageL(FailedToConnect(UpdateUser));
         }];
        
        
    };
    
    [apiHandler postApiCallOfUrl:GetURL(UpdatePost) parameter:dict];
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
      if([textView.text isEqualToString:@"Write some text here"])
      {
          textView.text = @"";
      }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0)
    {
        textView.text = @"Write some text here";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

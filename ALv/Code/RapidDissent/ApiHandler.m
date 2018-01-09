//

//
//  Created by Hardik Hadwani on 04/03/15.
//  Copyright (c) 2015 Hardik Hadwani. All rights reserved.
//

#import "ApiHandler.h"
#import "AFURLSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
@implementation ApiHandler
@synthesize transcriptResponse=_transcriptResponse;
@synthesize responseWithString = _responseWithString;
@synthesize responseWithDict = _responseWithDict;
@synthesize responseFail = _responseFail;
@synthesize response = _response;
@synthesize responseFailMessage = _responseFailMessage;




-(void)postApiCallOfUrl:(NSString *)apiUrl parameter:(NSMutableDictionary *)data
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:apiUrl parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        // NSLog(@"JSON: %@", responseObject);
         if ([[responseObject valueForKey:@"status"] isEqualToString:@"error"]) {
             _responseFailMessage([responseObject valueForKey:@"status_error"]);

         }
         else
         {
             _responseWithDict((NSMutableDictionary*)responseObject);
         }
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         _responseFail();
     }];

}

-(void)getApiCallOfUrl:(NSString *)apiUrl parameter:(NSMutableDictionary *)data
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:apiUrl parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         _responseWithDict(responseObject);
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         _responseFail();
     }];

    
}

-(void)loginUser :(NSMutableDictionary *)data
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:GetURL(LogInApiName) parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         _responseWithString(responseObject);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         _responseFail();
     }];
    
}



-(void)forgotPassword :(NSMutableDictionary *)data
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:GetURL(PasswordReset) parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         
         NSLog(@"JSON: %@", responseObject);
         _responseWithString(responseObject);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         _responseFail();
     }];
    
}


/*-(void)sendAudio :(NSString *)audioname
{

        NSURL *audioPath=[NSURL fileURLWithPath:[MyMacros getpathForAudioFile:audioname]];
//       NSURL *audioPath =url;// [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"MyAudioMemo1_converted.wav"];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[kPref valueForKey:KToken] forKey:@"authorization"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:audioUploadURL parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        [formData appendPartWithFileURL:audioPath name:@"file" fileName:@"test.wav" mimeType:@"audio/wav" error:nil];
     
       
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
      {
          if (error)
          {
              NSLog(@"Error: %@", error);
          }
          else
          {
              NSLog(@" response %@ %@", response, responseObject);
              
              [self updateDatabase:[responseObject  valueForKey:@"id"]];
          }
      }];
    
    [uploadTask resume];
    
    
}*/
@end

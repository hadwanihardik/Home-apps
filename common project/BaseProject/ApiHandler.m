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



-(void)postApiCallOfUrl:(NSString *)apiUrl parameter:(NSMutableDictionary *)data
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:apiUrl parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         _response(responseObject);
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
         _response(responseObject);
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

-(void)getDishes:(NSMutableDictionary *)data
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:GetURL(Alldishes) parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject)
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
    
    
}
-(void)getTranscript :(NSString *)transcriptId
{
    
    NSMutableDictionary *data1=[NSMutableDictionary new];
    [data1 setValue:@"test" forKey:@"name"];
    [data1 setValue:@"hadwanihardik@gmail.com" forKey:@"email"];
    [data1 setValue:@"hadwanihardik" forKey:@"password"];
    [data1 setValue:@"testlocation" forKey:@"location"];
    [data1 setValue:@1 forKey:@"sex"];
    [data1 setValue:@"1234567890" forKey:@"contact_no"];
    

    NSString *stringURL=[NSString stringWithFormat:@"%@%@&authorization=%@",getTranscriptUrl,transcriptId,[kPref valueForKey:KToken]];
    // 2
    NSURLSessionConfiguration *sessionConfig =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 3
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:sessionConfig
                                  delegate:self
                             delegateQueue:nil];
    NSURLSessionTask *getTask =[session dataTaskWithURL:[NSURL URLWithString:stringURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
            if (error)
               {
                   NSLog(@"Error: %@", error);
               }
               else
               {
                
                   NSString *myString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                   NSLog(@" response %@ - %@ ", response,myString);
                   [self processTranscriptResponse :myString];
                  // _transcriptResponse([dict valueForKey:tEmbedded]);

               }

    }];

    [getTask resume];
    
}
-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    // use code above from completion handler
}
-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
     didWriteData:(int64_t)bytesWritten
totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"%f / %f", (double)totalBytesWritten,
          (double)totalBytesExpectedToWrite);
}
-(void)processTranscriptResponse:(NSString *)myString
{
    NSData* data = [myString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]];
 
    NSMutableArray *tmp=[[NSMutableArray alloc] init];
    tmp=[[dict valueForKey:tEmbedded] valueForKey:tMeeting];
    
    for (int i=0; i<tmp.count; i++)
    {
        NSDictionary *mediaDict=[[NSDictionary alloc] init];
        mediaDict=[[tmp objectAtIndex:i] valueForKey:tMedia];
        NSArray *test=[[NSArray alloc]initWithArray:[DBHandler selectSpecificData:[NSString stringWithFormat:@"SELECT %@ FROM meeting where %@ ='%@'",meeting_id,meeting_transcriptId,[[mediaDict valueForKey:tMediaId] objectAtIndex:0]]]];
        NSString *meetingid=[[test objectAtIndex:0] valueForKey:meeting_id];
        test=nil;
        NSMutableArray *tmpDiscussion=[[NSMutableArray alloc] init];
        tmpDiscussion=[[tmp objectAtIndex:i] valueForKey:tDiscussion];
        [DBHandler DeleteDatabase:[NSString stringWithFormat:@"delete  from Transcript where meetingId='%@'",meetingid]];
      
        for (int k=0;k<tmpDiscussion.count; k++)
        {
            NSDictionary *script=[[NSDictionary alloc] init];
            script=[tmpDiscussion objectAtIndex:k];
            
            NSMutableArray *bugword=kMutableArray;
            bugword=[script valueForKey:tBugWords];
             NSString *strbugs=@"";
            if (bugword.count==0)
            {
                strbugs=@"";
            }
            else
            {
                for (int j=0;j<bugword.count; j++)
                {
                    if (j==bugword.count-1) {
                        strbugs=[strbugs stringByAppendingString:[NSString stringWithFormat:@"%@",[bugword objectAtIndex:j]]];
                    }
                    else
                    {
                        strbugs=[strbugs stringByAppendingString:[NSString stringWithFormat:@"%@,",[bugword objectAtIndex:j]]];
                    }
                }
                
            }
            
           
                
            BOOL isfailed;
            
            
               if (![[script valueForKey:tIsFailed] isKindOfClass:[NSNull class]])
               {
                   if ([[script valueForKey:tIsFailed] boolValue] == false)
                   {
                
                      
                        NSString *strContent=@"";
                        if (![[script valueForKey:tContent] isKindOfClass:[NSNull class]])
                        {
                            strContent= [[script valueForKey:tContent] stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
                        }
                        
                        [DBHandler InsertDatabase:[NSString stringWithFormat:@"insert into Transcript(bugWords,content,endSeconds,torder,participant,startSecond,meetingId,failed,totalSpeakers) values(\"%@\",\"%@\",'%@','%@','%@','%@','%@','%@',%d)",[strbugs stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""],strContent,
                                                   [script valueForKey:tEndSeconds],
                                                   [script valueForKey:tOrder],
                                                   [script valueForKey:tParticipant],
                                                   [script valueForKey:tStartSecond],
                                                   meetingid,
                                                   [script valueForKey:tIsFailed],
                                                   [[script valueForKey:tTotalSpeakers] intValue]
                                                   ]];
                       
                    }
                    else
                    {
                        isfailed=TRUE;
                    }
           
               }
            else{
                  isfailed=TRUE;
               }
            
            if (isfailed==TRUE)
            {
                
                [DBHandler InsertDatabase:[NSString stringWithFormat:@"insert into Transcript(bugWords,content,endSeconds,torder,participant,startSecond,meetingId,failed,totalSpeakers) values('%@','%@','%@','%@','%@','%@','%@','%@',%d)",@"",@"",[script valueForKey:tEndSeconds],
                                           [script valueForKey:tOrder],
                                           [script valueForKey:tParticipant],
                                           [script valueForKey:tStartSecond],
                                           meetingid,
                                           [script valueForKey:tIsFailed],
                                           [[script valueForKey:tTotalSpeakers] intValue]
                                           ]];
                

            }
        }
        [DBHandler UpdateDatabase:[NSString stringWithFormat:@"update meeting  set %@='1' where %@ ='%@'",meeting_hasTranscript,meeting_id,meetingid]];
        for (int j=0; j< [[[tmp objectAtIndex:i] valueForKey:tTotalSpeakers]  intValue]; j++)
        {
            [DBHandler InsertDatabase:[NSString stringWithFormat:@"insert into Participants(participantName,meetingId) values(' ','%@')",meetingid]];
        }

        
    }
    _transcriptResponse();
    
}


-(void)updateDatabase:(NSString *)transcriptId
{
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Success"
//                                                    message:[NSString stringWithFormat:@"File has been uploaded. Transcript id is : %@",transcriptId]
//                                                   delegate: nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
    NSLog(@" transcriptId %@ ",  transcriptId);
    
    [DBHandler UpdateDatabase:[NSString stringWithFormat:@"update meeting  set transcriptId='%@',isUploaded=1 where name ='%@'",transcriptId,self.meetingName]];
    

}*/
@end

//
//
//  Created by Hardik Hadwani on 04/03/15.
//  Copyright (c) 2015 Hardik Hadwani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiHandler : NSObject<NSURLSessionDelegate>



-(void)postApiCallOfUrl:(NSString *)apiUrl parameter:(NSMutableDictionary *)data;
-(void)getApiCallOfUrl:(NSString *)apiUrl parameter:(NSMutableDictionary *)data;
-(void)loginUser :(NSMutableDictionary *)data;
-(void)forgotPassword :(NSMutableDictionary *)data;
-(void)getDishes:(NSMutableDictionary *)data;

//-(void)registerUser :(NSMutableDictionary *)data;
//-(void)sendAudio :(NSString *)audioname;
//-(void)getTranscript :(NSString *)transcriptId;

@property(nonatomic,retain) NSString *meetingName;
@property(nonatomic,copy)Callbackvoid responseFail;
@property(nonatomic,copy)Callbackvoid transcriptResponse;
@property(nonatomic,copy)CallbackString responseWithString;
@property(nonatomic,copy)CallbackDict responseWithDict;
@property(nonatomic,copy)Callbackid response;
@end

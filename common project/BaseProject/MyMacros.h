//
//  MyMacros.h
//  MyMacrofile
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Structured  data types
#define kMutableArray [[NSMutableArray alloc] init]
#define kMutableDictionary [[NSMutableDictionary alloc] init]

//UIControls
#define kInitView(frame,view) [[view alloc] initWithFrame:frame]
#define kNSStringFormat(string,param) [NSString stringWithFormat:string,param]

//AppDelegate Object
#define kAppDelegate (AppDelegate *) [[UIApplication sharedApplication] delegate]
#define getiosVerson() [[[UIDevice currentDevice] systemVersion] floatValue]

//Pref
#define kPref [NSUserDefaults standardUserDefaults]

//push view
#define kSuperPushView(mainview,pushingview) [[MyMacros viewController:mainview].navigationController pushViewController:pushingview animated:YES]
#define kPushView(view) [self.navigationController pushViewController:view animated:YES]
#define kPopView() [self.navigationController popViewControllerAnimated:YES];
#define kPopToRoot() [self.navigationController popToRootViewControllerAnimated:YES];

//iphone/ipad
#define isIpad() ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] ? [[UIDevice currentDevice] userInterfaceIdiom] : UIUserInterfaceIdiomPhone)

#define ibAction(name) -(IBAction)name:(UIButton *)sender
#define mProperty(type,name) @property(nonatomic,retain)type *name

#define mViewHeight self.view.bounds.size.height

#define ShowProgress(msg) [SVProgressHUD showWithStatus:Localized(msg)];
#define HideProgress()   [SVProgressHUD dismiss];

#define ShowErrorMessage(msg) [SVProgressHUD showErrorWithStatus:Localized(msg)];
#define ShowErrorMessageL(msg) [SVProgressHUD showErrorWithStatus:msg];
#define ShowInfoMessage(msg) [SVProgressHUD showInfoWithStatus:Localized(msg)];

#define ShowAlert(title,message,view) [MyMacros ShowAlert:title :message ForViewController:view]


#ifdef DEBUG
#   define NSLog(...) NSLog(__VA_ARGS__)
#else
#   define NSLog(...) (void)0
#endif


//For image url

//call backs
typedef void(^CallbackString)(NSString *);
typedef void(^CallbackDict) (NSMutableDictionary *);
typedef void(^CallbackArr) (NSMutableArray *);
typedef void(^CallbackBool)(bool);
typedef void(^Callbackvoid)();
typedef void(^Callbackid)(id);


@interface MyMacros : NSObject

//Validations and Check  for Null or empty
+(BOOL) ValidateEmail:(NSString*)string;
+(BOOL) CheckForEmpty:(id)string;
+(BOOL) CheckAlphaNumeric:(NSString*)string;
+(BOOL) CheckNumeric:(NSString*)string;
+(void)ShowAlert:(NSString *)title :(NSString *)message ForViewController:(UIViewController *)vc;

@end

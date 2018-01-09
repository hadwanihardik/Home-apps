//
//  MyMacros.m
//  MyMacrofile
//
//

#import "MyMacros.h"

@implementation MyMacros




+(BOOL) ValidateEmail:(NSString*) string
{
    NSString*emailRegex =@"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate*emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return[emailTest evaluateWithObject:string];
}
+(BOOL) CheckForEmpty:(id) string
{
    
    return string == nil
    || [string isKindOfClass:[NSNull class]]
    || ([string respondsToSelector:@selector(length)]
        && ![string respondsToSelector:@selector(count)]
        && [(NSData *)string length] == 0)
    || ([string respondsToSelector:@selector(count)]
        && [string count] == 0);
}
+(BOOL) CheckAlphaNumeric:(NSString*) string
{
    if([string rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location == NSNotFound)
    {
        return TRUE;
    }
   return false;
}
+(BOOL) CheckNumeric:(NSString*)string
{
    if([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound)
    {
        return TRUE;
    }
    return false;
}

+(void)ShowAlert:(NSString *)title :(NSString *)message ForViewController:(UIViewController *)vc
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (UIViewController*)viewController:(UIView *)view
{
    for (UIView* next = view.superview; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    
    return nil;
    
}
+(NSString*) getUserData:(NSString*) string
{

      return[[kPref valueForKey:kUserData] valueForKey:string];
}
+(NSString *) timtSince:(NSString *)postTime
{
    NSDateFormatter *formter =  [[NSDateFormatter alloc] init];
    [formter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSTimeInterval secondsElapsed = [[NSDate date] timeIntervalSinceDate:[formter dateFromString:postTime]];
    int hour = secondsElapsed / 3600;
    
    if (secondsElapsed < 60)
    {
        return [NSString stringWithFormat:@"%.f Seconds ago",secondsElapsed];
    }
    else if (hour==0)
    {
        return [NSString stringWithFormat:@"%d Minutes ago",(int)secondsElapsed % 60];
    }
    else
        if (hour<24)
        {
            return [NSString stringWithFormat:@"%d Hours ago",hour];
            
        }
        else
        {
            return [NSString stringWithFormat:@"%d Days ago",hour/24];
        }
}

@end

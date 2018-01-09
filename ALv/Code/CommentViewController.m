//
//  CommentViewController.m
//  RapidDissent
//
//  Created by Hardik on 4/27/17.
//  Copyright © 2017 HardikHadwani. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"
@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMe)];
    [self.view addGestureRecognizer:tap];
    arrayComments = kMutableArray;
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getComments];
   self.txtComment.text = @"Write some text here";
   self.txtComment.textColor = [UIColor lightGrayColor];
 
}
-(IBAction)closeMe
{
    [self.view removeFromSuperview];
}
- (IBAction)postComment:(id)sender {
    
    /*
     action=addcomment
     userid=122
     post_id=2
     comment=this is too cool bro !!
     */
    
    if([self.txtComment.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0 || [self.txtComment.text isEqualToString:@"Write some text here"])
    {
        self.lblErrorMessage.hidden = false;
        self.lblErrorMessage.text = EmptyComment;
        return;
    }
    if(self.txtComment.text.length > 250)
    {
        self.lblErrorMessage.hidden = false;
        self.lblErrorMessage.text = EmptyComment;
        return;
    }
    
    self.lblErrorMessage.hidden = true;

    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:getUserDataFromPref(kId) forKey:kUserid];
    [dict setValue:self.postId forKey:kPostId];
    [dict setValue:self.txtComment.text forKey:kComment];

    apiHandler.responseWithDict=^(NSDictionary *dict)
    {
        NSLog(@"postComment : %@",dict);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
             HideProgress();
             [self closeMe];
             ShowInfoMessage(CommentSuccess);

         }];
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
             ShowErrorMessageL(FailedToConnect(AddComment));
         }];
    };
    
    [apiHandler postApiCallOfUrl:GetURL(AddComment) parameter:dict];

    
}

-(void)getComments
{
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    NSMutableDictionary *dict = kMutableDictionary;
    [dict setValue:self.postId forKey:kPostId];

    apiHandler.responseWithDict=^(NSDictionary *dict)
    {
        arrayComments =  [dict valueForKey:kRecords];
        NSLog(@"Comments : %@",arrayComments);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^
         {
           [self.tblComments reloadData];
             HideProgress()
             if(arrayComments.count==0)
             {
             }
         }];
        
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
             ShowErrorMessageL(FailedToConnect(GetComments));
         }];
        
    };
    
    [apiHandler postApiCallOfUrl:GetURL(GetComments) parameter:dict];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayComments.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.estimatedRowHeight = 50;

    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *feedCellWithOneImage = @"CommentCell";
    // static NSString *feedCell = @"FeedCell";
    
    NSDictionary *comment = [arrayComments objectAtIndex:indexPath.row];
    CommentCell *cell = (CommentCell *)[tableView dequeueReusableCellWithIdentifier:feedCellWithOneImage];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.lblComment.text = [comment valueForKey:kComment];
    cell.lbldatetime.text = [MyMacros timtSince:[comment valueForKey:kInsertedTime]];

    
    cell.tag = indexPath.row;
    return cell;
}




-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"Write some text here"])
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    if(textView.text.length > 250)
    {
        self.lblErrorMessage.hidden = false;
        self.lblErrorMessage.text = EmptyComment;
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0)
    {
        textView.text = @"Write some text here";
        textView.textColor = [UIColor lightGrayColor];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

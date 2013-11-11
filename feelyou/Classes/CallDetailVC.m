//
//  CallDetailVC.m
//  feelyou
//
//  Created by wang haijun on 13-11-2.
//
//

#import "CallDetailVC.h"

@interface CallDetailVC ()

@end

@implementation CallDetailVC

@synthesize webView;

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    //    http://wap.feelyou.me/api/call_list.php?ggid=xx&checkcode("feelyou.me" + ggid + "fy602")
    
    NSString* ggid = [SharedInstance instance].ggid;
    
    NSString* md5String = [HttpUtils getMD5:[NSString stringWithFormat:@"feelyou.me%@fy602",ggid]];
    
    NSString* urlString = [NSString stringWithFormat:URL_CALL_DETAIL,BASE_URL,ggid,md5String];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [webView loadRequest:request];
    
}

- (IBAction)actionBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end

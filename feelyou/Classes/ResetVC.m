//
//  ResetVC.m
//  feelyou
//
//  Created by wang haijun on 13-10-21.
//
//

#import "ResetVC.h"

@interface ResetVC ()

@end

@implementation ResetVC

@synthesize tfMobileId,loadingView;

- (IBAction)actionReset:(id)sender {
    
    NSString* mobileId = [tfMobileId text];
    
    if (mobileId==Nil || mobileId.length<11) {
        
        [HttpUtils showAlert:@"请输入正确的手机号码！"];
        
        return;
    }
    
    [self.loadingView startAnimating];
    
    [HttpUtils doResetPwd:mobileId blockFinish:^(NSDictionary *dic) {
        [self.loadingView stopAnimating];
        DLog(@"reuqest successed!!!");
        DLog(@"%@",dic);
        [HttpUtils showAlert:@"密码重置成功，请注意查收短信！"];
        
        [self actionBack:sender];
        
    } blockFailur:^ {
        [self.loadingView stopAnimating];
        DLog(@"reuqest failured!!!");
        [HttpUtils showAlert:@"密码重置失败，请稍后重试！"];
    }];
    
}

- (IBAction)actionBack:(id)sender {
    
    [self.loadingView stopAnimating];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end

//
//  CardRechargeVC.m
//  feelyou
//
//  Created by wang haijun on 13-11-2.
//
//

#import "CardRechargeVC.h"

@interface CardRechargeVC ()

@end

@implementation CardRechargeVC

@synthesize tfAmount,tfCardNo,tfCardPwd;
@synthesize type,loadingView;

- (IBAction)actionConfirm:(id)sender {
    
    NSString* cardNo = tfCardNo.text;
    NSString* pwd = tfCardPwd.text;
    NSString* amount = tfAmount.text;
    
    if (cardNo == Nil || [cardNo isEqualToString:@""]) {
        [HttpUtils showAlert:@"请输入卡号"];
        return;
    }
    
    if (pwd == Nil || [pwd isEqualToString:@""]) {
        [HttpUtils showAlert:@"请输入密码"];
        return;
    }
    
    if (amount == Nil || [amount isEqualToString:@""]) {
        [HttpUtils showAlert:@"请输入金额"];
        return;
    }
    
//    Channel:卡类型SZX中国移动充值卡UNICOM中国联通充值卡CT中国电信充值卡
    
    [self.view endEditing:YES];
    
    [self.loadingView startAnimating];
    
    NSArray* channels = [NSArray arrayWithObjects:@"SZX", @"UNICOM", @"CT",nil];
    
    [HttpUtils doRechargeCard:[SharedInstance instance].ggid channel:[channels objectAtIndex:self.type] cardno:cardNo cardpwd:pwd money:amount blockFinish:^(NSDictionary *dic) {
        
        [self.loadingView stopAnimating];
        
        DLog(@"card recharge reuqest successed!!!");
        DLog(@"%@",dic);
        
        NSString* ret = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ret"]];
        
        DLog(@"ret:%@",ret);
        
        if ([@"1" isEqualToString:ret]) {
            [HttpUtils showAlert:@"充值申请已提交，请稍后确认是否到账。"];
        }else{
            [HttpUtils showAlert:@"充值失败！"];
        }
        
    } blockFailur:^ {
        
        [self.loadingView stopAnimating];
        
        DLog(@"reuqest failured!!!");
        [HttpUtils showAlert:@"充值失败！"];
    }];
    
}

- (IBAction)actionBack:(id)sender {
    
    [self.loadingView stopAnimating];
    
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)actionSelected:(id)sender {
    
    UISegmentedControl* seg = (UISegmentedControl*)sender;
    
    self.type = seg.selectedSegmentIndex;
    
    DLog(@"selected:%d",self.type);
    
}
@end

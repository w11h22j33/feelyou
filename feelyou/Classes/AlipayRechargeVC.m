//
//  AlipayRechargeVC.m
//  feelyou
//
//  Created by wang haijun on 13-11-2.
//
//

#import "AlipayRechargeVC.h"
#import "AlixPayOrder.h"
#import "DataSigner.h"
#import "AlixPay.h"

@interface AlipayRechargeVC ()

@end

@implementation AlipayRechargeVC

@synthesize tfAmount,loadingView;

- (IBAction)actionConfirm:(id)sender {
    
    NSString* amount = tfAmount.text;
    
    if (amount == Nil || [amount isEqualToString:@""]) {
        [HttpUtils showAlert:@"请输入金额"];
        return;
    }
    
    if ([amount intValue] < 10) {
        [HttpUtils showAlert:@"充值金额最低10元，请重新输入。"];
        return;
    }
    
    [self.loadingView startAnimating];
    
    [self.view endEditing:NO];
    
    [HttpUtils doRechargeAlipay:[SharedInstance instance].ggid total_fee:amount blockFinish:^(NSDictionary *dic) {
        
        [self.loadingView stopAnimating];
        
        DLog(@"reuqest successed!!!");
        DLog(@"%@",dic);
        
        NSString* ret = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ret"]];
        
        NSString* out_trade_no = [NSString stringWithFormat:@"%@",[dic objectForKey:@"out_trade_no"]];
        
        if ([@"1" isEqualToString:ret] && ![out_trade_no isEqualToString:@""]) {
            DLog(@"out_trade_no:%@",out_trade_no);
            
            NSString* desc = [NSString stringWithFormat:@"%d飞币",[amount intValue]*20];
            
            [self invokeAlipay:out_trade_no amount:amount productDesc:desc];
            
            
        }else{
            [HttpUtils showAlert:@"充值失败，请稍后重试。"];
        }
        
    } blockFailur:^ {
        
        [self.loadingView stopAnimating];
        
        DLog(@"reuqest failured!!!");
        [HttpUtils showAlert:@"充值失败，请稍后重试。"];
    }];
    
}

- (void)invokeAlipay:(NSString*)out_trade_no amount:(NSString*)amount productDesc:(NSString*)productDesc{
    
    /*
	 *商户的唯一的parnter和seller。
	 *本demo将parnter和seller信息存于（AlixPayDemo-Info.plist）中,外部商户可以考虑存于服务端或本地其他地方。
	 *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
	 */
	//如果partner和seller数据存于其他位置,请改写下面两行代码
	NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
    NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
	
	//partner和seller获取失败,提示
	if ([partner length] == 0 || [seller length] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
														message:@"缺少partner或者seller。"
													   delegate:self
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
		[alert show];
		return;
	}
	
	/*
	 *生成订单信息及签名
	 *由于demo的局限性，本demo中的公私钥存放在AlixPayDemo-Info.plist中,外部商户可以存放在服务端或本地其他地方。
	 */
	//将商品信息赋予AlixPayOrder的成员变量
	AlixPayOrder *order = [[AlixPayOrder alloc] init];
	order.partner = partner;
	order.seller = seller;
	order.tradeNO = out_trade_no; //订单ID（由商家自行制定）
	order.productName = @"飞币充值"; //商品标题
	order.productDescription = productDesc; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",[amount floatValue]]; //商品价格
	order.notifyURL =  @"http://wap.feelyou.cn//alipay_android/notify_url.php"; //回调URL
	
	//应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于快捷支付成功后重新唤起商户应用
	NSString *appScheme = @"FeelYou";
	
	//将商品信息拼接成字符串
	NSString *orderSpec = [order description];
	DLog(@"orderSpec = %@",orderSpec);
	
	//获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
	id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
	NSString *signedString = [signer signString:orderSpec];
	
	//将签名成功字符串格式化为订单字符串,请严格按照该格式
	NSString *orderString = nil;
	if (signedString != nil) {
		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        //获取快捷支付单例并调用快捷支付接口
        AlixPay * alixpay = [AlixPay shared];
        int ret = [alixpay pay:orderString applicationScheme:appScheme];
        
        if (ret == kSPErrorAlipayClientNotInstalled) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:@"您还没有安装支付宝快捷支付，请先安装。"
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil];
            [alertView setTag:123];
            [alertView show];
        }
        else if (ret == kSPErrorSignError) {
            DLog(@"签名错误！");
        }
        
	}

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 123) {
		NSString * URLString = @"http://itunes.apple.com/cn/app/id535715926?mt=8";
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
	}
}


- (IBAction)actionBack:(id)sender {
    
    [self.loadingView stopAnimating];
    
    [self.view endEditing:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

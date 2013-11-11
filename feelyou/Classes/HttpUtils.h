//
//  Utils.h
//  feelyou
//
//  Created by wang hongbo on 12-3-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BlockRequestFinish)(NSDictionary *);
typedef void(^BlockRequestFailur)(void);

#define BASE_URL @"http://wap.feelyou.cn/api/"

//登陆
#define URL_LOGIN @"%@check_user_json.php?fid=%@&fpwd=%@&checkcode=%@"
//找回密码
#define URL_RESET_PWD @"%@find_pwd.php?mobileno=%@&checkcode=%@"
//拨打电话
#define URL_DAIL @"%@javacall.php?telno=%@&ggid=%@&checkcode=%@"
//余额查询
#define URL_GET_BALANCE @"%@getBalance.php?ggid=%@&checkcode=%@"
//通话详单
#define URL_CALL_DETAIL @"%@call_list.php?ggid=%@&checkcode=%@"
//支付宝下单
#define URL_RECHARGE_ALIPAY @"%@android_pay.php?ggid=%@&total_fee=%@&checkcode=%@"
//充值卡充值
#define URL_RECHARGE_CARD @"%@sjk_pay.php?ggid=%@&channel=%@&cardno=%@&cardpwd=%@&money=%@&checkcode=%@"
//查询充值卡充值记录
#define URL_RECHARGE_CARD_HIS @"%@sjk_pay_list.php?ggid=%@&checkcode=%@"

#define KEY_DEFAULT @"result"
#define RESULT_SUCCESS @"0"

#define KEY_GGID @"ggid"
#define KEY_MOBILEID @"tel"

@interface HttpUtils : NSObject {

}

+ (NSString *) getMD5:(NSString *)str;

+ (BOOL) isValidPhoneNumber:(NSString *)phoneNumber;

+ (void) doRequest:(NSString *)urlString blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur;

+ (void) doLogin:(NSString*)fid fpwd:(NSString*)fpwd blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur;

+ (void) doResetPwd:(NSString*)mobileno blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur;

+ (void) doDail:(NSString*)telno ggid:(NSString*)ggid blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur;

+ (void) doGetBalance:(NSString*)ggid blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur;

+ (void) doRechargeAlipay:(NSString*)ggid total_fee:(NSString*)total_fee blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur;

+ (void) doRechargeCard:(NSString*)ggid channel:(NSString*)channel cardno:(NSString*)cardno cardpwd:(NSString*)cardpwd money:(NSString*)money blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur;

+ (void) doRechargeCardHis:(NSString*)ggid blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur;

+ (void) showAlert:(NSString*)message;

@end

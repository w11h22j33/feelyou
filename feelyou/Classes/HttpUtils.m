//
//  Utils.m
//  feelyou
//
//  Created by wang hongbo on 12-3-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HttpUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFJSONRequestOperation.h"

#define end_fix @"fy602"

@implementation HttpUtils

+ (NSString *) getMD5:(NSString *)str {
	const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", 
				result[0], result[1], result[2], result[3], 
				result[4], result[5], result[6], result[7], 
				result[8], result[9], result[10], result[11], 
				result[12], result[13], result[14], result[15]];
} 

+ (BOOL) isValidPhoneNumber:(NSString *)phoneNumber {
	NSString *phoneNumberRegex = @"^1[358]\\d{9}";
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumberRegex];
    return [regexPredicate evaluateWithObject:phoneNumber];
}

+ (void)doRequest:(NSString *)urlString blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur{
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        NSDictionary * jsonDic  = (NSDictionary *)JSON;
                                                        
                                                        if (blockFinish) {
                                                            blockFinish(jsonDic);
                                                        }
                                                        
                                                    }
     
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        
                                                        if (blockFailur) {
                                                            blockFailur();
                                                        }else{
                                                            
                                                            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                                         message:[NSString stringWithFormat:@"%@",error]
                                                                                                        delegate:nil
                                                                                               cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                            [av show];
                                                        }
                                                        
                                                        
                                                    }];
    
    [operation start];
    
}

+ (void)doLogin:(NSString*)fid fpwd:(NSString *)fpwd blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur{
    
    NSString* preMd5 = [NSString stringWithFormat:@"%@%@%@",fid,fpwd,end_fix];
    
    NSString *urlString = [NSString stringWithFormat:URL_LOGIN,BASE_URL,fid,fpwd,[HttpUtils getMD5:preMd5]];
    
    [HttpUtils doRequest:urlString blockFinish:blockFinish blockFailur:blockFailur];
    
}

+ (void)doResetPwd:(NSString *)mobileno blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur{
    
    NSString* preMd5 = [NSString stringWithFormat:@"%@%@",mobileno,end_fix];
    
    NSString *urlString = [NSString stringWithFormat:URL_RESET_PWD,BASE_URL,mobileno,[HttpUtils getMD5:preMd5]];
    
    NSError* error;
    
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        blockFailur();
    }else{
        blockFinish([NSDictionary dictionaryWithObject:result forKey:KEY_DEFAULT]);
    }
    
}

+ (void)doDail:(NSString *)telno ggid:(NSString *)ggid blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur{
    
    NSString* preMd5 = [NSString stringWithFormat:@"%@%@%@",telno,ggid,end_fix];
    
    NSString *urlString = [NSString stringWithFormat:URL_DAIL,BASE_URL,telno,ggid,[HttpUtils getMD5:preMd5]];
    
    NSError* error;
    
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        blockFailur();
    }else{
        blockFinish([NSDictionary dictionaryWithObject:result forKey:KEY_DEFAULT]);
    }
    
}

+ (void)doGetBalance:(NSString *)ggid blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur{
    
    NSString* preMd5 = [NSString stringWithFormat:@"%@%@",ggid,end_fix];
    
    NSString *urlString = [NSString stringWithFormat:URL_GET_BALANCE,BASE_URL,ggid,[HttpUtils getMD5:preMd5]];
    
    NSError* error;
    
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        blockFailur();
    }else{
        blockFinish([NSDictionary dictionaryWithObject:result forKey:KEY_DEFAULT]);
    }
    
}

+ (void)doRechargeAlipay:(NSString *)ggid total_fee:(NSString *)total_fee blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur{
    
    NSString* preMd5 = [NSString stringWithFormat:@"%@%@%@",ggid,total_fee,end_fix];
    
    NSString *urlString = [NSString stringWithFormat:URL_RECHARGE_ALIPAY,BASE_URL,ggid,total_fee,[HttpUtils getMD5:preMd5]];
    
    [HttpUtils doRequest:urlString blockFinish:blockFinish blockFailur:blockFailur];
    
}

+ (void)doRechargeCard:(NSString *)ggid channel:(NSString *)channel cardno:(NSString *)cardno cardpwd:(NSString *)cardpwd money:(NSString *)money blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur{
    
    NSString* preMd5 = [NSString stringWithFormat:@"%@%@%@%@",ggid,cardno,cardpwd,end_fix];
    
    NSString *urlString = [NSString stringWithFormat:URL_RECHARGE_CARD,BASE_URL,ggid,channel,cardno,cardpwd,money,[HttpUtils getMD5:preMd5]];
    
    [HttpUtils doRequest:urlString blockFinish:blockFinish blockFailur:blockFailur];
    
}

+ (void)doRechargeCardHis:(NSString *)ggid blockFinish:(BlockRequestFinish)blockFinish blockFailur:(BlockRequestFailur)blockFailur{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    NSString* date = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString* preMd5 = [NSString stringWithFormat:@"%@%@%@",ggid,date,end_fix];
    
    NSString *urlString = [NSString stringWithFormat:URL_RECHARGE_CARD_HIS,BASE_URL,ggid,[HttpUtils getMD5:preMd5]];
    
    [HttpUtils doRequest:urlString blockFinish:blockFinish blockFailur:blockFailur];
    
//    NSError* error;
//    
//    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:&error];
//    
//    if (error) {
//        blockFailur();
//    }else{
//        blockFinish([NSDictionary dictionaryWithObject:result forKey:KEY_DEFAULT]);
//    }
    
}

+ (void)showAlert:(NSString *)message{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
    
}

@end

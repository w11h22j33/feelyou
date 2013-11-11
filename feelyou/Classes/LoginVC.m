//
//  LoginVC.m
//  UPay
//
//  Created by haijun wang on 12-7-31.
//  Copyright (c) 2012年 Umpay. All rights reserved.
//

#import "LoginVC.h"

#define SEG_LOGIN @"segLoginSuccess"
#define SEG_REGIST @"segRegist"
#define SEG_RESETPWD @"segReset"

@interface LoginVC (){
    
    
    
}

@end


@implementation LoginVC

@synthesize tfPassWord,tfUserName;
@synthesize btnRegist,btnResetPwd,btnSubmit;
@synthesize loadingView;

- (void)viewDidLoad{
    
    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    
    self.tfUserName.text = [prefs valueForKey:@"mobileId"];
    
//    self.tfPassWord.text = [prefs valueForKey:@"pwd"];
    
}

- (IBAction)actionLogin:(id)sender {
    
    DLog(@"actionLogin-->");
    
//    AppDelegate* dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
//    NSManagedObjectContext* context = dele.managedObjectContext;
    
    NSString* mobileId = [tfUserName text];
    NSString* pwd = [tfPassWord text];
    
    if (mobileId==Nil || mobileId.length<11) {
        
        [HttpUtils showAlert:@"请输入正确的手机号码！"];
        
        return;
    }
    
    if (pwd==Nil || pwd.length<6) {
        
        [HttpUtils showAlert:@"请输入正确的密码！"];
        
        return;
        
    }
    
    [self.view endEditing:NO];
    
    [self.loadingView startAnimating];
    
    [HttpUtils doLogin:mobileId fpwd:pwd blockFinish:^(NSDictionary * dic) {
        
        [self.loadingView stopAnimating];
        
        DLog(@"reuqest successed!!!");
        DLog(@"%@",dic);
        
        NSString* ggid = [dic objectForKey:KEY_GGID];
        NSString* mobileId = [dic objectForKey:KEY_MOBILEID];
        
        if (ggid && mobileId) {
            
            [[SharedInstance instance] setGgid:ggid];
            [[SharedInstance instance] setMobileId:mobileId];
            
            NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
            
            [prefs setValue:mobileId forKey:@"mobileId"];
            
            [prefs setValue:pwd forKey:@"pwd"];
            
            [prefs synchronize];

            
//            User* user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
//            user.phone = mobileId;
//            user.password = pwd;
//            user.ggid = ggid;
//            
//            NSError* error = nil;
//            if(![context save:&error]){
//                DLog(@"%@",[error localizedDescription]);
//            }else{
//                DLog(@"insert successed!!!");
//            }
//            
//            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
//            NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
//            [fetchRequest setEntity:entity];
//            
//            NSArray *fetchObject = [context executeFetchRequest:fetchRequest error:&error];
//            for (NSManagedObject *user in fetchObject) {
//                DLog(@"user:%@",[user description]);
//            }
            
            [self performSegueWithIdentifier:SEG_LOGIN sender:self];
        }else{
            [HttpUtils showAlert:@"登陆失败，请重试！"];
        }
        
    } blockFailur:^ {
        
        [self.loadingView stopAnimating];
        
        DLog(@"reuqest failured!!!");
        
        [HttpUtils showAlert:@"登陆失败，请重试！"];
        
    }];
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//    if ([segue.identifier isEqualToString:SEG_LOGIN]) {
//        UIViewController* desVC = (UIViewController*)segue.destinationViewController;
//    }
//    
//}

@end

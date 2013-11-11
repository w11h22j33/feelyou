//
//  LoginVC.h
//
//  Created by haijun wang on 12-7-31.
//  Copyright (c) 2012年 Umpay. All rights reserved.
//

#import "User.h"
#import "AppDelegate.h"
#import "BaseViewController.h"

@interface LoginVC : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfPassWord;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton *btnRegist;
@property (weak, nonatomic) IBOutlet UIButton *btnResetPwd;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

- (IBAction)actionLogin:(id)sender;

@end

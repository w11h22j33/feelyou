//
//  CardRechargeVC.h
//  feelyou
//
//  Created by wang haijun on 13-11-2.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CardRechargeVC : BaseViewController

@property (assign,nonatomic) int type;
@property (weak, nonatomic) IBOutlet UITextField *tfCardNo;
@property (weak, nonatomic) IBOutlet UITextField *tfCardPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfAmount;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

- (IBAction)actionConfirm:(id)sender;
- (IBAction)actionBack:(id)sender;
- (IBAction)actionSelected:(id)sender;



@end

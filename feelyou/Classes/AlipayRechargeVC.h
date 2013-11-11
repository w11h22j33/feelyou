//
//  AlipayRechargeVC.h
//  feelyou
//
//  Created by wang haijun on 13-11-2.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AlipayRechargeVC : BaseViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tfAmount;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
- (IBAction)actionConfirm:(id)sender;
- (IBAction)actionBack:(id)sender;

@end

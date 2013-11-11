//
//  ResetVC.h
//  feelyou
//
//  Created by wang haijun on 13-10-21.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ResetVC : BaseViewController
- (IBAction)actionReset:(id)sender;
- (IBAction)actionBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (weak, nonatomic) IBOutlet UITextField *tfMobileId;

@end

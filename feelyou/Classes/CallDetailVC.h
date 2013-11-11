//
//  CallDetailVC.h
//  feelyou
//
//  Created by wang haijun on 13-11-2.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CallDetailVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)actionBack:(id)sender;

@end

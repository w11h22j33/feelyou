//
//  BaseViewController.m
//  feelyou
//
//  Created by wang haijun on 13-11-6.
//
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    Boolean IS_IOS7 = [[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0f;
    
    if (IS_IOS7) {
        
        CGRect rect = self.view.frame;
        
        DLog(@"viewDidLoad----->%@",NSStringFromCGRect(rect));
        
        rect.origin.y -= 20;
        rect.size.height -= 20;
        
        self.view.bounds = rect;

    }
    
}

@end

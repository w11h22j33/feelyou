//
//  NavigationController.m
//  feelyou
//
//  Created by wang haijun on 13-11-6.
//
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化手势监听，用于点击关闭键盘
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
    tapGr.cancelsTouchesInView = NO;
    [tapGr setDelegate:self];
    [self.view addGestureRecognizer:tapGr];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    
    [self.view addGestureRecognizer:recognizer];
    
}

- (void)endEditing{
    
    [self.view endEditing:YES];
    
}

@end

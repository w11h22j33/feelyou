//
//  TextField.m
//  feelyou
//
//  Created by wang haijun on 13-11-6.
//
//

#import "TextField.h"

@implementation TextField

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    
    self.leftView = view;
    
    self.leftViewMode = UITextFieldViewModeAlways;
    
    [self setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    return self;
    
}

@end

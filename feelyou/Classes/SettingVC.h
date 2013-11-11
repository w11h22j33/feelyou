//
//  SettingVC.h
//  feelyou
//
//  Created by wang haijun on 13-10-25.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SettingVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSArray* sections;
@property (strong,nonatomic) NSArray* titles;
@property (strong,nonatomic) NSArray* actions;

@end

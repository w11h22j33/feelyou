//
//  CardRechargeHisVC.h
//  feelyou
//
//  Created by wang haijun on 13-11-2.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface CardRechargeHisVC : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray* records;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
- (IBAction)actionBack:(id)sender;

@end

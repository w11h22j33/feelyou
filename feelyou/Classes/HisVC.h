//
//  HisVC.h
//  feelyou
//
//  Created by wang haijun on 13-10-25.
//
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface HisVC : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray* records;



@end

//
//  SettingVC.m
//  feelyou
//
//  Created by wang haijun on 13-10-25.
//
//

#import "SettingVC.h"

@interface SettingVC ()

@end

@implementation SettingVC

@synthesize tableView;

@synthesize sections;

@synthesize titles,actions;

- (void)viewDidLoad{
    
    self.sections = [NSArray arrayWithObjects:@"我的账户", @"我要充值", nil];
    
    NSArray* titles1 = [NSArray arrayWithObjects:@"重新登录", @"通话详单",nil];
    
    NSArray* titles2 = [NSArray arrayWithObjects:@"支付宝充值", @"充值卡充值", @"充值卡充值记录",@"关于我们",nil];
    
    self.titles = [NSArray arrayWithObjects:titles1, titles2, nil];
    
    NSArray* actions1 = [NSArray arrayWithObjects:@"logout", @"segCallDetailVC", nil];
    
    NSArray* actions2 = [NSArray arrayWithObjects:@"segAlipayRechargeVC", @"segCardRechargeVC", @"segCardRechargeHisVC",@"segAboutVC",nil];
    
    self.actions = [NSArray arrayWithObjects:actions1, actions2, nil];
}

- (void)logout{
    
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
    
}

- (void)segCallDetailVC{
    
    [self performSegueWithIdentifier:@"SegCallDetailVC" sender:self];
    
}

- (void)segAlipayRechargeVC{
    
    [self performSegueWithIdentifier:@"SegAlipayRechargeVC" sender:self];
    
}

- (void)segCardRechargeVC{
    
    [self performSegueWithIdentifier:@"SegCardRechargeVC" sender:self];
    
}

- (void)segCardRechargeHisVC{
    
    [self performSegueWithIdentifier:@"SegCardRechargeHisVC" sender:self];
    
}

- (void)segAboutVC{
    
    [self performSegueWithIdentifier:@"SegAboutVC" sender:self];
    
}

#pragma mark tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sections.count;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self.sections objectAtIndex:section];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[self.titles objectAtIndex:section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [[self.titles objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int section = indexPath.section;
    int row = indexPath.row;
    
    SEL selector = NSSelectorFromString([[actions objectAtIndex:section] objectAtIndex:row]);
    
    [self performSelector:selector withObject:Nil];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

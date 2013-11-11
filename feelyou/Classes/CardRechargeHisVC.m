//
//  CardRechargeHisVC.m
//  feelyou
//
//  Created by wang haijun on 13-11-2.
//
//

#import "CardRechargeHisVC.h"

@interface CardRechargeHisVC ()

@end

@implementation CardRechargeHisVC

@synthesize tableView,records,loadingView;

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.loadingView startAnimating];
    
    [HttpUtils doRechargeCardHis:[SharedInstance instance].ggid blockFinish:^(NSDictionary *dic) {
        
        [self.loadingView stopAnimating];
        
        DLog(@"reuqest successed!!!");
        DLog(@"%@",dic);
        
        self.records = [[dic objectForKey:@"lists"] copy];
        
        if (self.records && self.records.count > 0) {
            [self.tableView reloadData];
        }else{
            [HttpUtils showAlert:@"充值记录查询失败。"];
        }
        
    } blockFailur:^ {
        [self.loadingView stopAnimating];
        
        [HttpUtils showAlert:@"充值记录查询失败。"];
        
        DLog(@"reuqest failured!!!");
    }];
    
}

- (IBAction)actionBack:(id)sender {
    
    [self.loadingView stopAnimating];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int rows = self.records.count;
    
    DLog(@"self.records.count:%d",rows);
    
    return rows;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
    
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        UILabel* lcardNo = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 210, 15)];
        lcardNo.tag = 101;
        lcardNo.font = [UIFont boldSystemFontOfSize:12];
        lcardNo.textColor = [UIColor blackColor];
        [cell addSubview:lcardNo];
        
        UILabel* ldate = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 210, 15)];
        ldate.tag = 102;
        ldate.font = [UIFont systemFontOfSize:12];
        ldate.textColor = [UIColor darkGrayColor];
        [cell addSubview:ldate];
        
        UILabel* lamount = [[UILabel alloc] initWithFrame:CGRectMake(215, 5, 100, 15)];
        lamount.tag = 103;
        lamount.font = [UIFont systemFontOfSize:12];
        lamount.textColor = [UIColor orangeColor];
        [cell addSubview:lamount];
        
        UILabel* lresult = [[UILabel alloc] initWithFrame:CGRectMake(215, 25, 100, 15)];
        lresult.tag = 104;
        lresult.font = [UIFont boldSystemFontOfSize:12];
        lresult.textColor = [UIColor redColor];
        [cell addSubview:lresult];
        
    }
    
    NSDictionary* d = [self.records objectAtIndex:indexPath.row];
    
    NSString* cardNo = [NSString stringWithString:[d objectForKey:@"cardno"]];
    NSString* date = [NSString stringWithString:[d objectForKey:@"order_time"]];
    NSString* amount = [NSString stringWithString:[d objectForKey:@"order_fee"]];
    NSString* result = [NSString stringWithFormat:@"%@",[d objectForKey:@"return_status"]];
    
    UILabel* lcardNo = (UILabel*)[cell viewWithTag:101];
    lcardNo.text = cardNo;
    
    UILabel* ldate = (UILabel*)[cell viewWithTag:102];
    ldate.text = date;
    
    UILabel* lamount = (UILabel*)[cell viewWithTag:103];
    lamount.text = [NSString stringWithFormat:@"面值：%@元",amount];
    
    UILabel* lresult = (UILabel*)[cell viewWithTag:104];
    lresult.text = [result isEqualToString:@"1"]?@"充值成功":@"充值失败";
    
    return cell;
}

@end

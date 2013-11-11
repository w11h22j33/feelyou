//
//  HisVC.m
//  feelyou
//
//  Created by wang haijun on 13-10-25.
//
//

#import "HisVC.h"

#import "AppDelegate.h"
#import "Records.h"

@interface HisVC ()

@end

@implementation HisVC

@synthesize records;
@synthesize tableView;
@synthesize loadingView;

- (void)viewWillAppear:(BOOL)animated{
    
    [self reloadData];
    [self.tableView reloadData];
}

- (void)reloadData{
    
    AppDelegate* dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext* context = dele.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Records" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError* error = nil;
    
    self.records = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *user in self.records) {
        DLog(@"record:%@",[user description]);
    }
    
}

#pragma mark tableView datasource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"拨号记录";
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int rows = self.records.count;
    
    if (rows == 0) {
        [self reloadData];
    }
    
    rows = self.records.count;
    
    DLog(@"self.records.count:%d",rows);
    
    return rows;
    
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    Records* r = [self.records objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@            %@",r.phone,r.time];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Records* r = [self.records objectAtIndex:indexPath.row];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString* mobileId = r.phone;
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"立即拨打电话%@？",mobileId] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        int index = alertView.tag;
        
        Records* r = [self.records objectAtIndex:index];
        
        NSString* mobileId = r.phone;
        
        [HttpUtils doDail:mobileId ggid:[SharedInstance instance].ggid blockFinish:^(NSDictionary *dic) {
            
            [self.loadingView stopAnimating];
            
            DLog(@"reuqest successed!!!");
            
            DLog(@"%@",dic);
            
            if ([RESULT_SUCCESS isEqualToString:[dic valueForKey:KEY_DEFAULT]]) {
                [HttpUtils showAlert:[NSString stringWithFormat:@"拨打电话%@成功,请注意接听来电。",mobileId]];
                
                AppDelegate* dele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                
                NSManagedObjectContext* context = dele.managedObjectContext;
                
                Records* record = [NSEntityDescription insertNewObjectForEntityForName:@"Records" inManagedObjectContext:context];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                
                NSString* time = [dateFormatter stringFromDate:[NSDate date]];
                
                record.phone = mobileId;
                record.time = time;
                
                NSError* error = nil;
                
                if(![context save:&error]){
                    DLog(@"%@",[error localizedDescription]);
                }else{
                    DLog(@"insert successed!!!");
                }
                
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"Records" inManagedObjectContext:context];
                [fetchRequest setEntity:entity];
                
                NSArray *fetchObject = [context executeFetchRequest:fetchRequest error:&error];
                for (NSManagedObject *user in fetchObject) {
                    DLog(@"record:%@",[user description]);
                }
                
            }else{
                
                [HttpUtils showAlert:[NSString stringWithFormat:@"拨打电话%@失败！",mobileId]];
            }
            
        } blockFailur:^ {
            
            [self.loadingView stopAnimating];
            
            DLog(@"reuqest failured!!!");
            [HttpUtils showAlert:[NSString stringWithFormat:@"拨打电话%@失败！",mobileId]];
        }];
    }
}

@end
//
//  DailVC.m
//  feelyou
//
//  Created by wang haijun on 13-10-25.
//
//

#import "DailVC.h"
#import "AppDelegate.h"
#import "Records.h"

@interface DailVC ()

@end

@implementation DailVC

@synthesize usershow,tfMobileId,loadingView;

- (void)viewWillAppear:(BOOL)animated{
    
    [HttpUtils doGetBalance:[SharedInstance instance].ggid blockFinish:^(NSDictionary *dic) {
        
        DLog(@"reuqest successed!!!");
        DLog(@"%@",dic);
        
        NSString* balance = [dic objectForKey: KEY_DEFAULT];
        
        if (balance) {
            
            NSString* userShowText = [NSString stringWithFormat:@"用户%@,您好！余额：%@",[SharedInstance instance].mobileId,balance];
            
            [usershow setText:userShowText];
        }
        
    } blockFailur:^ {
        
        DLog(@"reuqest failured!!!");
        
    }];
    
}

//************************从电话本中取得选择电话号

- (void)pickupMobileId{
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    
    picker.peoplePickerDelegate = self;
    
    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                               nil];
    
    picker.displayedProperties = displayedItems;
    
    [self presentViewController:picker animated:YES completion:Nil];
    
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
								property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    if (property == kABPersonPhoneProperty)
    {
        ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
        //电话号码
        NSString *phone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, identifier);
        
        phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
        
        phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
        
        phone = [phone stringByReplacingOccurrencesOfString:@"*" withString:@""];
        
        phone = [phone stringByReplacingOccurrencesOfString:@"+" withString:@""];
        
        phone = [phone stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        //        截取从电话本得到的电话号
        if ([phone length]>=11) {
            phone = [phone substringFromIndex:[phone length]-11];
        }
        
        [self.tfMobileId setText:phone];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:Nil];
    
    return NO;
    
    
    //	return NO;
}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}

- (IBAction)btnPickup:(id)sender {
    
    [self pickupMobileId];
    
}

- (IBAction)btnDial:(id)sender {
    
    NSString* mobileId = [tfMobileId text];
    
    if (mobileId==Nil || mobileId.length<11) {
        
        [HttpUtils showAlert:@"请输入正确的手机号码！"];
        
        return;
    }
    
    [self.view endEditing:YES];
    
    [self.loadingView startAnimating];
    
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

@end

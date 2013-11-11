//
//  DailVC.h
//  feelyou
//
//  Created by wang haijun on 13-10-25.
//
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "BaseViewController.h"

@interface DailVC : BaseViewController<ABPeoplePickerNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *usershow;
@property (weak, nonatomic) IBOutlet UITextField *tfMobileId;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
- (IBAction)btnPickup:(id)sender;
- (IBAction)btnDial:(id)sender;

@end

//
//  CallRecordsCell.h
//  backPocketAgent
//
//  Created by wang hongbo on 12-3-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CallRecordsCell : UITableViewCell {
	UILabel *callRecordLabel;
	UIImageView *chooseImageView;
}

@property (nonatomic,retain) IBOutlet UILabel *callRecordLabel;
@property (nonatomic,retain) IBOutlet UIImageView *chooseImageView;

@end

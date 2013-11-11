//
//  CallRecordsCell.m
//  backPocketAgent
//
//  Created by wang hongbo on 12-3-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CallRecordsCell.h"


@implementation CallRecordsCell

@synthesize callRecordLabel;
@synthesize chooseImageView;

- (void)dealloc {
	[callRecordLabel release];
	[chooseImageView release];
    [super dealloc];
}


@end

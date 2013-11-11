//
//  Records.h
//  feelyou
//
//  Created by wang haijun on 13-10-28.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Records : NSManagedObject

@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * time;

@end

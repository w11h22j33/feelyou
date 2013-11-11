//
//  User.h
//  feelyou
//
//  Created by wang haijun on 13-10-28.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * ggid;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * updateStatus;

@end

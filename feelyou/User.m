//
//  User.m
//  feelyou
//
//  Created by wang haijun on 13-10-28.
//
//

#import "User.h"


@implementation User

@dynamic ggid;
@dynamic phone;
@dynamic password;
@dynamic updateStatus;

- (NSString *)description{
    
    return [NSString stringWithFormat:@"ggid:%@,phone:%@,password:%@,updateStatus:%@",self.ggid,self.phone,self.password,self.updateStatus];
    
}

@end

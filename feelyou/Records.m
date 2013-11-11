//
//  Records.m
//  feelyou
//
//  Created by wang haijun on 13-10-28.
//
//

#import "Records.h"


@implementation Records

@dynamic phone;
@dynamic time;

- (NSString *)description{
    
    return [NSString stringWithFormat:@"phone:%@,time:%@,",self.phone,self.time];
    
}

@end

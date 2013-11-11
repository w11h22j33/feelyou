#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SharedInstance : NSObject

@property (strong,atomic) NSString* ggid;
@property (strong,atomic) NSString* mobileId;

+ (SharedInstance*)instance;



@end

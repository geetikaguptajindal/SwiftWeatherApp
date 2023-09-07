//
//  NetworkManager.h
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NetworkManagerSuccess)(id responseObject);
typedef void (^NetworkManagerFailure)(NSString *failureReason, NSInteger statusCode);

@interface NetworkManager : NSObject

+ (NetworkManager*)sharedManager;
- (void)performGETRequest:(NSDictionary *)params url: (NSURL*)url success:(NetworkManagerSuccess)success failure:(NetworkManagerFailure)failure;

@end

NS_ASSUME_NONNULL_END

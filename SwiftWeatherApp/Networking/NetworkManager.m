//
//  NetworkManager.m
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

#import "NetworkManager.h"
#import <Foundation/Foundation.h>
#import "NetworkHeader.h"

@implementation NetworkManager : NSObject

static NetworkManager* sharedManager = nil;

+ (NetworkManager*)sharedManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^
    {
        sharedManager = [[NetworkManager alloc] init];
    });
    return sharedManager;
}

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)performGETRequest:(NSDictionary *)params url: (NSURL*)url success:(NetworkManagerSuccess)success failure:(NetworkManagerFailure)failure {

    [self showProgressHUD];
    //create AFNetwork manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    // get request
    [manager GET:url.absoluteString parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * task, id  responseObject) {
        [self hideProgressHUD];
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * operation, NSError * error) {
        [self hideProgressHUD];
        NSString *errorMessage = [self getError:error];
        if (failure != nil) {
            failure(errorMessage, ((NSHTTPURLResponse*)operation.response).statusCode);
        }
    }];
}

- (NSString*)getError:(NSError*)error {
    if (error != nil) {
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        if (responseObject != nil && [responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"message"] != nil && [[responseObject objectForKey:@"message"] length] > 0) {
            return [responseObject objectForKey:@"message"];
        }
    }
    return @"Server Error. Please try again later";
}

- (void)showProgressHUD {
    [SVProgressHUD show];
}

- (void)hideProgressHUD {
    [SVProgressHUD dismiss];
}

@end
    
    



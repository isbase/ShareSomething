//
//  HttpTool.h
//  ShareSomething
//
//  Created by dev on 14-10-15.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface HttpTool : NSObject


+ (void) GET:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

+ (void) POST:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

@end

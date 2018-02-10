//
//  SharedData.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 27..
//  Copyright © 2017년 com. All rights reserved.
//

#import "SharedData.h"

@implementation SharedData

+ (instancetype) sharedInstance
{
    static SharedData *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SharedData alloc] init];
        [sharedInstance initInstance];
    });
    return sharedInstance;
}

- (void) initInstance
{
    self.userId = @"";
    self.token = @"";
}

@end

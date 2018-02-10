//
//  SharedData.h
//  Zdaly
//
//  Created by AAA on 2017. 9. 27..
//  Copyright © 2017년 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedData : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *token;
+ (instancetype) sharedInstance;
@end

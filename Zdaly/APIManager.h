//
//  APIManager.h
//  XaiCam
//
//  Created by AAA on 4/21/17.
//  Copyright © 2017 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIManagerListener

@optional

- (void) httpSuccess:(NSData *) data;
- (void) httpError:(NSError*) error;

@end


@interface APIManager : NSObject

// Flags..
@property (nonatomic, assign) NSInteger callbackFlag;

// Shared instance..
+ (instancetype) sharedInstance;

// Main functions..
- (void) authenticateUser:(id<APIManagerListener>)listener email:(NSString *)email password:(NSString *)password;
- (void) getDailyNews:(id<APIManagerListener>)listener;
- (void) getSearchedNews:(id<APIManagerListener>)listener searchTerm:(NSString *)searchTerm;
- (void) getFilteredNews:(id<APIManagerListener>)listener dateFilter:(NSString *)dateFilter;
- (void) getKeyTrends:(id<APIManagerListener>)listener;
- (void) getSpotPrices:(id<APIManagerListener>)listener;
- (void) getWeatherForecast:(id<APIManagerListener>)listener;
- (void) getMarineForecast:(id<APIManagerListener>)listener latitude:(double)latitude longitude:(double)longitude;
@end

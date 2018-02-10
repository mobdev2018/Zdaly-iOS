//
//  APIManager.m
//  XaiCam
//
//  Created by AAA on 4/21/17.
//  Copyright © 2017 com. All rights reserved.
//

#import "Global.h"
#import "APIManager.h"
#import "SharedData.h"
#import "AppDelegate.h"

@interface APIManager () <APIManagerListener>
{
    AppDelegate *appDelegate;
}
@end

@implementation APIManager

+ (instancetype) sharedInstance {
    static APIManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIManager alloc] init];
    });
    return sharedInstance;
}

- (void) authenticateUser:(id<APIManagerListener>)listener email:(NSString *)email password:(NSString *)password {
    [self httpRequestWithListener:listener URL:[NSString stringWithFormat:@"%@?email=%@&password=%@", AUTHENTICATE_URL, email, password] method:@"POST" parameter:nil];
}

//----------------------------------------------------------------------------------------------------------------
// Get News API
//----------------------------------------------------------------------------------------------------------------
- (void) getDailyNews:(id<APIManagerListener>)listener {
    [self httpRequestWithListener:listener URL:[NSString stringWithFormat:@"%@?id=%@", DAILY_NEWS_URL, [SharedData sharedInstance].userId] method:@"GET" parameter:nil];
}

- (void) getSearchedNews:(id<APIManagerListener>)listener searchTerm:(NSString *)searchTerm {
    [self httpRequestWithListener:listener URL:[NSString stringWithFormat:@"%@?id=%@&search=%@", DAILY_NEWS_URL, [SharedData sharedInstance].userId, searchTerm] method:@"GET" parameter:nil];
}

- (void) getFilteredNews:(id<APIManagerListener>)listener dateFilter:(NSString *)dateFilter {
    [self httpRequestWithListener:listener URL:[NSString stringWithFormat:@"%@?id=%@&date=%@", DAILY_NEWS_URL, [SharedData sharedInstance].userId, dateFilter] method:@"GET" parameter:nil];
}

- (void) getKeyTrends:(id<APIManagerListener>)listener {
    [self httpRequestWithListener:listener URL:[NSString stringWithFormat:@"%@?id=%@", KEY_TRENDS_URL, [SharedData sharedInstance].userId] method:@"GET" parameter:nil];
}

- (void) getSpotPrices:(id<APIManagerListener>)listener {
    [self httpRequestWithListener:listener URL:[NSString stringWithFormat:@"%@?id=%@", SPOT_PRICES_URL, [SharedData sharedInstance].userId] method:@"GET" parameter:nil];
}

- (void) getWeatherForecast:(id<APIManagerListener>)listener {
    [self httpRequestWithListener:listener URL:[NSString stringWithFormat:@"%@?id=%@", WEATHER_FORECAST_URL, [SharedData sharedInstance].userId] method:@"GET" parameter:nil];
}

- (void) getMarineForecast:(id<APIManagerListener>)listener latitude:(double)latitude longitude:(double)longitude {
    [self httpRequestWithListener1:listener URL:[NSString stringWithFormat:@"%@?key=%@&format=json&q=%f,%f",MARINE_FORECAST_URL, API_KEY, latitude, longitude] method:@"GET" parameter:nil];
}

//----------------------------------------------------------------------------------------------------------------
// HTTP Request API
//----------------------------------------------------------------------------------------------------------------

- (void) httpRequestWithListener:(id<APIManagerListener>)listener URL:(NSString *)actionURL method:(NSString *)method parameter:(NSMutableDictionary *)parameters {
    NSString* urlString = [NSString stringWithFormat:@"%@%@", SERVER_ADDR, actionURL];
    NSURL *httpURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpURL];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    request.HTTPMethod = method;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *httpErr = error;
        if (error == nil) {
            [self dispatchSuccessToListener:listener result:data];
            return;
        }
        else {
            [self dispatchErrorToListener:listener error:httpErr];
        }
    }];
    
    [dataTask resume];
}

- (void) httpRequestWithListener1:(id<APIManagerListener>)listener URL:(NSString *)actionURL method:(NSString *)method parameter:(NSMutableDictionary *)parameters {
    NSString* urlString = actionURL;
    NSURL *httpURL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:httpURL];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    request.HTTPMethod = method;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *httpErr = error;
        if (error == nil) {
            [self dispatchSuccessToListener:listener result:data];
            return;
        }
        else {
            [self dispatchErrorToListener:listener error:httpErr];
        }
    }];
    
    [dataTask resume];
}


- (void) dispatchSuccessToListener:(id<APIManagerListener>)listener result:(NSData *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [listener httpSuccess:data];

    });
}

- (void) dispatchErrorToListener:(id<APIManagerListener>)listener error:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [listener httpError:error];
    });
}


@end

//
//  STParsing.h
//  SteelonCall
//
//  Created by administrator on 30/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLS.h"
#import "GCNetworkReachability.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "MBProgressHUD.h"


typedef void(^completionHandler)(BOOL success,id data);
typedef void(^completionHandler1)(BOOL success,id data);

@interface STParsing : NSObject<MBProgressHUDDelegate>
{
    BOOL requestInProcess;
    int  requestNumber;
}

@property (nonatomic, strong) MBProgressHUD  *HUD;

+ (STParsing *)sharedWebServiceHelper;

-(void)requesting_GET_ServiceWithString:(NSString *)requestedString requestNumber:(int)reqNo showProgress:(BOOL)progress withHandler:(completionHandler)responseData ;

-(void)requesting_POST_ServiceWithString1:(NSString *)requestedString parameters :(NSDictionary *)parameters requestNumber:(int)reqNo showProgress:(BOOL)progress withHandler:(completionHandler1)responseData;

@end

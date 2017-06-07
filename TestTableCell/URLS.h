//
//  URLS.h
//
//  Created by administrator on 30/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#ifndef URLS_h
#define URLS_h
#import "AFNetworking/AFNetworking.h"
#import "UIImageView+AFNetworking.h"

//Constants
//production
#define Banners_Url @"https://steeloncall.com/b2b/"
#define Sponcers_Url @"https://steeloncall.com/"
#define UserOrder_Url  @"https://steeloncall.com/b2b/calculate/userservice/"
#define MAIN_Url  @"https://steeloncall.com/b2b/calculate/service/"
#define MAIN_Url1  @"https://steeloncall.com/b2b/calculate/service/"

//staging
//#define Banners_Url @"http://stg.steeloncall.com/b2b/"
//#define UserOrder_Url  @"http://stg.steeloncall.com/b2b/calculate/userservice/"
//#define MAIN_Url  @"http://stg.steeloncall.com/b2b/calculate/service/"
//#define MAIN_Url1  @"http://steeloncall.com/b2b/calculate/service/"
//#define Sponcers_Url @"https://steeloncall.com/"

//#define NSLog 

#define ALERT_DIALOG(__title__,__message__) \
do\
{\
UIAlertController * alert= [UIAlertController alertControllerWithTitle:(__title__) message:(__message__) preferredStyle:UIAlertControllerStyleAlert];UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){[alert dismissViewControllerAnimated:YES completion:nil];}];[alert addAction:ok];[self presentViewController:alert animated:YES completion:nil];\
} while ( 0 )

typedef enum
{
    WS_MAIN,
    PRODUCT_LIST,
    PRODUCT_TONNES,
    Get_Country,
    Getting_Brands,
    Getting_Grades,
    More_Seller,
    More_Detail,
    Getting_Def_Product,
    WS_Banners,
    WS_Search,
    Getting_Carts,
    Coupon_send,
    Remove_cart,
    Save_cart,
    Save_to_Cart,
    Cart_Count,
    WS_Login,
    Registration,
    fwd,
    Order_Detail,
    WS_SPONSORS,
    WS_LOAD_YOUR_ORDERS,
    Save_Payment,
    WS_BUILDING_INFO,
    WS_GET_BUILDING_INFO,
    WS_Shipping_INFO,
    WS_GET_GetOrderReview,
     WS_GET_PlaceOrderReview,
    Shipping_Handling,
    Shipping_Addr,
    WS_GET_ACCOUNT_INFO,
    WS_UPDATE_EMAIL,
    WS_UPDATE_PASSWORD,
    WS_GET_GetComapare,
    WS_GET_GetBrandInfo,
    WS_UPDATE_ADDRESS,
    Shipping_Method,
    Change_tons,
    WS_CCAvenueResponse,
    WS_Get_Shipping
    
} WSENUM;

#endif /* URLS_h */

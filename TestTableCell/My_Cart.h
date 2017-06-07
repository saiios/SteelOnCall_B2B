//
//  My_Cart.h
//  SteelonCall
//
//  Created by Manoyadav on 02/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCart_Cell.h"
#import "Product_defined_cell.h"
#import "Coupan_cell.h"
#import "STParsing.h"
#import "UIImageView+WebCache.h"
#import "Detail_Order_View.h"
#import "BillingInfoViewController.h"
#import "CRToastView.h"
#import "HomeViewController.h"

@interface My_Cart : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *Cart_Products_ary,*pieces_per_ton_ary;
    UITapGestureRecognizer *singleFingerTap;
    BOOL keyboardIsShown;
    NSUserDefaults *user_data;
    NSString *user_id,*Cart_Count;
    int tableHeight;
    NSString *newString,*discount_str,*price_str;
    NSMutableString *product_ids_str;
    NSMutableDictionary *Grand_Total_Dict;
    float Grand_total;
}

@property (strong, nonatomic) IBOutlet UITableView *cart_table;
@property (strong, nonatomic) IBOutlet UILabel *cart_count;

@property (strong, nonatomic) IBOutlet UIView *activityView;
- (IBAction)Continue_shopping:(id)sender;
- (IBAction)PlaceOrder_click:(id)sender;
@property (strong, nonatomic)  NSString *From_check;
@property (strong, nonatomic) IBOutlet UILabel *Grand_lbl;
@property (nonatomic, strong) MBProgressHUD  *HUD;

@end

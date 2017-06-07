//
//  product_defined.h
//  SteelonCall
//
//  Created by Manoyadav on 01/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "Product_defined_cell.h"
#import "More_Details.h"
#import "More_Sellers.h"
#import "STParsing.h"
#import "My_Cart.h"
#import "searchPopupVIew.h"
#import "CRToastView.h"
#import "LoginViewController.h"
#import "CompareViewController.h"
#import "MBProgressHUD.h"
#import "Shipping_Info.h"
#import "More_Sellers.h"
#import "Shipping_info_cell.h"
#import "Shipping_lastCell.h"



@interface product_defined : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,searchTableViewDelegate,MBProgressHUDDelegate,NSURLSessionDelegate,NSURLSessionDataDelegate>
{
    UITapGestureRecognizer *singleFingerTap;
    NSMutableArray *Products_dict,*Cart_Details_ary,*pieces_per_ton_ary;
    searchPopupVIew *searchView;
    NSMutableArray *searchItemsArray;
    NSString *selected_item,*popup_tag;
    NSString *table_tag,*newString,*Referesh_tag,*Refreshing_id,*jsonString;
    UILabel *noDataLabel;
    NSMutableArray *T_P_Ary;
    NSIndexPath *Refreshing_Indexpath;
    BOOL keyboardIsShown;
    NSUserDefaults *user_data;
    NSString *user_id,*discount_str,*price_str;
    UILabel *Cart_lbl;
    int More_seller_tag,Discount_index;
    NSMutableDictionary *Dict;
    NSString *S_H_Price;
    }
@property (strong, nonatomic) IBOutlet UIView *activityView;

@property (nonatomic, strong) MBProgressHUD  *HUD;
@property (strong, nonatomic) IBOutlet UIButton *company_btn;
@property (strong, nonatomic) IBOutlet UITableView *list_view;
@property (strong, nonatomic) IBOutlet UIView *company_view;
@property (strong, nonatomic) IBOutlet UIView *model_view;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *popup_up_constraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *popup_down_constraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *popup_top;
@property (strong, nonatomic) NSString *Pin_code;
@property (strong, nonatomic) NSString *Location;
@property (strong, nonatomic) NSString *selected_ids;
@property (strong, nonatomic) NSString *selected_qty;
//from more sellers
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *ton_price;
@property (strong, nonatomic) NSString *S_id;
@property (strong, nonatomic) NSString *seller_name;
@property (strong, nonatomic) NSMutableArray *products_ary;
- (IBAction)Shipping_info_click:(id)sender;
@property (strong, nonatomic) NSString *pin;
@property (strong, nonatomic) NSString *s_qty;
@property (strong, nonatomic) NSString *s_ids;
@property (strong, nonatomic) NSString *brand_str;
@property (strong, nonatomic) NSString *grade_str;
@property int tag_str;

@property (strong, nonatomic) NSMutableArray *tonne_piece_ary;
@property (strong, nonatomic) NSMutableArray *TP_ary;

@property (strong, nonatomic) IBOutlet UILabel *brand_lbl;
@property (strong, nonatomic) IBOutlet UILabel *grade_lbl;
@property (strong, nonatomic) IBOutlet UIView *Grade_view;

@property (strong, nonatomic) IBOutlet UIButton *grade_btn;
- (IBAction)Model_click:(id)sender;
- (IBAction)Company_click:(id)sender;
- (IBAction)Compare_click:(id)sender;
- (IBAction)continue_click:(id)sender;
@end

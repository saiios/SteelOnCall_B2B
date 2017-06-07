//
//  Products_List.h
//  SteelonCall
//
//  Created by Manoyadav on 01/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.

#import <UIKit/UIKit.h>
#import "Product_list_cell.h"
#import "product_defined.h"
#import "STParsing.h"
#import "Products_Model.h"
#import "UIImageView+WebCache.h"
#import "CRToastConfig.h"


@interface Products_List : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    Product_list_cell *cell;
    NSMutableArray *tick_check,*pieces_per_ton_ary,*Selected_ids_ary,*tonnes_pieces_ary,*product_names;
    NSMutableDictionary *tones_dict,*pieces_dict;
    UITapGestureRecognizer *singleFingerTap;
    NSDictionary *Product_List_Dict,*Countries_dict;
    NSMutableString *product_ids_str;
    NSString *table_tag,*newString ;
    NSArray *locations_array;
    UILabel *Cart_lbl;
    BOOL keyboardIsShown;
    NSUserDefaults *user_data;
    NSString *user_id;
    int tableHeight;
}

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *popup_top;
@property (strong, nonatomic) IBOutlet UITableView *list_view;
@property (strong, nonatomic) IBOutlet UIView *popup_view;

@property (strong, nonatomic) IBOutlet UITextField *pincode_tf;
@property (strong, nonatomic) IBOutlet UITextField *city_tf;
- (IBAction)popup_proceed_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *location_table;
- (IBAction)popup_decline_click:(id)sender;
@property (strong, nonatomic) NSString *product_id;
@property (strong, nonatomic) NSString *product_type;
@property (strong, nonatomic) NSString *From;

- (IBAction)Proceed_click:(id)sender;
@end

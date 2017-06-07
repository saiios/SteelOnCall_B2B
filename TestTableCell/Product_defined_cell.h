//
//  Product_defined_cell.h
//  SteelonCall
//
//  Created by Manoyadav on 29/11/16.
//  Copyright © 2016 Manoyadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product_defined_cell : UITableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *defined_cell_view;
@property (strong, nonatomic) IBOutlet UILabel *seller_name;
@property (strong, nonatomic) IBOutlet UITextField *tonnes_tf;
@property (strong, nonatomic) IBOutlet UITextField *pieces_tf;
@property (strong, nonatomic) IBOutlet UILabel *price_ton;
@property (strong, nonatomic) IBOutlet UILabel *total_price;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UIButton *remove;
@property (strong, nonatomic) IBOutlet UIButton *save;
@property (strong, nonatomic) IBOutlet UIButton *detail_view;
@property (strong, nonatomic) IBOutlet UIButton *more_sellers;
@property (strong, nonatomic) IBOutlet UILabel *Discount;
@property (strong, nonatomic) IBOutlet UIButton *Refresh_Btn;
@property (strong, nonatomic) IBOutlet UIView *Refresh_view;

@end

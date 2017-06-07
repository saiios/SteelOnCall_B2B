//
//  MyCart_Cell.h
//  SteelonCall
//
//  Created by Manoyadav on 02/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCart_Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *seller_name;
@property (strong, nonatomic) IBOutlet UILabel *brand;
@property (strong, nonatomic) IBOutlet UILabel *rolling;
@property (strong, nonatomic) IBOutlet UITextField *tonnnes;
@property (strong, nonatomic) IBOutlet UITextField *pieces;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *total_price;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIButton *save;
@property (strong, nonatomic) IBOutlet UIButton *remove;
@property (strong, nonatomic) IBOutlet UILabel *Discount_lbl;


@end

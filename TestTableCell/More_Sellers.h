//
//  More_Sellers.h
//  SteelonCall
//
//  Created by Manoyadav on 01/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seller_cell.h"
#import "product_defined.h"


@protocol moreSellers <NSObject>
@optional
-(void)productIds:(NSDictionary *)prod;

@end

@interface More_Sellers : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    int selected_tag;
    NSArray *Sellers_Ary;
}
@property (nonatomic,assign) id <moreSellers>delegate;
@property (strong, nonatomic) IBOutlet UITableView *list_view;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSString *grade;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *img_url;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *Location;
@property (strong, nonatomic) NSMutableArray *products_ary;
@property (strong, nonatomic) NSMutableArray *tonne_piece_ary;
@property (strong, nonatomic) NSString *Pin_code;
@property (strong, nonatomic) IBOutlet UILabel *name_lbl;
@property (strong, nonatomic) IBOutlet UILabel *brand_lbl;
@property (strong, nonatomic) IBOutlet UILabel *grade_lbl;
@property (strong, nonatomic) IBOutlet UILabel *price_lbl;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) NSString *selected_ids;
@property (strong, nonatomic) NSString *selected_qty;
@property  int tag_int;

@end

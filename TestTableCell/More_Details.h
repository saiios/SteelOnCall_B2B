//
//  More_Details.h
//  SteelonCall
//
//  Created by Manoyadav on 01/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"
#import "UIImageView+WebCache.h"

@interface More_Details : UIViewController<UIScrollViewDelegate>
{
    NSDictionary *Details_Dict;
}
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UILabel *Name;
@property (strong, nonatomic) IBOutlet UILabel *size;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *seller_name;
@property (strong, nonatomic) IBOutlet UILabel *brand_name;
@property (strong, nonatomic) IBOutlet UILabel *grade;
@property (strong, nonatomic) IBOutlet UILabel *Description;
@property (strong, nonatomic) IBOutlet UILabel *yield_strength;
@property (strong, nonatomic) IBOutlet UILabel *uts;
@property (strong, nonatomic) IBOutlet UILabel *elongation;
@property (strong, nonatomic) IBOutlet UILabel *c;
@property (strong, nonatomic) IBOutlet UILabel *s;
@property (strong, nonatomic) IBOutlet UILabel *p;
@property (strong, nonatomic) IBOutlet UILabel *s_p;
@property (strong, nonatomic) IBOutlet UILabel *specification;

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *PINCODE;
@property (strong, nonatomic) NSString *BRAND;
@property (strong, nonatomic) NSString *GRADE;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *price_str;
@property (strong, nonatomic) NSString *childId;

@end

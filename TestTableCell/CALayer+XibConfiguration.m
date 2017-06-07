//
//  CALayer+XibConfiguration.m
//  simpleBrowsing
//
//  Created by mullangi gandhi on 3/6/14.
//  Copyright (c) 2014 com.OrganisationName. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer(XibConfiguration)

-(void)setBorderColorIB:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderColorIB
{
    return [UIColor colorWithCGColor:self.borderColor];
}

-(void)setShadowColorIB:(UIColor*)color
{
    self.shadowColor = color.CGColor;
}

-(UIColor*)shadowColorIB
{
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end
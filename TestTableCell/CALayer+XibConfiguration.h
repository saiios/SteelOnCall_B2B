//
//  CALayer+XibConfiguration.h
//  simpleBrowsing
//
//  Created by mullangi gandhi on 3/6/14.
//  Copyright (c) 2014 com.OrganisationName. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer(XibConfiguration)

// This assigns a CGColor to borderColor.
@property(nonatomic, assign) UIColor* borderColorIB;
@property(nonatomic, assign) UIColor* shadowColorIB;

@end

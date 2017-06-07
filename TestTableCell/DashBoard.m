//
//  DashBoard.m
//  SteelonCall
//
//  Created by Manoyadav on 30/11/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import "DashBoard.h"
#import <UIKit/UIKit.h>
@implementation DashBoard

+(NSArray *)parseResponce:(id)responce{
    
    
    NSMutableArray *baseArray =[[NSMutableArray alloc]init];
    
    [baseArray addObject:@""];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"Construction Steel" forKey:@"CategoryName"];
    [dic setValue:[responce valueForKey:@"construction"] forKey:@"Objects"];
    
    [baseArray addObject:dic];
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setValue:@"Fabrication Steel" forKey:@"CategoryName"];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *fab = [responce valueForKey:@"fabrication"];
    float countOfObjects = 0 ;
    int itemCount =0 ;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        
        itemCount = ((int)[UIScreen mainScreen].bounds.size.width/170);
        
    }else{
        
        itemCount = 3;

    }
    for (NSDictionary *sec in fab) {
        
        NSMutableDictionary *subDic = [[NSMutableDictionary alloc]init];
        [subDic setValue:[sec valueForKey:@"name"] forKey:@"name"];
        [subDic setValue:[sec valueForKey:@"img"] forKey:@"img"];
        [subDic setValue:[sec valueForKey:@"id"] forKey:@"id"];
        if ([[sec valueForKey:@"name"] isEqualToString:@"Light Structurals"]) {
            
            [subDic setValue:[responce valueForKey:@"light_structurals"] forKey:@"secObjects"];
            float p = ceil ((float)[[responce valueForKey:@"light_structurals"] count]/itemCount);
            
            countOfObjects = countOfObjects + p ;
            
        }else{
            
            [subDic setValue:[responce valueForKey:@"heavy_structurals"] forKey:@"secObjects"];
            float p =ceil ((float)[[responce valueForKey:@"heavy_structurals"] count]/itemCount);
            countOfObjects = countOfObjects + p;
            
        }
        
        
        [arr addObject:subDic];
        
    }
    
    
    [dic1 setValue:[NSString stringWithFormat:@"%f",countOfObjects] forKey:@"totalCount"];
    [dic1 setValue:arr forKey:@"sections"];
    
    [baseArray addObject:dic1];
    
    
    return baseArray;
    
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
@end

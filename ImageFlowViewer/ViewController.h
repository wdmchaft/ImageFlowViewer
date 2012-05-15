//
//  ViewController.h
//  ImageFlowedViewer
//
//  Created by KUDO IKUO on 12/05/13.
//  Copyright (c) 2012年 n/a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

@interface ViewController : UIViewController < UIScrollViewDelegate >

@property ( nonatomic, strong ) UIScrollView* scrollView;
@property ( nonatomic, strong ) UIView* container;

@property ( nonatomic, strong ) ImageScrollView* leftView;
@property ( nonatomic, strong ) ImageScrollView* rightView;
@property ( nonatomic, strong ) ImageScrollView* centerView;

@property ( nonatomic, assign ) CGSize pageSize;

@end

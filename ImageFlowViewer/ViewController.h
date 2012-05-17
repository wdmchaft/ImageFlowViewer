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

@property ( nonatomic, strong ) ImageScrollView* imageView0;
@property ( nonatomic, strong ) ImageScrollView* imageView1;
@property ( nonatomic, strong ) ImageScrollView* imageView2;





@end

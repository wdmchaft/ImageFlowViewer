//
//  ViewController.h
//  ImageFlowedViewer
//
//  Created by KUDO IKUO on 12/05/13.
//  Copyright (c) 2012年 n/a. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController < UIScrollViewDelegate >

@property ( nonatomic, strong ) UIScrollView* scrollView;
@property ( nonatomic, strong ) UIView* container;

@property ( nonatomic, strong ) UIScrollView* subScrollView;
@property ( nonatomic, strong ) UIImageView* leftView;
@property ( nonatomic, strong ) UIImageView* rightView;
@property ( nonatomic, strong ) UIImageView* centerView;

@end

//
//  AppDelegate.h
//  ImageFlowedViewer
//
//  Created by KUDO IKUO on 12/05/13.
//  Copyright (c) 2012年 n/a. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property ( nonatomic, strong ) UINavigationController* navigationController;
@property ( nonatomic, strong ) ViewController* viewController;

@end

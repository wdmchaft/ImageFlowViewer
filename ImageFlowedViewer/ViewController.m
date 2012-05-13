//
//  ViewController.m
//  ImageFlowedViewer
//
//  Created by KUDO IKUO on 12/05/13.
//  Copyright (c) 2012年 n/a. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize scrollView, subScrollView, container, leftView, centerView, rightView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGRect frame;
    CGSize size = self.view.frame.size;
    NSLog( @"Frame size: %f, %f", size.width, size.height );
    
    frame = CGRectMake( 0, 0, size.width * 3, size.height );
    scrollView = [ [ UIScrollView alloc ] initWithFrame: frame ];
    container = [ [ UIView alloc ] initWithFrame: frame ];
    
    frame = CGRectMake( 0, 0, size.width, size.height );
    leftView =  [ [ UIImageView alloc ] initWithFrame: frame ];
    centerView = [ [ UIImageView alloc ] initWithFrame: frame ];
    
    frame.origin.x = size.width;
    subScrollView = [ [ UIScrollView alloc ] initWithFrame: frame ];
    frame.origin.x = size.width * 2.0;
    rightView =  [ [ UIImageView alloc ] initWithFrame: frame ];
    
    [ container addSubview: leftView ];
    [ subScrollView addSubview: centerView ];
    [ container addSubview: subScrollView ];
    [ container addSubview: rightView ];
    
    [ scrollView addSubview: container ];
    scrollView.contentSize = container.frame.size;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end

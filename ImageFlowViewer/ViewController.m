//
//  ViewController.m
//  ImageFlowedViewer
//
//  Created by KUDO IKUO on 12/05/13.
//  Copyright (c) 2012年 n/a. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property ( nonatomic, assign ) int pageIndex;

- ( void ) layoutViews;
- ( void ) setImage: ( UIImageView* ) view  index: ( int ) number;

@end

@implementation ViewController
@synthesize scrollView, subScrollView, container, leftView, centerView, rightView;
@synthesize pageIndex;

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
    
    float navigationbarHeight = self.navigationController.navigationBar.frame.size.height;
    float toolbarHeight = self.navigationController.toolbar.frame.size.height;
    
    NSLog( @"Frame size: %f, %f", size.width, size.height );
    
    frame = CGRectMake( 0, 0, size.width * 3, size.height - navigationbarHeight - toolbarHeight );
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
    
    self.view = scrollView;
    scrollView.backgroundColor = [ UIColor grayColor ];
    
    [ self setImage:leftView index: 0 ];
    [ self setImage:centerView index: 1 ];
    [ self setImage:rightView index: 2];
    
    pageIndex = -1;
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


// ドラッグ終了
- (void)scrollViewDidEndDragging:(UIScrollView*)scroll willDecelerate:(BOOL)decelerate
{
    if ( scroll == self.scrollView ) {
        
        // 加速無し
        if ( !decelerate ) [ self layoutViews ];
    }
}

// フリック操作によるスクロール終了
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    [ self layoutViews ];
}


- ( void ) setImage: ( UIImageView* ) view  index: ( int ) number
{
    NSString* file = [ NSString stringWithFormat:@"image%d",  number ];
    NSString* path = [ [ NSBundle mainBundle ] pathForResource: file ofType:@"jpg"];
    UIImage* image = [ [ UIImage alloc] initWithContentsOfFile: path ];
    view.image = image;
}

- ( void ) layoutViews
{
    
}

@end

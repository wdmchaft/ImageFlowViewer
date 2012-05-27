//
//  ViewController.m
//  ImageFlowedViewer
//
//  Created by KUDO IKUO on 12/05/13.
//  Copyright (c) 2012年 n/a. All rights reserved.
//

#import "ViewController.h"
#import "ImageScrollView.h"

typedef enum
{
    ViewStateLeftEdge = 0,
    ViewStateNotEdge = 1,
    ViewStateRightEdge = 2
} ViewState;

@interface ViewController ()
{
    ViewState viewState;
}

@property ( nonatomic, strong ) ImageScrollView* imageView0;
@property ( nonatomic, strong ) ImageScrollView* imageView1;
@property ( nonatomic, strong ) ImageScrollView* imageView2;
@property ( nonatomic, assign ) int currentPageNo;   // 現在表示（ View Center )コンテンツのページ番号, 0,1,2...
@property ( nonatomic, assign ) int pageMax;            // コンテンツページ最大値
@property ( nonatomic, assign ) int oldViewIndex;       // Center Viewのインデックス
@property ( nonatomic, assign ) CGSize contentsSize;    // 画像のサイズ
@property ( nonatomic, assign ) CGRect left;
@property ( nonatomic, assign ) CGRect center;
@property ( nonatomic, assign ) CGRect right;

- ( void ) moveImageFrom: ( ImageScrollView* ) sourceView to: ( ImageScrollView* ) targetView;
- ( void ) setImage: ( ImageScrollView* ) imageView  index: ( int ) index;
- ( void ) layoutViews;
- ( void ) updateView;
- ( void ) slideToRight;
- ( void ) slideToLeft;

@end

@implementation ViewController
@synthesize scrollView,  container, imageView0, imageView1, imageView2;
@synthesize currentPageNo, pageMax, oldViewIndex, contentsSize;
@synthesize left, center, right;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- ( void ) setImage: ( ImageScrollView* ) imageView  index: ( int ) index
{
    NSString* f = [ [ NSString alloc ] initWithFormat: @"image%d.jpg", index ];
    UIImage* image = [ UIImage imageNamed: f ];
    imageView.imageView.image = nil;
    [ imageView setImage: image ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    float navigationbarHeight = self.navigationController.navigationBar.frame.size.height;
    float toolbarHeight = self.navigationController.toolbar.frame.size.height;
    
    CGSize size = self.view.frame.size;
    contentsSize = CGSizeMake( size.width,size.height - navigationbarHeight - toolbarHeight );    
    NSLog( @"Frame size: %f, %f", size.width, size.height );
    
    CGRect frame = CGRectMake( 0, 0, contentsSize.width * 2, contentsSize.height  );
    scrollView = [ [ UIScrollView alloc ] initWithFrame: frame ];
    scrollView.delegate = self;
    
    left = CGRectMake( 0, 0, contentsSize.width, contentsSize.height );
    center = left;
    center.origin.x += contentsSize.width;
    right = center;
    right.origin.x += contentsSize.width;
    
    container = [ [ UIView alloc ] initWithFrame: frame ];
    imageView0 =  [ [ ImageScrollView alloc ] initWithFrame: left ];
    imageView1 = [ [ ImageScrollView alloc ] initWithFrame: center ];
    imageView2 =  [ [ ImageScrollView alloc ] initWithFrame: CGRectZero ];
    
    [ container addSubview: imageView0 ];
    [ container addSubview: imageView1 ];
    [ container addSubview: imageView2 ];
    
    [ scrollView addSubview: container ];
    scrollView.contentSize = container.frame.size;
    
    self.view = scrollView;
    scrollView.backgroundColor = [ UIColor grayColor ];
    scrollView.pagingEnabled = YES;
    
    [ self setImage: self.imageView0 index: 0 ];
    [ self.imageView0 setFrame: left ];
    [ self setImage: self.imageView1 index: 1 ];
    [ self.imageView1 setFrame: center ];
    self.imageView2.imageView.image = nil;
    [ self.imageView2 setFrame: CGRectZero ];
    
    pageMax = 7;
    currentPageNo = 0;
    oldViewIndex = 0;
    viewState = ViewStateLeftEdge;
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

-( void ) updateView
{
    
}

// ドラッグ終了
/*- (void)scrollViewDidEndDragging:(UIScrollView*)scroll willDecelerate:(BOOL)decelerate
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
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     [ self layoutViews ];
}

- ( void ) moveImageFrom: ( ImageScrollView* ) sourceView to: ( ImageScrollView* ) targetView
{
    targetView.imageView.image = sourceView.imageView.image; 
}

- ( void ) slideToRight
{
    // 現在既に右端のときは移動しない
    if( currentPageNo > pageMax ) return;
    
    DLog( @">>>" ); 
    
    currentPageNo++;
    if( currentPageNo == pageMax - 1 ) {
        // 右端に移動
        CGRect frame = CGRectMake( 0, 0, contentsSize.width * 2, contentsSize.height );
        [ self.scrollView setFrame: frame ];
        [ self.container setFrame: frame ];
        
        // 左にRotate
        [ self moveImageFrom: self.imageView2 to: self.imageView1 ];
        [ self.imageView2 setFrame: center ];
        
        [ self moveImageFrom: self.imageView1 to: self.imageView0 ];
        [ self.imageView1 setFrame: left ];
                
        self.imageView2.imageView.image = nil;
        [ self.imageView2 setFrame: CGRectZero ];
        
        [ self.scrollView setContentOffset: center.origin ];           
        
        viewState = ViewStateRightEdge;
    }
    else {
        // 右端ではない
        CGRect frame = CGRectMake( 0, 0, contentsSize.width * 3, contentsSize.height );
        [ self.scrollView setFrame: frame ];
        [ self.container setFrame: frame ];
        
        // 左にRotate
        [ self moveImageFrom: self.imageView1 to: self.imageView0 ];
        [ self.imageView0 setFrame: left ];
        
        if( self.imageView2.imageView == nil ) 
            [ self setImage: self.imageView2 index: currentPageNo + 1 ];
        [ self moveImageFrom: self.imageView2 to: self.imageView1 ];
        [ self.imageView1 setFrame: center ];
        
        [ self setImage: self.imageView0 index: currentPageNo + 2 ];
        [ self moveImageFrom: self.imageView0 to: self.imageView1 ];
        [ self.imageView1 setFrame: right ];
        
        [ self.scrollView setContentOffset: center.origin ];        
        viewState = ViewStateNotEdge;
    }
}

- ( void ) slideToLeft
{
    // 左端のときは移動しない
    if( currentPageNo == 0 ) return;
    
    DLog( @"<<<" );
    
    currentPageNo--;
    if( currentPageNo == 0 ) {
        //左端に移動
        CGRect frame = CGRectMake( 0, 0, contentsSize.width * 2, contentsSize.height );
        [ self.scrollView setFrame: frame ];
        [ self.container setFrame: frame ];
        
        
        self.imageView2.imageView.image = nil;
        [ self.imageView2 setFrame: CGRectZero ];
        
        [ self.scrollView setContentOffset: left.origin ];          
        
        viewState = ViewStateLeftEdge;
    }
    else {
        // 左端ではない
        CGRect frame = CGRectMake( 0, 0, contentsSize.width * 3, contentsSize.height );
        [ self.scrollView setFrame: frame ];
        [ self.container setFrame: frame ];
        
        // 右にRotate
        [ self moveImageFrom: self.imageView1 to: self.imageView2 ];
        
        [ self moveImageFrom: self.imageView0 to: self.imageView1 ];
        [ self.imageView1 setFrame: center ];
        
        [ self setImage: self.imageView0 index: currentPageNo - 1 ];
        [ self moveImageFrom: self.imageView0 to: self.imageView1 ];      
        
        viewState = ViewStateNotEdge;
    }
}

- ( void ) layoutViews
{
    float viewIndex =  self.scrollView.contentOffset.x / ( float ) contentsSize.width ;
    float delta = viewIndex - ( float ) oldViewIndex;
    NSLog( @"view index... old: %d  current: %f ( %f )", oldViewIndex, viewIndex, delta );

    BOOL slided = YES;
    switch( ( int ) viewState ) {
            
        case ViewStateLeftEdge:
            if ( delta >= 1.0 ) [ self slideToRight ]; else slided = NO;
                
        break;
            
        case ViewStateNotEdge:
            if ( delta >= 1.0 ) [ self slideToRight ];
            else if( delta <= -1.0 ) [ self slideToLeft ];
            else slided = NO;
        break;
            
        case ViewStateRightEdge:
            if ( delta <= 1.0 ) [ self slideToLeft ]; else slided = NO;
        break;
    }
    
    if ( slided ) {
        oldViewIndex = ( int ) viewIndex;
    }
}

@end

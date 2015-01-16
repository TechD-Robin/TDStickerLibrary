//
//  ViewController.m
//  DemoStickerLibrary
//
//  Created by Robin Hsu on 2015/1/15.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import "UIKit+TechD.h"
#import "TDStickerLibrary.h"

#import "ViewController.h"

@interface ViewController ()


- (void) _CreateButton;

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@implementation ViewController

//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- (void) _CreateButton
{
    UIButton                      * button;
    CGRect                          mainRect;
    
    mainRect                        = [[UIScreen mainScreen] bounds];
    //.NSLog( @"%s", [NSStringFromCGRect( mainRect ) UTF8String] );
    button                          = [UIButton buttonWithType: UIButtonTypeInfoDark];
    if ( nil == button )
    {
        return;
    }
    
    [button                         setBackgroundColor: [UIColor darkGrayColor]];
    [button                         setFrame: CGRectMake( 0, 0, 120, 36)];
    [button                         setCenter: CGPointMake( ( mainRect.size.width / 2.0f ), ( mainRect.size.height /2.0f ) )];
    [button                         setTitle: @" Start" forState: UIControlStateNormal];
    [[self                          view] addSubview: button];
    
    UITapGestureRecognizer        * tap;
    
    tap                             = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector( _TapButtonAction: )];
    if ( nil == tap )
    {
        return;
    }
    [button                         addGestureRecognizer: tap];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapButtonAction:(id)sender
{
    TDStickerLibraryViewController* controller;
    
    controller                      = [[TDStickerLibraryViewController alloc] init];
    if ( nil == controller )
    {
        return;
    }
    
    [self                           presentViewController: controller animated: YES completion: nil];
    
//    NSLog( @"new get status bar height : %f", [[UIScreen mainScreen] getStatusBarHeight] );
}

//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self view] setBackgroundColor: [UIColor grayColor]];

    
    [self                           _CreateButton];
    
//    [[UIApplication sharedApplication] setStatusBarHidden: NO withAnimation:UIStatusBarAnimationFade];
}

//// 這一個一設定, 變成無論如何都 hidden = YES.
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

//  ------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

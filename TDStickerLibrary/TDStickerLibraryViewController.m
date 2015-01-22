//
//  TDStickerLibraryViewController.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/15.
//  Copyright (c) 2015年 TechD. All rights reserved.
//


#import "UIKit+TechD.h"

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "TDStickerLibraryTabInfo.h"
#import "TDStickerLibraryViewController.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryViewController

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface TDStickerLibraryViewController ()
{
    
    UINavigationBar               * navigationBar;
    UIView                        * bannerView;     //  for plugin method used.
    
    UIScrollView                  * tabMenu;
    
    TDStickerLibraryCustomization * customizationParam;
    
    TDStickerLibraryTabInfo       * tabConfigure;
    
    
}
//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method declare for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare for Private
@interface TDStickerLibraryViewController(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
- ( void ) _LoadSystemConfigure;


//  ------------------------------------------------------------------------------------------------
- ( CGFloat ) _GetNextCreateSubviewTopPosition;

- ( BOOL ) _CreateNavigationBar;
- ( BOOL ) _CreateBannerView;
- ( BOOL ) _CreateTabMenu;
- ( BOOL ) _CreateTabMenuItems;


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method implementation for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for Private method
@implementation TDStickerLibraryViewController(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    navigationBar                   = nil;
    bannerView                      = nil;
    
    tabMenu                         = nil;
    
    customizationParam              = nil;
    
    tabConfigure                    = nil;
}


//  ------------------------------------------------------------------------------------------------
- ( void ) _LoadSystemConfigure
{
    tabConfigure                    = [TDStickerLibraryTabInfo loadDataFromZip: [customizationParam tabConfigureFilename] inZippedPath: [customizationParam tabConfigureFilename] inDirectory: @"" ];
    if ( nil == tabConfigure )
    {
        return;
    }
    
    
    
    
    
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( CGFloat ) _GetNextCreateSubviewTopPosition
{
    CGFloat                         subviewTop;
    
    subviewTop                      = 0.0f;
    subviewTop                      = [[UIScreen mainScreen] getStatusBarHeight];
    if ( nil != navigationBar )
    {
        subviewTop                  += [navigationBar bounds].size.height;
    }
    if ( nil != bannerView )
    {
        subviewTop                  += [bannerView bounds].size.height;
    }
    if ( nil != tabMenu )
    {
        subviewTop                  += [tabMenu bounds].size.height;
    }
    
    
    return subviewTop;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateNavigationBar
{
    //  init Top bar & back button.
    CGFloat                         screenWidth;
    CGFloat                         subviewTop;
    CGFloat                         navigationBarHight;
    
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    subviewTop                      = [self _GetNextCreateSubviewTopPosition];
    navigationBarHight              = [customizationParam navigationBarHeight];
    navigationBar                   = [[UINavigationBar alloc] initWithFrame: CGRectMake( 0, ( subviewTop + 1.0f ), screenWidth, navigationBarHight )];
    if ( nil == navigationBar )
    {
        return NO;
    }
    [navigationBar                  setBackgroundColor: [UIColor blueColor]];   // some effect at navigation bar. (錯覺嗎?, 本來應該要沒效果的)
    [[self                          view] addSubview: navigationBar];
    
    UIBarButtonItem               * backItem;
    UINavigationItem              * titleItem;
    
    backItem                        = SAFE_ARC_AUTORELEASE( [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStylePlain target: self action: @selector( _BackAction: )] );
    
    titleItem                       = SAFE_ARC_AUTORELEASE( [[UINavigationItem alloc] initWithTitle: @"Sticker Library"] );
    if ( nil == titleItem )
    {
        return YES;
    }
    
    [navigationBar                  pushNavigationItem: titleItem animated: YES];
    if ( nil != backItem )
    {
        [titleItem                  setLeftBarButtonItem: backItem];
    }

    //  width stretchy when device Orientation is changed.
    [NSLayoutConstraint             constraintForWidthStretchy: navigationBar top: ( subviewTop + 1.0f ) height: navigationBarHight in: [self view]];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _BackAction:(id) sender
{
    [self                           dismissViewControllerAnimated: YES completion: ^()
    {
    }];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateBannerView
{
    CGFloat                         screenWidth;
    CGFloat                         subviewTop;
    CGFloat                         bannerHeight;
    CGRect                          bannerRect;
    
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    subviewTop                      = [self _GetNextCreateSubviewTopPosition];
    bannerHeight                    = [customizationParam bannerHeight];
    bannerRect                      = CGRectMake( 0, ( subviewTop + 1.0f ) , screenWidth, bannerHeight );
    bannerView                      = [[UIView alloc] initWithFrame: bannerRect];
    if ( nil == bannerView )
    {
        return NO;
    }
    
    [bannerView                     setBackgroundColor: [UIColor grayColor]];
    [[self                          view] addSubview: bannerView];
    NSLog( @" sub view top %f", subviewTop );
    
    //  width stretchy when device Orientation is changed.
    [NSLayoutConstraint             constraintForWidthStretchy: bannerView top: ( subviewTop + 1.0f ) height: bannerHeight in: [self view]];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateTabMenu
{
    CGFloat                         screenWidth;
    CGFloat                         subviewTop;
    CGFloat                         tabMenuHeight;
    CGRect                          tabMenuRect;
    
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    subviewTop                      = [self _GetNextCreateSubviewTopPosition];
    tabMenuHeight                   = [customizationParam tabMenuHeight];
    tabMenuRect                     = CGRectMake( 0, ( subviewTop + 1.0f ) , screenWidth, tabMenuHeight );
    tabMenu                         = [[UIScrollView alloc] initWithFrame: tabMenuRect];
    if ( nil == tabMenu )
    {
        return NO;
    }
    
    [tabMenu                        setBackgroundColor: [UIColor blackColor]];
    [[self                          view] addSubview: tabMenu];
    
    //  width stretchy when device Orientation is changed.
    [NSLayoutConstraint             constraintForWidthStretchy: tabMenu top: ( subviewTop + 1.0f ) height: tabMenuHeight in: [super view]];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateTabMenuItems
{
    if ( ( nil == tabConfigure ) || ( [tabConfigure infoDataCount] == 0 ) )
    {
        return NO;
    }
    
    NSDictionary                  * infoData;
    NSArray                       * imagesName;
    NSData                        * imageData;
    
    infoData                        = nil;
    imagesName                      = nil;
    imageData                       = nil;
    for ( int i = 0; i < [tabConfigure infoDataCount]; ++i )
    {
        infoData                    = [tabConfigure infoDataAtIndex: i];
        if ( nil == infoData )
        {
            continue;
        }
        
        //  for test on here.
        imagesName                  = [infoData objectForKey: @"Image"];
        if ( nil == imagesName )
        {
            continue;
        }
        
        imageData                   = [tabConfigure imageDataForKey: imagesName[1]];
        if ( nil == imageData )
        {
            continue;
        }
        
        
        UIImageView               * imageView;
        
        imageView                   = [[UIImageView alloc] initWithImage: [UIImage imageWithData: imageData]];
        if ( nil != imageView )
        {
            [tabMenu                addSubview: imageView];
        }
        
//        [UIImage]
        
        
        
        
    }
    
    return YES;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  public method implementation.
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public method
@implementation TDStickerLibraryViewController

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------
- ( id ) init
{
    return [self initWithCustomization: nil];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != navigationBar )
    {
        SAFE_ARC_RELEASE( navigationBar );
        SAFE_ARC_ASSIGN_POINTER_NIL( navigationBar );
    }
    if ( nil != bannerView )
    {
        SAFE_ARC_RELEASE( bannerView );
        SAFE_ARC_ASSIGN_POINTER_NIL( bannerView );
    }
    if ( nil != tabMenu )
    {
        SAFE_ARC_RELEASE( tabMenu );
        SAFE_ARC_ASSIGN_POINTER_NIL( tabMenu );
    }
    
    if ( nil != customizationParam )
    {
        SAFE_ARC_RETAIN( customizationParam );
        SAFE_ARC_ASSIGN_POINTER_NIL( customizationParam );
    }
    
    if ( nil != tabConfigure )
    {
        SAFE_ARC_RETAIN( tabConfigure );
        SAFE_ARC_ASSIGN_POINTER_NIL( tabConfigure );
    }
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of UIViewController.
//  ------------------------------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self                           _CreateNavigationBar];
    
    if ( [customizationParam bannerHeight] != 0.0f )
    {
        [self                       _CreateBannerView];
    }
    
    [self                           _CreateTabMenu];
    [self                           _CreateTabMenuItems];
    
    [[self view] setBackgroundColor: [UIColor darkGrayColor]];
    NSLog( @"%s",  [NSStringFromCGRect( [[self view] bounds] ) UTF8String] );
    
}

//  ------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  ------------------------------------------------------------------------------------------------
//- (BOOL)prefersStatusBarHidden
//{
//    return NO;
//}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( instancetype ) initWithCustomization:(TDStickerLibraryCustomization *)customization
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    [self                           _InitAttributes];
    
    //  when customization is nil, system create a default object.
    if ( nil == customization )
    {
        customization               = [[TDStickerLibraryCustomization alloc] init];
    }
    customizationParam              = customization;
    [self                           _LoadSystemConfigure];
    
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ (instancetype) stickerLibaray
{
    return [[[self class] alloc] initWithCustomization: nil];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) stickerLibarayWithCustomization:(TDStickerLibraryCustomization *)customization
{
    return [[[self class] alloc] initWithCustomization: customization];
}

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

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

#import "TDBaseTabMenuItem.h"
#import "TDStickerLibraryTabPageView.h"

#import "TDPreUpdateJSONInfo.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryViewController

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryViewController ()
{
    //  sub view.
    /**
     *  a navigation bar object.
     */
    UINavigationBar               * navigationBar;
    
    /**
     *  a banner view; for plugin method used.
     */
    UIView                        * bannerView;
    
    /**
     *  a tab menu view.
     */
    UIScrollView                  * tabMenu;
    
    
    //  configure.
    /**
     *  a pointer for the customization object, reference some properties.
     */
    TDStickerLibraryCustomization * customizationParam;
    
    /**
     *  the pointer for tab information, i/o the configure from this object.
     */
    TDStickerLibraryTabInfo       * tabConfigure;
    
}
//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryViewController (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load configure data for the sticker library view controller.
 *  load configure data for the sticker library view controller.
 */
- ( void ) _LoadSystemConfigure;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a navigation bar into this object.
 *  create a navigation bar into this object.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateNavigationBar;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a banner into this object.
 *  create a banner into this object.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateBannerView;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a tab menu into this object.
 *  create a tab menu into this object.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateTabMenu;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create tab menu's items with relation object into this object.
 *  create tab menu's items with relation object into this object.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateTabMenuItemsWithRelations;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create first tab page when this object did load.
 *  create first tab page when this object did load.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateStartTabPage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a tab page.
 *  create a tab page.
 *
 *  @param index                    index of the configure data.
 *
 *  @return object|nil              the tab page view or nil.
 */
- ( id ) _CreateTabPage:(NSInteger)index;;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a tab menu item into tab menu object.
 *  create a tab menu item into tab menu object.
 *
 *  @param imagesName               image name's container(normal and highlighted.).
 *  @param index                    index of the configure data.
 *
 *  @return object|nil              the tab menu item or nil.
 */
- ( id ) _CreateTabMenuItem:(NSArray *)imagesName index:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for calculate object's properties.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate subview's top position when create a new subview.
 *  calculate subview's top position when create a new subview.
 *
 *  @return                         subview's top position.
 */
- ( CGFloat ) _GetNewSubviewTopPosition;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryViewController (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    //  sub view.
    navigationBar                   = nil;
    bannerView                      = nil;
    
    tabMenu                         = nil;
    
    //  configure.
    customizationParam              = nil;
    
    tabConfigure                    = nil;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _LoadSystemConfigure
{
    tabConfigure                    = [TDStickerLibraryTabInfo loadDataFromZip: [customizationParam systemConfigureTabDefaultFilename]
                                                                forDirectories: [customizationParam systemConfigureDefaultDirectory]
                                                                   inDirectory: [customizationParam systemConfigureDefaultSubpath]
                                                                  inZippedPath: [customizationParam systemConfigureTabDefaultInZippedPrefix]];
    if ( nil == tabConfigure )
    {
        return;
    }
    
    TDPreUpdateJSONInfo           * jsonInfo;
    TDGetPathDirectory              configureDirectory;
    NSString                      * subPath;
    NSString                      * updateKey;
    
    subPath                         = @"Download/Configure";
    updateKey                       = @"UpdateTab";
    configureDirectory              = TDDocumentDirectory;
    
    
    jsonInfo                        = [TDPreUpdateJSONInfo loadData: @"SystemConfigureUpdate.json" forDirectories: configureDirectory inDirectory: subPath encoding: NSUTF8StringEncoding];
    if ( nil == jsonInfo )
    {
        return;
    }
    
    
    [customizationParam             setSystemConfigureTabUpdateFilename: [jsonInfo updateConfigureFilenameForKey: updateKey]];
    
    
    [tabConfigure                   updateDataFromZip: [customizationParam systemConfigureTabUpdateFilename]
                                       forDirectories: TDDocumentDirectory inDirectory: subPath
                                         inZippedPath: [customizationParam systemConfigureTabUpdateInZippedPrefix]
                                                 with: @"StickerLibrary"];
    
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for create object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateNavigationBar
{
    //  init Top bar & back button.
    CGFloat                         screenWidth;
    CGFloat                         subviewTop;
    CGFloat                         navigationBarHight;
    
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    subviewTop                      = [self _GetNewSubviewTopPosition];
    navigationBarHight              = [customizationParam navigationBarHeight];
    navigationBar                   = [[UINavigationBar alloc] initWithFrame: CGRectMake( 0, ( subviewTop + 1.0f ), screenWidth, navigationBarHight )];
    if ( nil == navigationBar )
    {
        return NO;
    }
    [navigationBar                  setBackgroundColor: [customizationParam navigationBGC]];   // some effect at navigation bar. (錯覺嗎?, 本來應該要沒效果的)
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
    subviewTop                      = [self _GetNewSubviewTopPosition];
    bannerHeight                    = [customizationParam bannerHeight];
    bannerRect                      = CGRectMake( 0, ( subviewTop + 1.0f ) , screenWidth, bannerHeight );
    bannerView                      = [[UIView alloc] initWithFrame: bannerRect];
    if ( nil == bannerView )
    {
        return NO;
    }
    
    [bannerView                     setBackgroundColor: [customizationParam bannerBGC]];
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
    subviewTop                      = [self _GetNewSubviewTopPosition];
    tabMenuHeight                   = [customizationParam tabMenuHeight];
    tabMenuRect                     = CGRectMake( 0, ( subviewTop + 1.0f ) , screenWidth, tabMenuHeight );
    tabMenu                         = [[UIScrollView alloc] initWithFrame: tabMenuRect];
    if ( nil == tabMenu )
    {
        return NO;
    }
    
    [tabMenu                        setBackgroundColor: [customizationParam tabMenuBGC]];
    [[self                          view] addSubview: tabMenu];
    
    //  width stretchy when device Orientation is changed.
    [NSLayoutConstraint             constraintForWidthStretchy: tabMenu top: ( subviewTop + 1.0f ) height: tabMenuHeight in: [super view]];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateTabMenuItemsWithRelations
{
    if ( ( nil == tabConfigure ) || ( [tabConfigure infoDataCount] == 0 ) )
    {
        return NO;
    }
    
    NSInteger                       index;
    NSArray                       * imagesName;
    NSData                        * imageData;
    TDBaseTabMenuItem             * baseItem;
    
    NSString                      * configure;
    NSString                      * dataLink;
    NSString                      * timestamp;
    
    index                           = 0;
    imagesName                      = nil;
    imageData                       = nil;
    baseItem                        = nil;
    for ( int i = 0; i < [tabConfigure infoDataCount]; ++i )
    {
        //  when disable info.
        if ( [tabConfigure isInfoDataEnabledAtIndex: i] == NO )
        {
            continue;
        }
        
        //  when configure file exist.
        configure                   = [tabConfigure configureNameAtIndex: i];
        dataLink                    = [tabConfigure dataLinkAtIndex: i];
        timestamp                   = [tabConfigure timestampAtIndex: i];
        if ( [TDStickerLibraryUpdate checkConfigureFileExist: configure from: dataLink updateCheckBy: timestamp with: customizationParam extensionResult: NULL] == NO )
        {
            continue;
        }
        
        //  create tab menu item.
        imagesName                  = [tabConfigure imagesNameAtIndex: i];
        if ( nil == imagesName )
        {
            continue;
        }
        
        baseItem                    = [self _CreateTabMenuItem: imagesName index: index];
        if ( nil == baseItem )
        {
            continue;
        }
        [baseItem                   setTag: ( i + 1 )];     //  index key.( tag index )
        
        index++;
    }
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateStartTabPage
{
    //  if have save to configure, load it.
    NSInteger                       loadIndex;
    UIView                        * relationView;
    
    loadIndex                       = [tabConfigure indexOfInfoDataEnabledAtOrder: 1];  //  tag index to array index.
    if (  -1 == loadIndex )
    {
        return NO;
    }
        
    relationView                    = [self _CreateTabPage: loadIndex];
    if ( nil == relationView )
    {
        return NO;
    }
    
    if ( ( nil == tabMenu ) || ( [[tabMenu subviews] count] == 0 ) )
    {
        return NO;
    }
    
    for ( id idObject in [tabMenu subviews] )
    {
        if ( ( nil == idObject ) || ( [idObject isKindOfClass: [TDBaseTabMenuItem class] ] == NO ) )
        {
            continue;
        }
        
        if ( ( [idObject tag] - 1 )== loadIndex )
        {
            
            [idObject               setHighlighted: YES];
            break;
        }
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( id ) _CreateTabPage:(NSInteger)index
{
    CGFloat                         screenWidth;
    CGFloat                         subviewTop;
    CGFloat                         viewHeight;
    
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    subviewTop                      = [self _GetNewSubviewTopPosition];
    viewHeight                      = ( [[UIScreen mainScreen] bounds].size.height - subviewTop );
    

    UIView                        * view;
    CGRect                          viewRect;
    NSString                      * configure;
    NSString                      * configureKey;
    NSString                      * dataLink;
    NSString                      * timestamp;
    
    configure                       = [tabConfigure configureNameAtIndex: index];       //  array index. ( tag index - 1 ).
    configureKey                    = [tabConfigure configureKeyAtIndex: index];
    dataLink                        = [tabConfigure dataLinkAtIndex: index];
    timestamp                       = [tabConfigure timestampAtIndex: index];
    if ( ( nil == configure ) || ( nil == configureKey ) )
    {
        return nil;
    }
    
    viewRect                        = CGRectMake( 0.0f, subviewTop, screenWidth, viewHeight );
    view                            = [TDStickerLibraryTabPageView tabPageWithFrame: viewRect customization: customizationParam data: configure from: dataLink updateCheckBy: timestamp forKey: configureKey];
    if ( nil == view )
    {
        return nil;
    }
    [view                           setHidden: NO];
    [[self                          view] addSubview: view];
    
    NSLog( @"%@", configure );
    
    
    //  link relation tab item.
    for ( id idObject in [tabMenu subviews] )
    {
        if ( ( nil == idObject ) || ( [idObject isKindOfClass: [TDBaseTabMenuItem class] ] == NO ) )
        {
            continue;
        }
        
        if ( ( [idObject tag] - 1 ) == index )
        {
            [idObject               setRelationView: view];
            break;
        }
    }
    
    
    //  just to make out for test.
    switch ( index )
    {
        case 0: [view setBackgroundColor: [UIColor redColor]];      break;
        case 1: [view setBackgroundColor: [UIColor greenColor]];    break;
        case 2: [view setBackgroundColor: [UIColor blueColor]];     break;
        case 3: [view setBackgroundColor: [UIColor purpleColor]];   break;
        case 4: [view setBackgroundColor: [UIColor yellowColor]];   break;
        case 5: [view setBackgroundColor: [UIColor orangeColor]];   break;
        default:                                                    break;
    }

    return view;
}

//  ------------------------------------------------------------------------------------------------
- ( id ) _CreateTabMenuItem:(NSArray *)imagesName index:(NSInteger)index
{
    if ( ( nil == imagesName ) || ( [imagesName count] == 0 ) )
    {
        return nil;
    }
    
    NSData                        * imageData;
    NSData                        * imageHighLightData;
    
    imageData                       = nil;
    imageHighLightData              = nil;
    switch ( [imagesName count] )
    {
        case 3:                                                                         //  do nothing.
        case 2: imageHighLightData  = [tabConfigure imageDataForKey: imagesName[1]];    //  don't break on here, must set imagedata.
        case 1: imageData           = [tabConfigure imageDataForKey: imagesName[0]];    break;
        default:                                                                        break;
    }
    
    CGRect                          itemRect;
    CGSize                          itemSize;
    CGSize                          itemSizeInset;
    UIImage                       * image;
    UIImage                       * imageHighLight;
    TDBaseTabMenuItem             * baseItem;
    
    image                           = [UIImage imageWithData: imageData];
    imageHighLight                  = [UIImage imageWithData: imageHighLightData];
    
    itemSize                        = [customizationParam tabMenuItemSize];
    itemSizeInset                   = [customizationParam tabMenuItemSizeInset];
    itemRect                        = CGRectMake( (index * itemSize.width ), 0.0f, itemSize.width, itemSize.height );
    itemRect                        = CGRectInset( itemRect, itemSizeInset.width , itemSizeInset.height );
    baseItem                        = [TDBaseTabMenuItem tabMenuItemWithFrame: itemRect image: image highlightedImage: imageHighLight create: ^( NSInteger tag )
    {
        //  create relation object for baseItem by tag.
        [self                       _CreateTabPage: ( tag - 1 )];    //  index key.( tag index )
    }];
    
    
    if ( nil == baseItem )
    {
        return nil;
    }
    if ( nil != tabMenu )
    {
        [tabMenu                    addSubview: baseItem];
    }
    
    return baseItem;
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for calculate object's properties.
//  ------------------------------------------------------------------------------------------------
- ( CGFloat ) _GetNewSubviewTopPosition
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
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
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
    [self                           _CreateTabMenuItemsWithRelations];
    
    [self                           _CreateStartTabPage];
    
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
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




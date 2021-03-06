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
@interface TDStickerLibraryViewController () <TDBaseTabMenuItemDelegate>
{
    //  sub view.
    /**
     *  a navigation bar object.
     */
    UINavigationBar               * navigationBar;
    
    /**
     *  a top view; maybe like navigation bar.
     */
    UIView                        * topView;
    
    
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
    TDStickerLibraryCustomization * customization;
    
    /**
     *  the pointer for tab information, i/o the configure from this object.
     */
    TDStickerLibraryTabInfo       * tabConfigure;

    /**
     *  assign a block's pointer for be executed when get a current image by user touch action.
     */
    FinishedStickerLibraryCallbackBlock finishedCallbackBlock;
    
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
 *  @brief create a top view.
 *  create a top view; maybe like navigation bar.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateTopView;

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
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a name of current tab tag for stored container.
 *  get a name(key) of current tab tag for stored container
 *
 *  @return name|nil                a name(key) or nil.
 */
- ( NSString * ) _NameForStoredCurrentTabTag;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the current tab tag from stored container.
 *  get the current tab tag from stored container ( NSUserDefaults object ).
 *
 *  @return tag| 1                  a tab tag or 1.
 */
- ( NSInteger ) _GetCurrentTabTag;

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
#pragma mark declare for update layout.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief when device is rotated, execute this method to update new layout.
 *  when device is rotated, execute this method to update new layout.
 */
- ( void ) _DeviceOrientationIsRotation;

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
    
    topView                         = nil;
    bannerView                      = nil;
    
    tabMenu                         = nil;
    
    //  configure.
    customization                   = nil;
    
    tabConfigure                    = nil;
    
    //  callback.
    finishedCallbackBlock           = nil;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _LoadSystemConfigure
{
    tabConfigure                    = [TDStickerLibraryTabInfo loadDataFromZip: [customization systemConfigureTabDefaultFilename]
                                                                forDirectories: [customization systemConfigureDefaultDirectory]
                                                                   inDirectory: [customization systemConfigureDefaultSubpath]
                                                                  inZippedPath: [customization systemConfigureTabDefaultInZippedPrefix] with: nil];
    if ( nil == tabConfigure )
    {
        return;
    }
    
    TDPreUpdateJSONInfo           * jsonInfo;
    NSString                      * updateFile;
    
    updateFile                      = nil;
    jsonInfo                        = [TDPreUpdateJSONInfo loadData: [customization systemConfigureUpdateFilename]
                                                     forDirectories: [customization systemConfigureUpdateDirectory]
                                                        inDirectory: [customization systemConfigureUpdateSubpath]
                                                           encoding: NSUTF8StringEncoding];
    if ( nil == jsonInfo )
    {
        [tabConfigure               sortInfoData];
        return;
    }
    
    updateFile                      = [jsonInfo updateConfigureFilenameForKey: [customization systemConfigureTabUpdateDefaultKey]];
    if ( nil != updateFile )
    {
        [customization              setSystemConfigureTabUpdateFilename: updateFile];
    }
    
    [tabConfigure                   updateDataFromZip: [customization systemConfigureTabUpdateFilename]
                                       forDirectories: [customization systemConfigureUpdateDirectory]
                                          inDirectory: [customization systemConfigureUpdateSubpath]
                                         inZippedPath: [customization systemConfigureTabUpdateInZippedPrefix]
                                                 with: [customization systemConfigureTabUpdateZpwiaopsrpsded]];
    
    //  sort data after data update.
    [tabConfigure                   sortInfoData];
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
    navigationBarHight              = [customization navigationBarHeight];
    navigationBar                   = [[UINavigationBar alloc] initWithFrame: CGRectMake( 0, ( subviewTop + 1.0f ), screenWidth, navigationBarHight )];
    if ( nil == navigationBar )
    {
        return NO;
    }
    [navigationBar                  setBackgroundColor: [customization navigationBGC]];   // some effect at navigation bar. (錯覺嗎?, 本來應該要沒效果的)
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
- ( BOOL ) _CreateTopView
{
    //  init Top bar & back button.
    CGFloat                         screenWidth;
    CGFloat                         subviewTop;
    CGFloat                         topViewHight;
    CGRect                          topViewRect;
    
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    subviewTop                      = [self _GetNewSubviewTopPosition];
    topViewHight                    = [customization navigationBarHeight];
    topViewRect                     = CGRectMake( 0, ( subviewTop + 1.0f ), screenWidth,  topViewHight );
    topView                         = [[UIView alloc] initWithFrame: topViewRect];
    if ( nil == topView )
    {
        return NO;
    }
    
    [topView                        setBackgroundColor: [customization sysStyleNavigationBGC]];
    [[self                          view] addSubview: topView];
    
    //  width stretchy when device Orientation is changed.
    [NSLayoutConstraint             constraintForWidthStretchy: topView top: ( subviewTop + 1.0f ) height: topViewHight in: [self view]];
    

    
    UIButton                      * button;
    
    button                          = [UIButton buttonWithImage: [customization sysStyleBackToMenuImage]
                                                    highlighted: [customization sysStyleBackToMenuImageHighlighted]
                                                         origin: CGPointMake( [customization edgeActionObjectInsets].left, [customization edgeActionObjectInsets].top )];
    [topView                        addSubview: button];
    [button                         addTarget: self action: @selector( _BackToMenuAction: ) forControlEvents: UIControlEventTouchUpInside];
    
    UILabel                       * topTitle;
    

    topTitle                        = [[UILabel alloc] init];
    [topTitle                       setText: [customization libraryTitleString]];
    [topTitle                       setTextAlignment: NSTextAlignmentCenter];
    [topTitle                       setTextColor: [customization sysStyleTitleTextColor]];
    [topTitle                       setFrame: CGRectMake( 0.0f, 0.0f, screenWidth, topViewHight)];
    [topView                        addSubview: topTitle];
    
    [NSLayoutConstraint             constraintForWidthStretchy: topTitle top: 0.0f height: topViewHight in: topView];

    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _BackToMenuAction:(id)sender
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
    bannerHeight                    = [customization bannerHeight];
    bannerRect                      = CGRectMake( 0, ( subviewTop + 1.0f ) , screenWidth, bannerHeight );
    bannerView                      = [[UIView alloc] initWithFrame: bannerRect];
    if ( nil == bannerView )
    {
        return NO;
    }
    
    [bannerView                     setBackgroundColor: [customization bannerBGC]];
    [[self                          view] addSubview: bannerView];
//    NSLog( @" sub view top %f", subviewTop );
    
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
    tabMenuHeight                   = [customization tabMenuHeight];
    tabMenuRect                     = CGRectMake( 0, ( subviewTop + 1.0f ) , screenWidth, tabMenuHeight );
    tabMenu                         = [[UIScrollView alloc] initWithFrame: tabMenuRect];
    if ( nil == tabMenu )
    {
        return NO;
    }
    
    [tabMenu                        setBackgroundColor: [customization tabMenuBGC]];
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
        if ( [TDStickerLibraryUpdate checkConfigureFileExist: configure from: dataLink updateCheckBy: timestamp with: customization extensionResult: NULL] == NO )
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
    NSInteger                       currentTabTag;
    UIView                        * relationView;
    
    currentTabTag                   = [self _GetCurrentTabTag];
    loadIndex                       = [tabConfigure indexOfInfoDataEnabledAtOrder: currentTabTag];  //  tag index to array index.
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
    

    TDStickerLibraryTabPageView   * view;
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
    view                            = [TDStickerLibraryTabPageView tabPageWithFrame: viewRect customization: customization data:
                                       configure from: dataLink updateCheckBy: timestamp forKey: configureKey];
    if ( nil == view )
    {
        return nil;
    }
    [view                           setHidden: NO];
    [view                           setIdExtensionDelegate: [self idExtensionDelegate]];
    [[self                          view] addSubview: view];
    
    
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
    
//    //  just to make out for test.
//    switch ( index )
//    {
//        case 0: [view setBackgroundColor: [UIColor redColor]];      break;
//        case 1: [view setBackgroundColor: [UIColor greenColor]];    break;
//        case 2: [view setBackgroundColor: [UIColor blueColor]];     break;
//        case 3: [view setBackgroundColor: [UIColor purpleColor]];   break;
//        case 4: [view setBackgroundColor: [UIColor yellowColor]];   break;
//        case 5: [view setBackgroundColor: [UIColor orangeColor]];   break;
//        default:                                                    break;
//    }

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
    
    itemSize                        = [customization tabMenuItemSize];
    itemSizeInset                   = [customization tabMenuItemSizeInset];
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
    
    [baseItem                       setIdDelegate: self];
    return baseItem;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) _NameForStoredCurrentTabTag
{
    NSString                      * bundleIdentifier;
    NSString                      * aKey;
    
    aKey                            = @"CurrentTabTag";
    bundleIdentifier                = [[NSBundle mainBundle] bundleIdentifier];
    if ( nil == bundleIdentifier )
    {
        return aKey;
    }
    
    aKey                            = [bundleIdentifier stringByAppendingPathExtension: aKey];
    return aKey;
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) _GetCurrentTabTag
{
    if ( ( nil != customization ) && ( [customization isSaveTabMenuCurrentTabTag] == NO ) )
    {
        return 1;
    }
    
    NSString                      * aKey;
    NSString                      * currentTabTag;
    NSUserDefaults                * userDefaults;
    
    currentTabTag                   = nil;
    aKey                            = [self _NameForStoredCurrentTabTag];
    userDefaults                    = [NSUserDefaults standardUserDefaults];
    if ( ( nil == aKey ) || ( nil == userDefaults ) )
    {
        return 1;
    }
    
    currentTabTag                   = [userDefaults objectForKey: aKey];
    if ( nil == currentTabTag )
    {
        return 1;
    }
    
    if ( nil != tabConfigure )
    {
        //  maybe is error data, remove it.
        if ( [tabConfigure infoDataCount] < [currentTabTag integerValue] )
        {
            [userDefaults           removeObjectForKey: aKey];
            return 1;
        }
    }
    
    return [currentTabTag integerValue];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for calculate object's properties.
//  ------------------------------------------------------------------------------------------------
- ( CGFloat ) _GetNewSubviewTopPosition
{
    CGFloat                         subviewTop;
    
    subviewTop                      = 0.0f;
    subviewTop                      = [[UIScreen mainScreen] getStatusBarHeight];
    //  加保險的概念
    //  add a check condition like insurance concept.
    if ( ( 0.0f != subviewTop ) && ( [self prefersStatusBarHidden] == YES ) )
    {
        subviewTop                  = 0.0f;
    }
    if ( nil != navigationBar )
    {
        subviewTop                  += [navigationBar bounds].size.height;
    }
    if ( nil != topView )
    {
        subviewTop                  += [topView bounds].size.height;
    }
    if ( nil != bannerView )
    {
        subviewTop                  += [bannerView bounds].size.height;
    }
    if ( nil != tabMenu )
    {
        subviewTop                  += ( [tabMenu bounds].size.height + 1 );
    }
    
    return subviewTop;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for update layout.
//  ------------------------------------------------------------------------------------------------
- ( void ) _DeviceOrientationIsRotation
{
    if ( ( nil == tabMenu ) || ( [[tabMenu subviews] count] == 0 ) )
    {
        return;
    }
    
    CGFloat                         screenWidth;
    CGFloat                         subviewTop;
    CGFloat                         viewHeight;
    CGRect                          viewRect;
    
    TDStickerLibraryTabPageView   * collectionView;
    TDStickerLibraryTabPageLayout * layout;
    
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    subviewTop                      = [self _GetNewSubviewTopPosition];
    viewHeight                      = ( [[UIScreen mainScreen] bounds].size.height - subviewTop );
    viewRect                        = CGRectMake( 0.0f, subviewTop, screenWidth, viewHeight );
    for ( id idObject in [tabMenu subviews] )
    {
        if ( ( nil == idObject ) || ( [idObject isKindOfClass: [TDBaseTabMenuItem class] ] == NO ) )
        {
            continue;
        }
        
        if ( [idObject relationView] == nil )
        {
            continue;
        }
        
        collectionView              = (TDStickerLibraryTabPageView *)[idObject relationView];
        layout                      = (TDStickerLibraryTabPageLayout *)[collectionView collectionViewLayout];
        if ( nil == layout )
        {
            continue;
        }
        
        [collectionView             setFrame: viewRect];
        [collectionView             reloadSectionData];     //  must above layout's needUpdateLayoutAttributes.
        [layout                     needUpdateLayoutAttributes: YES];
        [collectionView             reloadData];
        [collectionView             whenDeviceRotateUpdatePosition: CGPointZero];
    }
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
    [self                           releaseCreatedObject];
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of UIViewController.
//  ------------------------------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self                           _CreateNavigationBar];
    [self                           _CreateTopView];
    
    if ( [customization bannerHeight] != 0.0f )
    {
        [self                       _CreateBannerView];
    }
    
    [self                           _CreateTabMenu];
    [self                           _CreateTabMenuItemsWithRelations];
    
    [self                           _CreateStartTabPage];
    
    [[self                          view] setBackgroundColor: [customization sysStyleMasterVisionBGC]];    
}

////  ------------------------------------------------------------------------------------------------
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [self                           releaseCreatedObject];          //  be executed this, will trigger system to call dealloc.
//    [super                          viewDidDisappear: animated];
//}

//  ------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  ------------------------------------------------------------------------------------------------
- (BOOL)prefersStatusBarHidden
{
    if ( nil == customization )
    {
        return NO;
    }
    return [customization isStatusBarHidden];
}

//  ------------------------------------------------------------------------------------------------
- (UIStatusBarStyle)preferredStatusBarStyle
{
    if ( nil == customization )
    {
        return UIStatusBarStyleDefault;
    }
    return [customization statusBarStyle];
}

//  --------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of protocol of UIContentContainer.
//  ------------------------------------------------------------------------------------------------
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
              withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super                          willTransitionToTraitCollection: newCollection withTransitionCoordinator: coordinator];
    
    //NSLog( @"trans : %f", [coordinator transitionDuration] );
    [coordinator                    animateAlongsideTransition: ^(id <UIViewControllerTransitionCoordinatorContext> context)
    {
        [self                       _DeviceOrientationIsRotation];
     
    }
    completion: ^(id <UIViewControllerTransitionCoordinatorContext> context)
    {
//        [self                       _DeviceOrientationIsRotation];
    }];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark release object.
//  ------------------------------------------------------------------------------------------------
//  release object that's created by self.
- ( void ) releaseCreatedObject
{
    if ( nil != navigationBar )
    {
        SAFE_ARC_RELEASE( navigationBar );
        navigationBar               = nil;
    }
    if ( nil != topView )
    {
        SAFE_ARC_RELEASE( topView );
        topView                     = nil;
    }
    if ( nil != bannerView )
    {
        SAFE_ARC_RELEASE( bannerView );
        bannerView                  = nil;
    }
    if ( nil != tabMenu )
    {
        if ( [[tabMenu subviews] count] != 0 )
        {
            NSMutableArray        * subviews;
            subviews                = [NSMutableArray arrayWithArray: [tabMenu subviews]];
            for ( id idObject in subviews )
            {
                if ( ( nil == idObject ) || ( [idObject isKindOfClass: [TDBaseTabMenuItem class]] == NO ) )
                {
                    continue;
                }
                [idObject           removeFromSuperview];
                SAFE_ARC_RELEASE( idObject );
                SAFE_ARC_ASSIGN_POINTER_NIL( idObject );
            }
            [subviews               removeAllObjects];
            SAFE_ARC_RELEASE( subviews );
            subviews                = nil;
        }
        
        SAFE_ARC_RELEASE( tabMenu );
        tabMenu                     = nil;
    }
    
    if ( nil != customization )
    {
        //SAFE_ARC_RELEASE( customization );
        customization               = nil;
    }
    
    if ( nil != tabConfigure )
    {
        SAFE_ARC_RELEASE( tabConfigure );
        tabConfigure                = nil;
    }
    
    if ( nil != finishedCallbackBlock )
    {
        finishedCallbackBlock       = nil;
    }
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithCustomization:(TDStickerLibraryCustomization *)custom
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    [self                           _InitAttributes];
    
    //  when customization is nil, system create a default object.
    if ( nil == custom )
    {
        custom                      = [[TDStickerLibraryCustomization alloc] init];
    }
    customization                   = custom;
    [self                           _LoadSystemConfigure];
    
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ (instancetype) stickerLibaray
{
    return [[[self class] alloc] initWithCustomization: nil];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) stickerLibarayWithCustomization:(TDStickerLibraryCustomization *)custom
{
    return [[[self class] alloc] initWithCustomization: custom];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for base methos of procedure
//  ------------------------------------------------------------------------------------------------
- ( void ) setFinishedStickerLibraryCallbackBlock:(FinishedStickerLibraryCallbackBlock)callbackBlock
{
    if ( nil == callbackBlock )
    {
        return;
    }
    finishedCallbackBlock           = callbackBlock;
}

//  ------------------------------------------------------------------------------------------------
- (FinishedStickerLibraryCallbackBlock)finishedStickerLibraryCallbackBlock
{
    return finishedCallbackBlock;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) actionCompletion
{
    [self                           _BackAction: nil];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol optional for TDBaseTabMenuItemDelegate.
//  ------------------------------------------------------------------------------------------------
- ( void ) menuItem:(TDBaseTabMenuItem *)menuItem didSelected:(NSInteger)tag
{
    if ( ( nil != customization ) && ( [customization isSaveTabMenuCurrentTabTag] == NO ) )
    {
        return;
    }

    //  store item's tag into user defaultes.
    NSString                      * aKey;
    NSUserDefaults                * userDefaults;
    
    aKey                            = [self _NameForStoredCurrentTabTag];
    userDefaults                    = [NSUserDefaults standardUserDefaults];
    if ( ( nil == aKey ) || ( nil == userDefaults ) )
    {
        return;
    }
    
    [userDefaults                   setObject: @(tag) forKey: aKey];
    [userDefaults                   synchronize];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




//
//  TDStickerLibraryStickerIntroDLVC.m
//  StickerLibrary
//
//  Created by Robin Hsu on 2015/4/19.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "UIKit+TechD.h"

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "TDBasePopMenu.h"
#import "TDStickerLibraryStickerIntroDLVC.h"
#import "TDStickerLibraryTabPageView.h"
#import "TDStickerLibrarySectionPreviewCell.h"
#import "TDDownloadManager.h"


//  ------------------------------------------------------------------------------------------------
#pragma mark define constant string.
//  ------------------------------------------------------------------------------------------------
static  NSInteger   const kTDStickerLibraryConfigureIndexAfterSwap      = 0;
static  NSInteger   const kTDStickerLibraryIntroImageDefaultIndex       = 0;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryStickerIntroDLVC

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryStickerIntroDLVC ()
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
     *  a back button.
     */
    UIButton                      * backButton;
    
    /**
     *  a scroll view, main view's container.
     */
    UIScrollView                  * scrollView;
    
    /**
     *  a intro view, information object's container
     */
    UIView                        * introView;
    
    /**
     *  a stamp view of intro.
     */
    UIImageView                   * introStampView;
    
    /**
     *  a download button for download action.
     */
    UIButton                      * downloadButton;
    
    /**
     *  a delete button for delete action.
     */
    UIButton                      * deleteButton;
    
    /**
     *  a view for sticker preview.
     */
    TDStickerLibraryTabPageView   * stickerPageView;
    
    
    //  configure.
    /**
     *  a pointer for the customization object, reference some properties.
     */
    TDStickerLibraryCustomization * customization;
    
    /**
     *  the pointer for page information, i/o the configure from this object.
     */
    TDStickerLibraryTabPageInfo   * pageConfigure;
    
    //  sticker's page.
    /**
     *  section index of tab page.
     */
    NSInteger                       sectionIndex;
    
    /**
     *  identifier of sticker's data.
     */
    NSString                      * stickerIdentifier;

    /**
     *  set the flag when data is downloaded or data is delete.
     */
    BOOL                            dataIsDownloaded;

    /**
     *  set the flag when action is success or failure
     */
    BOOL                            actionFinished;
    
    /**
     *  assign a block's pointer for be executed when closed this view controller.
     */
    FinishedIntroDLVCCallbackBlock  finishedCallbackBlock;
    
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
@interface TDStickerLibraryStickerIntroDLVC (Private)

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
 *  @brief load configure data for the view controller.
 *  load configure data for the view controller, include swap for sticker data.
 */
- ( void ) _SwapSystemConfigure;

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
 *  @brief create a scroll view.
 *  create a scroll view; this view is main view of others.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateScrollView;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a intro view.
 *  create a intro view.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateIntroView;

//  ------------------------------------------------------------------------------------------------
//  1st, create intro stamp view by intro image data(intro image name),
//       if the method just create a image view, and self's image is nil then 2nd.
//  2nd, check configure data mode,
//       if the mode is normal then get a stamp image by index.
//       if the mode is use preview image then clip a stamp image from preview image.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a stamp view of intro view.
 *  create a stamp view of intro view.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateIntroStampView;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a stamp's image of intro's view, configure is normal mode.
 *  create a stamp's image of intro's view, configure is normal mode.
 *
 *  @return image|nil               a stamp image or nil.
 */
- ( UIImage * ) _IntroStampImageWithNormalMode;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a stamp's imge of intro's view, configure is preview mode.
 *  create a stamp's imge of intro's view, configure is preview mode.
 *
 *  @return image|nil               a stamp image or nil.
 */
- ( UIImage * ) _IntroStampImageWithPreviewMode;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create description's contents of intro view.
 *  create description's contents of intro view.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateIntroDescriptionContent;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a download action's button object into this object.
 *  create a download action's button object into this object.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateDownloadButton;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a delete action's button object into this object.
 *  create a delete action's button object into this object.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateDeleteButton;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a page for sticker into this object.
 *  create a page for sticker into this object.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreatePageView;


//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a pop menu for extension action.
 *  create a pop menu for extension action; like send email or open hyperlink.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _createPopMenu;


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
/**
 *  @brief calculate subview's top position of scroll view when create a new subview.
 *  calculate subview's top position of scroll view when create a new subview.
 *
 *  @return                         subview's top position.
 */
- ( CGFloat ) _GetScrollViewNewSubviewTopPosition;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for check object's properties.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the configure have introducation information or not.
 *  check the configure have introducation information or not.
 *
 *  @return YES|NO                  have information or not.
 */
- ( BOOL ) _IsHaveIntroInformation;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the configure have website hyperlink information or not.
 *  check the configure have website hyperlink or not.
 *
 *  @return YES|NO                  have information or not.
 */
- ( BOOL ) _IsHaveWebSiteInformation;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the configure have email address information or not.
 *  check the configure have email address information or not.
 *
 *  @return YES|NO                  have information or not.
 */
- ( BOOL ) _IsHaveEMailInformation;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the configure have download information or not.
 *  check the configure have download information or not.
 *
 *  @return YES|NO                  must download or need not.
 */
- ( BOOL ) _IsHaveDownloadInformation;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the file is downloaded or not.
 *  check the file is downloaded or not, a data is downloaded, the value is YES, otherwise it's NO(maybe is mean data delete).
 *
 *  @param isDownloaded             pointer of the download state to get result..
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _IsDownloaded:(BOOL *)isDownloaded;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief set some states of data download.
 *  set some states of data download, include variable & UI object's properties.
 *
 *  @param checkFileExist           set these states about file is exist or not.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _SetDataDownloadState:(BOOL)checkFileExist;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryStickerIntroDLVC (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    //  sub view.
    navigationBar                   = nil;

    topView                         = nil;
    backButton                      = nil;
    
    scrollView                      = nil;
    introView                       = nil;
    introStampView                  = nil;
    
    downloadButton                  = nil;
    deleteButton                    = nil;
    
    
    stickerPageView                 = nil;
    
    //  configure.
    customization                   = nil;
    pageConfigure                   = nil;
    
    //  sticker's page.
    sectionIndex                    = -1;
    stickerIdentifier               = nil;
    
    dataIsDownloaded                = NO;
    actionFinished                  = NO;
    finishedCallbackBlock           = nil;
}

//  --------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _SwapSystemConfigure
{
    if ( ( nil == pageConfigure ) || ( -1 == sectionIndex ) )
    {
        return;
    }
    
    if ( [pageConfigure swapInfoDataWithIndex: sectionIndex] == NO )
    {
        return;
    }
}

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateNavigationBar;
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
    
    titleItem                       = SAFE_ARC_AUTORELEASE( [[UINavigationItem alloc] initWithTitle: @"Sticker Introduction"] );
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
    [self                           dismissViewControllerAnimated: YES completion: nil];
    
    if ( [pageConfigure reverseInfoData] == NO )
    {
        return;
    }
    
    if ( nil != finishedCallbackBlock )
    {
        finishedCallbackBlock( stickerIdentifier, sectionIndex, dataIsDownloaded, actionFinished );
    }
    
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
    
    [topView                        setBackgroundColor: [UIColor clearColor]];
    [[self                          view] addSubview: topView];
    
    //  width stretchy when device Orientation is changed.
    [NSLayoutConstraint             constraintForWidthStretchy: topView top: ( subviewTop + 1.0f ) height: topViewHight in: [self view]];
    
    backButton                      = [UIButton buttonWithImage: [customization sysStyleBackImage]
                                                    highlighted: [customization sysStyleBackImageHighlighted]
                                                       disabled: [customization sysStyleBackImageDisabled]
                                                       selected: nil origin: CGPointMake( 6.0f, 0.0f )];
    
    [topView                        addSubview: backButton];
    [backButton                     addTarget: self action: @selector( _BackAction: ) forControlEvents: UIControlEventTouchUpInside];
    
    
    
    UILabel                       * topTitle;
    NSString                      * title;
    
    topTitle                        = [[UILabel alloc] init];
    title                           = [pageConfigure dataTitleAtIndex: 0];
    if ( nil != title )
    {
        [topTitle                   setText: title];
    }

    [topTitle                       setTextAlignment: NSTextAlignmentCenter];
    [topTitle                       setTextColor: [customization sysStyleTitleTextColor]];
    [topTitle                       setFrame: CGRectMake( 0.0f, 0.0f, screenWidth, topViewHight)];
    [topView                        addSubview: topTitle];
    
    [NSLayoutConstraint             constraintForWidthStretchy: topTitle top: 0.0f height: topViewHight in: topView];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateScrollView
{
    CGFloat                         screenWidth;
    CGFloat                         subviewTop;
    CGFloat                         viewHeight;
    CGRect                          viewRect;
    
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    subviewTop                      = [self _GetNewSubviewTopPosition];
    viewHeight                      = ( [[UIScreen mainScreen] bounds].size.height - subviewTop );
    viewRect                        = CGRectMake( 0.0f, subviewTop, screenWidth, viewHeight );

    scrollView                      = [[UIScrollView alloc] initWithFrame: viewRect];
    if ( nil == scrollView )
    {
        return NO;
    }
    
//    [scrollView                     setBackgroundColor: [UIColor brownColor]];
    [[self                          view] addSubview: scrollView];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateIntroView
{
    if ( [self _IsHaveIntroInformation] == NO )
    {
        return NO;
    }
    
    CGFloat                         screenWidth;
//    CGFloat                         subviewTop;
    CGFloat                         subviewHeight;
    CGRect                          introRect;
    
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
//    subviewTop                      = [self _GetScrollViewNewSubviewTopPosition];

    subviewHeight                   = [customization introViewHeight];
//    subviewTop                      += 40.0f;
//    buttonHeight                    = 36.0f;
    introRect                       = CGRectMake( 0.0f, 0.0f, screenWidth, subviewHeight );
    introView                       = [[UIView alloc] initWithFrame: introRect];
    if ( nil == introView )
    {
        return NO;
    }
    
    if ( nil != scrollView )
    {
        [scrollView                 addSubview: introView];
    }
    
    
    
//    [introView                      setBackgroundColor: [UIColor brownColor]];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateIntroStampView
{
    if ( nil == introView )
    {
        return NO;
    }
    
    CGFloat                         screenWidth;
    CGFloat                         introViewHeight;
    UIEdgeInsets                    subViewInsets;
    CGRect                          stampRect;
    CGSize                          baseSize;
    UIImage                       * stampImage;
    NSInteger                       mode;
    
    
    mode                            = 0;
    stampImage                      = nil;
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    introViewHeight                 = [customization introViewHeight];
    subViewInsets                   = [customization introViewSubViewInsets];
    baseSize.width                  = ( introViewHeight - ( subViewInsets.left + subViewInsets.right ) );
    baseSize.height                 = ( introViewHeight - ( subViewInsets.top + subViewInsets.bottom ) );
    stampRect.size                  = baseSize;
    stampRect.origin                = CGPointMake( ( ( screenWidth / 2.0f ) - baseSize.width ), subViewInsets.top );
    
    introStampView                  = [[UIImageView alloc] initWithFrame: stampRect];
    if ( nil == introStampView )
    {
        return NO;
    }
    
    [introView                      addSubview: introStampView];

//    [introStampView                 setBackgroundColor: [UIColor orangeColor]];

    if ( [pageConfigure dataMode: &mode atIndex: kTDStickerLibraryConfigureIndexAfterSwap] == NO )
    {
        return YES;
    }
    
    if ( 0 == mode )
    {
        stampImage                  = [self _IntroStampImageWithNormalMode];
        if ( nil == stampImage )
        {
            return NO;
        }
        [introStampView             setImage: stampImage];
        return YES;
    }
    
    stampImage                      = [self _IntroStampImageWithPreviewMode];
    if ( nil == stampImage )
    {
        return NO;
    }
    [introStampView                 setImage: stampImage];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _IntroStampImageWithNormalMode
{
    NSData                        * stampData;
    UIImage                       * stampImage;
    
    //  first, use configure data to get image.
    stampImage                      = nil;
    stampData                       = [pageConfigure introImageDataAtIndex: kTDStickerLibraryConfigureIndexAfterSwap];
    if ( nil != stampData )
    {
        stampImage                  = [UIImage imageWithData: stampData];
    }
    if ( nil != stampImage )
    {
        return stampImage;
    }
    
    //  second, use preview page data to get image.
    stampData                       = [pageConfigure imageDataAtIndex: kTDStickerLibraryConfigureIndexAfterSwap
                                                              inArray: kTDStickerLibraryIntroImageDefaultIndex];

    if ( nil == stampData )
    {
        return nil;
    }
    
    stampImage                      = [UIImage imageWithData: stampData];
    return stampImage;
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _IntroStampImageWithPreviewMode
{
    if ( ( nil == stickerPageView ) || ( [stickerPageView isKindOfClass: [TDStickerLibraryTabPageView class]] == NO ) )
    {
        return nil;
    }
    
    //  get configure data from cell object.
    NSIndexPath                   * indexPath;
    UICollectionViewCell          * cell;
    
    cell                            = nil;
    indexPath                       = [NSIndexPath indexPathForItem: 0 inSection: kTDStickerLibraryConfigureIndexAfterSwap];
    if ( nil == indexPath )
    {
        return nil;
    }
    
    cell                            = [stickerPageView collectionView: stickerPageView cellForItemAtIndexPath: indexPath];
    if ( ( nil == cell ) || ( [cell isKindOfClass: [TDStickerLibrarySectionPreviewCell class]] == NO ) )
    {
        return nil;
    }
    
    //  get preview image from configure data.
    NSString                      * previewImageName;
    NSData                        * previewImageData;
    UIImage                       * previewImage;
    
    NSString                      * stampImageName;
    NSData                        * stampData;
    UIImage                       * stampImage;
    CGRect                          clippingRect;
    
    stampData                       = nil;
    stampImage                      = nil;
    stampImageName                  = nil;
    previewImageData                = nil;
    previewImage                    = nil;
    previewImageName                = nil;
    clippingRect                    = CGRectZero;
    
    //  first, use configure data to get clipping data.
    stampImageName                  = [pageConfigure introImageNameAtIndex: kTDStickerLibraryConfigureIndexAfterSwap];
    if ( nil != stampImageName )
    {
        clippingRect                = [(TDStickerLibrarySectionPreviewCell *)cell originalSpriteFrameForKey: stampImageName];
    }
    
    //  second, use preview page default to get clipping data. ( index = 0. )
    if ( CGRectEqualToRect( clippingRect, CGRectZero ) == true )
    {
        clippingRect                = [(TDStickerLibrarySectionPreviewCell *)cell originalSpriteFrameAtIndex: kTDStickerLibraryIntroImageDefaultIndex];
    }
    if ( CGRectEqualToRect( clippingRect, CGRectZero ) == true )
    {
        return nil;
    }
    
    previewImageName                = [(TDStickerLibrarySectionPreviewCell *)cell previewTextureName];
    if ( nil == previewImageName )
    {
        return nil;
    }
    
    previewImageData                = [pageConfigure imageDataAtIndex: kTDStickerLibraryConfigureIndexAfterSwap forKey: previewImageName];
    if ( nil == previewImageData )
    {
        return nil;
    }
    
    previewImage                    = [UIImage imageWithData: previewImageData];
    if ( nil == previewImage )
    {
        return nil;
    }
    
    return [previewImage clipping: clippingRect];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateIntroDescriptionContent
{
    CGFloat                         screenWidth;
    CGFloat                         introViewHeight;
    CGFloat                         fontSize;
    UIEdgeInsets                    subViewInsets;
    NSString                      * illustrator;
    NSString                      * description;
    UILabel                       * illustratorLabel;
    UILabel                       * descriptionLabel;
    CGRect                          illustratorRect;
    CGRect                          descriptionRect;
    
    description                     = nil;
    illustratorLabel                = nil;
    descriptionLabel                = nil;
    illustratorRect                 = CGRectZero;
    descriptionRect                 = CGRectZero;
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    introViewHeight                 = [customization introViewHeight];
    fontSize                        = [customization introViewIllustratorFontSize];
    subViewInsets                   = [customization introViewSubViewInsets];
    illustrator                     = [pageConfigure illustratorAtIndex: kTDStickerLibraryConfigureIndexAfterSwap];
    if ( nil != illustrator )
    {
        NSMutableAttributedString * attributedString;
        NSRange                     attributedRange;
        
        
        attributedRange             = NSMakeRange( 0,  [illustrator length] );
        attributedString            = [[NSMutableAttributedString alloc] initWithString: illustrator];
        if ( nil != attributedString )
        {
            [attributedString       addAttribute: NSUnderlineStyleAttributeName value: @(NSUnderlineStyleSingle) range: attributedRange];
            [attributedString       addAttribute: NSFontAttributeName value: [UIFont boldSystemFontOfSize: fontSize] range: attributedRange];
    
            
            illustratorRect.size    = CGSizeMake( ( ( screenWidth / 2.0f ) - ( ( subViewInsets.left / 2.0f ) + subViewInsets.right ) ), ( fontSize + ( 2 * 2.0f ) ) );
            illustratorRect.origin  = CGPointMake( ( ( screenWidth / 2.0f ) + ( subViewInsets.left / 2.0f ) ) , subViewInsets.top );
            illustratorLabel        = [[UILabel alloc] initWithFrame: illustratorRect];
            if ( nil != illustratorLabel )
            {
                [illustratorLabel   setAttributedText: attributedString];
                [introView          addSubview: illustratorLabel];
                
//                [illustratorLabel   setBackgroundColor: [UIColor cyanColor]];
            }
        }
    }
    
    description                     = [pageConfigure descriptionAtIndex: kTDStickerLibraryConfigureIndexAfterSwap];
    if ( nil != description )
    {
        NSMutableAttributedString * attributedString;
        NSRange                     attributedRange;
        CGFloat                     lineSpacing;
        
        fontSize                    = [customization introViewDescriptionFontSize];
        lineSpacing                 = [customization introViewContentsLineSpacing];
        attributedRange             = NSMakeRange( 0,  [description length] );
        attributedString            = [[NSMutableAttributedString alloc] initWithString: description];
        if ( nil != attributedString )
        {
            [attributedString       addAttribute: NSFontAttributeName value: [UIFont boldSystemFontOfSize: fontSize] range: attributedRange];
            
            descriptionRect.size.width      = ( screenWidth / 2.0f ) - ( ( subViewInsets.left / 2.0f ) + subViewInsets.right );
            descriptionRect.size.height     = introViewHeight - ( illustratorRect.size.height + subViewInsets.top + subViewInsets.bottom + lineSpacing );
            descriptionRect.origin.x        = ( screenWidth / 2.0f ) + ( subViewInsets.left / 2.0f );
            descriptionRect.origin.y        = subViewInsets.top + illustratorRect.size.height + lineSpacing;
            
            descriptionLabel        = [[UILabel alloc] initWithFrame: descriptionRect];
            if ( nil != descriptionLabel )
            {
                [descriptionLabel   setNumberOfLines: 0];
                [descriptionLabel   setAttributedText: attributedString];
                [descriptionLabel   sizeToFit];     //  don't code above UIFont setting.
                
                [introView          addSubview: descriptionLabel];
                
//                [descriptionLabel   setBackgroundColor: [UIColor purpleColor]];
            }
        }
    }
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateDownloadButton
{
    BOOL                            isDownloaded;
    CGFloat                         screenWidth;
    CGFloat                         subviewTop;
    CGFloat                         buttonHeight;
    CGRect                          buttonRect;
    
    isDownloaded                    = NO;
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    subviewTop                      = [self _GetScrollViewNewSubviewTopPosition];
    
//    subviewTop                      += 40.0f;
    buttonHeight                    = 36.0f;
    
    buttonRect                      = CGRectMake( 0, ( subviewTop + 1.0f ) , screenWidth, buttonHeight );    
    downloadButton                  = [UIButton buttonWithImage: [customization sysStyleDownloadImage]
                                                    highlighted: [customization sysStyleDownloadImageHighlighted] 
                                                       disabled: [customization sysStyleDownloadImageDisabled]
                                                       selected: nil
                                                         origin: buttonRect.origin];
    if ( nil == downloadButton )
    {
        return NO;
    }
    
    [downloadButton                 setFrame: buttonRect];
    [downloadButton                 setBackgroundColor: [UIColor darkGrayColor]];
    [downloadButton                 setTitle: @" Download "      forState: UIControlStateNormal];
    [downloadButton                 setTitle: @" Is Downloaded " forState: UIControlStateDisabled];
    //[[self                          view] addSubview: downloadButton];
    if ( nil != scrollView )
    {
        [scrollView                 addSubview: downloadButton];
    }
    
    
    [downloadButton                 addTarget: self action: @selector( _TapDownloadButtonAction: ) forControlEvents: UIControlEventTouchUpInside];
    
    ////  width stretchy when device Orientation is changed.
    //[NSLayoutConstraint             constraintForWidthStretchy: downloadButton top: ( subviewTop + 1.0f ) height: buttonHeight in: [self view]];

    if ( [self _IsDownloaded: &isDownloaded] == YES )
    {
        [downloadButton             setEnabled: !isDownloaded];
    }
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapDownloadButtonAction:(id)sender
{
    NSParameterAssert( [pageConfigure infoDataCount] == 1 );
    
    NSInteger                       index;
    NSString                      * ID;
    NSString                      * configure;
    NSString                      * dataLink;
    NSString                      * timestamp;
    
    index                           = kTDStickerLibraryConfigureIndexAfterSwap;
    ID                              = [pageConfigure dataIDAtIndex: index];
    configure                       = [pageConfigure configureNameAtIndex: index];
    dataLink                        = [pageConfigure dataLinkAtIndex: index];
    timestamp                       = [pageConfigure timestampAtIndex: index];
    
    //  need not to download
    if ( ( nil == configure ) || ( nil == dataLink ) || ( nil == timestamp ) )
    {
        return;
    }
    
    //  check ID equal.
    if ( [stickerIdentifier isEqualToString: ID] == NO )
    {
        return;
    }
    
    //  call download method.
    [TDDownloadManager              download: configure from: dataLink
                                        into: [customization stickerDownloadSubpath] of: [customization stickerDownloadDirectory]
                               updateCheckBy: timestamp completed: ^(NSError * error, NSString * fullPath, BOOL finished)
    {
        [backButton                     setEnabled: YES];
        
         NSLog( @"result %d, %@", finished, error );
         NSLog( @"file full path : %@", fullPath );
        if ( NO == finished )
        {
            return;
        }
        [self                       _SetDataDownloadState: YES];
    }];
    
    //  when downloading, button must disable; ** when system is downloading, touch the back button, system will crash. **
    [backButton                     setEnabled: NO];
    
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateDeleteButton
{
    
    BOOL                            isDownloaded;
    CGFloat                         screenWidth;
    CGFloat                         subviewTop;
    CGFloat                         buttonHeight;
    CGRect                          buttonRect;
    UITapGestureRecognizer        * tap;
    
    tap                             = nil;
    isDownloaded                    = NO;
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    subviewTop                      = [self _GetScrollViewNewSubviewTopPosition];
    
//    subviewTop                      += 40.0f;
    buttonHeight                    = 36.0f;
    
    buttonRect                      = CGRectMake( 0, ( subviewTop + 1.0f ) , screenWidth, buttonHeight );
    if ( nil != downloadButton )
    {
        buttonRect                  = [downloadButton frame];
    }
    deleteButton                    = [UIButton buttonWithImage: [customization sysStyleDeleteImage]
                                                    highlighted: [customization sysStyleDeleteImageHighlighted]
                                                       disabled: [customization sysStyleDeleteImageDisabled]
                                                       selected: nil
                                                         origin: buttonRect.origin];
    if ( nil == deleteButton )
    {
        return NO;
    }
    
    [deleteButton                   setFrame: buttonRect];
    [deleteButton                   setBackgroundColor: [UIColor darkGrayColor]];
    [deleteButton                   setTitle: @" Delete "      forState: UIControlStateNormal];
    //[[self                          view] addSubview: deleteButton];
    if ( nil != scrollView )
    {
        [scrollView                 addSubview: deleteButton];
    }
    
    ////  width stretchy when device Orientation is changed.
    //[NSLayoutConstraint             constraintForWidthStretchy: deleteButton top: ( subviewTop + 1.0f ) height: buttonHeight in: [self view]];
    
    
    if ( [self _IsDownloaded: &isDownloaded] == YES )
    {
        [deleteButton               setHidden: !isDownloaded];
    }
    
    tap                             = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector( _TapDeleteButtonAction: )];
    if ( nil == tap )
    {
        return YES;
    }
    [deleteButton                   addGestureRecognizer: tap];
    
    SAFE_ARC_RELEASE( tap );
    tap                             = nil;
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapDeleteButtonAction:(id)sender
{
    NSParameterAssert( [pageConfigure infoDataCount] == 1 );
    
    NSInteger                       index;
    NSString                      * ID;
    NSString                      * configure;
    NSString                      * timestamp;
    NSString                      * filePath;
    
    index                           = kTDStickerLibraryConfigureIndexAfterSwap;
    ID                              = [pageConfigure dataIDAtIndex: index];
    configure                       = [pageConfigure configureNameAtIndex: index];
    timestamp                       = [pageConfigure timestampAtIndex: index];
    
    //  need not to download
    if ( ( nil == configure ) || ( nil == timestamp ) )
    {
        return;
    }
    
    //  check ID equal.
    if ( [stickerIdentifier isEqualToString: ID] == NO )
    {
        return;
    }
    
    filePath                        = TDGetPathForDirectoriesWithTimestamp( [customization stickerDownloadDirectory],
                                                                           configure, timestamp, nil,
                                                                           [customization stickerDownloadSubpath], YES );
    if ( nil == filePath )
    {
        return;
    }
    
    
    //  remove file.
    NSFileManager                 * manager;
    NSError                       * error;
    BOOL                            isDir;
    
    error                           = nil;
    isDir                           = NO;
    
    //  when file exist, delete it.
    manager                         = [NSFileManager defaultManager];
    if ( [manager fileExistsAtPath: filePath isDirectory: &isDir] == NO )
    {
        return;
    }
    if ( YES == isDir )
    {
        return;
    }
    
    if ( [manager removeItemAtPath: filePath error: &error] == NO )
    {
        NSLog( @"remove file error : %@ ", error );
        return;
    }
    
    //  delete file finish.
    [self                       _SetDataDownloadState: NO];
    return;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreatePageView
{
    CGFloat                         screenWidth;
    CGFloat                         subviewTop;
    CGFloat                         viewHeight;
    
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    subviewTop                      = [self _GetScrollViewNewSubviewTopPosition];
    
//    subviewTop                      +=80;
    
    viewHeight                      = ( [[UIScreen mainScreen] bounds].size.height - subviewTop );
    
    UIView                        * view;
    CGRect                          viewRect;
    
    viewRect                        = CGRectMake( 0.0f, subviewTop, screenWidth, viewHeight );
    view                            = [TDStickerLibraryTabPageView introductionPageWithFrame: viewRect customization: customization
                                                                                   configure: pageConfigure forSection: sectionIndex];
    if ( nil == view )
    {
        return NO;
    }

    [view                           setHidden: NO];
    //[[self                          view] addSubview: view];
    if ( nil != scrollView )
    {
        [scrollView                 addSubview: view];
    }
    stickerPageView                 = (TDStickerLibraryTabPageView *)view;
    
    
    
//    [view setBackgroundColor: [UIColor orangeColor]];
    
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _createPopMenu
{
    //  cannot find configure, skip create the pop menu.
    if ( ( [self _IsHaveWebSiteInformation] == NO ) && ( [self _IsHaveEMailInformation] == NO ) )
    {
        return NO;
    }
    
    CGFloat                         statusBarHeight;
    UIImage                       * popOutMenuImage;
    UIImage                       * popOutMenuImageHighlighted;
    UIImage                       * unPopOutMenuImage;
    UIImage                       * unPopOutMenuImageHighlighted;
    TDBasePopMenu                 * popMenu;
    
    statusBarHeight                 = [[UIScreen mainScreen] getStatusBarHeight];
    popOutMenuImage                 = [customization popMenuPopOutImage];
    popOutMenuImageHighlighted      = [customization popMenuPopOutImageHightlighted];
    popMenu                         = [TDBasePopMenu popMenu: TDBasePopMenuPositionRightTop
                                                      popOut: popOutMenuImage highlighted: popOutMenuImageHighlighted
                                                      origin: CGPointMake( -6.0f, statusBarHeight )];
    if ( nil == popMenu )
    {
        return NO;
    }
    
    unPopOutMenuImage               = [customization popMenuUnPopOutImage];
    unPopOutMenuImageHighlighted    = [customization popMenuUnPopOutImageHightlighted];
    [popMenu                        setUnPopOut: unPopOutMenuImage highlighted: unPopOutMenuImageHighlighted];
    //[popMenu                        setInteritemSpacing: [customization popMenuInteritemSpacing]];
    [[self                          view] addSubview: popMenu];
    
    //  add pop menu actions item.
    if ( [self _IsHaveWebSiteInformation] == YES )
    {
        
        [popMenu                    AddAction: [customization popItemActionWebsiteImage]
                                  highlighted: [customization popItemActionWebsiteImageHightlighted]
                                       target: self action: @selector( _GotoWebsiteAction: ) forControlEvents: UIControlEventTouchUpInside];
    }
    if ( [self _IsHaveEMailInformation] == YES )
    {
        [popMenu                    AddAction: [customization popItemActionEMailImage]
                                  highlighted: [customization popItemActionEMailImageHightlighted]
                                       target: self action: @selector( _WriteEMailAction: ) forControlEvents: UIControlEventTouchUpInside];
    }
    
    [popMenu                        setInteritemSpacing: [customization popMenuInteritemSpacing]];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _GotoWebsiteAction: (id) sender
{
    if ( [self _IsHaveWebSiteInformation] == NO )
    {
        return;
    }
    
    NSInteger                       index;
    NSString                      * website;
    NSURL                         * websiteURL;
    
    index                           = kTDStickerLibraryConfigureIndexAfterSwap;
    website                         = [pageConfigure illustratorWebsiteAtIndex: index];
    website                         = [@"http://" stringByAppendingString: website];
    websiteURL                      = [NSURL URLWithString: website];
    if ( nil == websiteURL )
    {
        return;
    }
    
    [[UIApplication                 sharedApplication] openURL: websiteURL];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _WriteEMailAction: (id) sender
{
    if ( [self _IsHaveEMailInformation] == NO )
    {
        return;
    }
    
    NSInteger                       index;
    NSString                      * email;
    NSURL                         * emailURL;
    
    index                           = kTDStickerLibraryConfigureIndexAfterSwap;
    email                           = [pageConfigure illustratorEMailAtIndex: index];
    email                           = [@"mailto:" stringByAppendingString: email];
    emailURL                        = [NSURL URLWithString: email];
    if ( nil == emailURL )
    {
        return;
    }
    
    [[UIApplication                 sharedApplication] openURL: emailURL];
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
    
    if ( nil != topView )
    {
        subviewTop                  += [topView bounds].size.height;
    }
    
//    if ( nil != downloadButton )
//    {
//        subviewTop                  += [downloadButton bounds].size.height;
//    }
    
    if ( nil != stickerPageView )
    {
        subviewTop                  += [stickerPageView bounds].size.height;
    }
    
    return subviewTop;
}

//  ------------------------------------------------------------------------------------------------
- ( CGFloat ) _GetScrollViewNewSubviewTopPosition
{
    CGFloat                         subviewTop;
    
    subviewTop                      = 0.0f;
    if ( nil != introView )
    {
        subviewTop                  += [introView bounds].size.height;
    }
    
    if ( nil != downloadButton )
    {
        if ( 0.0f == subviewTop )
        {
            subviewTop              = [downloadButton frame].origin.y;
        }
        subviewTop                  += [downloadButton bounds].size.height;
    }
    
    return subviewTop;
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for check object's properties.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _IsHaveIntroInformation
{
    NSParameterAssert( [pageConfigure infoDataCount] == 1 );

    NSInteger                       index;
//    NSInteger                       introImageIndex;
    NSString                      * illustrator;
    NSString                      * email;
    NSString                      * website;
//    BOOL                            result;
    
//    introImageIndex                 = 0;
    index                           = kTDStickerLibraryConfigureIndexAfterSwap;
    illustrator                     = [pageConfigure illustratorAtIndex: index];
    email                           = [pageConfigure illustratorEMailAtIndex: index];
    website                         = [pageConfigure illustratorWebsiteAtIndex: index];
//    result                          = [pageConfigure introImageIndex: &introImageIndex atIndex: index];
    
    if ( ( nil == illustrator ) || ([illustrator length] == 0 ) )
    {
        return NO;
    }
    
    //  illustrator && website.
    if ( ( nil != website ) && ( [website length] > 0 ) )
    {
        return YES;
    }
    
    //  illustrator && email.
    if ( ( nil != email ) && ( [email length] > 0 ) )
    {
        return YES;
    }
    return NO;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _IsHaveWebSiteInformation
{
    NSParameterAssert( [pageConfigure infoDataCount] == 1 );
    
    NSInteger                       index;
    NSString                      * website;
    
    index                           = kTDStickerLibraryConfigureIndexAfterSwap;
    website                         = [pageConfigure illustratorWebsiteAtIndex: index];
    if ( ( nil == website ) || ( [website length] == 0 ) )
    {
        return NO;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _IsHaveEMailInformation
{
    NSParameterAssert( [pageConfigure infoDataCount] == 1 );
    
    NSInteger                       index;
    NSString                      * email;
    
    index                           = kTDStickerLibraryConfigureIndexAfterSwap;
    email                           = [pageConfigure illustratorEMailAtIndex: index];
    if ( ( nil == email ) || ( [email length] == 0 ) )
    {
        return NO;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _IsHaveDownloadInformation
{
    NSParameterAssert( [pageConfigure infoDataCount] == 1 );

    NSInteger                       index;
    NSString                      * configure;
    NSString                      * dataLink;
    NSString                      * timestamp;
    
    index                           = kTDStickerLibraryConfigureIndexAfterSwap;
    configure                       = [pageConfigure configureNameAtIndex: index];
    dataLink                        = [pageConfigure dataLinkAtIndex: index];
    timestamp                       = [pageConfigure timestampAtIndex: index];

    //  have data or not.
    if ( ( nil == configure ) || ( nil == dataLink ) || ( nil == timestamp ) )
    {
        return NO;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _IsDownloaded:(BOOL *)isDownloaded
{
    NSParameterAssert( [pageConfigure infoDataCount] == 1 );

    NSInteger                       index;
    NSString                      * configure;
    NSString                      * timestamp;
    NSString                      * filePath;
    
    index                           = kTDStickerLibraryConfigureIndexAfterSwap;
    configure                       = [pageConfigure configureNameAtIndex: index];
    timestamp                       = [pageConfigure timestampAtIndex: index];
    
    //  need not to download
    if ( ( nil == configure ) || ( nil == timestamp ) )
    {
        return NO;
    }
    
    filePath                        = TDGetPathForDirectoriesWithTimestamp( [customization stickerDownloadDirectory],
                                                                           configure,
                                                                           timestamp,
                                                                           nil,
                                                                           [customization stickerDownloadSubpath], YES );
    if ( NULL != isDownloaded )
    {
        *isDownloaded               = ( ( nil == filePath ) ? NO : YES );
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _SetDataDownloadState:(BOOL)checkFileExist
{
    BOOL                            fileExist;
    
    fileExist                       = NO;
    if ( [self _IsDownloaded: &fileExist] == NO )
    {
        return NO;
    }
    
    //  for check download action.
    if ( YES == checkFileExist )
    {
        if ( NO == fileExist )
        {
            return YES;
        }
        //  finish ... then ...
        dataIsDownloaded            = YES;
        actionFinished              = YES;
        
        [downloadButton             setEnabled: NO];
        [deleteButton               setHidden: NO];
        return YES;
    }

    //  for check delete action.
    if ( YES == fileExist )
    {
        return YES;
    }
    
    //  finish ... then ...
    dataIsDownloaded                = NO;
    actionFinished                  = YES;
    
    [downloadButton                 setEnabled: YES];
    [deleteButton                   setHidden: YES];
    return YES;
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
@implementation TDStickerLibraryStickerIntroDLVC

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
////  ------------------------------------------------------------------------------------------------
//- ( id ) init
//{
//}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
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
    if ( nil != backButton )
    {
        SAFE_ARC_RELEASE( backButton );
        backButton                  = nil;
    }
    
    if ( nil != scrollView )
    {
        SAFE_ARC_RELEASE( scrollView )
        scrollView                  = nil;
    }
    if ( nil != introView )
    {
        SAFE_ARC_RELEASE( introView );
        introView                   = nil;
    }
    if ( nil != introStampView )
    {
        SAFE_ARC_RELEASE( introStampView );
        introStampView              = nil;
    }
    
    if ( nil != downloadButton )
    {
        downloadButton              = nil;
    }
    if ( nil != deleteButton )
    {
        deleteButton                = nil;
    }
    
    if ( nil != stickerPageView )
    {
        SAFE_ARC_RELEASE( stickerPageView );
        stickerPageView             = nil;
    }
    
    //  just only assign these pointer to nil, because this object has not creator.
    //  release by creator.
    if ( nil != customization )
    {
        customization               = nil;
    }
    
    if ( nil != pageConfigure )
    {
        pageConfigure               = nil;
    }
    
    if ( nil != finishedCallbackBlock )
    {
        finishedCallbackBlock       = nil;
    }
    
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
    
    [self                           _CreateScrollView];
    [self                           _CreateIntroView];
    
    if ( [self _IsHaveDownloadInformation] == YES )
    {
        [self                       _CreateDownloadButton];
        [self                       _CreateDeleteButton];
    }
    
    [self                           _CreatePageView];

    [self                           _CreateIntroStampView];
    [self                           _CreateIntroDescriptionContent];
    
    [self                           _createPopMenu];
    
    [[self                          view] setBackgroundColor: [UIColor darkGrayColor]];
    
}

//  ------------------------------------------------------------------------------------------------
- ( void ) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    if ( ( nil == scrollView ) || ( nil == stickerPageView ) )
    {
        return;
    }
    

    TDStickerLibraryTabPageLayout * layout;
    CGRect                          currectRect;
    CGSize                          correctContentSize;
    
    currectRect                     = [stickerPageView frame];
    layout                          = (TDStickerLibraryTabPageLayout *)[stickerPageView collectionViewLayout];
    if ( nil == layout )
    {
        return;
    }
    correctContentSize              = [layout collectionViewContentSize];
    currectRect.size                = correctContentSize;
    
    if ( [stickerPageView frame].size.height >= currectRect.size.height )
    {
        return;
    }
    
    [stickerPageView                setFrame: currectRect];

    correctContentSize.height       += currectRect.origin.y;
    [scrollView                     setContentSize: correctContentSize];

}

//  ------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithCustomization:(TDStickerLibraryCustomization *)custom configure:(TDStickerLibraryTabPageInfo *)pageInfo
                              forSection:(NSInteger)index identifier:(NSString *)stickerID
{
    NSParameterAssert( nil != custom );
    NSParameterAssert( nil != pageInfo );

    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    [self                           _InitAttributes];
    
    //  assign variables.
    customization                   = custom;
    pageConfigure                   = pageInfo;
    
    sectionIndex                    = index;
    stickerIdentifier               = stickerID;
    [self                           _SwapSystemConfigure];
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) introductionDL:(TDStickerLibraryCustomization *)custom configure:(TDStickerLibraryTabPageInfo *)pageInfo
                       forSection:(NSInteger)index identifier:(NSString *)stickerID
{
    return [[[self class] alloc] initWithCustomization: custom configure: pageInfo forSection: index identifier: stickerID];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for base methos of procedure
//  ------------------------------------------------------------------------------------------------
- ( void ) setFinishedIntroDLVCCallbackBlock:(FinishedIntroDLVCCallbackBlock)callbackBlock
{
    if ( nil == callbackBlock )
    {
        return;
    }
    finishedCallbackBlock           = callbackBlock;
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




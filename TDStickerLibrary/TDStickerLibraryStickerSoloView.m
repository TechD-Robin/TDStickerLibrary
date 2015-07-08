//
//  TDStickerLibraryStickerSoloView.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/11.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "TDMath.h"
#import "UIKit+TechD.h"
#import "TDStickerLibraryStickerSoloView.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibrarySectionHeader

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryStickerSoloView ()
{
    /**
     *  the pointer for the customization object, reference some properties.
     */
    TDStickerLibraryCustomization * customization;
    
    
    //  sticker image view.
    /**
     *  the sticker original frame.
     */
    CGSize                          stickerOriginalSize;
    
    /**
     *  the sticker now frame on screen.
     */
    CGRect                          stickerOnScreenFrame;
    
    /**
     *  the sticker image view, create with sticker image.
     */
    UIImageView                   * stickerImageView;
    
    /**
     *  a blur image view.
     */
    UIImageView                   * blurImageView;
    
    
    /**
     *  assign the block method point than call the block method when the view show action is finish.(change to hidden)
     */
    FinishedCallbackBlock           finishCallbackBlock;
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
@interface TDStickerLibraryStickerSoloView (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create tap gesture recognizer.
 *  create tap gesture recognizer for self (header object).
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateTapAction;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a sticker image view with sticker image.
 *  create a sticker image view with sticker image.
 *
 *  @param stickerImage             the sticker image.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateStickerImageView:(UIImage *)stickerImage;


//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a blur image by core graphic method.
 *  create a blur image by core graphic method.
 *
 *  @return object|nil              a blur image object or nil.
 */
- ( UIImage * ) _CreateBlurImage;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a blur image.
 *  create a blur image.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateBlurImageView;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for show or hide the object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief show the sticker solo view on window.
 *  show the Sticker solo view on window(device screen).
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _BringTheViewToFront;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief hide the sticker solo view.
 *  hide the sticker solo view; transation to position on screen for collection view's section.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _SendTheViewToBack;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibraryStickerSoloView (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    customization                   = nil;
    
    //  sticker image view.
    stickerOriginalSize             = CGSizeZero;
    stickerOnScreenFrame            = CGRectZero;
    stickerImageView                = nil;
    blurImageView                   = nil;
    
    finishCallbackBlock             = nil;
    
    //  background. ( clear view )
    [self                           setBackgroundColor: [UIColor clearColor]];
    [self                           setUserInteractionEnabled: YES];
    [self                           setHidden: YES];
    [self                           _CreateTapAction];

}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for create object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateTapAction
{
    return [UIGestureRecognizer tapGestureRecognizer: self withTarget: self action: @selector( _TapAction: )];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapAction:(UITapGestureRecognizer *) sender
{
    [self                           _SendTheViewToBack];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateStickerImageView:(UIImage *)stickerImage
{
    if ( nil == stickerImage )
    {
        return NO;
    }
    
    stickerImageView                = [[UIImageView alloc] initWithImage: stickerImage];
    if ( nil == stickerImage )
    {
        return NO;
    }

    [stickerImageView               setFrame: stickerOnScreenFrame];
    [self                           addSubview: stickerImageView];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _CreateBlurImage
{
    if ( CGRectEqualToRect( stickerOnScreenFrame, CGRectZero ) == true  )
    {
        return nil;
    }
    
    CGRect                          mainRect;
    UIImage                       * image;
    CGContextRef                    context;
    
    image                           = nil;
    mainRect                        = [[UIScreen mainScreen] bounds];
    
    UIGraphicsBeginImageContext( mainRect.size );
    context                         = UIGraphicsGetCurrentContext();
    
    
    //  # must declare the porperty  change 'assign' to 'copy'; otherwise project will crash when call following code.
    //  ※ 這個地方很奇怪, 就算用了之前解決 tabMenuBGC 的 static method 方式, 一樣無法解決,
    //    一定要在 property 的地方, 把 assign 換成 copy 才能完全排除掉可能透過各種方式產生 UIColor 物件, 造成後面這行 CGColor 程式會 crash 調的問題.
    //CGContextSetFillColorWithColor( context, [[[customization soloViewBlurLayerColor] copy] CGColor] );
    CGContextSetFillColorWithColor( context, [[customization soloViewBlurLayerColor] CGColor] );
    CGContextFillRect( context, mainRect );
    CGContextStrokePath( context );
    
    image                           = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateBlurImageView
{
    CGRect                          layerFrame;

    layerFrame                      = CGRectInset( stickerOnScreenFrame, [customization soloViewBlurLayerInsetSize].width, [customization soloViewBlurLayerInsetSize].height );

    UIImage                       * blurImage;
    
    blurImage                       = [self _CreateBlurImage];
    if ( nil == blurImage )
    {
        return NO;
    }

    blurImageView                   = [[UIImageView alloc] initWithImage: blurImage];
    if ( nil == blurImageView )
    {
        return NO;
    }
    
    [blurImageView                  setAlpha: 0.0f];
    [blurImageView                  setFrame: layerFrame];
    [self                           addSubview: blurImageView];
    [self                           sendSubviewToBack: blurImageView];    
    return YES;
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for show or hide the object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _BringTheViewToFront
{
    CGSize                          mainSize;
    CGFloat                         stickerRatio;
    CGRect                          stickerMaxFrame;
    
    mainSize                        = [[UIScreen mainScreen] bounds].size;
    stickerRatio                    = ( stickerOriginalSize.height / stickerOriginalSize.width );
    stickerMaxFrame.size            = calculateProportionalMaxSizeWithLimit( stickerRatio, stickerOriginalSize, mainSize );
    stickerMaxFrame.origin          = CGPointMake( ( ( mainSize.width - stickerMaxFrame.size.width ) / 2.0f ) , ( ( mainSize.height - stickerMaxFrame.size.height ) / 2.0f ) );
    
    
    //  run animation.
    __weak id                       blockSticker;
    __weak id                       blockBlur;
    
    if ( nil != blurImageView )
    {
        [blurImageView              setAlpha: 0.0f];
    }
    
    blockSticker                    = stickerImageView;
    blockBlur                       = blurImageView;

    [self                           setHidden: NO];
    [UIView animateWithDuration: [customization soloViewShowAnimateDuration] animations: ^
    {
        CGRect                      newFrame;
        
        newFrame                    = CGRectInset( stickerMaxFrame, [customization soloViewInsetSize].width, [customization soloViewInsetSize].height );
        [blockSticker               setFrame: newFrame];
        
        if ( nil != blockBlur )
        {
            newFrame                = CGRectInset( newFrame, [customization soloViewBlurLayerInsetSizeOnTop].width, [customization soloViewBlurLayerInsetSizeOnTop].height );
            [blockBlur              setFrame: newFrame];
            [blockBlur              setAlpha: [customization soloViewBlurLayerAlphaOnTop]];
        }
    }
    completion: ^ ( BOOL finished )
    {
        
    }];
    
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _SendTheViewToBack
{
    __weak id                       blockSelf;
    __weak id                       blockSticker;
    __weak id                       blockBlur;
    
    blockSelf                       = self;
    blockSticker                    = stickerImageView;
    blockBlur                       = blurImageView;
    [UIView animateWithDuration: [customization soloViewHideAnimateDuration] animations: ^
    {
        [blockSticker               setFrame: stickerOnScreenFrame];
        if ( nil != blockBlur )
        {
            [blockBlur              setFrame: stickerOnScreenFrame];
            [blockBlur              setAlpha: 0.0f];
        }
    }
    completion: ^ ( BOOL finished )
    {
        [blockSelf                  setHidden: YES];
        [blockSelf                  removeFromSuperview];
        if ( nil != blockBlur )
        {
            [blockBlur              setHidden: YES];
            [blockBlur              removeFromSuperview];
        }
        
        if ( nil != finishCallbackBlock )
        {
            finishCallbackBlock( finished );
        }
        
    }];
    
    SAFE_ARC_RELEASE( stickerImageView );
    SAFE_ARC_RELEASE( blurImageView );
    
    SAFE_ARC_ASSIGN_POINTER_NIL( stickerImageView );
    SAFE_ARC_ASSIGN_POINTER_NIL( blurImageView );
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
@implementation TDStickerLibraryStickerSoloView

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != customization )
    {
        //  release by creator.
        customization               = nil;
    }
    
    if ( nil != stickerImageView )
    {
        SAFE_ARC_RELEASE( stickerImageView );
        stickerImageView            = nil;
    }
    
    if ( nil != blurImageView )
    {
        SAFE_ARC_RELEASE( blurImageView );
        blurImageView               = nil;
    }
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithStickerSoloView:(UIImage *)stickerImage original:(CGSize)stickerSize onScreen:(CGRect)nowFrame
                                      with:(UIWindow *)window customization:(TDStickerLibraryCustomization *)custom
{
    self                            = [super initWithFrame: [[UIScreen mainScreen] bounds]];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    
    //  sticker image view.
    stickerOriginalSize             = stickerSize;
    stickerOnScreenFrame            = nowFrame;
    customization                   = custom;
    [self                           _CreateStickerImageView: stickerImage];
    
    if ( [customization isStickerSoloViewUseBlurLayer] == YES )
    {
        [self                       _CreateBlurImageView];
    }
    
    
    if ( nil != window )
    {
        [window                     addSubview: self];
    }
    return self;
    
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) stickerSoloView:(UIImage *)stickerImage original:(CGSize)stickerSize onScreen:(CGRect)nowFrame
                              with:(UIWindow *)window customization:(TDStickerLibraryCustomization *)custom
{
    return [[[self class] alloc] initWithStickerSoloView: stickerImage original: stickerSize onScreen: nowFrame with: window customization: custom];
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for show/hide the object.
//  ------------------------------------------------------------------------------------------------
- ( void ) showSoloView:(void (^)(void))showView completion:(FinishedCallbackBlock)completion
{
    [self                           _BringTheViewToFront];
    
    //  execute showView block pointer.
    if ( nil != showView )
    {
        showView();
    }
    
    //  set callback block pointer.
    if ( nil != completion )
    {
        finishCallbackBlock         = completion;
    }
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------










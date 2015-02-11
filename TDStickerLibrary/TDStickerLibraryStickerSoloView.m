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
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface TDStickerLibraryStickerSoloView ()
{
    TDStickerLibraryCustomization * customizationParam;
    
    //  sticker image view.
    CGSize                          stickerOriginalSize;
    CGRect                          stickerOnScreenFrame;
    UIImageView                   * stickerImageView;
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
//  method declare for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare for Private
@interface TDStickerLibraryStickerSoloView(Private)

//  ------------------------------------------------------------------------------------------------
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
- ( BOOL ) _CreateStickerImageView:(UIImage *)stickerImage;

- ( UIImage * ) _CreateBlurImage;

- ( BOOL ) _CreateBlurImageView;
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _BringTheViewToFront;
- ( BOOL ) _SendTheViewToBack;

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method implementation for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for Private method
@implementation TDStickerLibraryStickerSoloView(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    customizationParam              = nil;
    
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
    //CGContextSetFillColorWithColor( context, [[[customizationParam soloViewBlurLayerColor] copy] CGColor] );
    CGContextSetFillColorWithColor( context, [[customizationParam soloViewBlurLayerColor] CGColor] );
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

    layerFrame                      = CGRectInset( stickerOnScreenFrame, [customizationParam soloViewBlurLayerInsetSize].width, [customizationParam soloViewBlurLayerInsetSize].height );

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
    __weak id                       blockSelf;
    __weak id                       blockSticker;
    __weak id                       blockBlur;
    
    if ( nil != blurImageView )
    {
        [blurImageView              setAlpha: 0.0f];
    }
    
    blockSelf                       = self;
    blockSticker                    = stickerImageView;
    blockBlur                       = blurImageView;

    [self                           setHidden: NO];
    [UIView animateWithDuration: [customizationParam soloViewShowAnimateDuration] animations: ^
    {
        CGRect                      newFrame;
        
        newFrame                    = CGRectInset( stickerMaxFrame, [customizationParam soloViewInsetSize].width, [customizationParam soloViewInsetSize].height );
        [blockSticker               setFrame: newFrame];
        
        if ( nil != blockBlur )
        {
            newFrame                = CGRectInset( newFrame, [customizationParam soloViewBlurLayerInsetSizeOnTop].width, [customizationParam soloViewBlurLayerInsetSizeOnTop].height );
            [blockBlur              setFrame: newFrame];
            [blockBlur              setAlpha: [customizationParam soloViewBlurLayerAlphaOnTop]];
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
    [UIView animateWithDuration: [customizationParam soloViewHideAnimateDuration] animations: ^
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
//  public method implementation.
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public method
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
    if ( nil != customizationParam )
    {
        //  release by creator.
        SAFE_ARC_ASSIGN_POINTER_NIL( customizationParam );
    }
    
    if ( nil != stickerImageView )
    {
        SAFE_ARC_RELEASE( stickerImageView );
        SAFE_ARC_ASSIGN_POINTER_NIL( stickerImageView );
    }
    
    if ( nil != blurImageView )
    {
        SAFE_ARC_RELEASE( blurImageView );
        SAFE_ARC_ASSIGN_POINTER_NIL( blurImageView );
    }
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithStickerSoloView:(UIImage *)stickerImage original:(CGSize)stickerSize onScreen:(CGRect)nowFrame
                                      with:(UIWindow *)window customization:(TDStickerLibraryCustomization *)customization
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
    customizationParam              = customization;
    [self                           _CreateStickerImageView: stickerImage];
    
    if ( [customizationParam isStickerSoloViewUseBlurLayer] == YES )
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
                              with:(UIWindow *)window customization:(TDStickerLibraryCustomization *)customization
{
    return [[[self class] alloc] initWithStickerSoloView: stickerImage original: stickerSize onScreen: nowFrame with: window customization: customization];
}


//  ------------------------------------------------------------------------------------------------
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










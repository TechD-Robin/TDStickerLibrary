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

    
    //  for progress function.
    /**
     *  set the flag when progress's state is running or state is stop.
     */
    BOOL                            isProgressing;
    
    /**
     *  a container of progress message.
     */
    NSArray                       * progressingMessages;
    
    /**
     *  a progress message.
     */
    UILabel                       * progressMessage;
    
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
/**
 *  @brief initial the progress message string.
 *  initial the progress message string.
 */
- ( void ) _InitProgressingMessages;

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
 *  @param layerColor               a blur layer's color.
 *
 *  @return object|nil              a blur image object or nil.
 */
- ( UIImage * ) _CreateBlurImage:(UIColor *)layerColor;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a blur image.
 *  create a blur image.
 *
 *  @param layerColor               a blur layer's color.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateBlurImageView:(UIColor *)layerColor;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a progress message object.
 *  create a progress message object (is UILabel).
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateProgressMessage;

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
/**
 *  @brief update the view's & subview's frame.
 *  update the view's & subview's frame.
 */
- ( void ) _UpdateTheViewFrame;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief show the sticker progress view on window.
 *  show the sticker progress view on window.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _SimulateProgressBringTheViewToFront;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief hide the sticker progress view.
 *  hide the sticker progress view; transation to position on screen for DLVC's intro view's stamp.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _SimulateProgressSendTheViewToBack;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief update the sticker progress view's & subview's frame.
 *  update the sticker progress view's & subview's frame.
 */
- ( void ) _UpdateSimulateProgressFrame;

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
    
    isProgressing                   = NO;
    progressingMessages             = nil;
    
    //  background. ( clear view )
    [self                           setBackgroundColor: [UIColor clearColor]];
    [self                           setUserInteractionEnabled: YES];
    [self                           setHidden: YES];
//    [self                           _CreateTapAction];

}

//  ------------------------------------------------------------------------------------------------
- ( void ) _InitProgressingMessages
{
    if ( nil == customization )
    {
        return;
    }
    
    //  init string.
    
    NSString                      * message;
    NSString                      * message1;
    NSString                      * message2;
    NSString                      * message3;
    
    message                         = [customization downloadingString];
    message                         = ( ( nil == message ) ? @" Downloading " : message );
    message1                        = [message stringByAppendingString: @". " ];
    message2                        = [message stringByAppendingString: @".. " ];
    message3                        = [message stringByAppendingString: @"... " ];
    
    progressingMessages             = [NSArray arrayWithObjects: message1, message2, message3, nil];
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
- ( UIImage * ) _CreateBlurImage:(UIColor *)layerColor
{
    if ( CGRectEqualToRect( stickerOnScreenFrame, CGRectZero ) == true  )
    {
        return nil;
    }
    
    if ( nil == layerColor )
    {
        layerColor                  = [UIColor clearColor];
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
    CGContextSetFillColorWithColor( context, [layerColor CGColor] );
    CGContextFillRect( context, mainRect );
    CGContextStrokePath( context );
    
    image                           = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateBlurImageView:(UIColor *)layerColor;
{
    CGRect                          layerFrame;

    layerFrame                      = CGRectInset( stickerOnScreenFrame, [customization soloViewBlurLayerInsetSize].width, [customization soloViewBlurLayerInsetSize].height );

    UIImage                       * blurImage;
    
    blurImage                       = [self _CreateBlurImage: layerColor];
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
- ( BOOL ) _CreateProgressMessage
{
    if ( ( nil == blurImageView ) || ( nil == progressingMessages ) || ( [progressingMessages count] == 0 )  )
    {
        return NO;
    }
    
    
    NSString                      * message;
    CGRect                          viewRect;
    
    viewRect                        = CGRectZero;
    progressMessage                 = [[UILabel alloc] init];
    message                         = [progressingMessages objectAtIndex: 0];
    if ( ( nil == progressMessage ) || ( nil == message ) )
    {
        return NO;
    }
    
    [progressMessage                setTextColor: [customization introProgressMessageTextColor]];
//    [progressMessage                setBackgroundColor: [UIColor orangeColor]];
    
    [progressMessage                setText: message];
    [progressMessage                sizeToFit];
    
    
    viewRect                        = [blurImageView bounds];
    viewRect.origin.x               = ( ( viewRect.size.width - [progressMessage bounds].size.width ) / 2.0f );
    viewRect.origin.y               = ( viewRect.size.height - [progressMessage bounds].size.height - ( [customization introProgressMessageBottomEdgeOnTop] / 2.0f ) );
    viewRect.size                   = [progressMessage bounds].size;
    
    [progressMessage                setFrame: viewRect];
    [progressMessage                setAlpha: 0.0f];
    [blurImageView                  addSubview: progressMessage];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for show or hide the object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _BringTheViewToFront
{
    
    //  run animation.
    if ( nil != blurImageView )
    {
        [blurImageView              setAlpha: 0.0f];
    }
    
    [self                           setHidden: NO];
    [UIView animateWithDuration: [customization soloViewShowAnimateDuration] animations: ^
    {
        [self                       _UpdateTheViewFrame];
        if ( nil != blurImageView )
        {
            [blurImageView          setAlpha: [customization soloViewBlurLayerAlphaOnTop]];
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
    [UIView animateWithDuration: [customization soloViewHideAnimateDuration] animations: ^
    {
        if ( nil != stickerImageView )
        {
            [stickerImageView       setFrame: stickerOnScreenFrame];
        }
        
        if ( nil != blurImageView )
        {
            [blurImageView          setFrame: stickerOnScreenFrame];
            [blurImageView          setAlpha: 0.0f];
        }
    }
    completion: ^ ( BOOL finished )
    {
        [self                       setHidden: YES];
        [self                       removeFromSuperview];
        if ( nil != blurImageView )
        {
            [blurImageView          setHidden: YES];
            [blurImageView          removeFromSuperview];
            
            SAFE_ARC_RELEASE( blurImageView );
            blurImageView           = nil;
        }
        
        if ( nil != finishCallbackBlock )
        {
            finishCallbackBlock( finished );
        }
        
        if ( nil != stickerImageView )
        {
            SAFE_ARC_RELEASE( stickerImageView );
            stickerImageView        = nil;
        }
    }];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _UpdateTheViewFrame
{
    CGSize                          mainSize;
    CGFloat                         stickerRatio;
    CGRect                          stickerMaxFrame;
    CGRect                          newFrame;
    
    mainSize                        = [[UIScreen mainScreen] bounds].size;
    stickerRatio                    = ( stickerOriginalSize.height / stickerOriginalSize.width );
    stickerMaxFrame.size            = calculateProportionalMaxSizeWithLimit( stickerRatio, stickerOriginalSize, mainSize );
    stickerMaxFrame.origin.x        = ( ( mainSize.width - stickerMaxFrame.size.width ) / 2.0f );
    stickerMaxFrame.origin.y        = ( ( mainSize.height - stickerMaxFrame.size.height ) / 2.0f );
    
    if ( nil != stickerImageView )
    {
        newFrame                    = CGRectInset( stickerMaxFrame, [customization soloViewInsetSize].width, [customization soloViewInsetSize].height );
        [stickerImageView           setFrame: newFrame];
    }
    
    if ( nil != blurImageView )
    {
        newFrame                    = CGRectInset( newFrame, [customization soloViewBlurLayerInsetSizeOnTop].width, [customization soloViewBlurLayerInsetSizeOnTop].height );
        [blurImageView              setFrame: newFrame];
    }
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _SimulateProgressBringTheViewToFront
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
    
    blockSelf                       = self;
    if ( nil != blurImageView )
    {
        [blurImageView              setAlpha: 0.0f];
    }
    
    [self                           setHidden: NO];
    [UIView animateWithDuration: [customization introProgressShowAnimateDuration] animations: ^
    {
        [blockSelf                  _UpdateSimulateProgressFrame];
        if ( nil != blurImageView )
        {
            [blurImageView          setAlpha: [customization introProgressBlurLayerAlphaOnTop]];
        }

        if ( nil != progressMessage )
        {
            [progressMessage        setAlpha: 1.0f];
        }
    }
    completion: ^ ( BOOL finished )
    {
        //  use tag to count.
        [blockSelf                  setTag: 1];
        [blockSelf                  performSelector: @selector( _AnimateProgressMessage ) withObject: nil afterDelay: 0.5f];
    }];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _AnimateProgressMessage
{
    if ( ( nil == progressMessage ) || ( nil == progressingMessages ) || ( [progressingMessages count] == 0 ) )
    {
        return;
    }
    
    //  when state not progressing.
    if ( NO == isProgressing )
    {
        return;
    }
    
    NSString                      * message;
    
    message                         = [progressingMessages objectAtIndex: ( [self tag] % [progressingMessages count] )];
    if ( nil != message )
    {
        [progressMessage            setText: message];
        [progressMessage            sizeToFit];
    }
    
    [self                           setTag: ( [self tag] + 1 )];
    [self                           performSelector: @selector( _AnimateProgressMessage ) withObject: nil afterDelay: 0.5f];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _SimulateProgressSendTheViewToBack
{
    __weak id                       blockSelf;
    
    blockSelf                       = self;
    [UIView animateWithDuration: [customization introProgressDismissAnimateDuration] animations: ^
    {
        if ( nil != stickerImageView )
        {
            [stickerImageView       setFrame: stickerOnScreenFrame];
        }
        
        if ( nil != blurImageView )
        {
            [blurImageView          setFrame: stickerOnScreenFrame];
            [blurImageView          setAlpha: 0.0f];
        }

        if ( nil != progressMessage )
        {
            CGRect                  viewRect;

            viewRect                = stickerOnScreenFrame;
            viewRect.origin.x       = 0.0f;
            viewRect.origin.y       = ( viewRect.size.height - [progressMessage bounds].size.height );
            viewRect.size           = [progressMessage bounds].size;

            [progressMessage        setFrame: viewRect];
            [progressMessage        setAlpha: 0.0f];
        }
    }
    completion: ^ ( BOOL finished )
    {
        [blockSelf                  setHidden: YES];
        [blockSelf                  removeFromSuperview];
        if ( nil != blurImageView )
        {
            [blurImageView          setHidden: YES];
            [blurImageView          removeFromSuperview];
            
            SAFE_ARC_RELEASE( blurImageView );
            blurImageView           = nil;
        }
        if ( nil != progressMessage )
        {
            [progressMessage        setHidden: YES];
            [progressMessage        removeFromSuperview];
            
            SAFE_ARC_RELEASE( progressMessage );
            progressMessage        = nil;
        }

        if ( nil != finishCallbackBlock )
        {
            finishCallbackBlock( finished );
        }
        
        if ( nil != stickerImageView )
        {
            SAFE_ARC_RELEASE( stickerImageView );
            stickerImageView        = nil;
        }
    }];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _UpdateSimulateProgressFrame
{
    CGSize                          mainSize;
    CGFloat                         stickerRatio;
    CGRect                          stickerMaxFrame;
    CGRect                          newFrame;
    CGFloat                         newPosition;
    
    newPosition                     = 0.0f;
    mainSize                        = [[UIScreen mainScreen] bounds].size;
    stickerRatio                    = ( stickerOriginalSize.height / stickerOriginalSize.width );
    stickerMaxFrame.size            = calculateProportionalMaxSizeWithLimit( stickerRatio, stickerOriginalSize, mainSize );
    stickerMaxFrame.origin.x        = ( ( mainSize.width - stickerMaxFrame.size.width ) / 2.0f );
    stickerMaxFrame.origin.y        = ( ( mainSize.height - stickerMaxFrame.size.height ) / 2.0f );
    
    
    newFrame                        = CGRectInset( stickerMaxFrame, [customization introProgressImageInsetSize].width, [customization introProgressImageInsetSize].height );
    if ( nil != progressMessage )
    {
        newFrame.origin.y       -= ( ( [progressMessage bounds].size.height * 2.0f ) / 3.0f );
    }
    
    if ( nil != stickerImageView )
    {
        [stickerImageView           setFrame: newFrame];
    }
    
    
    newFrame                = [[UIScreen mainScreen] bounds];
    newPosition             = fabsf( ( ( newFrame.size.width - newFrame.size.height ) / 2.0f ) );
    if ( newFrame.size.width < newFrame.size.height )
    {
        newFrame.origin.x   = 0.0f;
        newFrame.origin.y   = newPosition;
        newFrame.size.height= newFrame.size.width;
    }
    else
    {
        newFrame.origin.x   = newPosition;
        newFrame.origin.y   = 0.0f;
        newFrame.size.width = newFrame.size.height;
    }
    
    newFrame                        = CGRectInset( newFrame, [customization introProgressBlurLayerInsetSizeOnTop].width, [customization introProgressBlurLayerInsetSizeOnTop].height );
    if ( nil != blurImageView )
    {
        [blurImageView              setFrame: newFrame];
    }
    if ( nil != progressMessage )
    {
        newFrame.origin.x       = ( ( newFrame.size.width - [progressMessage bounds].size.width ) / 2.0f );
        newFrame.origin.y       = ( newFrame.size.height - [progressMessage bounds].size.height - [customization introProgressMessageBottomEdgeOnTop] );
        newFrame.size           = [progressMessage bounds].size;
        
        [progressMessage        setFrame: newFrame];
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
    
    if ( nil != finishCallbackBlock )
    {
        finishCallbackBlock         = nil;
    }
    
    if ( nil != progressingMessages )
    {
        progressingMessages         = nil;
    }
    
    if ( nil != progressMessage )
    {
        SAFE_ARC_RELEASE( progressMessage );
        progressMessage             = nil;
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
    [self                           _CreateTapAction];
    
    //  sticker image view.
    stickerOriginalSize             = stickerSize;
    stickerOnScreenFrame            = nowFrame;
    customization                   = custom;
    [self                           _CreateStickerImageView: stickerImage];
    
    if ( [customization isStickerSoloViewUseBlurLayer] == YES )
    {
        [self                       _CreateBlurImageView: [customization soloViewBlurLayerColor]];
    }
    
    
    if ( nil != window )
    {
        [window                     addSubview: self];
    }
    return self;
    
}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithProgressView:(UIImage *)stickerImage onScreen:(CGRect)nowFrame
                                   with:(UIWindow *)window customization:(TDStickerLibraryCustomization *)custom
{
    if ( nil == stickerImage )
    {
        return nil;
    }
    
    self                            = [super initWithFrame: [[UIScreen mainScreen] bounds]];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];

    //  sticker image view.
    stickerOriginalSize             = [stickerImage size];
    stickerOnScreenFrame            = nowFrame;
    
    customization                   = custom;
    [self                           _InitProgressingMessages];
    [self                           _CreateStickerImageView: stickerImage];
    [self                           _CreateBlurImageView: [customization introProgressBlurLayerColor]];
    [self                           _CreateProgressMessage];
    
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
+ ( instancetype ) stickerProgressView:(UIImage *)stickerImage onScreen:(CGRect)nowFrame
                                  with:(UIWindow *)window customization:(TDStickerLibraryCustomization *)custom
{
    return [[[self class] alloc] initWithProgressView: stickerImage onScreen: nowFrame with: window customization: custom];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) whenDeviceRotateUpdatePosition:(CGRect)nowFrame
{
    if ( CGRectEqualToRect( nowFrame, CGRectZero ) == false )
    {
        stickerOnScreenFrame        = nowFrame;
    }
    
    CGSize                          mainSize;
    CGRect                          newFrame;
    
    newFrame                        = CGRectZero;
    mainSize                        = [[UIScreen mainScreen] bounds].size;
    newFrame.size                   = mainSize;
    [self                           setFrame: newFrame];
    
    //  because this check flag just use in progress method.
    if ( NO == isProgressing )
    {
        [self                       _UpdateTheViewFrame];
        return;
    }
    [self                           _UpdateSimulateProgressFrame];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for show/hide the solo object.
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
#pragma mark method for show/dismiss the progress object.
//  ------------------------------------------------------------------------------------------------
- ( void ) showProgress
{
    isProgressing                   = YES;
    [self                           _SimulateProgressBringTheViewToFront];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) dismissProgress
{
    isProgressing                   = NO;
    [self                           _SimulateProgressSendTheViewToBack];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------










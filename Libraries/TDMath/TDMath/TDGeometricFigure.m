//
//  TDGeometricFigure.m
//  TDMath
//
//  Created by Robin Hsu on 2014/12/11.
//  Copyright (c) 2014年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "TDGeometricFigure.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
double degreeToRadian( double degree )
{
    return ( degree * M_PI / 180.0f );
}

//  ------------------------------------------------------------------------------------------------
double radianToDegree( double radian )
{
    return ( radian * 180.0f / M_PI );
}

//  ------------------------------------------------------------------------------------------------
double degreeWithCircleAliquot( int aliquotPart )
{
    return ( 360.0f / abs( aliquotPart ) );
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
CGFloat distanceBetweenPoints( CGPoint first, CGPoint second )
{
    return ( sqrtf( powf( ( second.x - first.x ), 2.0f ) + powf( ( second.y - first.y ), 2.0f ) ) );
}


//  ------------------------------------------------------------------------------------------------
CGFloat radianBetweenPoints( CGPoint first, CGPoint second )
{
    return -( atan2( ( second.y - first.y ), ( second.x - first.x ) ) );
}


//  ------------------------------------------------------------------------------------------------
//  reference : http://goo.gl/x4Gz3N
//  ※ 類似向量 & 和積化差的方式求得夾角.  rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))))
CGFloat radianBetweenLines( CGPoint firstStart, CGPoint firstEnd, CGPoint secondStart, CGPoint secondEnd )
{
    CGFloat                         radian;
    CGPoint                         vectorFirst;
    CGPoint                         vectorSecond;
    CGFloat                         scalar;
    CGFloat                         length;
    CGFloat                         fraction;

    vectorFirst                     = CGPointMake( ( firstEnd.x - firstStart.x ), ( firstEnd.y - firstStart.y ) );
    vectorSecond                    = CGPointMake( ( secondEnd.x - secondStart.x ), ( secondEnd.y - secondStart.y ) );

    scalar                          = ( vectorFirst.x * vectorSecond.x ) + ( vectorFirst.y * vectorSecond.y );
    length                          = ( sqrtf( powf( vectorFirst.x,  2.0f ) + powf( vectorFirst.y, 2.0f ) ) ) * ( sqrtf( powf( vectorSecond.x,  2.0f ) + powf( vectorSecond.y, 2.0f ) ) );
    fraction                        = scalar / length;

    fraction                        = ( ( -1 > fraction ) ? -1 : fraction );
    fraction                        = ( ( 1 < fraction ) ? 1 : fraction );

    radian                          = acosf( fraction );
    return radian;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
CGSize calculateProportionalSize( CGFloat ratio, CGSize baseSize )
{
    if ( ( 0.0f == ratio ) || ( CGSizeEqualToSize( baseSize, CGSizeZero ) == true ) )
    {
        return CGSizeZero;
    }
    
    CGFloat                         H;
    CGSize                          furtureSize;
    
    furtureSize                     = baseSize;
    H                               = furtureSize.width * ratio;
    if ( H <= furtureSize.height )
    {
        furtureSize.height          = H;
    }
    else
    {
        furtureSize.width           *= ( furtureSize.height / H );
    }
    return furtureSize;
}

//  ------------------------------------------------------------------------------------------------
CGSize calculateProportionalMaxSizeWithLimit( CGFloat ratio, CGSize baseSize, CGSize limitSize )
{
    if ( ( 0.0f == ratio ) || ( CGSizeEqualToSize( baseSize, CGSizeZero ) == true ) )
    {
        return CGSizeZero;
    }
    
    CGFloat                         H;
    CGSize                          furtureSize;
    
    furtureSize                     = baseSize;
    furtureSize.width               = ( ( furtureSize.width > limitSize.width ) ? limitSize.width : furtureSize.width );
    furtureSize.height              = ( ( furtureSize.height > limitSize.height ) ? limitSize.height : furtureSize.height );
    H                               = furtureSize.width * ratio;
    if ( H <= furtureSize.height )
    {
        furtureSize.height          = H;
    }
    else
    {
        furtureSize.width           *= ( furtureSize.height / H );
    }
    return furtureSize;
}

//  ------------------------------------------------------------------------------------------------
CGRect calculateProportionalRectWithParentSize( CGFloat ratio, CGSize baseSize, CGSize parentSize )
{
    if ( ( 0.0f == ratio ) || ( CGSizeEqualToSize( baseSize, CGSizeZero ) == true ) || ( CGSizeEqualToSize( parentSize,  CGSizeZero ) == true ) )
    {
        return CGRectZero;
    }
    
    CGRect                          furtureRect;
    
    furtureRect                     = CGRectZero;
    furtureRect.size                = calculateProportionalSize( ratio, baseSize );
    
    //  calculate position with parent size.
    furtureRect.origin.x            = ( ( parentSize.width - furtureRect.size.width) / 2.0f );
    furtureRect.origin.y            = ( ( parentSize.height - furtureRect.size.height) / 2.0f );
    return furtureRect;
}

//  ------------------------------------------------------------------------------------------------
CGRect calculateNewRectByScaled( CGRect baseRect, CGFloat scale )
{
    if ( ( CGRectEqualToRect( baseRect, CGRectZero ) ) || ( 0.0f == scale ) )
    {
        return CGRectZero;
    }
    
    baseRect.origin.x               /= scale;
    baseRect.origin.y               /= scale;
    baseRect.size.width             /= scale;
    baseRect.size.height            /= scale;
    return baseRect;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




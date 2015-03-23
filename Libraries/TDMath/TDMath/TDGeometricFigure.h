//
//  TDGeometricFigure.h
//  TDMath
//
//  Created by Robin Hsu on 2014/12/11.
//  Copyright (c) 2014年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef TDMath_TDGeometricFigure_h
#define TDMath_TDGeometricFigure_h

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief convert degrees to radians.
 *  convert degrees to radians.
 *
 *  @param degree                   degrees value.
 *
 *  @return                         converted value in radians.
 */
double degreeToRadian( double degree );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief convert radians to degrees
 *  convert radians to degrees
 *
 *  @param radian                   radians value.
 *
 *  @return                         converted value in degrees.
 */
double radianToDegree( double radian );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief to divide circle into n equal parts
 *  to divide circle into n equal parts
 *
 *  @param aliquotPart              divide value of circle aliguot.
 *
 *  @return                         degrees of aliguot part.
 */
double degreeWithCircleAliquot( int aliquotPart );


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate distance between two points.
 *  calculate distance between first point and second point.
 *
 *  @param first                    first point.
 *  @param second                   second point.
 *
 *  @return                         calculated value for distance.
 */
CGFloat distanceBetweenPoints( CGPoint first, CGPoint second );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate radian between two points.
 *  calculate radian between first point and second point.
 *
 *  @param first                    first point.
 *  @param second                   second point.
 *
 *  @return                         calculated value for radians.
 */
CGFloat radianBetweenPoints( CGPoint first, CGPoint second );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate radian between two lines.
 *  calculate radian between first line and second line.
 *
 *  @param firstStart               start point of first line.
 *  @param firstEnd                 end point of first line.
 *  @param secondStart              start point of second line.
 *  @param secondEnd                end point of second line.
 *
 *  @return                         calculated value for radians.
 */
CGFloat radianBetweenLines( CGPoint firstStart, CGPoint firstEnd, CGPoint secondStart, CGPoint secondEnd );


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate size of proportional for ratio.
 *  calculate size of proportional for ratio.
 *
 *  @param ratio                    ratio ( height/width )
 *  @param baseSize                 be calculated's size.
 *
 *  @return size|ZeroSize           the result size or ZeroSize.
 */
CGSize calculateProportionalSize( CGFloat ratio, CGSize baseSize );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate max size of proportional for ratio with limit size.
 *  calculate max size of proportional for ratio with limit size.
 *
 *  @param ratio                    ratio ( height/width )
 *  @param baseSize                 be calculated's size.
 *  @param limitSize                max size of limit. ( the result size cannot more then the limit width or height )
 *
 *  @return size|ZeroSize           the result size or ZeroSize.
 */
CGSize calculateProportionalMaxSizeWithLimit( CGFloat ratio, CGSize baseSize, CGSize limitSize );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate a new rect, rect's size of proportional for ratio, rect's origin with parent's size.
 *  calculate a new rect, rect's size of proportional for ratio, rect's origin with parent's size.
 *
 *  @param ratio                    ratio ( height/width )
 *  @param baseSize                 be calculated's size.
 *  @param parentSize               parent's size.
 *
 *  @return rect|ZeroRect           the result rect or ZeroRect.
 */
CGRect calculateProportionalRectWithParentSize( CGFloat ratio, CGSize baseSize, CGSize parentSize );

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate a new rect by scale.
 *  calculate a new rect by scale.
 *
 *  @param baseRect                 be calculated's rect.
 *  @param scale                    scale value.
 *
 *  @return rect|ZeroRect           the result rect or ZeroRect.
 */
CGRect calculateNewRectByScaled( CGRect baseRect, CGFloat scale );

//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------


#endif

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------




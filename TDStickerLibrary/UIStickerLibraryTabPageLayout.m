//
//  UIStickerLibraryTabPageLayout.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/26.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.


#import "UIStickerLibraryTabPageLayout.h"

//#define _debug_system_code_

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
static  NSString * const kTDLayoutAttributesKeyCell         = @"CellLayout";
static  NSString * const kTDLayoutAttributesKeyHeader       = @"HeaderLayout";
static  NSString * const kTDLayoutAttributesKeyFooter       = @"FooterLayout";



//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class UIStickerLibraryTabPageLayout

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface UIStickerLibraryTabPageLayout ()
{
    /**
     *  container of layout's attributes object.
     */
    NSMutableDictionary           * layoutAttributesContainer;

    /**
     *  current size of the content's view.
     */
    CGSize                          currentContentSize;

    /**
     *  set the flag when layout Attributes must be recalculated.
     */
    BOOL                            recalculatedLayout;
    
    
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
@interface UIStickerLibraryTabPageLayout(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for i/o container of layoutAttributesContainer.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get all layout Attributes of all type.
 @  get all layout Attributes of all type.
 *
 *  @return container|nil           layout Attributes's container or nil.
 */
- ( NSArray * ) _GetAllLayoutAttributes;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get all layout Attributes of item type.
 *  get all layout Attributes of item type.
 *
 *  @return container|nil           layout Attributes's container or nil.
 */
- ( NSDictionary * ) _GetLayoutAttributesForItem;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get all layout Attributes of header type.
 *  get all layout Attributes of header type.
 *
 *  @return container|nil           layout Attributes's container or nil.
 */
- ( NSDictionary * ) _GetLayoutAttributesForHeader;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get all layout Attributes of footer type.
 *  get all layout Attributes of footer type.
 *
 *  @return container|nil           layout Attributes's container or nil.
 */
- ( NSDictionary * ) _GetLayoutAttributesForFooter;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get layout Attributes for item at index path.
 *  get layout Attributes for item at index path
 *
 *  @param indexPath                indexPath for item.
 *
 *  @return object                  object of layout attributes.
 */
- ( UICollectionViewLayoutAttributes * ) _GetLayoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get layout Attributes for header at index path.
 *  get layout Attributes for header at index path
 *
 *  @param indexPath                indexPath for header.
 *
 *  @return object                  object of layout attributes.
 */
- ( UICollectionViewLayoutAttributes * ) _GetLayoutAttributesForHeaderAtIndexPath:(NSIndexPath *)indexPath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get layout Attributes for footer at index path.
 *  get layout Attributes for footer at index path
 *
 *  @param indexPath                indexPath for footer.
 *
 *  @return object                  object of layout attributes.
 */
- ( UICollectionViewLayoutAttributes * ) _GetLayoutAttributesForFooterAtIndexPath:(NSIndexPath *)indexPath;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare create layout attributes.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief manual create all layout attributes.
 *  manual create all layout attributes. ( manual that mean create by developer, not use by system default. )
 *
 *  @return YES|NO                  create method success or failure.
 */
- ( BOOL ) _CreateLayoutAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare calculate layout positon.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief recalculating all layout attributes.
 *  recalculating all layout attributes, the method will effect on layout of center.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _RecalculatingLayoutAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare get layout attributes.
//  ------------------------------------------------------------------------------------------------
/**
 *  First, get these attribute from the delegate's method that when the method has been implemented,
 *  otherwise get these attribute from objects's properties.
 */
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get layout attribute of Inset for section at index.
 *  get layout attribute of Inset for section at index.
 *
 *  @param section                  section index.
 *
 *  @return value                   layout attribute of Inset.
 */
- ( UIEdgeInsets ) _GetInsetForSectionAtIndex:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get layout attribute of Minimum Line Spacing for section at index.
 *  get layout attribute of Minimum Line Spacing for section at index.
 *
 *  @param section                  section index.
 *
 *  @return value                   layout attribute of Minimum Line Spacing.
 */
- ( CGFloat ) _GetMinimumLineSpacingForSectionAtIndex:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get layout attribute of Minimum Interite Spacing for section at index.
 *  get layout attribute of Minimum Interite Spacing for section at index.
 *
 *  @param section                  section index.
 *
 *  @return value                   layout attribute of Minimum Interite Spacing.
 */
- ( CGFloat ) _GetMinimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get layout attribute of first item's size for section at index.
 *  get layout attribute of first item's size for section at index
 *
 *  @param section                  section index.
 *
 *  @return value                   layout attribute of first item's size.
 */
- ( CGSize ) _GetFirstItemSizeForSectionAtIndex:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare calculate capacity for a row.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate capacity of first row for section at index.
 *  calculate capacity of first row for section, calculate capacity with the delegate's method that when the method has been implemented,
 *  otherwise calculate capacity with object's properties.
 *
 *  @param section                  section index.
 *
 *  @return value| -1               calculated value for capacity or -1.
 */
- ( NSInteger ) _CalculateFirstRowCapacityForSectionAtIndex:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate capacity of first row for section at index.
 *  calculate capacity of row for section, calculate capacity just with object's properties.
 *
 *  @param section                  section index.
 *
 *  @return value| -1               calculated value for capacity or -1.
 */
- ( NSInteger ) _CalculatePerRowCapacityForSectionAtIndex:(NSInteger)section;


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
@implementation UIStickerLibraryTabPageLayout(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    layoutAttributesContainer       = nil;
    
    currentContentSize              = CGSizeZero;
    
    recalculatedLayout              = NO;
    
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for i/o container of layoutAttributesContainer.
//  ------------------------------------------------------------------------------------------------
- ( NSArray * ) _GetAllLayoutAttributes
{
    NSMutableArray                * indexPaths;
    NSDictionary                  * layoutAttributes;
    
    indexPaths                      = [NSMutableArray arrayWithCapacity: 3];
    if ( nil == indexPaths )
    {
        return nil;
    }
    
    layoutAttributes                = [self _GetLayoutAttributesForHeader];
    if ( nil != layoutAttributes )
    {
        [indexPaths                 addObjectsFromArray: [layoutAttributes allValues]];
    }
    
    layoutAttributes                = [self _GetLayoutAttributesForFooter];
    if ( nil != layoutAttributes )
    {
        [indexPaths                 addObjectsFromArray: [layoutAttributes allValues]];
    }
    
    layoutAttributes                = [self _GetLayoutAttributesForItem];
    if ( nil != layoutAttributes )
    {
        [indexPaths                 addObjectsFromArray: [layoutAttributes allValues]];
    }
    
    //NSLog( @"layoutAttributes :%@ ", indexPaths );
    return indexPaths;
}

//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _GetLayoutAttributesForItem
{
    if ( ( nil == layoutAttributesContainer ) || ( [layoutAttributesContainer count] == 0 ) )
    {
        return nil;
    }
    return [layoutAttributesContainer objectForKey: kTDLayoutAttributesKeyCell];
}

//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _GetLayoutAttributesForHeader
{
    if ( ( nil == layoutAttributesContainer ) || ( [layoutAttributesContainer count] == 0 ) )
    {
        return nil;
    }
    return [layoutAttributesContainer objectForKey: kTDLayoutAttributesKeyHeader];
}

//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _GetLayoutAttributesForFooter
{
    if ( ( nil == layoutAttributesContainer ) || ( [layoutAttributesContainer count] == 0 ) )
    {
        return nil;
    }
    return [layoutAttributesContainer objectForKey: kTDLayoutAttributesKeyFooter];
}

//  ------------------------------------------------------------------------------------------------
- ( UICollectionViewLayoutAttributes * ) _GetLayoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self _GetLayoutAttributesForItem] objectForKey: indexPath];
}

//  ------------------------------------------------------------------------------------------------
- ( UICollectionViewLayoutAttributes * ) _GetLayoutAttributesForHeaderAtIndexPath:(NSIndexPath *)indexPath;
{
    return [[self _GetLayoutAttributesForHeader] objectForKey: indexPath];
}

//  ------------------------------------------------------------------------------------------------
- ( UICollectionViewLayoutAttributes * ) _GetLayoutAttributesForFooterAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self _GetLayoutAttributesForFooter] objectForKey: indexPath];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method create layout attributes.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateLayoutAttributes
{
    if ( ( [self collectionView] == nil ) || ( [[self collectionView] numberOfSections] == 0 ) )
    {
        return NO;
    }
    
    NSIndexPath                   * indexPath;
    NSIndexPath                   * indexPathsupplement;
    UICollectionView              * collectionView;
    NSMutableDictionary           * cellContainer;
    NSMutableDictionary           * headerContainer;
    NSMutableDictionary           * footerContainer;
    UICollectionViewLayoutAttributes  * cellAttributes;
    UICollectionViewLayoutAttributes  * headerAttributes;
    UICollectionViewLayoutAttributes  * footerAttributes;
    
    
    indexPath                       = nil;
    indexPathsupplement             = nil;
    cellAttributes                  = nil;
    headerAttributes                = nil;
    footerAttributes                = nil;
    headerContainer                 = nil;
    footerContainer                 = nil;
    cellContainer                   = nil;
    collectionView                  = [self collectionView];
    for ( int i = 0; i < [collectionView numberOfSections]; ++i )
    {
        //  init header.
        if ( [collectionView respondsToSelector: @selector( collectionView: layout: referenceSizeForHeaderInSection: )] == YES )
        {
            if ( nil == headerContainer )
            {
                headerContainer     = [NSMutableDictionary dictionary];
            }
            
            indexPathsupplement     = [NSIndexPath indexPathForItem: 0 inSection: i];
            if ( nil != indexPathsupplement )
            {
                headerAttributes    = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind: UICollectionElementKindSectionHeader withIndexPath: indexPathsupplement];
                if ( nil != headerAttributes )
                {
                    [headerContainer    setObject: headerAttributes forKey: indexPathsupplement];
                }
            }
        }
        
        //  init cell.
        if ( [collectionView  respondsToSelector: @selector( collectionView: layout: sizeForItemAtIndexPath: )] == YES )
        {
            for ( int j = 0; j < [collectionView numberOfItemsInSection: i]; ++j )
            {
                if ( nil == cellContainer )
                {
                    cellContainer   = [NSMutableDictionary dictionary];
                }
                
                indexPath           = [NSIndexPath indexPathForItem: j inSection: i];
                if ( nil == indexPath )
                {
                    continue;
                }
                
                cellAttributes      = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath: indexPath];
                if ( nil == cellAttributes )
                {
                    continue;
                }
                [cellContainer      setObject: cellAttributes forKey: indexPath];
            }
        }
        
        //  init footer.
        if ( [collectionView respondsToSelector: @selector( collectionView: layout: referenceSizeForFooterInSection: )] == YES )
        {
            if ( nil == footerContainer )
            {
                footerContainer     = [NSMutableDictionary dictionary];
            }
            
            indexPathsupplement     = [NSIndexPath indexPathForItem: 0 inSection: i];
            if ( nil != indexPathsupplement )
            {
                footerAttributes     = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind: UICollectionElementKindSectionFooter withIndexPath: indexPathsupplement];
                if ( nil != footerAttributes )
                {
                    [footerContainer    setObject: footerAttributes forKey: indexPathsupplement];
                }
            }
        }
    }   //  End of for ( int i = 0; i < [collectionView numberOfSections]; ++i ).
    if ( ( nil == headerContainer ) && ( nil == footerContainer ) && ( nil == cellContainer ) )
    {
        return NO;
    }
    
    layoutAttributesContainer       = [[NSMutableDictionary alloc] initWithCapacity: 3];
    if ( nil != headerContainer )
    {
        [layoutAttributesContainer  setObject: headerContainer forKey: kTDLayoutAttributesKeyHeader];
    }
    if ( nil != footerContainer )
    {
        [layoutAttributesContainer  setObject: footerContainer forKey: kTDLayoutAttributesKeyFooter];
    }
    if ( nil != cellContainer )
    {
        [layoutAttributesContainer  setObject: cellContainer forKey: kTDLayoutAttributesKeyCell];
    }
    
    currentContentSize              = [collectionView bounds].size;
    
    //NSLog( @"init layoutContainer: %@", layoutContainer );
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method calculate layout positon.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _RecalculatingLayoutAttributes
{
    if ( ( [self collectionView] == nil ) || ( [[self collectionView] numberOfSections] == 0 ) )
    {
        return NO;
    }
    
    NSIndexPath                   * indexPath;
    NSIndexPath                   * indexPathsupplement;
    UICollectionView              * collectionView;
    UICollectionViewLayoutAttributes  * cellAttributes;
    UICollectionViewLayoutAttributes  * headerAttributes;
    UICollectionViewLayoutAttributes  * footerAttributes;
    
    
    indexPath                       = nil;
    indexPathsupplement             = nil;
    cellAttributes                  = nil;
    headerAttributes                = nil;
    footerAttributes                = nil;
    collectionView                  = [self collectionView];
    
    
    CGSize                          collectionViewSize;
    CGPoint                         currentPoint;
    UIEdgeInsets                    sectionInset;
    CGFloat                         minimumLineSpacing;
    CGFloat                         minimumInteritemSpacing;
    CGFloat                         widthSpace;
    
    CGRect                          newRect;
    CGFloat                         maximumHeight;
    CGFloat                         calculatedSpacing;
    NSInteger                       emptyCount;
    NSMutableArray                * queueInRow;
    
    
    sectionInset                    = UIEdgeInsetsZero;
    minimumLineSpacing              = 0.0f;
    minimumInteritemSpacing         = 0.0f;
    currentPoint                    = CGPointMake( 0, 0 );
    collectionViewSize              = [[self collectionView] bounds].size;
    widthSpace                      = collectionViewSize.width;
    
    maximumHeight                   = 0.0f;
    calculatedSpacing               = 0.0f;
    newRect                         = CGRectZero;
    emptyCount                      = 0;
    queueInRow                      = [NSMutableArray array];
    
    for ( int i = 0; i < [collectionView numberOfSections]; ++i )
    {
        //  get section info.
        sectionInset                = [self _GetInsetForSectionAtIndex: i];
        minimumLineSpacing          = [self _GetMinimumLineSpacingForSectionAtIndex: i];
        minimumInteritemSpacing     = [self _GetMinimumInteritemSpacingForSectionAtIndex: i];
        
        //  recalculating header.
        indexPathsupplement         = [NSIndexPath indexPathForItem: 0 inSection: i];
        if ( nil != indexPathsupplement )
        {
            headerAttributes        = [self layoutAttributesForSupplementaryViewOfKind: UICollectionElementKindSectionHeader atIndexPath: indexPathsupplement];
        }
        if ( nil != headerAttributes )
        {
            newRect                 = CGRectMake( currentPoint.x, currentPoint.y, [headerAttributes size].width , [headerAttributes size].height );
            [headerAttributes        setFrame:  newRect];
            currentPoint.y          += ( [headerAttributes size].height + sectionInset.top ) ;
        }
        
        
        //  recalculating cell.
        currentPoint.x              = sectionInset.left;
        widthSpace                  -= ( sectionInset.left + sectionInset.right );
        calculatedSpacing           = widthSpace;
        for ( int j = 0; j < [collectionView numberOfItemsInSection: i]; ++j )
        {
            indexPath               = [NSIndexPath indexPathForItem: j inSection: i];
            if ( nil == indexPath )
            {
                continue;
            }
            
            cellAttributes           = [self layoutAttributesForItemAtIndexPath: indexPath];
            if ( nil == cellAttributes )
            {
                continue;
            }
            
            //  check maximum for height of row.
            maximumHeight           = ( ( maximumHeight < [cellAttributes size].height ) ? [cellAttributes size].height : maximumHeight );
            
            //  check width space for new item.
            if ( widthSpace >= [cellAttributes size].width )
            {
                widthSpace          -= ( [cellAttributes size].width + minimumInteritemSpacing );
                calculatedSpacing   -= [cellAttributes size].width;
                [queueInRow         addObject: cellAttributes];
                continue;
            }
            
            //  when space not engough, process attributes in queue.
            calculatedSpacing       = ( ( 0.0f > calculatedSpacing ) ? 0.0f : calculatedSpacing );
            if ( [queueInRow count] > 1 )
            {
                calculatedSpacing   = ( calculatedSpacing / ( [queueInRow count] - 1 ) );
            }
            
            for ( id idAttributes in queueInRow )
            {
                if ( nil == idAttributes )
                {
                    continue;
                }
                
                newRect             = [idAttributes frame];
                newRect.origin.x    = currentPoint.x;
                newRect.origin.y    = ( currentPoint.y + ( ( maximumHeight - [idAttributes size].height ) / 2.0f ) );
                [idAttributes       setFrame: newRect];
                
                currentPoint.x      += ( newRect.size.width + calculatedSpacing );
            }
            
            //  when space cannot input new cell, goto next row.
            currentPoint.x          = sectionInset.left;
            currentPoint.y          += ( maximumHeight + minimumLineSpacing );
            maximumHeight           = [cellAttributes size].height;
            
            //  reset variable.
            widthSpace              = collectionViewSize.width;
            widthSpace              -= ( sectionInset.left + sectionInset.right );
            calculatedSpacing       = widthSpace;
            
            [queueInRow             removeAllObjects];
            
            //  process current attributes on here.
            widthSpace              -= ( [cellAttributes size].width + minimumInteritemSpacing );
            calculatedSpacing       -= [cellAttributes size].width;
            [queueInRow             addObject: cellAttributes];
            
        }   //  End of for ( int j = 0; j < [collectionView numberOfItemsInSection: i]; ++j ).
        
        //  other items(empty item) width use default of layout to calculate.
        //  這邊處理的流程主要是因為 在未滿足行的狀況下, 就離開了上面那一個 for loop.
        emptyCount                  = 0;
        while ( ( widthSpace >= [self itemSize].width )  )
        {
            widthSpace              -= ( [self itemSize].width + minimumInteritemSpacing );
            calculatedSpacing       -= [self itemSize].width;
            emptyCount++;
        }
        
        //  when space not engough, process attributes in queue.
        calculatedSpacing       = ( ( 0.0f > calculatedSpacing ) ? 0.0f : calculatedSpacing );
        if ( ( [queueInRow count] + emptyCount ) > 1 )
        {
            calculatedSpacing   = ( calculatedSpacing / ( ( [queueInRow count] + emptyCount ) - 1 ) );
        }
        
        //  recalculating other attributes in queue.
        if ( [queueInRow count] > 0 )
        {
            for ( id idAttributes in queueInRow )
            {
                if ( nil == idAttributes )
                {
                    continue;
                }
                
                newRect             = [idAttributes frame];
                newRect.origin.x    = currentPoint.x;
                newRect.origin.y    = ( currentPoint.y + ( ( maximumHeight - [idAttributes size].height ) / 2.0f ) );
                [idAttributes       setFrame: newRect];
                
                currentPoint.x      += ( newRect.size.width + calculatedSpacing );
            }
            
            //  when space cannot input new cell, goto next row.
            currentPoint.x          = sectionInset.left;
            currentPoint.y          += maximumHeight;
            
            //  reset variable.
            widthSpace              = collectionViewSize.width;
            calculatedSpacing       = widthSpace;
            
            emptyCount              = 0;
            maximumHeight           = 0.0f;
            [queueInRow             removeAllObjects];
        }   //  End of if ( [queueInRow count] > 0 ).
        
        //  at sectioin bottom.
        currentPoint.x              = 0.0f;
        currentPoint.y              += sectionInset.bottom;
        
        //  recalculating footer.
        if ( nil != indexPathsupplement )
        {
            footerAttributes        = [self layoutAttributesForSupplementaryViewOfKind: UICollectionElementKindSectionFooter atIndexPath: indexPathsupplement];
        }
        if ( nil != footerAttributes )
        {
            newRect                 = CGRectMake( currentPoint.x, currentPoint.y, [footerAttributes size].width , [footerAttributes size].height );
            [footerAttributes        setFrame: newRect];
            currentPoint.y          += ( [footerAttributes size].height + sectionInset.bottom ) ;
        }
    }   //  End of for ( int i = 0; i < [collectionView numberOfSections]; ++i ).
    
    
    currentContentSize.height       = currentPoint.y;
    
    //NSLog( @"recalculate layoutContainer: %@", layoutContainer );
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method get layout attributes.
//  ------------------------------------------------------------------------------------------------
- ( UIEdgeInsets ) _GetInsetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets                    sectionInset;
    
    sectionInset                    = UIEdgeInsetsZero;
    if ( ( [self idDelegate] == nil ) || ( [[self idDelegate] respondsToSelector: @selector( collectionView: layout: insetForSectionAtIndex: )] == NO ) )
    {
        return [self sectionInset];
    }
    
    sectionInset                    = [[self idDelegate] collectionView: [self collectionView] layout: self insetForSectionAtIndex: section];
    if ( UIEdgeInsetsEqualToEdgeInsets( sectionInset, UIEdgeInsetsZero ) == true )
    {
        sectionInset                = [self sectionInset];
    }
    return sectionInset;
}

//  ------------------------------------------------------------------------------------------------
- ( CGFloat ) _GetMinimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat                         minimumLineSpacing;
    
    minimumLineSpacing              = -1.0f;
    if ( ( [self idDelegate] == nil ) || ( [[self idDelegate] respondsToSelector: @selector( collectionView: layout: minimumLineSpacingForSectionAtIndex: )] == NO ) )
    {
        return [self minimumLineSpacing];
    }
    
    minimumLineSpacing              = [[self idDelegate] collectionView: [self collectionView] layout: self minimumLineSpacingForSectionAtIndex: section];
    if ( -1.0f == minimumLineSpacing )
    {
        minimumLineSpacing          = [self minimumLineSpacing];
    }
    return minimumLineSpacing;
}

//  ------------------------------------------------------------------------------------------------
- ( CGFloat ) _GetMinimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat                         minimumInteritemSpacing;
    
    minimumInteritemSpacing         = -1.0f;
    if ( ( [self idDelegate] == nil ) || ( [[self idDelegate] respondsToSelector: @selector( collectionView: layout: minimumInteritemSpacingForSectionAtIndex: )] == NO ) )
    {
        return [self minimumInteritemSpacing];
    }
    
    minimumInteritemSpacing         = [[self idDelegate] collectionView: [self collectionView] layout: self minimumInteritemSpacingForSectionAtIndex: section];
    if ( -1.0f == minimumInteritemSpacing )
    {
        minimumInteritemSpacing     = [self minimumInteritemSpacing];
    }
    return minimumInteritemSpacing;
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) _GetFirstItemSizeForSectionAtIndex:(NSInteger)section;
{
    CGSize                          itemSize;
    NSIndexPath                   * indexPath;
    
    itemSize                        = CGSizeZero;
    indexPath                       = [NSIndexPath indexPathForItem: 0 inSection: section];
    if ( ( [self idDelegate] == nil ) || ( [[self idDelegate] respondsToSelector: @selector( collectionView: layout: sizeForItemAtIndexPath: )] == NO ) )
    {
        return [self itemSize];
    }
    
    itemSize                        = [[self idDelegate] collectionView: [self collectionView] layout: self sizeForItemAtIndexPath: indexPath];
    if ( CGSizeEqualToSize( itemSize, CGSizeZero ) == true )
    {
        itemSize                    = [self itemSize];
    }
    return itemSize;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method calculate capacity for a row.
//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) _CalculateFirstRowCapacityForSectionAtIndex:(NSInteger)section
{
    if ( ( [self collectionView] == nil ) || ( [[self collectionView] numberOfSections] == 0 ) )
    {
        return -1;
    }
    
    NSIndexPath                       * indexPath;
    UICollectionViewLayoutAttributes  * cellAttributes;
    
    indexPath                           = nil;
    cellAttributes                      = nil;
    
    
    CGPoint                         currentPoint;
    UIEdgeInsets                    sectionInset;
    CGFloat                         minimumInteritemSpacing;
    CGFloat                         widthSpace;
    NSInteger                       itemAmount;
    NSInteger                       emptyCount;
    
    currentPoint                    = CGPointMake( 0, 0 );
    sectionInset                    = UIEdgeInsetsZero;
    minimumInteritemSpacing         = 0.0f;
    widthSpace                      = [[self collectionView] bounds].size.width;
    
    //  get section info.
    sectionInset                    = [self _GetInsetForSectionAtIndex: section];
    minimumInteritemSpacing         = [self _GetMinimumInteritemSpacingForSectionAtIndex: section];
    
    //  recalculating cell width.
    itemAmount                      = 0;
    emptyCount                      = 0;
    currentPoint.x                  = sectionInset.left;
    widthSpace                      -= ( sectionInset.left + sectionInset.right );
    do
    {
        indexPath                   = [NSIndexPath indexPathForItem: itemAmount inSection: section];
        if ( nil == indexPath )
        {
            //  when total width of items of row less then width of bounds of view.
            widthSpace              -= ( [self itemSize].width + minimumInteritemSpacing );
            emptyCount++;
            itemAmount++;
            continue;
        }
        
        cellAttributes               = [self layoutAttributesForItemAtIndexPath: indexPath];
        if ( nil == cellAttributes )
        {
            //  when total width of items of row less then width of bounds of view.
            widthSpace              -= ( [self itemSize].width + minimumInteritemSpacing );
            emptyCount++;
            itemAmount++;
            continue;
        }
        
        widthSpace                  -= ( [cellAttributes size].width + minimumInteritemSpacing );
        itemAmount++;
    } while ( widthSpace >= [cellAttributes size].width );
    
    return ( itemAmount - emptyCount );
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) _CalculatePerRowCapacityForSectionAtIndex:(NSInteger)section
{
    if ( [self collectionView] == nil )
    {
        return -1;
    }
    
    CGFloat                         baseWidth;
    NSInteger                       perRowItem;
    UIEdgeInsets                    sectionInset;
    CGSize                          firstItemSize;
    CGFloat                         minimumInteritemSpacing;
    
    perRowItem                      = 0;
    baseWidth                       = [[self collectionView] bounds].size.width;
    sectionInset                    = [self _GetInsetForSectionAtIndex: section];
    firstItemSize                   = [self _GetFirstItemSizeForSectionAtIndex: section];
    minimumInteritemSpacing         = [self _GetMinimumInteritemSpacingForSectionAtIndex: section];
    
    //  1st, calculate for without edgeInset.
    baseWidth                       -= ( sectionInset.left + sectionInset.right );
    
    //  2nd, calculate for without first item.
    baseWidth                       -= firstItemSize.width;
    
    //  3th. use others to calculate for amount.
    perRowItem                      = ceilf( baseWidth / ( firstItemSize.width + minimumInteritemSpacing ) );
    if ( 0 >= perRowItem )
    {
        perRowItem                  = 1;
    }
    return perRowItem;
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
@implementation UIStickerLibraryTabPageLayout

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------
- ( id ) init
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    return self;
}

//  --------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != layoutAttributesContainer )
    {
        [layoutAttributesContainer  removeAllObjects];
        SAFE_ARC_RELEASE( layoutAttributesContainer );
        SAFE_ARC_ASSIGN_POINTER_NIL( layoutAttributesContainer );
    }
    
}

//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of UICollectionViewLayout.
//  ------------------------------------------------------------------------------------------------
- ( void ) prepareLayout
{
    [super                          prepareLayout];
#if defined(_debug_system_code_)
    return;
#endif

    if ( nil == layoutAttributesContainer )
    {
        if ( [self _CreateLayoutAttributes] == YES )
        {
            recalculatedLayout      = YES;
        }
    }
    
    //  recalculate.
    if ( YES == recalculatedLayout )
    {
        if ( [self _RecalculatingLayoutAttributes] == YES )
        {
            recalculatedLayout      = NO;
        }
    }
}

//  ------------------------------------------------------------------------------------------------
- ( NSArray * ) layoutAttributesForElementsInRect:(CGRect)rect
{
#if defined(_debug_system_code_)
    return [super layoutAttributesForElementsInRect: rect];
#endif

    NSMutableArray                * layouts;
    
    layouts                         = [NSMutableArray array];
    for ( id idAttributes in [self _GetAllLayoutAttributes] )
    {
        if ( nil == idAttributes )
        {
            continue;
        }
        if ( CGRectIntersectsRect( [idAttributes frame] , rect ) == false )
        {
            continue;
        }
        [layouts                    addObject: idAttributes];
    }
    return layouts;
}

//  ------------------------------------------------------------------------------------------------
- ( UICollectionViewLayoutAttributes * )layoutAttributesForItemAtIndexPath:(NSIndexPath *) indexPath
{
#if defined(_debug_system_code_)
    return [super layoutAttributesForItemAtIndexPath: indexPath];
#endif

    CGSize                              referenceSize;
    UICollectionViewLayoutAttributes  * attributes;
    
    referenceSize                       = CGSizeZero;
    attributes                          = [self _GetLayoutAttributesForItemAtIndexPath: indexPath];
    if ( nil == attributes )
    {
        return nil;
    }
    
    if ( ( [self idDelegate] != nil ) && ( [[self idDelegate] respondsToSelector: @selector( collectionView: layout: sizeForItemAtIndexPath: )] == YES ) )
    {
        referenceSize               = [[self idDelegate] collectionView: [self collectionView] layout: self sizeForItemAtIndexPath: indexPath];
    }
    if ( CGSizeEqualToSize( referenceSize, CGSizeZero ) == true )
    {
        referenceSize               = [self itemSize];
    }
    
    //  don't set center, frame.origin  on here.
    [attributes                     setSize: referenceSize];
    return attributes;
}

//  ------------------------------------------------------------------------------------------------
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
#if defined(_debug_system_code_)
    return [super layoutAttributesForSupplementaryViewOfKind: elementKind atIndexPath: indexPath];
#endif

    CGSize                              referenceSize;
    UICollectionViewLayoutAttributes  * attributes;
    
    
    attributes                      = nil;
    referenceSize                   = CGSizeZero;
    if ( [elementKind isEqualToString: UICollectionElementKindSectionHeader] == YES )
    {
        attributes                  = [self _GetLayoutAttributesForHeaderAtIndexPath: indexPath];
        if ( ( [self idDelegate] != nil ) && ( [[self idDelegate] respondsToSelector: @selector( collectionView: layout: referenceSizeForHeaderInSection: )] == YES ) )
        {
            referenceSize           = [[self idDelegate] collectionView: [self collectionView] layout: self referenceSizeForHeaderInSection: indexPath.section ];
        }
        if ( CGSizeEqualToSize( referenceSize, CGSizeZero ) == true )
        {
            referenceSize           = [self headerReferenceSize];
        }
    }
    else if ( [elementKind isEqualToString: UICollectionElementKindSectionFooter] == YES )
    {
        attributes                  = [self _GetLayoutAttributesForFooterAtIndexPath: indexPath];
        if ( ( [self idDelegate] != nil ) && ( [[self idDelegate] respondsToSelector: @selector( collectionView: layout: referenceSizeForFooterInSection: )] == YES ) )
        {
            referenceSize           = [[self idDelegate] collectionView: [self collectionView] layout: self referenceSizeForFooterInSection: indexPath.section ];
        }
        if ( CGSizeEqualToSize( referenceSize, CGSizeZero ) == true )
        {
            referenceSize           = [self footerReferenceSize];
        }
    }
    
    if ( nil == attributes )
    {
        return nil;
    }
    
    //  don't set center, frame.origin  on here.
    [attributes                     setSize: referenceSize];
    return attributes;
}

//  ------------------------------------------------------------------------------------------------
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
//    CGRect                              oldBounds;
//    oldBounds                           = [[self collectionView] bounds];
//    if ( CGRectGetHeight( newBounds ) == CGRectGetHeight( oldBounds ) )
//    {
//        return NO;
//    }
//
//    return YES;
    return NO;
}

//  ------------------------------------------------------------------------------------------------
-( CGSize )collectionViewContentSize
{
#if defined(_debug_system_code_)
    CGSize                          contentSize;
    contentSize                     = [super collectionViewContentSize];
    return CGSizeMake( contentSize.width , ( contentSize.height + 0 ) );
#endif
    
    return currentContentSize;
}


////  ------------------------------------------------------------------------------------------------
////  ※ 經過一些測試發現, 結果這一系列的 method 也適用在諸如 insert delete 過程, animation 用的初始設定, 會是最後結果的設定.
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//#if defined(_debug_system_code_)
//    NSLog( @"%@", itemIndexPath );
//    return [super initialLayoutAttributesForAppearingItemAtIndexPath: itemIndexPath];
//#endif
//    
//}
//
////  ------------------------------------------------------------------------------------------------
//- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
//{
//#if defined(_debug_system_code_)
//    NSLog( @"%@", itemIndexPath );
//    return [super finalLayoutAttributesForDisappearingItemAtIndexPath: itemIndexPath];
//#endif
//    
//}



////  ------------------------------------------------------------------------------------------------
//#pragma mark method for set property of variable
////  ------------------------------------------------------------------------------------------------
//- ( void ) setSectionInset:(UIEdgeInsets)sectionInset
//{
//    
//    [super                          setSectionInset: sectionInset];
//}



////  ------------------------------------------------------------------------------------------------
//#pragma mark declare calculate capacity for a row.
////  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
#pragma mark method update status of layout attributes.
//  ------------------------------------------------------------------------------------------------
- ( void ) needUpdateLayoutAttributes:(BOOL)amountChanging
{
    recalculatedLayout              = YES;
    if ( NO == amountChanging )
    {
        return;
    }
    
    [layoutAttributesContainer      removeAllObjects];
    SAFE_ARC_RELEASE( layoutAttributesContainer );
    layoutAttributesContainer       = nil;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method calculate capacity for a row.
//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) calculateFirstRowCapacityForSectionAtIndex:(NSInteger)section
{
    return [self _CalculateFirstRowCapacityForSectionAtIndex: section];
}

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


















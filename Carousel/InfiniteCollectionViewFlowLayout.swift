//
//  InfiniteCollectionViewFlowLayout.swift
//  Carousel
//
//  Created by Fellipe Calleia on 1/18/18.
//  Copyright © 2018 Fellipe Calleia. All rights reserved.
//

import UIKit

class InfiniteCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    let standardItemAlpha = CGFloat(0.5)
    let standardItemScale = CGFloat(0.5)
    
    var isSetup = false
    
    override func prepare() {
        super.prepare()
        
        if isSetup == false {
            setupCollectionView()
            isSetup = true
        }
    }
    
    func changeLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) {
        
        let collectionCenter = collectionView!.frame.size.height/2
        let offset = collectionView!.contentOffset.y
        let normalizedCenter = attributes.center.y - offset

        let maxDistance = self.itemSize.height + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)

        let ratio = (maxDistance - distance)/maxDistance
        let alpha = ratio * (1 - self.standardItemAlpha) + self.standardItemAlpha
        let scale = ratio * (1 - self.standardItemScale) + self.standardItemScale

        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()
        
        for itemAttributes in attributes! {
            let itemAttributesCopy = itemAttributes.copy() as! UICollectionViewLayoutAttributes
            
            changeLayoutAttributes(itemAttributesCopy)
            attributesCopy.append(itemAttributesCopy)
        }
        
        return attributesCopy
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    // MARK: - Cell Snapping
    
    func setupCollectionView() {
        self.collectionView!.decelerationRate = UIScrollViewDecelerationRateFast
        
        let collectionSize = collectionView!.bounds.size
        let yInset = (collectionSize.height - self.itemSize.height) / 2
        let xInset = (collectionSize.width - self.itemSize.width) / 2
        
        self.sectionInset = UIEdgeInsetsMake(yInset, xInset, yInset, xInset)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let layoutAttributes = self.layoutAttributesForElements(in: collectionView!.bounds)
        
        let center = collectionView!.bounds.size.height / 2
        let proposedContentOffsetCenterOrigin = proposedContentOffset.y + center
        
        let closest = layoutAttributes!.sorted { abs($0.center.y - proposedContentOffsetCenterOrigin) < abs($1.center.y - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
        
        let targetContentOffset = CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - center))
        
        return targetContentOffset
    }
}

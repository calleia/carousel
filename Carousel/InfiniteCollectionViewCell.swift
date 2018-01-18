//
//  InfiniteCollectionViewCell.swift
//  Carousel
//
//  Created by Fellipe Calleia on 1/18/18.
//  Copyright © 2018 Fellipe Calleia. All rights reserved.
//

import UIKit

class InfiniteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = CGFloat(1)
    }
}

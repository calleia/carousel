//
//  ViewController.swift
//  Carousel
//
//  Created by Fellipe Calleia on 1/18/18.
//  Copyright © 2018 Fellipe Calleia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var carouselViews = [Any]()
    
    let reuseIdentifier = "InfiniteCollectionViewCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        for index in 0...19 {
            carouselViews.append(index)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK: - Extensions

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! InfiniteCollectionViewCell
        
        let title = carouselViews[indexPath.row]
        cell.label.text = String(describing: title)
        
        return cell
    }
}

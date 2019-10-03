//
//  DogCollectionViewCell.swift
//  collection-view-with-persistence
//
//  Created by David Rifkin on 10/3/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class DogCollectionViewCell: UICollectionViewCell {
    
    //closures are first order types just like Int and String
    var buttonFunction: (()->())?

    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if let closure = buttonFunction {
            closure()
        }
    }
}

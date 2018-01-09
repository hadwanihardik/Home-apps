//
//  MovieCell.swift
//  FandangoTest
//
//  Created by Hardik on 12/14/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import UIKit
class MovieCell: UICollectionViewCell {

    @IBOutlet weak var imvPosterImage: UIImageView!
    @IBOutlet weak var tomatoIcon: UIImageView!
    @IBOutlet weak var tomatoRating: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var lblNoRatings: UILabel!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var movieName: UILabel!

     override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentView.translatesAutoresizingMaskIntoConstraints = false;
//        self.cellWidthConstraint = self.contentView.widthAnchor.constraint(equalToConstant: 0.f) //[self.contentView.widthAnchor constraintEqualToConstant:0.f];
        // Initialization code
    }
    

}

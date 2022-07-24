//
//  ImageCollectionViewCell.swift
//  RentaTeamTest
//
//  Created by Alex Krzywicki on 02.09.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "ImageCollectionViewCell"
    
    var representedIdentifier: String = ""
    
    var title: String? {
      didSet {
        titleLabel.text = title
          if titleLabel.text == nil {
              titleLabel.text = "NO description =("
          }
      }
    }
    var image: UIImage? {
      didSet {
        imageView.image = image
      }
    }
    
    var badge: UIImage? {
      didSet {
        badgeImageView.image = badge
      }
    }
  }


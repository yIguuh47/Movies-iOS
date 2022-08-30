//
//  CustomCollectionViewCell.swift
//  MoviesApp
//
//  Created by Virtual Machine on 04/08/22.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var moviesImageView: UIImageView!
    
    static let identifier: String = "CustomCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func didConvertImageUrl(url: String) {
           DispatchQueue.global().async {
               do {
                   let data = try Data.init(contentsOf: URL.init(string: String(url))!)
                   DispatchQueue.main.async {
                       self.moviesImageView.image = UIImage(data: data)
                   }
               }
               catch {
                   print("Erro image\(url)")
               }
           }
    }

}

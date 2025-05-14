//
//  UserCell.swift
//  ImageLoading
//
//  Created by Akash Sheelavant on 2/18/25.
//

import UIKit
import Foundation

class UserCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(userViewModel: UserViewModelType) {
        nameLabel.text = userViewModel.name
        addressLabel.text = userViewModel.address
        
        if let url = URL(string: userViewModel.imageURL) {
           URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
               if let data = data {
                   DispatchQueue.main.async { [weak self] in
                       self?.userImageView.image = UIImage(data: data)
                   }
               }
           }).resume()                                                                                
        }
    }
}

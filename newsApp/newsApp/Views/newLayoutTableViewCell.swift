//
//  newLayoutTableViewCell.swift
//  newsApp
//
//  Created by kranthi.kumar on 31/07/22.
//

import UIKit



class newLayoutTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsDescription: UITextView!
    @IBOutlet weak var newsAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

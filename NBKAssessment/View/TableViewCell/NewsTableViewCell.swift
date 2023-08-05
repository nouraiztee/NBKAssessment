//
//  NewsTableViewCell.swift
//  NBKAssessment
//
//  Created by Nouraiz Taimour on 05/08/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsThumbnail: UIImageView!
    
    @IBOutlet weak var newsTitleLbl: UILabel!
    @IBOutlet weak var newsAuthorLbl: UILabel!
    @IBOutlet weak var timeSincePostedLbl: UILabel!
    
    static let reuseID = "NewsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

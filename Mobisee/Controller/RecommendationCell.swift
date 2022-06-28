//
//  RecommendationCell.swift
//  Mobisee
//
//  Created by Vincentius Sutanto on 28/06/22.
//

import UIKit

class RecommendationCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var totalMin: UILabel!
    
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!

    @IBOutlet weak var firstMileImg: UIImageView!
    @IBOutlet weak var middleMileImg: UIImageView!
    @IBOutlet weak var lastMileImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
//    override func layoutSubviews() {
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

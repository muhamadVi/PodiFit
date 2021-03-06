//
//  CompletedPlanCollectionViewCell.swift
//  PodiFit
//
//  Created by Nathanael Adolf Sukiman on 23/10/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class CompletedPlanCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet var movesLabel: UILabel!
    
    @IBOutlet var completedPlanBackgroundView: UIView!
    
    override func awakeFromNib() {
        completedPlanBackgroundView.backgroundColor = Colors.cellColor
        completedPlanBackgroundView.layer.cornerRadius = 5
        

        
    }
}

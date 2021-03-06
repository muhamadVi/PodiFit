//
//  ExerciseTableViewCell.swift
//  PodiFit
//
//  Created by Griffin on 22/10/20.
//  Copyright © 2020 Nathanael Adolf Sukiman. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    static let identifier = "ExerciseTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "ExerciseTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var exerciseImage: UIImageView!
    
    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var exerciseDuration: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //exerciseImage.image = UIImage.init(named: "glutebridgecalfraise")
        exerciseImage.layer.cornerRadius = 5.0
        exerciseDuration.text = "00:30"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func parseData(data: ExerciseModel) {
        exerciseName.text = data.namaExercise.uppercased()
        exerciseImage.image = UIImage.init(named: data.image)
    }
    
}

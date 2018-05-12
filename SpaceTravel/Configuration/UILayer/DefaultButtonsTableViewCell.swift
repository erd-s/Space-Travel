//
//  DefaultButtonsTableViewCell.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import UIKit

protocol DefaultsButtonCellDelegate: class {
	func tappedSetDefault()
	func tappedResetDefault()
}

class DefaultButtonsTableViewCell: UITableViewCell {
	static let reuseID = "defaultButtons"
	weak var delegate: DefaultsButtonCellDelegate?
	
	@IBOutlet weak var setDefaultButton: UIButton!
	@IBOutlet weak var resetDefaultButton: UIButton!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setDefaultButton.layer.cornerRadius = 5
		resetDefaultButton.layer.cornerRadius = 5
	}
	
	@IBAction func setDefaultButtonTapped(_ sender: UIButton) {
		sender.setTitle("Default Set Successfully!", for: .normal)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			sender.setTitle("Set Default", for: .normal)
		}
		
		delegate?.tappedSetDefault()
	}
	
	@IBAction func resetDefaultButtonTapped(_ sender: UIButton) {
		sender.setTitle("Reset Successful!", for: .normal)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			sender.setTitle("Reset Defaults", for: .normal)
		}
		
		delegate?.tappedResetDefault()
	}
}

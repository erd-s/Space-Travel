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
		sender.setTitle("success", for: .normal)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
			sender.setTitle("set default", for: .normal)
		}
		
		delegate?.tappedSetDefault()
	}
	
	@IBAction func resetDefaultButtonTapped(_ sender: UIButton) {
		sender.setTitle("success", for: .normal)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
			sender.setTitle("reset defaults", for: .normal)
		}
		
		delegate?.tappedResetDefault()
	}
}

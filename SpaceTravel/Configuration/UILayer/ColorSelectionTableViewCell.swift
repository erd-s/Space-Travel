//
//  ColorSelectionTableViewCell.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import UIKit

protocol ColorSelectionDelegate: class {
	func didUpdateColor(_ color: UIColor, sender: ColorSelectionTableViewCell)
}

class ColorSelectionTableViewCell: UITableViewCell {
	static let reuseID = "colorSelection"
	weak var delegate: ColorSelectionDelegate?

	@IBOutlet weak var headerLabel: ConfigHeaderLabel!
	@IBOutlet weak var colorView: UIView!
	
	@IBOutlet weak var redSlider: UISlider!
	@IBOutlet weak var greenSlider: UISlider!
	@IBOutlet weak var blueSlider: UISlider!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupForSliders()
	}
	
	func configure(headerText: String, delegate: ColorSelectionDelegate?) {
		self.headerLabel.text = headerText
		self.delegate = delegate
	}
	
	func setupForSliders() {
		redSlider.minimumValue = 1
		redSlider.maximumValue = 255
		greenSlider.minimumValue = 1
		greenSlider.maximumValue = 255
		blueSlider.minimumValue = 1
		blueSlider.maximumValue = 255
	}
	
	@IBAction func sliderValueChanged(_ sender: UISlider) {
		let r = 1 / CGFloat(redSlider.value)
		let g = 1 / CGFloat(greenSlider.value)
		let b = 1 / CGFloat(blueSlider.value)
		
		let color = UIColor(red: r,
							green: g,
							blue: b,
							alpha: 1)
		
		colorView.backgroundColor = color
		delegate?.didUpdateColor(color, sender: self)
	}
}

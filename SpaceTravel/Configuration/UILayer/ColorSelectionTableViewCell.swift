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
		setup()
	}
	
	func configure(headerText: String, delegate: ColorSelectionDelegate?, color: UIColor) {
		self.headerLabel.text = headerText
		self.delegate = delegate
		
		self.colorView.backgroundColor = color
		
		self.redSlider.value = Float(color.components.red * 255)
		self.blueSlider.value = Float(color.components.blue * 255)
		self.greenSlider.value = Float(color.components.green * 255)
	}
	
	func setup() {
		redSlider.minimumValue = 1
		redSlider.maximumValue = 255
		greenSlider.minimumValue = 1
		greenSlider.maximumValue = 255
		blueSlider.minimumValue = 1
		blueSlider.maximumValue = 255
		
		colorView.layer.borderColor = UIColor.black.cgColor.copy(alpha: 0.5)
		colorView.layer.borderWidth = 0.5
	}
	
	@IBAction func sliderValueChanged(_ sender: UISlider) {
		let r = CGFloat(redSlider.value) / 255
		let g = CGFloat(greenSlider.value) / 255
		let b = CGFloat(blueSlider.value) / 255
		
		let color = UIColor(red: r,
							green: g,
							blue: b,
							alpha: 1)
		
		colorView.backgroundColor = color
		delegate?.didUpdateColor(color, sender: self)
	}
}

//
//  SingleSliderTableViewCell.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import UIKit

protocol SingleSliderSelectionDelegate: class {
	func sliderDidUpdateValue(_ value: Float, sender: SingleSliderTableViewCell)
}

class SingleSliderTableViewCell: UITableViewCell {
	static let reuseID = "singleSlider"
	weak var delegate: SingleSliderSelectionDelegate?
	var sliderIncrementValue: Int = 1
	
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var slider: UISlider!
	
	func configure(headerText: String, sliderConfig: SliderConfig, delegate: SingleSliderSelectionDelegate?) {
		slider.maximumValue = sliderConfig.max
		slider.minimumValue = sliderConfig.min
		slider.value = sliderConfig.value
		sliderIncrementValue = sliderConfig.increment
		
		headerLabel.text = headerText
		
		self.delegate = delegate
	}
	
	@IBAction func sliderValueChanged(_ sender: UISlider) {
		let rounded = sender.value.roundToNearest(sliderIncrementValue)
		sender.value = rounded
		print("roundedvalue = \(sender.value)")
		delegate?.sliderDidUpdateValue(rounded, sender: self)
	}
}

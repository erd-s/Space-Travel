//
//  SingleSliderTableViewCell.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import UIKit

protocol SingleSliderSelectionDelegate: class {
	func sliderDidUpdateValue(_ value: Float)
}

class SingleSliderTableViewCell: UITableViewCell {
	static let reuseID = "singleSlider"
	weak var delegate: SingleSliderSelectionDelegate?
	
	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var slider: UISlider!
	
	
	func configure(headerText: String, sliderConfig: SliderConfig, delegate: SingleSliderSelectionDelegate) {
		
		slider.maximumValue = sliderConfig.max
		slider.minimumValue = sliderConfig.min
		slider.value = sliderConfig.value
		
		
		self.delegate = delegate
	}
	
	@IBAction func sliderValueChanged(_ sender: UISlider) {
		delegate?.sliderDidUpdateValue(sender.value)
	}
}

//
//  UIColor+Components.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	var coreImageColor: CIColor {
		return CIColor(color: self)
	}
	
	var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		let coreImageColor = self.coreImageColor
		return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
	}
}

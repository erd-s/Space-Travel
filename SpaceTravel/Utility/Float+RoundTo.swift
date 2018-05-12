//
//  Float+RoundTo.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import Foundation

extension Float {
	func roundToNearest(_ value: Int) -> Float {
		return Float(lroundf(self / Float(value)) * value)
	}
}

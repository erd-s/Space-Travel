//
//  Config.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import Foundation
import UIKit

class Config {
	var asteroidColor: UIColor = .white
	var backgroundColor: UIColor = .black
	var animationDuration: Double = 3
	var asteroidMaxSize: CGFloat = 6
	var maxNumberOfAsteroids: Int = 1000
	
	static func getAsteroidSizeMinMax() -> (min: Float, max: Float) {
		return (0, 12)
	}

	static func getNumberMinMax() -> (min: Float, max: Float) {
		return (100, 10000)
	}
	
	static func getDurationMinMax() -> (min: Float, max: Float) {
		return (1, 10)
	}
}

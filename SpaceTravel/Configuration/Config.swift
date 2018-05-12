//
//  Config.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import Foundation
import UIKit

struct Config {
	let asteroidColor: UIColor = .white
	let backgroundColor: UIColor = .black
	let animationDuration: Double = 3
	let asteroidSize: (min: CGFloat, max: CGFloat) = (0, 6)
	let maxNumberOfAsteroids: Int = 1000
}

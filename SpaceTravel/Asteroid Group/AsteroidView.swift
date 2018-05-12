//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 Christopher Erdos. All rights reserved.

import UIKit

struct Asteroid {
	let radius: CGFloat
	let position: CGPoint
}

class AsteroidView: UIView {
	var readyToReanimate = false
	
	init(asteroid: Asteroid, color: UIColor) {
		let asteroidFrame = CGRect(x: asteroid.position.x,
								   y: asteroid.position.y,
								   width: asteroid.radius,
								   height: asteroid.radius)
		super.init(frame: asteroidFrame)
		configuration(color: color)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configuration(color: backgroundColor)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configuration(color: backgroundColor)
	}

	private func configuration(color: UIColor?) {
		backgroundColor = color
		layer.opacity = 0
		layer.cornerRadius = frame.width / 2
		isUserInteractionEnabled = false
	}
}

//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 Christopher Erdos. All rights reserved.

import UIKit

struct Asteroid {
	let radius: CGFloat
	let position: CGPoint
}

class AsteroidView: UIView {
	var readyToReanimate = false
	
	init(asteroid: Asteroid) {
		let asteroidFrame = CGRect(x: asteroid.position.x,
								   y: asteroid.position.y,
								   width: asteroid.radius,
								   height: asteroid.radius)
		super.init(frame: asteroidFrame)
		configuration()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configuration()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configuration()
	}

	private func configuration() {
		backgroundColor = .white
		layer.opacity = 0
		layer.cornerRadius = frame.width / 2
		isUserInteractionEnabled = false
	}
}

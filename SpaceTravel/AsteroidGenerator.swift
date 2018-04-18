//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 GPShopper. All rights reserved.

import Foundation
import UIKit

struct AsteroidGenerator {
	
	static func createAsteroidViews(number: Int) -> [AsteroidView] {
		let asteroids = createRandomAsteroids(number: number)
		var asteroidViews: [AsteroidView] = []
		
		asteroids.forEach { asteroid in
		    let asteroidFrame = CGRect(x: asteroid.position.x,
									   y: asteroid.position.y,
									   width: asteroid.radius,
									   height: asteroid.radius)
		    let asteroidView = AsteroidView(frame: asteroidFrame)
			asteroidViews.append(asteroidView)
		}
		
		return asteroidViews
	}
	
	private static func createRandomAsteroids(number: Int) -> [Asteroid] {
		var asteroids: [Asteroid] = []
		for _ in 0...number {
			let position = CGPoint(x: UIScreen.main.bounds.midX,
									  y: UIScreen.main.bounds.midY)
		
			let randomRadius: CGFloat = CGFloat(arc4random_uniform(500)) / 100.0
		
			let asteroid = Asteroid(radius: randomRadius, position: position)
			asteroids.append(asteroid)
		}
		
		return asteroids
	}
}

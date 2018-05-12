//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 Christopher Erdos. All rights reserved.

import Foundation
import UIKit

struct AsteroidGenerator {
	
	static func createAsteroidViews(number: Int, color: UIColor, maxSize: CGFloat) -> [AsteroidView] {
		let asteroids = createRandomAsteroids(number: number, maxSize: maxSize)
		var asteroidViews: [AsteroidView] = []
		
		asteroids.forEach { asteroid in
			let asteroidView = AsteroidView(asteroid: asteroid, color: color)
			asteroidViews.append(asteroidView)
		}
		
		return asteroidViews
	}
	
	private static func createRandomAsteroids(number: Int, maxSize: CGFloat) -> [Asteroid] {
		var asteroids: [Asteroid] = []
		for _ in 0...number {
			let position = CGPoint(x: UIScreen.main.bounds.midX,
									  y: UIScreen.main.bounds.midY)
		
			let randomRadius: CGFloat = CGFloat(arc4random_uniform(UInt32(maxSize) * 1000)) / 1000.0
		
			let asteroid = Asteroid(radius: randomRadius, position: position)
			asteroids.append(asteroid)
		}
		
		return asteroids
	}
}

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

		while asteroids.count < number {
			let position = CGPoint(x: UIScreen.main.bounds.midX,
									  y: UIScreen.main.bounds.midY)
			let granularity: Int = 1000
			let randomMaxWithGranularity: Int = Int(maxSize) * granularity
			let randomRadiusBy1000: Int = Int.random(in: 0...randomMaxWithGranularity)
			let randomRadius: CGFloat = CGFloat(integerLiteral: randomRadiusBy1000 / granularity)
		
			let asteroid = Asteroid(radius: randomRadius, position: position)
			asteroids.append(asteroid)
		}
		
		return asteroids
	}
}

//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 GPShopper. All rights reserved.

import UIKit

class ViewController: UIViewController {
	let animationDuration: Double = 3
	var maxNumberOfStars: Int = 1000
	var reuseAsteroidViews: [AsteroidView] = []
	var asteroidViewsAnimationIndex: Int = 0
	var shouldContinueCreatingAsteroids: Bool {
		return reuseAsteroidViews.count < maxNumberOfStars
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		startAddingAsteroids(number: 2)
	}
	
	func startAddingAsteroids(number: Int) {
		let msFor60fps: Int = 17
		RefreshTimer.shared.executeEvery(milliseconds: msFor60fps) {
			if self.shouldContinueCreatingAsteroids {
				self.createAsteroids(number: number)
			} else {
				self.restartAnimationOnAsteroids(number: number)
			}
		}
	}
	
	func restartAnimationOnAsteroids(number: Int) {
		let startIndex = self.asteroidViewsAnimationIndex
		let endIndex = startIndex + number - 1
		let range = startIndex...endIndex
		var viewsToAnimate: [AsteroidView] = []
		
		for viewIndex in range {
			let viewToAnimate = reuseAsteroidViews[viewIndex]
			if viewToAnimate.readyToReanimate {
				viewsToAnimate.append(viewToAnimate)
			}
		}
		
		animateAsteroidsOut(asteroidViews: viewsToAnimate)
		asteroidViewsAnimationIndex += number
		
		if asteroidViewsAnimationIndex >= maxNumberOfStars {
			asteroidViewsAnimationIndex = 0
		}
	}
	
	func createAsteroids(number: Int) {
		let asteroidViews = AsteroidGenerator.createAsteroidViews(number: number)
		asteroidViews.forEach {
			self.view.addSubview($0)
			self.reuseAsteroidViews.append($0)
		}
		self.animateAsteroidsOut(asteroidViews: asteroidViews)
	}

	func animateAsteroidsOut(asteroidViews: [AsteroidView]?) {
		asteroidViews?.forEach { asteroid in
			AsteroidAnimator.shared.animateAstroidOffScreen(asteroidView: asteroid, duration: animationDuration)
		}
	}
}

//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 GPShopper. All rights reserved.

import UIKit

class ViewController: UIViewController {
	let animationDuration: Double = 1
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		startAddingAsteroids(number: 2)
	}
	
	func startAddingAsteroids(number: Int) {
		let oneSecondInNanoseconds = 1_000_000_000
		RefreshTimer.shared.executeEvery(nanoseconds: oneSecondInNanoseconds) {
			self.addAsteroids(number: number)
		}
	}
	
	func addAsteroids(number: Int) {
		let asteroidViews = AsteroidGenerator.createAsteroidViews(number: number)
		asteroidViews.forEach {
			self.view.addSubview($0)
		}
		self.animateAsteroidsOut(asteroidViews: asteroidViews)
	}

	func animateAsteroidsOut(asteroidViews: [AsteroidView]?) {
		asteroidViews?.forEach { asteroid in
			AsteroidAnimator.animateAstroidOffScreen(asteroidView: asteroid, duration: animationDuration) {
				DispatchQueue.main.async {
					asteroid.removeFromSuperview()
				}
			}
		}
	}
}

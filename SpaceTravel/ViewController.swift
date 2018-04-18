//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 GPShopper. All rights reserved.

import UIKit

class ViewController: UIViewController {
	let animationDuration: Double = 50
	
	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .black
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		RefreshTimer.shared.executeEvery(nanoseconds: 1000000000) {
			self.addAsteroids(number: 3)
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
				self.clearOut(asteroidViews: asteroidViews)
			}
		}
	}
	
	func clearOut(asteroidViews: [AsteroidView]?) {
		DispatchQueue.main.async {
			asteroidViews?.forEach {
				$0.removeFromSuperview()
			}
		}
	}
}

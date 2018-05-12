//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 Christopher Erdos. All rights reserved.

import UIKit

class AsteroidViewController: UIViewController {
	let animationDuration: Double = 3
	var reuseAsteroidViews: [AsteroidView] = []
	var asteroidViewsAnimationIndex: Int = 0
	var shouldContinueCreatingAsteroids: Bool {
		return reuseAsteroidViews.count < config.maxNumberOfAsteroids
	}
	var config = Config()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		addLongPressToOpenConfig()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let msFor60fps: Int = 17
		startAddAsteroidTimerAdding(numberOfAsteroids: 2, every: msFor60fps)
		UIView.animate(withDuration: 0.3) {
			self.view.backgroundColor = self.config.backgroundColor
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		reset()
	}
	
	func startAddAsteroidTimerAdding(numberOfAsteroids number: Int, every ms: Int) {
		RefreshTimer.shared.executeEvery(ms: ms) {
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
		
		if asteroidViewsAnimationIndex >= config.maxNumberOfAsteroids {
			asteroidViewsAnimationIndex = 0
		}
	}
	
	func createAsteroids(number: Int) {
		let asteroidViews = AsteroidGenerator.createAsteroidViews(number: number,
																  color: config.asteroidColor,
																  maxSize: config.asteroidMaxSize)
		asteroidViews.forEach {
			self.view.addSubview($0)
			self.reuseAsteroidViews.append($0)
		}
		self.animateAsteroidsOut(asteroidViews: asteroidViews)
	}

	func animateAsteroidsOut(asteroidViews: [AsteroidView]?) {
		asteroidViews?.forEach { asteroid in
			AsteroidAnimator.shared.animateAstroidOffScreen(asteroidView: asteroid,
															duration: animationDuration)
		}
	}
	
	func reset() {
		RefreshTimer.shared.stopAllExecutions()
		reuseAsteroidViews.removeAll()
		asteroidViewsAnimationIndex = 0
	}
}

//MARK: Configuration
extension AsteroidViewController: ConfigViewControllerDelegate, UIGestureRecognizerDelegate {
	func addLongPressToOpenConfig() {
		let longPress = UILongPressGestureRecognizer(target: self, action: #selector(openConfig))
		longPress.delegate = self
		view.addGestureRecognizer(longPress)
	}
		
	@objc func openConfig() {
		performSegue(withIdentifier: "openConfig", sender: self)
	}
	
	func didSaveConfig(_ config: Config) {
		self.config = config
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let navController = segue.destination as? UINavigationController,
			let dvc = navController.topViewController as? ConfigViewController {
			dvc.config = self.config
			dvc.delegate = self
		}
	}
}

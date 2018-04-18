//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 GPShopper. All rights reserved.

import Foundation
import UIKit

struct AsteroidAnimator {
	static func animateAstroidOffScreen(asteroidView: AsteroidView, duration animationDuration: Double, completion: @escaping ()->()) {
		
		let direction = getDirectionFromCenter()

		let warpOutAnimation = CABasicAnimation(keyPath: "transform")
		let identity = asteroidView.layer.transform
		warpOutAnimation.fromValue = identity
		
		let warpOutTranslation = CATransform3DMakeTranslation(direction.dx * 15, direction.dy * 15, 1)
		warpOutAnimation.toValue = warpOutTranslation
		
		warpOutAnimation.duration = animationDuration
		asteroidView.layer.add(warpOutAnimation, forKey: "warpAnimation")
		asteroidView.layer.transform = warpOutTranslation
		
		UIView.animate(withDuration: animationDuration / 15) {
			asteroidView.alpha = 1
		}
		
		DispatchQueue.global().asyncAfter(deadline: .now() + animationDuration) {
			completion()
		}
	}
	
	//MARK: - Update Coordinates
	private static func getDirectionFromCenter() -> CGVector {
		let isNegativeX = NSNumber(value: arc4random_uniform(1)).boolValue
		let isNegativeY = NSNumber(value: arc4random_uniform(1)).boolValue
		var randomX: CGFloat = CGFloat(arc4random_uniform(1000))
		var randomY: CGFloat = CGFloat(arc4random_uniform(1000))
		if isNegativeX {
			randomX = randomX * -1
		}
		
		if isNegativeY {
			randomY = randomY * -1
		}
		
		let randomPosition = CGPoint(x: randomX, y: randomY)
		
		let startingPoint = CGPoint(x: UIScreen.main.bounds.width / 2,
									y: UIScreen.main.bounds.height / 2)
		
		let dx = randomPosition.x - startingPoint.x
		let dy = randomPosition.y - startingPoint.y
		return CGVector(dx: dx, dy: dy)
	}
}

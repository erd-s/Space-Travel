//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 GPShopper. All rights reserved.

import Foundation
import UIKit

struct AsteroidAnimator {
	static func animateAstroidOffScreen(asteroidView: AsteroidView, duration animationDuration: Double, completion: @escaping ()->()) {
		
		let direction = getDirectionFromCenter()

		let warpOutAnimation = CABasicAnimation(keyPath: "transform")
		warpOutAnimation.fromValue = asteroidView.layer.transform
		let endTransform = CATransform3DMakeTranslation(direction.dx * 1.1,
														direction.dy * 1.1,
														1)
		warpOutAnimation.toValue = endTransform
		
		warpOutAnimation.duration = animationDuration
		asteroidView.layer.add(warpOutAnimation, forKey: "warpAnimation")
		asteroidView.layer.transform = endTransform
		
		UIView.animate(withDuration: animationDuration / 2) {
			asteroidView.alpha = 1
		}
		
		DispatchQueue.global().asyncAfter(deadline: .now() + animationDuration) {
			completion()
		}
	}
	
	//MARK: - Update Coordinates
	private static func getDirectionFromCenter() -> CGVector {
		let isNegativeX = arc4random_uniform(1) == 1 ? true : false
		let isNegativeY = arc4random_uniform(1) == 1 ? true : false

		var randomX: CGFloat = CGFloat(arc4random_uniform(ScreenConstants.shared.screenWidthUInt32))
		var randomY: CGFloat = CGFloat(arc4random_uniform(ScreenConstants.shared.screenHeightUInt32))
		
		if isNegativeX {
			randomX = randomX * -1
		}
		
		if isNegativeY {
			randomY = randomY * -1
		}
		
		let randomPosition = CGPoint(x: randomX, y: randomY)
		
		let dx = randomPosition.x - ScreenConstants.shared.screenCenter.x
		let dy = randomPosition.y - ScreenConstants.shared.screenCenter.y
		return CGVector(dx: dx, dy: dy)
	}
}

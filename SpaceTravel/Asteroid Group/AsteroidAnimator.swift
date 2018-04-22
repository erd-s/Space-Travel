//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 Christopher Erdos. All rights reserved.

import Foundation
import UIKit

class AsteroidAnimator: NSObject {
	static let shared = AsteroidAnimator()
	
	func animateAstroidOffScreen(asteroidView: AsteroidView, duration animationDuration: Double) {
		asteroidView.readyToReanimate = false
		
		let animationGroup = CAAnimationGroup()

		//warp out translation animation
		let warpOutAnimation = CABasicAnimation(keyPath: "transform")
		let identityTransform = asteroidView.layer.transform
		
		warpOutAnimation.fromValue = identityTransform
		let direction = getDirectionFromCenter()
		let endTransform = CATransform3DMakeTranslation(direction.dx * CGFloat(animationDuration),
														direction.dy * CGFloat(animationDuration),
														1)
		warpOutAnimation.toValue = endTransform
		warpOutAnimation.duration = animationDuration
		asteroidView.layer.transform = identityTransform
		asteroidView.layer.opacity = 1
		
		//alpha translation animation
		let opacityAnimation = CABasicAnimation(keyPath: "opacity")
		opacityAnimation.fromValue = 0.0
		opacityAnimation.toValue = 1
		opacityAnimation.duration = animationDuration / 1.25
		asteroidView.layer.opacity = 0.0
		
		animationGroup.animations = [warpOutAnimation, opacityAnimation]
		animationGroup.isRemovedOnCompletion = true
		animationGroup.duration = animationDuration
		
		asteroidView.layer.add(animationGroup, forKey: "warpAnimation")
		
		DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
			asteroidView.readyToReanimate = true
		}
	}
	
	//MARK: - Update Coordinates
	private func getDirectionFromCenter() -> CGVector {
		let randomPosition = generateRandomNonCenterPoint()
		
		let dx = randomPosition.x - ScreenConstants.shared.screenCenter.x
		let dy = randomPosition.y - ScreenConstants.shared.screenCenter.y
		return CGVector(dx: dx, dy: dy)
	}
	
	private func generateRandomNonCenterPoint() -> CGPoint {
		let shouldInvertX = arc4random_uniform(1) == 1 ? true : false
		let shouldInvertY = arc4random_uniform(1) == 1 ? true : false
		
		var randomX: CGFloat = CGFloat(arc4random_uniform(ScreenConstants.shared.screenWidthUInt32))
		var randomY: CGFloat = CGFloat(arc4random_uniform(ScreenConstants.shared.screenHeightUInt32))
		
		
		if shouldInvertX {
			randomX = randomX * -1
		}
		
		if shouldInvertY {
			randomY = randomY * -1
		}
		
		let randomPoint = CGPoint(x: randomX, y: randomY)
		
		guard randomPoint != ScreenConstants.shared.screenCenter else {
			return generateRandomNonCenterPoint()
		}
		
		return randomPoint
	}
}

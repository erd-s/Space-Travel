//
//  Defaults.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import Foundation
import UIKit

class Defaults {
	static let shared = Defaults()
	private let kMaxSize: String = "maxSize"
	private let kMaxNumber: String = "maxNumber"
	
	var config: Config {
		get {
			return getConfigFromDefaults()
		}
		set {
			setDefaultsFromConfig(newValue)
		}
	}
	
	private func getConfigFromDefaults() -> Config {
		let asteroidColorR: Float = UserDefaults.standard.float(forKey: getAsteroidColorKey(component: "r"))
		let asteroidColorG: Float = UserDefaults.standard.float(forKey: getAsteroidColorKey(component: "g"))
		let asteroidColorB: Float = UserDefaults.standard.float(forKey: getAsteroidColorKey(component: "b"))
		let asteroidColor = UIColor(red: CGFloat(asteroidColorR),
									green: CGFloat(asteroidColorG),
									blue: CGFloat(asteroidColorB),
									alpha: 1)
		
		let backgroundColorR: Float = UserDefaults.standard.float(forKey: getBackgroundColorKey(component: "r"))
		let backgroundColorG: Float = UserDefaults.standard.float(forKey: getBackgroundColorKey(component: "g"))
		let backgroundColorB: Float = UserDefaults.standard.float(forKey: getBackgroundColorKey(component: "b"))
		let backgroundColor = UIColor(red: CGFloat(backgroundColorR),
									green: CGFloat(backgroundColorG),
									blue: CGFloat(backgroundColorB),
									alpha: 1)
		
		let maxSize: CGFloat = CGFloat(UserDefaults.standard.float(forKey: kMaxSize))
		let maxNumber: Int = UserDefaults.standard.integer(forKey: kMaxNumber)
		
		let config = Config()
		config.asteroidColor = asteroidColor
		config.backgroundColor = backgroundColor
		config.asteroidMaxSize = maxSize
		config.maxNumberOfAsteroids = maxNumber
		return config
	}
	
	private func setDefaultsFromConfig(_ config: Config) {
		UserDefaults.standard.set(config.asteroidColor.components.red,
								  forKey: getAsteroidColorKey(component: "r"))
		UserDefaults.standard.set(config.asteroidColor.components.green,
								  forKey: getAsteroidColorKey(component: "g"))
		UserDefaults.standard.set(config.asteroidColor.components.blue,
								  forKey: getAsteroidColorKey(component: "b"))
		
		UserDefaults.standard.set(config.backgroundColor.components.red,
								  forKey: getBackgroundColorKey(component: "r"))
		UserDefaults.standard.set(config.backgroundColor.components.green,
								  forKey: getBackgroundColorKey(component: "g"))
		UserDefaults.standard.set(config.backgroundColor.components.blue,
								  forKey: getBackgroundColorKey(component: "b"))
		
		UserDefaults.standard.set(Float(config.asteroidMaxSize), forKey: kMaxSize)
		UserDefaults.standard.set(config.maxNumberOfAsteroids, forKey: kMaxNumber)
	}
	
	private func getAsteroidColorKey(component: String) -> String {
		return "asteroidColor_\(component)"
	}
	
	private func getBackgroundColorKey(component: String) -> String {
		return "backgroundColor_\(component)"
	}
	
}

private struct ColorParts {
	let r: Float
	let g: Float
	let b: Float
}

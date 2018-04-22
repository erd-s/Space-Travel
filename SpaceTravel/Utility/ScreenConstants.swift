//  Created by Chris Erdos on 4/19/18.
//  Copyright © 2018 Christopher Erdos. All rights reserved.

import Foundation
import UIKit

class ScreenConstants {
	static let shared = ScreenConstants()
	let screenWidth = UIScreen.main.bounds.width
	let screenHeight = UIScreen.main.bounds.height
	lazy var screenCenter: CGPoint = CGPoint(x: screenWidth / 2,
											 y: screenHeight / 2)
	
	lazy var screenWidthUInt32 = UInt32(screenWidth)
	lazy var screenHeightUInt32 = UInt32(screenHeight)
}

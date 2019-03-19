//  Created by Chris Erdos on 4/19/18.
//  Copyright © 2018 Christopher Erdos. All rights reserved.

import Foundation
import UIKit

enum Screen {
	static let width = UIScreen.main.bounds.width
	static let height = UIScreen.main.bounds.height
	static let center: CGPoint = CGPoint(x: UIScreen.main.bounds.midX,
											 y: UIScreen.main.bounds.midY)
}

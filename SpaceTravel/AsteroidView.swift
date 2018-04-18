//  Created by Chris Erdos on 4/18/18.
//  Copyright © 2018 GPShopper. All rights reserved.

import UIKit

class AsteroidView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
		configuration()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configuration()
	}
	
	private func configuration() {
		backgroundColor = .white
		alpha = 0.0
	}
}

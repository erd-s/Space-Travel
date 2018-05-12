//
//  ConfigHeaderLabel.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import UIKit

class ConfigHeaderLabel: UILabel {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		font = UIFont(name: "Menlo", size: 15)
		text = text?.lowercased()
	}
}

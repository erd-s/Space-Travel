//
//  ConfigViewController.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {
	var configDataSource: ConfigDataSource?
	var config: Config?
	
	@IBOutlet weak var configTableView: UITableView!
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
	}
	
	func setup() {
		guard let config = config else { return }
		configDataSource = ConfigDataSource(config: config, tableView: configTableView, delegate: self)
	}
}

extension ConfigViewController: ConfigDataSourceDelegate {
	func didUpdateConfig(config: Config) {
		self.config = config
	}
}

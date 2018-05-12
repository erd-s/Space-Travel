//
//  ConfigViewController.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import UIKit

protocol ConfigViewControllerDelegate: class {
	func didSaveConfig(_ config: Config)
}

class ConfigViewController: UIViewController {
	var config: Config?
	var dataSource: ConfigDataSource?
	weak var delegate: ConfigViewControllerDelegate?
	
	@IBOutlet weak var configTableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
	}
	
	func setup() {
		guard let config = config else { return }
		dataSource = ConfigDataSource(config: config, tableView: configTableView, delegate: self)
		configTableView.dataSource = dataSource
		configTableView.tableFooterView = UIView()
		configTableView.reloadData()
	}
	
	//MARK: - Actions	
	@IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
		exitConfig()
	}
	
	@IBAction func saveButtonTapped(_ sender: UIButton) {
		if let config = config {
			delegate?.didSaveConfig(config)
		}
		
		exitConfig()
	}
	
	func exitConfig() {
		dismiss(animated: true, completion: nil)
	}
}

extension ConfigViewController: ConfigDataSourceDelegate {
	func didUpdateConfig(config: Config) {
		self.config = config
	}
}

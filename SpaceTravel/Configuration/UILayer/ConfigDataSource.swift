//
//  ConfigDataSource.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigDataSourceDelegate: class {
	func didUpdateConfig(config: Config)
}

class ConfigDataSource: NSObject, UITableViewDataSource {
	weak var delegate: ConfigDataSourceDelegate?
	unowned let tableView: UITableView
	var config: Config
	
	init(config: Config, tableView: UITableView, delegate: ConfigDataSourceDelegate?) {
		self.config = config
		self.delegate = delegate
		self.tableView = tableView
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return Section.all().count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
		
		switch section {
		case .asteroidColor:
			return configureForColor(tableView: tableView, section: section, color: config.asteroidColor)
		case .backgroundColor:
			return configureForColor(tableView: tableView, section: section, color: config.backgroundColor)
		case .size, .number:
			return configureForSingleSlider(tableView: tableView, section: section)
		case .defaults:
			return configureForDefaultsButtons(tableView: tableView)
		}
	}
	
	
	private func configureForColor(tableView: UITableView, section: Section, color: UIColor) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ColorSelectionTableViewCell.reuseID) as! ColorSelectionTableViewCell
		
		cell.configure(headerText: section.getHeader(), delegate: self, color: color)
		
		return cell
	}
	
	private func configureForSingleSlider(tableView: UITableView, section: Section) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: SingleSliderTableViewCell.reuseID) as! SingleSliderTableViewCell
		
		if let sliderConfig = getConfigForSingleSliderSection(section: section) {
			cell.configure(headerText: section.getHeader(), sliderConfig: sliderConfig, delegate: self)
		}
		
		return cell
	}
	
	private func configureForDefaultsButtons(tableView: UITableView) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DefaultButtonsTableViewCell.reuseID) as! DefaultButtonsTableViewCell
		cell.delegate = self
		return cell
	}
	
	private func getConfigForSingleSliderSection(section: Section) -> SliderConfig? {
		switch section {
		case .size:
			return SliderConfig(min: Config.getAsteroidSizeMinMax().min,
								max: Config.getAsteroidSizeMinMax().max,
								increment: 1,
								value: Float(config.asteroidMaxSize))
		case .number:
			return SliderConfig(min: Config.getNumberMinMax().min,
								max: Config.getNumberMinMax().max,
								increment: 500,
								value: Float(config.maxNumberOfAsteroids))
		default:
			assertionFailure("should not be hitting default if section != above")
		}
		
		return nil
	}
	
	
}

extension ConfigDataSource: ColorSelectionDelegate, SingleSliderSelectionDelegate, DefaultsButtonCellDelegate {
	func tappedSetDefault() {
		Defaults.shared.config = self.config
	}
	
	func tappedResetDefault() {
		self.config = Config()
		tableView.reloadData()
		Defaults.shared.config = Config()
	}
	
	func sliderDidUpdateValue(_ value: Float, sender: SingleSliderTableViewCell) {
		guard let indexPathSection = tableView.indexPath(for: sender)?.section,
			let section = Section(rawValue: indexPathSection) else {
				return
		}
		
		switch section {
		case .size:
			config.asteroidMaxSize = CGFloat(value)
		case .number:
			config.maxNumberOfAsteroids = Int(value)
		default: return
		}
		
		delegate?.didUpdateConfig(config: config)
	}
	
	func didUpdateColor(_ color: UIColor, sender: ColorSelectionTableViewCell) {
		guard let indexPathSection = tableView.indexPath(for: sender)?.section,
			let section = Section(rawValue: indexPathSection) else {
			return
		}
		
		if section == .asteroidColor {
			config.asteroidColor = color
		} else if section == .backgroundColor {
			config.backgroundColor = color
		}
		
		delegate?.didUpdateConfig(config: config)
	}
}

private enum Section: Int {
	case asteroidColor
	case backgroundColor
	case size
	case number
	case defaults
	
	init?(header: String) {
		for section in Section.all() {
			if section.getHeader() == header {
				self = section
			}
		}
		
		return nil
	}
	
	func getHeader() -> String {
		switch self {
		case .asteroidColor:
			return "asteroid color"
		case .backgroundColor:
			return "background color"
		case .size:
			return "size"
		case .number:
			return "max number (may affect performance)"
		default:
			return ""
		}
	}
	
	static func all() -> [Section] {
		return [.asteroidColor,
				.backgroundColor,
				.size,
				.number,
				.defaults]
	}
}

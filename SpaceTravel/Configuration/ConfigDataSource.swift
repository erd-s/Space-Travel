//
//  ConfigDataSource.swift
//  SpaceTravel
//
//  Created by Christopher Erdos on 5/12/18.
//  Copyright © 2018 Erdos. All rights reserved.
//

import Foundation
import UIKit


private enum Sections: Int {
	case asteroidColor
	case backgroundColor
	case duration
	case size
	case number
	
	static func all() -> [Sections] {
		return [.asteroidColor,
				.backgroundColor,
				.duration,
				.size,
				.number]
	}
}


class ConfigDataSource: NSObject, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return Sections.all().count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let section = Sections(rawValue: section) else { return 0 }
		
		switch section {
		case .asteroidColor, .backgroundColor:
			return 3
		case .duration, .size, .number:
			return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let section = Sections(rawValue: indexPath.section) else { return UITableViewCell() }
		
		switch section {
		case .asteroidColor,
			 .backgroundColor:
			return configureForColor(tableView: tableView, indexPath: indexPath)
		case .duration, .size, .number:
			return configureForSingleSlider(tableView: tableView, indexPath: indexPath)
		}
	}
	
	
	private func configureForColor(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ColorSelectionTableViewCell.reuseID) as! ColorSelectionTableViewCell
		
		
		return cell
	}
	
	private func configureForSingleSlider(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: SingleSliderTableViewCell.reuseID) as! SingleSliderTableViewCell
		
		return cell
	}
}

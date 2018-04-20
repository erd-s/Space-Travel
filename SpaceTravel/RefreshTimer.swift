//  Created by Chris Erdos on 4/17/18.
//  Copyright © 2018 GPShopper. All rights reserved.

import Foundation


class RefreshTimer {
	static let shared = RefreshTimer()
	private var shouldStopExecutions: Bool = false {
		didSet {
			if shouldStopExecutions {
				self.killTimer()
			}
		}
	}
	private var timer: DispatchSourceTimer?
	
	init() {
		makeTimerIfNecessary()
	}
	
	//MARK - Scheduler
	func executeEvery(nanoseconds: Int, work: @escaping ()->()) {
		makeTimerIfNecessary()
		timer?.setEventHandler(qos: .userInitiated, flags: []) {
			work()
		}
		timer?.schedule(deadline: .now(),
						repeating: DispatchTimeInterval.milliseconds(16),
						leeway: DispatchTimeInterval.milliseconds(5))
		
		timer?.resume()
	}
	
	func stopAllExecutions() {
		shouldStopExecutions = true
	}
	
	//MARK: - Timer
	func makeTimerIfNecessary() {
		if timer == nil {
			timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
		}
	}
	
	private func killTimer() {
		timer?.cancel()
		timer = nil
	}
}

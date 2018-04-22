//  Created by Chris Erdos on 4/17/18.
//  Copyright © 2018 Christopher Erdos. All rights reserved.

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
		resetConfiguration()
	}
	
	//MARK - Scheduler
	func executeEvery(ms: Int, work: @escaping ()->()) {
		resetConfiguration()
		timer?.setEventHandler(qos: .userInitiated, flags: []) {
			guard self.shouldStopExecutions == false else {
				self.killTimer()
				return
			}
			work()
		}
		timer?.schedule(deadline: .now(),
						repeating: DispatchTimeInterval.milliseconds(ms),
						leeway: DispatchTimeInterval.milliseconds(ms/3))
		
		timer?.resume()
	}
	
	func stopAllExecutions() {
		shouldStopExecutions = true
	}
	
	//MARK: - Timer
	func resetConfiguration() {
		if timer == nil {
			timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
		}
		shouldStopExecutions = false
	}
	
	private func killTimer() {
		timer?.cancel()
		timer = nil
	}
}

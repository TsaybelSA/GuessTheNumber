//
//  HintsControl.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 19.08.2022.
//

import Foundation

struct HintsControl {
		
	private(set) var showHintBeforeStart = true
	
	mutating func toggleHintBeforeStart() {
		showHintBeforeStart.toggle()
		saveToUserDefaults()
	}
	
	private let userDefaults = UserDefaults.standard
	
	private let key = "showHintBeforeStart"
	
	private mutating func saveToUserDefaults() {
		userDefaults.set(showHintBeforeStart, forKey: key)
		print("saved")
	}
	
	init() {
		if let value = userDefaults.value(forKey: key), let value = value as? Bool {
			showHintBeforeStart = value
			print("Loaded From user defaults \(showHintBeforeStart)")
			return
		} else {
			print("Failed to load From UserDefaults")
			showHintBeforeStart = true
		}
	}
}

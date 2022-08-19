//
//  ComparisonButton.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 18.08.2022.
//

import Foundation

struct ComparisonButton {
	let conditionMark: String
	let id: Int
	
	static let buttons = [ComparisonButton(conditionMark: ">", id: 0),
						  ComparisonButton(conditionMark: "=", id: 1),
						  ComparisonButton(conditionMark: "<", id: 2)
						  ]
}

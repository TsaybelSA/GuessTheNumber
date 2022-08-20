//
//  Constants.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 18.08.2022.
//

import Foundation
import UIKit

struct K {
	struct DrawingConstants {
		static let buttonHeight = 50.0
		static let buttonWidth = 250.0
		
		static let questionmarkButtonHeight = 100.0
		static let questionmarkButtonWidth = 100.0
	}
	
	struct Colors {
		static let appBackgroundColor = UIColor(named: "backgroundColor")
		static let appButtonsColor = UIColor(named: "buttonsColor")
		static let secondaryBackgroundColor = UIColor(named: "secondaryBackgroundColor")
		static let secondaryButtonColor = UIColor(named: "secondaryButtonColor")
		static let computerTextColor = UIColor(named: "computerTextColor")
		static let extraColorForButton = UIColor(named: "extraColorForButton")
	}
	
	struct TableViewsCell {
		static let difficultyCell = "difficultyCell"
	}
	
	struct Hints {
		static let computerGuess = "In this round, the computer will guess your number, and you need to give hints to the computer by pressing the buttons greater than, less than or equal to."
		static let userGuess = "In this round, you need to guess number that computer created. Choose number that you think it can be and tap 'EnterTheNumber'."
		static let difficultySelection = """
			Easy - the computer will randomly select numbers from the list of remaining ones, according to your answers. Also, when you guessing the number, you will be offered answers taking into account the logical conditions of the computer's answer (the hidden number is greater or less).
			Medium - computer will guess your number using binary search. The answer options offered when you guessing the number still take into account the answers of the computer (the hidden number is more or less).
			Hard - at this difficulty level, the computer will guess your number based on binary search. But in the round when you have to guess, you will need to remember which numbers you have already asked the computer and logically look for the right number.
			"""
	}
}

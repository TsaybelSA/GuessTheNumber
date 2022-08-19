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
	}
	
	struct Hints {
		static let computerGuess = "In this round, the computer will guess your number, and you need to give hints to the computer by pressing the buttons greater than, less than or equal to."
		static let userGuess = "In this round, you need to guess number that computer created. Choose number that you think it can be and tap 'EnterTheNumber'."
	}
	
	struct Colors {
		static let appBackgroundColor = UIColor(named: "appBackgroundColor")
		static let appButtonsColor = UIColor(named: "appButtonsColor")
	}
}

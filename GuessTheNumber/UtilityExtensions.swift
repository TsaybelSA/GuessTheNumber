//
//  UtilityExtensions.swift
//  GuessTheNumber
//
//  Created by Сергей Цайбель on 18.08.2022.
//

import UIKit

extension UIViewController {
	func setupToHideKeyboardOnTapOnView() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(
			target: self,
			action: #selector(UIViewController.dismissKeyboard))

		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}

	@objc func dismissKeyboard(){
		view.endEditing(true)
	}
}

extension UITextField{

 func addDoneButtonToKeyboard(myAction:Selector?){
	let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
	doneToolbar.barStyle = UIBarStyle.default

	 let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
	 let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: myAction)

	var items = [UIBarButtonItem]()
	items.append(flexSpace)
	items.append(done)

	doneToolbar.items = items
	doneToolbar.sizeToFit()

	self.inputAccessoryView = doneToolbar
 }
}


public func makeTextField() -> UITextField {
	let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
	textField.font = UIFont.preferredFont(forTextStyle: .title1)
	textField.textAlignment = .center
	textField.layer.cornerRadius = 10
	textField.layer.borderColor = UIColor.gray.cgColor
	textField.layer.borderWidth = 1
	textField.placeholder = "Guess the number"
	textField.keyboardType = .numberPad
	textField.enablesReturnKeyAutomatically = true
	return textField
}

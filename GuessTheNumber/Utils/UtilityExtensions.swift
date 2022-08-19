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

class PaddingLabel: UILabel {

	var topInset: CGFloat
	var bottomInset: CGFloat
	var leftInset: CGFloat
	var rightInset: CGFloat

	required init(withInsets top: CGFloat, _ bottom: CGFloat,_ left: CGFloat,_ right: CGFloat) {
		self.topInset = top
		self.bottomInset = bottom
		self.leftInset = left
		self.rightInset = right
		super.init(frame: CGRect.zero)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func drawText(in rect: CGRect) {
		let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
		super.drawText(in: rect.inset(by: insets))
	}

	override var intrinsicContentSize: CGSize {
		get {
			var contentSize = super.intrinsicContentSize
			contentSize.height += topInset + bottomInset
			contentSize.width += leftInset + rightInset
			return contentSize
		}
	}
}

extension UILabel {
	func makeTypeEffectFor(_ text: String) {
		self.text = ""
		for (index, letter) in text.enumerated() {
			Timer.scheduledTimer(withTimeInterval: 0.05 * Double(index), repeats: false) { [weak self] _ in
				self?.text?.append(letter)
			}
		}
	}
}

extension UIButton {
	func makeBorderedWithShadow(cornerRadius: CGFloat? = nil) {
		self.layer.masksToBounds = false
		self.layer.cornerRadius = cornerRadius ?? 10
		self.backgroundColor = K.Colors.appButtonsColor
		self.layer.borderColor = UIColor.clear.cgColor
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 0)
		self.layer.shadowOpacity = 0.2
		self.layer.shadowRadius = 8
	}
}

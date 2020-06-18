//
//  StackUI.swift
//  StackUI
//
//  Created by Lavergne, Marc on 6/4/20.
//  Copyright © 2020 Lavergne, Marc. All rights reserved.
//

import UIKit

// SwiftUI style alignment specifiers
enum UIAlignment: Int {
    case vertical
    case horizontal
    case bottom
    case leading
    case top
    case trailing
}

// Avoid subclassing since that would create new types and add
// friction to the piecemeal adoption strategy

// SwiftUI has a "chained method" style syntax that allows use to avoid
// most (not all) namespace collisions

// Be careful to avoid extension naming conventions that might collide
// we user specific use cases

// Persisting metadata does present challenges

// Solution?
// let foo = objc_getAssociatedObject(self, &AssociatedProperties.foo) as? String
// objc_setAssociatedObject(self, &AssociatedProperties.foo, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

// SwiftUI extensions on UIView
extension UIView {
    @discardableResult
    func background(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }

    @discardableResult
    func clipped() -> Self {
        self.clipsToBounds = true
        return self
    }

    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func frame(height: CGFloat = -1, width: CGFloat = -1) -> Self {
        var frame = self.frame
        if height >= 0 {
            frame.size.height = height
        }
        if width >= 0 {
            frame.size.width = width
        }
        self.frame = frame
        return self
    }
    
    @discardableResult
    func opacity(_ opacity: CGFloat) -> Self {
        self.opacity = opacity
    }
}

// SwiftUI extensions on UIButton padding
extension UIButton {
    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        self.titleLabel?.textColor = color
        return self
    }
}

// SwiftUI extensions on UIView padding
extension UIView {
    @discardableResult
    func padding(_ axis: UIAlignment, _ inset: CGFloat) -> Self {
        var insets = self.layoutMargins
        switch axis {
        case .horizontal:
            insets.right = inset
            insets.left = inset
        case .vertical:
            insets.top = inset
            insets.bottom = inset
        case .bottom:
            insets.bottom = inset
        case .leading:
            insets.left = inset
        case .top:
            insets.top = inset
        case .trailing:
            insets.right = inset
        }
        self.layoutMargins = insets
        return self
    }

    @discardableResult
    func padding(_ insets: UIEdgeInsets) -> Self {
        self.layoutMargins = insets
        return self
    }

    @discardableResult
    func padding(_ inset: CGFloat) -> Self {
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        self.layoutMargins = insets
        return self
    }

    @discardableResult
    func padding() -> Self {
        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.layoutMargins = insets
        return self
    }
}

// SwiftUI extensions on UITextView
extension UILabel {
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func font(_ style: UIFont.TextStyle) -> Self {
        self.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }

    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    func lineLimit(_ lines: Int) -> Self {
        self.numberOfLines = lines
        return self
    }
}

// SwiftUI extensions on UITextField
extension UITextField {
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
   
    @discardableResult
    func autocapitalization(_ type: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = type
        return self
    }

    @discardableResult
    func clears(_ clears: Bool) -> Self {
        self.clearsOnBeginEditing = clears
        return self
    }

    @discardableResult
    func clearButton(_ mode: UITextField.ViewMode) -> Self {
        self.clearButtonMode = mode
        return self
    }

    @discardableResult
    func disableAutocorrection(_ disable: Bool) -> Self {
        self.autocorrectionType = disable ? .no : .yes
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func font(_ style: UIFont.TextStyle) -> Self {
        self.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }

    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    func placeholderText(_ text: String) -> Self {
        self.placeholder = text
        return self
    }

    // SWiftUI avoids the setter/getter impl, change to secure(_ isSecure: Bool)
    var secure: Bool {
        get {
            self.isSecureTextEntry
        }
        set(secure) {
            self.isSecureTextEntry = secure
        }
    }

    @discardableResult
    func textFieldStyle(_ style: UITextField.BorderStyle) -> Self {
        self.borderStyle = style
        return self
    }
}

// SwiftUI extensions on UITextView
extension UITextView {
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func font(_ style: UIFont.TextStyle) -> Self {
        self.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }

    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    func lineLimit(_ lines: Int) -> Self {
        self.textContainer.maximumNumberOfLines = lines
        return self
    }
}

// SwiftUI extensions on UIStackView
extension UIStackView {
    // viewBuilder
    var views: [UIView] {
        get {
            self.arrangedSubviews
        }
        set(views) {
            views.forEach{ view in
                self.addArrangedSubview(view)
            }
        }
    }

    // remove this
    var add: UIView {
        get {
            self
        }
        set(view) {
            self.addArrangedSubview(view)
        }
    }
    
    // spacing -> view.distribution

    // alignment -> view.alignment
    // but alignement is already defined on UIStackView, need to persist the setting and
    // provide a close enough API
    // func align() -> Self {}
    
    // handle via willMove(toSuperview:)
    @discardableResult
    func constrain(_ alignment: UIAlignment, superview: UIView) -> Self {
        switch alignment {
        case .vertical:
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
        case .horizontal:
            self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
        case .leading:
            self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor).isActive = true
        case .top:
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor).isActive = true
        case .trailing:
            self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
        return self
    }
}

protocol ListController {
    @discardableResult
    func row(at: Int) -> UITableViewCell {
        
    }
    
    func selected(at: Int) {
    }
}

// SwiftUI support for action closures
class UIAction: NSObject {
    static var actions: [UIControl: () -> Void] = [:]

    static func register(_ control: UIControl, event: UIControl.Event, action: @escaping () -> Void) {
        Self.actions[control] = action
        control.addTarget(self, action: #selector(handle), for: event)
    }

    static func deregister(_ control: UIControl) {
        Self.actions.removeValue(forKey: control)
    }

    @objc
    static func handle(_ sender: UIControl) {
        // lookup the sender and call the stored closure
        actions[sender]?()
    }
}

// SwiftUI style constructors
struct UI {
    static func Alert(title: String, message: String, dismissButton: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: dismissButton, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        return alertController
    }
    
    static func Image(_ named: String) -> UIImage {
        let image = UIImage(named: named) ?? UIImage()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }

    static func Button(_ title: String, action: @escaping () -> Void) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        UIAction.register(button, event: .touchUpInside, action: action)
        return button
    }

    static func Checkbox(action: (() -> Void)? = nil) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame(height: 44, width: 44)
        button.setImage(Image("checkbox-off"), for: .normal)
        button.setImage(Image("checkbox-on"), for: .selected)
        UIAction.register(button, event: .touchUpInside) {
            button.isSelected = !button.isSelected
            action?()
        }
        button.isSelected = false
        return button
    }
    
    // Deviates from the SwiftUI observer based implenentation
    static func List(_ data: [AnyObject]) -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }

    // Deviates from the SwiftUI observer based implenentation
    static func ListCell() -> UITableViewCell {
        let tableViewCell = UITableViewCell(frame: .zero)
        tableViewCell.translatesAutoresizingMaskIntoConstraints = false
        return tableViewCell
    }
    
    static func Text(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }

    static func TextField(_ text: String? = nil) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = text
        return textField
    }

    static func SecureField(_ text: String? = nil) -> UITextField {
        let textView = UITextField()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isSecureTextEntry = true
        textView.text = text
        return textView
    }

    static func Spacer() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func Stepper() -> UIStepper {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }
    
    static func Toggle() -> UISwitch {
        let switch = UISwitch()
        switch.translatesAutoresizingMaskIntoConstraints = false
        return switch
    }
    
    static func VStack(alignment: UIStackView.Alignment = .fill, body: (UIStackView) -> Void) -> UIStackView {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = alignment
        body(view)
        return view
    }

    static func HStack(alignment: UIStackView.Alignment = .fill, body: (UIStackView) -> Void) -> UIStackView {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = alignment
        body(view)
        return view
    }

    static func ZStack(alignment: UIStackView.Alignment = .fill, body: (UIStackView) -> Void) -> UIStackView {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = alignment
        body(view)
        return view
    }
}

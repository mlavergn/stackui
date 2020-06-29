//
//  StackUI.swift
//  StackUI
//
//  Created by Lavergne, Marc on 6/4/20.
//  Copyright © 2020 Lavergne, Marc. All rights reserved.
//

import UIKit

/// StackUI
///
/// A SwiftUI-like API for UIKit to allow progressive adoption of SwiftUI
///
/// SwiftUI Style
/// - uses a "call chaining" -like pattern
/// - no setter/getter patterns
/// - inline declarations
///
/// TODO
/// - Form - UITableView with sections?
/// - Picker - pickerStyle(.radioGroup)
/// - Divider
/// - Environment
/// - colorScheme - .dark : .light
/// - contentSize - .large : .axLarge : .small
/// - locale - en_US
/// - NavigationView / NavigationLink
///
/// FIX
/// - View property "chained" calls propagate based on the call order and the nesting order
///


/// SwiftUI style alignment specifiers
enum UIAlignment: Int {
    case vertical
    case horizontal
    case bottom
    case leading
    case top
    case trailing
    case all
}

// MARK: extensions

/// SwiftUI extensions on UIView
extension UIView {
    @discardableResult
    func background(_ color: UIColor, cornerRadius radius: CGFloat? = nil) -> Self {
        self.backgroundColor = color
        if let radius = radius {
            self.cornerRadius(radius)
        }
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
		self.widthAnchor.constraint(equalToConstant: width).isActive = true
		self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func opacity(_ opacity: Float) -> Self {
        self.layer.opacity = opacity
        return self
    }
}

/// SwiftUI extensions on UIView padding
extension UIView {
    // viewBuilder
    var views: [UIView] {
        get {
			self.subviews
        }
        set(views) {
            views.forEach{ view in
				self.addSubview(view)
            }
        }
    }

    @discardableResult
    func constrain(_ alignment: UIAlignment, superview: UIView) -> Self {
        switch alignment {
        case .vertical:
            self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor).isActive = true
        case .horizontal:
            self.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor).isActive = true
        case .leading:
            self.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor).isActive = true
        case .top:
            self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor).isActive = true
        case .trailing:
            self.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor).isActive = true
        case .all:
            self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.layoutMarginsGuide.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.layoutMarginsGuide.trailingAnchor).isActive = true
        }
        return self
    }

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
        case .all:
            insets.right = inset
            insets.left = inset
            insets.top = inset
            insets.bottom = inset
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

/// SwiftUI extensions on UIButton
extension UIButton {
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func font(_ style: UIFont.TextStyle) -> Self {
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }
    
    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        self.titleLabel?.textColor = color
        return self
    }
}

/// SwiftUI extensions on UITextView
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

/// SwiftUI extensions on UITextField
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

    // SwiftUI exception
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

/// SwiftUI extensions on UITextView
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

/// SwiftUI extensions on UIStackView
extension UIStackView {
    // viewBuilder
    var build: [UIView] {
        get {
            self.arrangedSubviews
        }
        set(views) {
            views.forEach{ view in
                self.addArrangedSubview(view)
            }
        }
    }

    @discardableResult
    func spacing(_ spacing: UIStackView.Distribution = .fillProportionally) -> Self {
        self.distribution = spacing
        return self
    }

    // alignment is already defined on UIStackView
    @discardableResult
    func align(_ alignment: UIStackView.Alignment = .center) -> Self {
        self.alignment = alignment
        return self
    }
}

/// SwiftUI support for action closures
extension UIControl {
    /// Inspect view state for the given UIEvent and return an appropriate UIControl.Event
    /// - Parameter event: UIEvent to attempt to convert
    /// - Returns: UIControl.Event
    func uiEventToControlEvent(_ event: UIEvent) -> UIControl.Event {
        // non-UIButton actions will typically have a nil UIEvent
        guard let touch = event.allTouches?.first else {
            return .primaryActionTriggered
        }
        let isInside = self.bounds.contains(touch.location(in: self))
        let wasInside = self.bounds.contains(touch.previousLocation(in: self))
        // let isEdit = self.isKind(of: UITextField.self)
        // TODO support editting events
        switch touch.phase {
        case .began:
            return touch.tapCount > 1 ? .touchDownRepeat : .touchDown
        case .moved:
            switch (wasInside, isInside) {
            case (true, true):
                return .touchDragInside
            case (false, true):
                return .touchDragEnter
            case (true, false):
                return .touchDragExit
            case (false, false):
                return .touchDragOutside
            }
        case .ended:
            return isInside ? .touchUpInside : .touchUpOutside
        case .cancelled:
            return .touchCancel
        case .stationary:
            return .primaryActionTriggered
        default:
            return .primaryActionTriggered
        }
    }
}

// MARK: list

// SwiftUI style List
final class List: UITableView {
    var controller: ListController?
    var cellHandler: (Any) -> UIView = { _ in
        return UIView()
    }

    init(_ data: [AnyObject]) {
        super.init(frame: .zero, style: .plain)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let listController = ListController()
        listController.data = data
        self.dataSource = listController
        self.delegate = listController
        self.register(UITableViewCell.self, forCellReuseIdentifier: listController.cellId)
        // created the controller, so hold a reference
        controller = listController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult
    func ForEach(_ handler: @escaping (Any) -> UIView) -> Self {
        cellHandler = handler
        return self
    }
    
    /// UIStackViews compress scrollviews, so re-anchor once added as a subview
    override func didMoveToSuperview() {
        if let superview = self.superview {
            self.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor).isActive = true
        }
    }

    /// map the optimal intrinsic size to the content size
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

// SwiftUI rename to Coordinator
final class ListController: UITableViewController {
    var data: [Any] = []
    let cellId: String = "cell"
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // bridge back
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let list = tableView as? List {
            // not optimal, find a pattern for reuse
            let view = list.cellHandler(data[indexPath.row])
            cell.addSubview(view)
        }
        return cell
    }
}

// MARK: types

final class Alert: UIAlertController {
	convenience init(title: String, message: String, dismissButton: String) {
		self.init(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: dismissButton, style: .default, handler: nil)
        self.addAction(defaultAction)
    }
}
	
final class Image: UIImageView {
    convenience init(_ named: String) {
        let image = UIImage(named: named)
		self.init(image: image)
    }
}

final class Button: UIButton {
	var events: [UInt: (UIEvent) -> Void] = [:]

	convenience init(action: @escaping (UIEvent) -> Void, label: () -> String) {
		self.init(type: .system)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(label(), for: .normal)
        self.event(.touchUpInside, action: action)
    }
	
    func event(_ event: UIControl.Event, action: @escaping (UIEvent) -> Void) {
        events[event.rawValue] = action
        self.addTarget(self, action: #selector(handler), for: event)
    }
	
    @objc
    func handler(_ sender: UIControl, forEvent event: UIEvent) {
        let controlEvent = uiEventToControlEvent(event)
		events[controlEvent.rawValue]?(event)
    }
}

final class Checkbox: UIButton {
	var events: [UInt: (UIEvent) -> Void] = [:]

    convenience init(action: ((Bool) -> Void)? = nil) {
		self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame(height: 44, width: 44)
        self.setImage(UIImage(named: "checkbox-off"), for: .normal)
        self.setImage(UIImage(named: "checkbox-on"), for: .selected)
        self.event(.touchUpInside) { _ in
            self.isSelected = !self.isSelected
            action?(self.isSelected)
        }
        self.isSelected = false
    }

    func event(_ event: UIControl.Event, action: @escaping (UIEvent) -> Void) {
        events[event.rawValue] = action
        self.addTarget(self, action: #selector(handler), for: event)
    }
	
    @objc
    func handler(_ sender: UIControl, forEvent event: UIEvent) {
        let controlEvent = uiEventToControlEvent(event)
		events[controlEvent.rawValue]?(event)
    }
}

final class Text: UILabel {
	convenience init(_ text: String) {
		self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
    }
}

final class TextField: UITextField {
	convenience init(_ text: String? = nil) {
		self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
    }
}

final class SecureField: UITextField {
	convenience init(_ text: String? = nil) {
		self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isSecureTextEntry = true
        self.text = text
    }
}

final class Spacer: UIView {
	convenience init() {
		self.init(frame: .zero)
		self.translatesAutoresizingMaskIntoConstraints = false
    }
}

final class Stepper: UIStepper {
	var events: [UInt: (UIEvent) -> Void] = [:]

	convenience init(in range: ClosedRange<Double>, action: @escaping (Double) -> Void) {
		self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.minimumValue = range.lowerBound
        self.maximumValue = range.upperBound
        self.event(.primaryActionTriggered) { _ in
            action(self.value)
        }
    }
	
    func event(_ event: UIControl.Event, action: @escaping (UIEvent) -> Void) {
        events[event.rawValue] = action
        self.addTarget(self, action: #selector(handler), for: event)
    }
	
    @objc
    func handler(_ sender: UIControl, forEvent event: UIEvent) {
        let controlEvent = uiEventToControlEvent(event)
		events[controlEvent.rawValue]?(event)
    }
}

final class Toggle: UISwitch {
	var events: [UInt: (UIEvent) -> Void] = [:]

	convenience init(isOn: Bool, action: @escaping (Bool) -> Void) {
		self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isOn = isOn
        self.event(.primaryActionTriggered) { _ in
            action(self.isOn)
        }
    }
	
    func event(_ event: UIControl.Event, action: @escaping (UIEvent) -> Void) {
        events[event.rawValue] = action
        self.addTarget(self, action: #selector(handler), for: event)
    }
	
    @objc
    func handler(_ sender: UIControl, forEvent event: UIEvent) {
        let controlEvent = uiEventToControlEvent(event)
		events[controlEvent.rawValue]?(event)
    }
}

// MARK: layout containers

final class VStack: UIStackView {
	convenience init(alignment: UIStackView.Alignment = .center, _ body: () -> [UIView]) {
		self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.distribution = .fillProportionally
        self.alignment = alignment
		body().forEach { view in
			self.addArrangedSubview(view)
		}
    }
}

final class HStack: UIStackView {
	convenience init(alignment: UIStackView.Alignment = .center, _ body:  () -> [UIView]) {
		self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .horizontal
        self.distribution = .fillProportionally
        self.alignment = alignment
		body().forEach { view in
			self.addArrangedSubview(view)
		}
    }
}

final class ZStack: UIStackView {
	convenience init(alignment: UIStackView.Alignment = .center, _ body: () -> [UIView]) {
		self.init()
		self.translatesAutoresizingMaskIntoConstraints = false
		self.axis = .horizontal
		self.distribution = .fillEqually
		self.alignment = alignment
		body().forEach { view in
			self.addArrangedSubview(view)
		}
	}
}

// MARK: view

class View: UIView {
	convenience init(_ body: (() -> [UIView])?) {
		self.init(frame: .zero)
		self.translatesAutoresizingMaskIntoConstraints = false
		body?().forEach { view in
			self.addSubview(view)
		}
	}

	convenience init() {
		self.init(frame: .zero)
		self.translatesAutoresizingMaskIntoConstraints = false
		if let view = self.body() {
			self.addSubview(view)
		}
//		self.add
//		views.forEach { view in
//			self.addSubview(view)
//		}
	}

//	var bodyImpl: (() -> [UIView])?
	func body() -> UIView? {
		return nil
	}
	
//	override func didMoveToSuperview() {
//		guard let superview = self.superview else { return }
//		self.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor).isActive = true
//		self.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor).isActive = true
//	}
}

// MARK: observable

class ObservedObject<T>: NSObject {
	@objc dynamic var value: Any?

	var wrappedValue: T? {
		didSet {
			self.value = wrappedValue
		}
	}
	
	func projectedValue(_ handler: @escaping (ObservedObject<T>, NSKeyValueObservedChange<Any?>) -> Void) -> NSKeyValueObservation? {
		return observe(\.self.value, options: [.old, .new], changeHandler: handler)
	}
	
	func update() {
		// called prior to rendering
	}
}

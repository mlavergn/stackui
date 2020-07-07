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

public struct StackUI {
    let version: String = "0.0.1"
}

/// SwiftUI style alignment specifiers
public enum Alignment: Int {
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
    public func background(_ color: UIColor, cornerRadius radius: CGFloat? = nil) -> Self {
        self.backgroundColor = color
        if let radius = radius {
            self.cornerRadius(radius)
        }
        return self
    }

    @discardableResult
    public func clipped() -> Self {
        self.clipsToBounds = true
        return self
    }

    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        return self
    }

    @discardableResult
    public func frame(height: CGFloat = -1, width: CGFloat = -1) -> Self {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }

    @discardableResult
    public func opacity(_ opacity: Float) -> Self {
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
    public func constrain(_ alignment: Alignment, superview: UIView) -> Self {
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
    public func padding(_ axis: Alignment, _ inset: CGFloat) -> Self {
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
    public func padding(_ insets: UIEdgeInsets) -> Self {
        self.layoutMargins = insets
        return self
    }

    @discardableResult
    public func padding(_ inset: CGFloat) -> Self {
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        self.layoutMargins = insets
        return self
    }

    @discardableResult
    public func padding() -> Self {
        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.layoutMargins = insets
        return self
    }
}

/// SwiftUI extensions on UIButton
extension UIButton {
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }

    @discardableResult
    public func font(_ style: UIFont.TextStyle) -> Self {
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }

    @discardableResult
    public func foregroundColor(_ color: UIColor) -> Self {
        self.titleLabel?.textColor = color
        return self
    }
}

/// SwiftUI extensions on UITextView
extension UILabel {
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    public func font(_ style: UIFont.TextStyle) -> Self {
        self.font = UIFont.preferredFont(forTextStyle: style)
        return self
    }

    @discardableResult
    public func foregroundColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    @discardableResult
    public func lineLimit(_ lines: Int) -> Self {
        self.numberOfLines = lines
        return self
    }
}

/// SwiftUI extensions on UITextField
extension UITextField {
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    @discardableResult
    public func autocapitalization(_ type: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = type
        return self
    }

    @discardableResult
    public func clears(_ clears: Bool) -> Self {
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
public final class List: UITableView {
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
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            self.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor).isActive = true
        }
    }

    /// map the optimal intrinsic size to the content size
    override public var intrinsicContentSize: CGSize {
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

public final class Alert: UIAlertController {
    public convenience init(title: String, message: String? = nil, dismissButton: String = "OK") {
        let messageText = message ?? title
        let titleText = message == nil ? "" : title
        self.init(title: titleText, message: messageText, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: dismissButton, style: .default, handler: nil)
        self.addAction(defaultAction)
    }
}

public final class Image: UIImageView {
    public convenience init(_ named: String) {
        let image = UIImage(named: named)
        self.init(image: image)
    }
}

public final class Button: UIButton {
    var events: [UInt: (UIEvent) -> Void] = [:]

    public convenience init(action: @escaping (UIEvent) -> Void, label: () -> [UIView]) {
        self.init(type: .system)
        self.translatesAutoresizingMaskIntoConstraints = false
        label().forEach { view in
            if let text = view as? Text<String> {
                self.setTitle(text.value, for: .normal)
            }
        }
        self.event(.touchUpInside, action: action)
    }

    public func event(_ event: UIControl.Event, action: @escaping (UIEvent) -> Void) {
        events[event.rawValue] = action
        self.addTarget(self, action: #selector(handler), for: event)
    }

    @objc
    func handler(_ sender: UIControl, forEvent event: UIEvent) {
        let controlEvent = uiEventToControlEvent(event)
        events[controlEvent.rawValue]?(event)
    }
    
    public func alert(isPresented: StateValue<Bool>, _ value: @escaping () -> Alert) -> Self {
        isPresented.observe(self) { isPresented in
            if isPresented.value {
                guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
                    return
                }
                vc.show(value(), sender: nil)
                isPresented.value = false
            }
        }
        return self
    }
}

public final class Checkbox: UIButton {
    var events: [UInt: (UIEvent) -> Void] = [:]

    public convenience init(action: ((Bool) -> Void)? = nil) {
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

    public func event(_ event: UIControl.Event, action: @escaping (UIEvent) -> Void) {
        events[event.rawValue] = action
        self.addTarget(self, action: #selector(handler), for: event)
    }

    @objc
    func handler(_ sender: UIControl, forEvent event: UIEvent) {
        let controlEvent = uiEventToControlEvent(event)
        events[controlEvent.rawValue]?(event)
    }
}

public class Text<T>: UILabel {
    var stateValue: StateValue<T>
    var setter: (() -> String)?

    public init(_ stateValue: StateValue<T>, value: @escaping () -> String) {
        self.stateValue = stateValue
        self.setter = value
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = value()
        self.stateValue.observe(self) { _ in
            self.text = value()
        }
    }

    public convenience init(_ value: T) {
        self.init(StateValue(value), value: { "\(value)" })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var value: T {
        return stateValue.value
    }
}

public final class TextField: UITextField, UITextFieldDelegate {
    var stateValue = StateValue("")
    public convenience init(_ placeholder: String? = nil, text: StateValue<String>) {
        self.init()
        self.stateValue = text
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        self.text = text.value
        self.delegate = self
        self.stateValue.observe(self) { _ in
            self.text = self.stateValue.value
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.stateValue.value = textField.text ?? ""
    }
}

public final class SecureField: UITextField, UITextFieldDelegate {
    var stateValue = StateValue("")
    public convenience init(_ placeholder: String? = nil, text: String) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isSecureTextEntry = true
        self.placeholder = placeholder
        self.text = text
        self.delegate = self
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.stateValue.value = textField.text ?? ""
    }
}

public final class Stepper: UIStepper {
    var events: [UInt: (UIEvent) -> Void] = [:]
    var stateValue: StateValue<Double> = StateValue(0.0)

    public convenience init(_ text: String, value: StateValue<Double>, in range: ClosedRange<Double>, action: (() -> Void)? = nil) {
        self.init(value: value, in: range, action: action)
        self.stateValue = value
        self.event(.touchUpInside) { _ in
            self.stateValue.value = self.value
        }
    }

    public convenience init(value: StateValue<Double>, in range: ClosedRange<Double>, action: (() -> Void)? = nil) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.minimumValue = range.lowerBound
        self.maximumValue = range.upperBound
        self.event(.primaryActionTriggered) { _ in
            action?()
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

public final class Toggle: UISwitch {
    var events: [UInt: (UIEvent) -> Void] = [:]
    public var stateValue = StateValue<Bool>(false)

    public convenience init(isOn stateValue: StateValue<Bool>, action: (() -> Void)? = nil, _ subviews: (() -> [UIView])? = nil) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.stateValue = stateValue
        self.isOn = self.stateValue.value
        self.event(.primaryActionTriggered) { _ in
            self.stateValue.value = self.isOn
        }
    }

    public func disabled(_ observe: StateValue<Bool>) -> Self {
        self.isEnabled = observe.value
        return self
    }

    public func event(_ event: UIControl.Event, action: @escaping (UIEvent) -> Void) {
        events[event.rawValue] = action
        self.addTarget(self, action: #selector(handler), for: event)
    }

    @objc
    func handler(_ sender: UIControl, forEvent event: UIEvent) {
        let controlEvent = uiEventToControlEvent(event)
        events[controlEvent.rawValue]?(event)
    }
}

// MARK: layout helpers

public final class Divider: UIView {
    public convenience init() {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame(height: 1.0, width: 320.0)
        self.backgroundColor = .black
    }
}

public final class Spacer: UIView {
    public convenience init() {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


// MARK: layout containers

public class Stack: UIStackView {
    public convenience init(alignment: UIStackView.Alignment = .center, spacing: CGFloat = 0, body: () -> [UIView]) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .fillProportionally
        self.alignment = alignment
        body().forEach { view in
            self.addArrangedSubview(view)
            if spacing != 0 {
                view.padding(spacing)
            }
        }
    }
}

public final class VStack: Stack {
    public convenience init(alignment: UIStackView.Alignment = .center, spacing: CGFloat = 0, _ body: () -> [UIView]) {
        self.init(alignment: alignment, spacing: spacing, body: body)
        self.axis = .vertical
    }
}

public final class HStack: Stack {
    public convenience init(alignment: UIStackView.Alignment = .center, spacing: CGFloat = 0, _ body:  () -> [UIView]) {
        self.init(alignment: alignment, spacing: spacing, body: body)
        self.axis = .horizontal
    }
}

public final class ZStack: Stack {
    public convenience init(alignment: UIStackView.Alignment = .center, spacing: CGFloat = 0, _ body: () -> [UIView]) {
        self.init(alignment: alignment, spacing: spacing, body: body)
        self.axis = .horizontal
        self.distribution = .fillEqually
    }
}

// MARK: view

open class View: UIView {
    public init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        if let view = self.body() {
            self.addSubview(view)
        }
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func body() -> UIView? {
        return nil
    }

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let superview = self.superview else { return }
        self.heightAnchor.constraint(equalTo: superview.layoutMarginsGuide.heightAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: superview.layoutMarginsGuide.widthAnchor).isActive = true
    }
}

// MARK: observables

public class StateValue<T>: CustomStringConvertible {

    var observers: [AnyHashable: (StateValue<T>) -> Void] = [:]

    public var value: T {
        didSet(value) {
            self.observers.forEach { kv in
                kv.value(self)
            }
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    public func observe(_ observer: AnyHashable, callback: @escaping (StateValue<T>) -> Void) {
        self.observers[observer] = callback
    }

    public var description: String {
        return "\(self.value)"
    }
}

/// Not functional
/// KVO may be avoided
/// ObservedObject wrapper
public class ObservedObject<T>: NSObject {
    @objc
    public dynamic var value: Any?

    public var wrappedValue: T? {
        didSet {
            self.value = wrappedValue
        }
    }

    public func projectedValue(_ handler: @escaping (ObservedObject<T>, NSKeyValueObservedChange<Any?>) -> Void) -> NSKeyValueObservation? {
        return observe(\.self.value, options: [.old, .new], changeHandler: handler)
    }

    public func update() {
        // called prior to rendering
    }
}

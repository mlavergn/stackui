# StackUI

SwiftUI inspired imperative API based on UIStackView

SwiftUI is a dead simple and minimalist UI API available in iOS 13, but requires structuring your logic to conform to the Combine reactive paradigm.

## Goal

This project attempts to replicate the ease of use of SwiftUI for imperative Swift.

## Why

This stemmed from wanting to move piecemeal to the reactive paradigm while avoiding an atomic rewrite of view code.

## How

The core of StackUI is extensions that mimic SwiftUI on top of UIKit components.

In addition, there are convenience functions (not subclasses) that mimic SwiftUI components.

The layout is entirely dependent on UIStackView nestings.

## Status

This is all experimental at this stage, it is certainly not packaged for external consumption.

Currently, all the relevant implementation code is contained in StackUI.swift, which isn't a masterclass in organizing source code, but which would simplify adding StackUI to existing projects since it would be drop and go.

## Usage

Usage is unusual, but it is similar enough to SwiftUI that converting to it should be quite simple.

```swift
let view = UI.VStack { body in
    body.views = [
        UI.Text("StackUI"),
        UI.Button("OK") {
            print("clicked")
        },
        UI.Spacer(),
        UI.HStack { body in
            body.views = [
                UI.Text("Hello"),
                UI.Spacer(),
                UI.Text("World"),
            ],
        }
    ]
}
.padding(.leading, 10)
```

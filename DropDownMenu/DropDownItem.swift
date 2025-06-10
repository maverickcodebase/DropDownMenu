//
//  DropDownItem.swift
//  DropDownMenu
//
//  Created by Sheraz Ahmed on 10/06/2025.
//


// MARK: - Dropdown Item Model
struct DropDownItem: Identifiable {
    let id: Int
    let title: String
    let onSelect: () -> Void
}


let dummyItems: [DropDownItem] = [
    .init(id: 1, title: "Option 1", onSelect: { print("Option 1 selected") }),
    .init(id: 2, title: "Option 2", onSelect: { print("Option 2 selected") })
    ]

let frameworkList: [DropDownItem] = [
    .init(id: 1, title: "SwiftUI", onSelect: { print("SwiftUI selected") }),
    .init(id: 2, title: "UIKit", onSelect: { print("UIKit selected") })
]

let IDEList: [DropDownItem] = [
    .init(id: 1, title: "Xcode", onSelect: { print("Xcode selected") }),
    .init(id: 2, title: "Visual Studio Code", onSelect: { print("Visual Studio Code selected") })
]

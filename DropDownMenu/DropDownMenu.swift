//
//  DropDownMenu.swift
//  DropDownMenu
//
//  Created by Sheraz Ahmed on 25/12/2024.
//

import SwiftUI

// MARK: - DropDownItem Model
/// Represents an item in the dropdown menu
struct DropDownItem: Identifiable {
    let id: Int
    let title: String
    let onSelect: () -> Void
    
    /// Initialize a dropdown item
    /// - Parameters:
    ///   - id: Unique identifier for the item
    ///   - title: Display text for the item
    ///   - onSelect: Closure to execute when item is selected
    init(id: Int, title: String, onSelect: @escaping () -> Void = {}) {
        self.id = id
        self.title = title
        self.onSelect = onSelect
    }
}

// MARK: - Sample Data
/// Sample data for previews and testing
extension DropDownItem {
    static let dummyItems: [DropDownItem] = [
        .init(id: 1, title: "Option 1"),
        .init(id: 2, title: "Option 2")
    ]
    
    static let frameworkList: [DropDownItem] = [
        .init(id: 1, title: "SwiftUI", onSelect: { print("SwiftUI selected") }),
        .init(id: 2, title: "UIKit", onSelect: { print("UIKit selected") })
    ]
    
    static let IDEList: [DropDownItem] = [
        .init(id: 1, title: "Xcode", onSelect: { print("Xcode selected") }),
        .init(id: 2, title: "Visual Studio Code", onSelect: { print("Visual Studio Code selected") })
    ]
}

// MARK: - DropDownMenu Component
/// A customizable dropdown menu component for SwiftUI
struct DropDownMenu: View {
    @State private var isSelecting = false
    @Binding var selectedItem: DropDownItem?

    let items: [DropDownItem]
    let placeholder: String
    let menuLabel: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Section(header: Text(menuLabel).font(.subheadline)) {
                VStack(spacing: 5) {
                    HStack {
                        Text(selectedItem?.title ?? placeholder)
                            .foregroundStyle(selectedItem == nil ? Color(.placeholderText) : Color(.label))

                        Spacer()

                        Image(systemName: "chevron.down")
                            .foregroundStyle(Color(.secondaryLabel))
                            .rotationEffect(.degrees(isSelecting ? -180 : 0))
                    }
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(isSelecting ? Color(.main) : Color(.border), lineWidth: 1)
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isSelecting.toggle()
                        }
                    }

                    if isSelecting {
                        VStack(spacing: 0) {
                            Spacer().frame(height: 5)

                            VStack(spacing: 5) {
                                ForEach(items) { item in
                                    DropDownMenuItemView(
                                        isSelecting: $isSelecting,
                                        selectedItem: $selectedItem,
                                        item: item
                                    )

                                    if item.id != items.last?.id {
                                        Divider().padding(.leading, 10)
                                    }
                                }
                            }
                            .padding(.vertical, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                            )
                        }
                    }
                }
            }
        }
    }


}


/// Individual item view within the dropdown menu
struct DropDownMenuItemView: View {
    @Binding var isSelecting: Bool
    @Binding var selectedItem: DropDownItem?

    let item: DropDownItem

    var body: some View {
        HStack {
            Text(item.title)
                .font(.system(size: 16))

            Spacer()

            if selectedItem?.id == item.id {
                Image(systemName: "checkmark")
                    .foregroundStyle(Color(.blue))
            }
        }
        .padding(10)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                isSelecting = false
            }
            selectedItem = item
            item.onSelect()
        }
    }
}

// MARK: - DropDownMenuItemView Preview
#Preview("DropDownMenuItemView") {
    @Previewable @State var isSelecting = true
    @Previewable @State var selectedItem: DropDownItem? = DropDownItem.dummyItems.first
    
    return VStack(spacing: 10) {
        DropDownMenuItemView(
            isSelecting: $isSelecting,
            selectedItem: $selectedItem,
            item: DropDownItem.dummyItems[0]
        )
        
        DropDownMenuItemView(
            isSelecting: $isSelecting,
            selectedItem: $selectedItem,
            item: DropDownItem.dummyItems[1]
        )
    }
    .padding()
}

// MARK: - DropDownMenuView (Demo View)
struct DropDownMenuView: View {
    @State private var selectedFramework: DropDownItem? = nil
    @State private var selectedIDE: DropDownItem? = nil

    var body: some View {
        VStack(spacing: 20) {
            DropDownMenu(
                selectedItem: $selectedFramework,
                items: DropDownItem.frameworkList,
                placeholder: "Select",
                menuLabel: "Framework"
            )

            DropDownMenu(
                selectedItem: $selectedIDE,
                items: DropDownItem.IDEList,
                placeholder: "Select",
                menuLabel: "IDE"
            )

            Spacer()
        }
        .padding()
    }
}

// MARK: - Main Preview
#Preview {
    @Previewable @State var selectedItem: DropDownItem? = nil
    
    return DropDownMenu(
        selectedItem: $selectedItem,
        items: DropDownItem.dummyItems,
        placeholder: "Select",
        menuLabel: "Dropdown Label"
    )
    .padding(.horizontal)
}

// MARK: - DropDownMenuView Preview
#Preview("DropDownMenuView") {
    DropDownMenuView()
}

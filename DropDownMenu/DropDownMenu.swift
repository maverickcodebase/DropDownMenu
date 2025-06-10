//
//  DropdownMenu.swift
//  Expense Ninja
//
//  Created by Sheraz Ahmed on 25/12/2024.
//



import SwiftUI

struct DropDownMenu: View {
    @State private var isSelecting = false

    @Binding var selectedItem: DropDownItem?

    let items: [DropDownItem]
    let placeholder: String
    var menuLabel: String

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
                                    DropdownMenuItemView(
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


struct DropdownMenuItemView: View {
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


struct CustomDropdownMenu_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
            .padding(.horizontal)
    }

    struct PreviewWrapper: View {
        @State private var selectedItem: DropDownItem? = nil

        var body: some View {
            DropDownMenu(
                selectedItem: $selectedItem,
                items: dummyItems,
                placeholder: "Select",
                menuLabel: "Dropdown Label"
            )
        }
    }
}

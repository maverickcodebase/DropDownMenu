//
//  ContentView.swift
//  DropDownMenu
//
//  Created by Sheraz Ahmed on 10/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedFramework: DropDownItem? = nil
    @State private var selectedIDE: DropDownItem? = nil

    var body: some View {
        VStack(spacing: 20) {
            DropDownMenu(
                selectedItem: $selectedFramework,
                items: frameworkList,
                placeholder: "Select",
                menuLabel: "Framework"
            )

            DropDownMenu(
                selectedItem: $selectedIDE,
                items: IDEList,
                placeholder: "Select",
                menuLabel: "IDE"
            )

//            Button("Get Selected") {
//                if let selected = selectedFramework {
//                    print("Selected: \(selected.title) (id: \(selected.id))")
//                } else {
//                    print("Nothing selected")
//                }
//
//                if let selected = selectedIDE {
//                    print("Selected: \(selected.title) (id: \(selected.id))")
//                } else {
//                    print("Nothing selected")
//                }
//
//            }
//            .buttonStyle(.borderedProminent)
//            .padding(.top)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

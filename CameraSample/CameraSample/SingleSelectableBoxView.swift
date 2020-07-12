//
//  TrySelectedBox.swift
//  CameraSample
//
//  Created by satoutakeshi on 2020/07/11.
//  Copyright © 2020 satoutakeshi. All rights reserved.
//

import SwiftUI
import Combine

final class MultipleSelectableViewModel: ObservableObject {
    @Published var isSelectedRed: Bool = false
    @Published var isSelectedGreen: Bool = false
    @Published var isSelectedBlue: Bool = false

    var cancels: [Cancellable] = []

    init() {
        let redSubscriber = $isSelectedRed.sink { (selected) in
            print("red is\(selected ? "" : " not") selected")
        }
        cancels.append(redSubscriber)

        let greenSubscriber = $isSelectedGreen.sink { (selected) in
            print("green is\(selected ? "" : " not") selected")
        }
        cancels.append(greenSubscriber)

        let blueSubscriber = $isSelectedBlue.sink { (selected) in
            print("blue is\(selected ? "" : " not") selected")
        }
        cancels.append(blueSubscriber)
    }
}


struct MultipleSelectableView: View {
    @ObservedObject var viewModel = MultipleSelectableViewModel()
    var body: some View {
        ScrollView {
            SelectBox(isSelected: $viewModel.isSelectedRed, color: .red)
            SelectBox(isSelected: $viewModel.isSelectedGreen, color: .green)
            SelectBox(isSelected: $viewModel.isSelectedBlue, color: .blue)
        }
    }
}

struct SelectBox: View {
    @Binding var isSelected: Bool
    let color: Color
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .frame(width: 100, height: 100)
            .cornerRadius(10)
            .onTapGesture {
                self.isSelected.toggle()
        }
        .padding()
        .border(Color.black, width: self.isSelected ? 4 : 0)
    }
}

struct MultipleSelectableView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSelectableView()
    }
}

enum BoxType: String {
    case unknown
    case red
    case green
    case blue
}

final class SingleSelectableBoxViewModel: ObservableObject {
    @Published var selectedBox: BoxType = .unknown
    var cancels: [AnyCancellable] = []

    init() {
        let selected = $selectedBox.sink { (box) in
            print("selected box is \(box.rawValue)")
        }
        cancels.append(selected)
    }
}

/*
1. 複数選択する方法。@Publishのboolを3つ作る。
 2. 一つ選択する方法。enumを追加。
 3. 親ビューを追加する方法。viewModelを親ビューに移動。子ビューにはbindingで渡す。

 */

struct ParentView: View {
    @ObservedObject var viewModel = SingleSelectableBoxViewModel()
    var body: some View {
        VStack {
            SingleSelectableBoxView(selectedBox: $viewModel.selectedBox)
            Text("Selected box is \(viewModel.selectedBox.rawValue)")
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}


struct SingleSelectableBoxView: View {
    @Binding var selectedBox: BoxType
    var body: some View {
        ScrollView {
            BoxView(selectedBox: $selectedBox, color: .red, boxType: .red)
            BoxView(selectedBox: $selectedBox, color: .green, boxType: .green)
            BoxView(selectedBox: $selectedBox, color: .blue, boxType: .blue)
        }
    }
}

struct SingleSelectableBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SingleSelectableBoxView(selectedBox: .constant(.red))
    }
}

struct BoxView: View {
    @Binding var selectedBox: BoxType
    let color: Color
    let boxType: BoxType
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .frame(width: 100, height: 100)
            .cornerRadius(10)
            .onTapGesture {
                self.selectedBox = self.boxType
        }
        .padding()
        .border(Color.black, width: selectedBox == boxType ? 4 : 0)
    }
}

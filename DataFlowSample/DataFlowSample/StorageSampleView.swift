//
//  StorageSampleView.swift
//  DataFlowSample
//
//  Created by satoutakeshi on 2020/09/19.
//

import SwiftUI

struct StorageSampleView: View {
    @SceneStorage("userName") private var userName: String = ""
    @AppStorage("isLogin") private var isLogin = false
    @State private var memo: String = ""
    var body: some View {
        List {
            TextField("Input your name", text: $userName)
            Toggle("Login", isOn: $isLogin)
            TextField("Input memo", text: $memo)
        }
    }
}

struct StorageSampleView_Previews: PreviewProvider {
    static var previews: some View {
        StorageSampleView()
    }
}

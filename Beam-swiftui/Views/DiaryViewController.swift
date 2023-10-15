//
//  DiaryViewController.swift
//  Beam-swiftui
//
//  Created by Priya on 15/10/23.
//

import SwiftUI

struct DiaryViewController: View {
    @State var date = Date()
    
    var body: some View {
        NavigationView{
            VStack{
                DatePicker("Select Date",
                           selection: $date,
                           in: ...Date(),
                           displayedComponents: .date)
                .padding()
            }
            .navigationTitle("Diary")
        }
    }
}

struct DiaryViewController_Previews: PreviewProvider {
    static var previews: some View {
        DiaryViewController()
    }
}

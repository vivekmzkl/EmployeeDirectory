//
//  EmployeeDetailValueItem.swift
//  EmployeeDirectory
//
//  Created by Vivek M on 31/05/22.
//

import SwiftUI

struct EmployeeDetailValueItem: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(title): ")
                .foregroundColor(.gray)
            
            Text(value)
                .foregroundColor(.gray)

        }
    }
}

//struct EmployeeDetailValueItem_Previews: PreviewProvider {
//    static var previews: some View {
//        EmployeeDetailValueItem()
//    }
//}

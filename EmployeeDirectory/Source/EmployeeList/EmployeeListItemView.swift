//
//  EmployeeListItemView.swift
//  EmployeeDirectory
//
//  Created by Vivek M on 31/05/22.
//

import SwiftUI

struct EmployeeListItemView: View {
    
    let employee: Employee
    
    var body: some View {
        HStack {
            Group {
                if let image = employee.profileImage {
                    URLImage(url: image)
                        
                } else {
                    Color.gray
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(50/2)
            
            VStack(alignment: .leading) {
                Text(employee.name ?? "NA")
                    .foregroundColor(.black)

                Text(employee.companyName ?? "NA")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

//struct EmployeeListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmployeeListItemView()
//    }
//}

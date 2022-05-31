//
//  EmployeeDetailView.swift
//  EmployeeDirectory
//
//  Created by Vivek M on 31/05/22.
//

import SwiftUI

struct EmployeeDetailView: View {
    let employee: Employee
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 10) {
                    Group {
                        if let image = employee.profileImage {
                            URLImage(url: image)
                                
                        } else {
                            Color.gray
                        }
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(100/2)
                    
                    Text(employee.name ?? "NA")
                        .foregroundColor(.black)
                    
                    Divider()
                        .foregroundColor(.gray)
                    
                    EmployeeDetailValueItem(title: "Website", value: employee.website ?? "NA")
                    
                    EmployeeDetailValueItem(title: "Email Address", value: employee.email ?? "NA")

                    EmployeeDetailValueItem(title: "Phone", value: employee.phone ?? "NA")
                    
                    EmployeeDetailValueItem(title: "Address", value: employee.addressCity ?? "NA")

                    EmployeeDetailValueItem(title: "Company", value: employee.companyName ?? "NA")


                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .navigationBarTitle("Employee Detail", displayMode: .inline)

    }
}

//struct EmployeeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmployeeDetailView()
//    }
//}

//
//  EmployeeListView.swift
//  EmployeeDirectory
//
//  Created by Vivek M on 31/05/22.
//

import SwiftUI

struct EmployeeListView: View {
     
    @StateObject var viewModel = EmployeeListViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                if viewModel.isLoading {
                    Text("Loading...")
                } else if let employees = viewModel.employees {
                    ScrollView {
                        ForEach(employees) { employee in
                            NavigationLink {
                                EmployeeDetailView(employee: employee)
                            } label: {
                                EmployeeListItemView(employee: employee)
                            }
                            
                            Divider()
                                .foregroundColor(.gray)
                        }
                    }
                    
                } else  {
                    Text("No data found!")
                }
                
            }
            .navigationBarTitle("Employee List")

        }
        .onAppear(perform: onAppear)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchText) { newValue in
            viewModel.filterEmployees(using: newValue, context: viewContext)
        }
        .alert(isPresented: $viewModel.showAlert) {
            viewModel.alert
        }
    }
}

//MARK: - Local functions
extension EmployeeListView {
    func onAppear() {
        viewModel.fetchEmployees(context: viewContext)
    }
}

struct EmployeeListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListView()
    }
}

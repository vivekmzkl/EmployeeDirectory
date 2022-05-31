//
//  BaseViewModel.swift
//  EmployeeDirectory
//
//  Created by Vivek M on 31/05/22.
//

import SwiftUI

class BaseViewModel: NSObject {
    
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var noDataFound = false
    
    var alert: Alert = Alert.alert() {
        didSet {
            DispatchQueue.main.async {
                self.showAlert = true
            }
        }
    }
    
    func showLoader(loading: Bool) {
        if loading {
            DispatchQueue.main.async {
                self.showAlert = false
            }
        }
        isLoading = loading
    }
}

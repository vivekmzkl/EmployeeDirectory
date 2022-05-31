//
//  EmployeeListViewModel.swift
//  EmployeeDirectory
//
//  Created by Vivek M on 31/05/22.
//

import SwiftUI
import CoreData

class EmployeeListViewModel: BaseViewModel, ObservableObject {
    //MARK: - Variables
    @Published var employees: [Employee]?
    
    //MARK: - Core data
    func filterEmployees(using filter: String, context: NSManagedObjectContext) {
        if !filter.isEmpty {
            let fetchRequest : NSFetchRequest<Employee> = Employee.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name BEGINSWITH %@ OR email BEGINSWITH %@", filter, filter)
            do {
                let list = try context.fetch(fetchRequest)
                DispatchQueue.main.async {
                    self.employees = list
                }
                return
            } catch {
                self.alert = Alert.alert(message: error.localizedDescription)
            }
            
            
        }
        
        DispatchQueue.main.async {
            self.employees = self.fetchEmployeesFromLocal(context: context)
        }
    }
    
    func fetchEmployeesFromLocal(context: NSManagedObjectContext) -> [Employee]? {
        let fetchRequest : NSFetchRequest<Employee> = Employee.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return nil
        }

    }
    
    //MARK: - Handle api response and core data
    func processData(_ data: Data, context: NSManagedObjectContext) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                
                for dict in json {
                    let newEmployee = Employee(context: context)
                    newEmployee.setValue(dict[EmployeeItem.CodingKeys.id.rawValue] as! Int, forKey: "id")
                    newEmployee.setValue(dict[EmployeeItem.CodingKeys.name.rawValue] as! String, forKey: "name")
                    newEmployee.setValue(dict[EmployeeItem.CodingKeys.email.rawValue] as! String, forKey: "email")
                    newEmployee.setValue(dict[EmployeeItem.CodingKeys.profileImage.rawValue] as? String, forKey: "phone")
                    newEmployee.setValue(dict[EmployeeItem.CodingKeys.website.rawValue] as? String, forKey: "website")
                    newEmployee.setValue(dict[EmployeeItem.CodingKeys.profileImage.rawValue] as? String, forKey: "profileImage")

                    
                    if let companyDict = dict["company"] as? [String: Any] {
                        newEmployee.setValue(companyDict[EmployeeItem.CodingKeys.name.rawValue] as! String, forKey: "companyName")
                    }
                    
                    if let addressDict = dict["address"] as? [String: Any] {
                        newEmployee.setValue(addressDict["city"] as! String, forKey: "addressCity")
                    }
                }
            }
            
            try context.save() //make sure to save your data once decoding is complete
            
        } catch {
            print(error.localizedDescription)
            self.alert = Alert.alert(message: error.localizedDescription)
        }
        
        DispatchQueue.main.async {
            self.employees = self.fetchEmployeesFromLocal(context: context)
        }
    }
    
    //MARK: - API Handling
    func fetchEmployees(context: NSManagedObjectContext) {
        
        if let localEmployees = fetchEmployeesFromLocal(context: context), localEmployees.count > 0 {
            DispatchQueue.main.async {
                self.employees = localEmployees
            }
            return
        }
        
        let endpoint = "5d565297300000680030a986"
        WebServiceHandler.makeCall(endpoint: endpoint) { data in
            self.processData(data, context: context)
        } errorHandler: { errorMessage in
            self.alert = Alert.alert(message: errorMessage)
        }
    }

}

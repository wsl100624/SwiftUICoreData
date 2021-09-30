//
//  AddTransactionForm.swift
//  SwiftUICoreData
//
//  Created by Will Wang on 9/29/21.
//

import SwiftUI

struct AddTransactionForm: View {
    
    @Environment(\.presentationMode) var isPresented
    
    @State private var name = ""
    @State private var amount = ""
    @State private var date = Date()
    @State private var photo = UIImage()
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Amount", text: $amount)
                    DatePicker("Date", selection: $date, displayedComponents: [.date])
                    NavigationLink {
                        Text("Many").navigationTitle("New Title")
                    } label: {
                        Text("Many to many")
                    }

                } header: {
                    Text("information".uppercased())
                }
                
                Section {
                    Button {
                        
                    } label: {
                        Text("Select Photo")
                    }

                } header: {
                    Text("photo/receipt".uppercased())
                }
            }
            .navigationTitle("Add Transaction")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isPresented.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Save")
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

struct AddTransactionForm_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionForm()
    }
}

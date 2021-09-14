//
//  AddCardForm.swift
//  AddCardForm
//
//  Created by Will Wang on 9/13/21.
//

import SwiftUI

struct AddCardForm: View {
    
    @Environment(\.presentationMode) var isPresented
    
    // Card Info
    @State private var name = ""
    @State private var number = ""
    @State private var limit = ""
        // Picker Data
    @State private var cardType = "visa"
    var cardTypes = ["visa", "master", "discover", "chase"]
    
    // Expiration
    @State private var month = 1
    @State private var year = Calendar.current.component(.year, from: Date())
    let currentYear = Calendar.current.component(.year, from: Date())
    
    // Color
    @State private var color = Color.blue
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    
                    TextField("credit card number".capitalized, text: $number)
                        .keyboardType(.numberPad)
                    
                    TextField("credit limit".capitalized, text: $limit)
                        .keyboardType(.numberPad)
                    
                    Picker("Type", selection: $cardType) {
                        ForEach(cardTypes, id: \.self) { cardType in
                            Text(String(cardType).capitalized).tag(String(cardType))
                        }
                    }
                } header: {
                    Text("card information".uppercased())
                }
                
                Section {
                    Picker("Month", selection: $month) {
                        ForEach(1..<13, id: \.self) { num in
                            Text(String(num)).tag(String(num))
                        }
                    }
                    
                    Picker("Year", selection: $year) {
                        ForEach(currentYear..<currentYear+20, id: \.self) { year in
                            Text(String(year)).tag(String(year))
                        }
                    }
                } header: {
                    Text("expiration".uppercased())
                }
                
                Section {
                    ColorPicker("Color", selection: $color)
                } header: {
                    Text("color".uppercased())
                }

            }
            
            .navigationTitle("Add Credit Card")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isPresented.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
        }
    }
}

struct AddCardForm_Previews: PreviewProvider {
    static var previews: some View {
        AddCardForm()
    }
}

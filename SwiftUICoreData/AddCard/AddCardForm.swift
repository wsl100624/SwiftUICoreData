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
    @State private var cardNumber = ""
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
                    
                    TextField("credit card number".capitalized, text: $cardNumber)
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
                    cancelButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }
            }
        }
    }
    
    var cancelButton: some View {
        Button(action: {
            isPresented.wrappedValue.dismiss()
        }, label: {
            Text("Cancel")
        })
    }
    
    var saveButton: some View {
        Button(action: {
            let viewContext = PersistenceController.shared.container.viewContext
            let card = Card(context: viewContext)
            card.timestamp = Date()
            card.name = self.name
            card.number = self.cardNumber
            card.limit = Int32(self.limit) ?? 0
            card.expMonth = Int16(self.month)
            card.year = Int16(self.year)
            card.color = UIColor(self.color).encode()
            card.type = cardType
            
            do {
                try viewContext.save()
                isPresented.wrappedValue.dismiss()
            } catch let error {
                print(error)
            }
        }, label: {
            Text("Save")
        })
    }
}

struct AddCardForm_Previews: PreviewProvider {
    static var previews: some View {
        AddCardForm()
    }
}

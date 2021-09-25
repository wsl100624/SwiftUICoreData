//
//  MainView.swift
//  MainView
//
//  Created by Will Wang on 9/12/21.
//

import SwiftUI

struct MainView: View {
    
    @State private var presentCardForm = false
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Card.timestamp, ascending: true)],
        animation: .default)
    private var cards: FetchedResults<Card>
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                if !cards.isEmpty {
                    TabView {
                        ForEach(cards) { card in
                            CreditCardView(card: card)
                                .padding(.bottom, 50)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .frame(height: 280)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                }
                
                Spacer()
                    .fullScreenCover(isPresented: $presentCardForm, onDismiss: nil) {
                        AddCardForm()
                    }

            }
            .navigationTitle("Credit Cards")
            .navigationBarItems(leading: HStack {
                addItemButton
                deleteAllButton
            }, trailing: addCardButton)
            
        }
    }
    
    var deleteAllButton: some View {
        Button(action: {
            cards.forEach { card in
                viewContext.delete(card)
            }
            do {
                try viewContext.save()
            } catch let error {
                print(error)
            }
        }, label: {
            Text("Delete All")
        })
    }
    
    var addItemButton: some View {
        Button(action: {
            withAnimation {
                let viewContext = PersistenceController.shared.container.viewContext
                let card = Card(context: viewContext)
                card.timestamp = Date()

                do {
                    try viewContext.save()
                } catch let error {
                    print(error)
                }
            }
        }, label: {
            Text("Add Item")
        })
    }
    
    var addCardButton: some View {
        Button(action: {
            presentCardForm.toggle()
        }, label: {
            Text("+ card".capitalized)
                .foregroundColor(Color(.systemBlue))
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                .background(Color(.systemFill))
                .font(.callout.bold())
                .cornerRadius(5)
        })
    }
}

struct CreditCardView: View {
    
    let card: Card
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            Text(card.name ?? "")
                .font(.title.bold())
            HStack {
                Image(card.type?.lowercased() ?? "visa")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 44)
//                    .clipped()
                Spacer()
                Text("Balance: $5,000")
                    .font(.headline)
            }
            
            Text(card.number ?? "")
            Text("Credit Limit: $\(card.limit)")
        }
        .foregroundColor(.white)
        .padding()
        .background(
            VStack {
                if let colorData = card.color,
                   let color = UIColor.color(data: colorData),
                   let actualColor = Color(color) {
                    LinearGradient(colors: [actualColor.opacity(0.6), actualColor], startPoint: .center, endPoint: .bottom)
                } else {
                    Color.purple
                }
                
            }
            
        )
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.secondary, lineWidth: 1))
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        MainView()
            .environment(\.managedObjectContext, viewContext)
    }
}

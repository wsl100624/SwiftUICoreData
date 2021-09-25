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
        sortDescriptors: [NSSortDescriptor(keyPath: \Card.timestamp, ascending: false)],
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
                } else {
                    emptyPromptMessage
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
    
    private var emptyPromptMessage: some View {
        VStack {
            Text("You currectly have no cards in the system.")
                .padding(.horizontal, 48)
                .padding(.vertical)
                .multilineTextAlignment(.center)
            Button {
                presentCardForm.toggle()
            } label: {
                Text("+ add your first card".capitalized)
                    .foregroundColor(Color(.systemBackground))
            }
            .padding()
            .background(Color(.label))
            .cornerRadius(12)
        }.font(.subheadline.bold())
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


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        MainView()
            .environment(\.managedObjectContext, viewContext)
    }
}

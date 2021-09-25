//
//  CreditCardView.swift
//  SwiftUICoreData
//
//  Created by Will Wang on 9/24/21.
//

import SwiftUI

struct CreditCardView: View {
    
    let card: Card
    
    @State private var shouldShowActionSheet = false
    
    private func handleDelete() {
        let viewContext = PersistenceController.shared.container.viewContext
        viewContext.delete(card)
        
        do {
            try viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            HStack {
                Text(card.name ?? "")
                    .font(.title.bold())
                Spacer()
                
                Button {
                    shouldShowActionSheet.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title)
                }
                .actionSheet(isPresented: $shouldShowActionSheet) {
                    .init(title: Text("Delete This Card?"), buttons: [
                        .destructive(Text("Delete"), action: handleDelete),
                        .cancel()
                    ])
                }
            }
            
            
            HStack {
                Image(card.type?.lowercased() ?? "visa")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 44)
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

//struct CreditCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreditCardView()
//    }
//}

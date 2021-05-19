//
//  ContentView.swift
//  Shared
//
//  Created by José Mateus Azevedo on 11/05/21.
// swiftlint:disable identifier_name

import SwiftUI

struct ContentView: View {

    @State private var newItem = ""
    @State private var allItens: [ItemList] = []
    private let key = "ItensKey"
    @State var showSheet = false

    var body: some View {
        NavigationView {
          VStack {
            MoneyDetails()
            HStack {
                Text("Minha Lista")
                Spacer()
                Button("Adicionar produto") {
                    showSheet.toggle()
                }.sheet(isPresented: self.$showSheet, content: {
                    Text("sfsdfdsf")
                })
            }.padding()

            List {
                ForEach(allItens) { item in
                    ListRow(item: ProductItem(id: UUID.init(), name: "arroz", price: 32.99, itemNumber: 4))
                }
                .onDelete(perform: deleteItem)
                .onTapGesture {
                    self.showSheet.toggle()
                }
            }
            .sheet(isPresented: self.$showSheet, content: {
                Text("sfsdfdsf")
            })
          }
          .navigationBarTitle("Compras da semana")
          .listStyle(GroupedListStyle())
        }
        .onAppear(perform: loadList)
    }

      private func saveList() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.allItens), forKey: key)
      }

      private func loadList() {
        if let todosData = UserDefaults.standard.value(forKey: key) as? Data {
          if let todosList = try? PropertyListDecoder().decode(Array<ItemList>.self, from: todosData) {
            self.allItens = todosList
          }
        }
      }

      private func deleteItem(at offsets: IndexSet) {
        self.allItens.remove(atOffsets: offsets)
        saveList()
      }
}

struct ItemList: Codable, Identifiable {
    var id = UUID()
    let itemName: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

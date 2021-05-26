//
//  ContentView.swift
//  Shared
//
//  Created by José Mateus Azevedo on 11/05/21.
// swiftlint:disable identifier_name

import SwiftUI

struct ContentView: View {

    @State var showSheet = false
    @StateObject var shoppingListVM = ShoppingListViewModel()
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    MoneyDetails(shoppingListVM: shoppingListVM)
                    HStack {
                        Text("Minha Lista")
                            .font(Font.custom(FontNameManager.Poppins.bold, size: 24))
                        Spacer()
                        Button(action: {
                            showSheet.toggle()
                        }) {
                            Text("Adicionar produto")
                                .frame(height: 10)
                                .font(Font.custom(FontNameManager.Poppins.medium, size: 17))
                                .padding()
                                .background(Color("AccentColor"))
                                .foregroundColor(Color("TitleColor"))
                                .cornerRadius(40)
                        }
                    }.padding()

                    List {
                        ForEach(shoppingListVM.itens, id: \.id) { item in
                            ListRow(item: ItemList(name: item.name, price: item.price, quantity: item.quantity, isChecked: item.isChecked))
                        }
                        .onDelete(perform: deleteItem)
                        .onTapGesture {
                            self.showSheet.toggle()
                        }
                    }
                }
                .navigationBarTitle("\(shoppingListVM.objective)")
                .listStyle(GroupedListStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(
                            destination: SettingsView(shoppingListVM: shoppingListVM),
                            label: {
                                Image(systemName: "gearshape.fill")
                            })
                    }
                }
                .background(Color("BackgroundColor"))
            }
            .onAppear(perform: {
                shoppingListVM.getAllItens()
            })
            AddProductModalView(isShowing: $showSheet, shoppingListVM: shoppingListVM)
        }
    }

    func deleteItem(at offsets: IndexSet) {
            offsets.forEach { index in
                let item = shoppingListVM.itens[index]
                shoppingListVM.delete(item)
            }
            shoppingListVM.getAllItens()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

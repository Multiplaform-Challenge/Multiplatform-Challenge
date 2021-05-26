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
    @StateObject var shoppingList = ShoppingListDemo()

    private var view: some View {
        VStack {
            #if os(iOS)
            MoneyDetails()
            #endif
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
                .buttonStyle(BorderlessButtonStyle())
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
    }
    #if os(iOS)
    //    init() {
    //        let appearance = UINavigationBar.appearance()
    //        appearance.largeTitleTextAttributes = [.font : UIFont(name: FontNameManager.Poppins.bold, size: 30)!]
    //        appearance.backgroundColor = UIColor(named: "BackgroundColor")
    //    }
    #endif

    var body: some View {
        ZStack {
            #if os(macOS)
            view
                .listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: {
                            NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                        }) {
                            Image(systemName: "sidebar.left")
                        }
                        .keyboardShortcut("S", modifiers: .command)
                    }
//                    .listStyle(PlainListStyle())
//                    .colorMultiply(Color("BackgroundColor")).padding(.top)
                }
                .onAppear(perform: {
                    shoppingListVM.getAllItens()
                })
            #else
            //            NavigationView {
            view
                .navigationBarTitle("Compras da semana")
                .listStyle(GroupedListStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(
                            destination: SettingsView(shoppingList: shoppingList),
                            label: {
                                Image(systemName: "gearshape.fill")
                            })
                    }
                }
                .background(Color("BackgroundColor"))
                .onAppear(perform: {
                    shoppingListVM.getAllItens()
                })
            AddProductModalView(isShowing: $showSheet, shoppingListVM: shoppingListVM)
        //}
            #endif
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

class ShoppingListDemo: ObservableObject {
    @Published var objective: String = ""
    @Published var budget: Double = 0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

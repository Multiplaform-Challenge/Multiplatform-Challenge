//
//  ContentView.swift
//  Shared
//
//  Created by José Mateus Azevedo on 11/05/21.
// swiftlint: disable identifier_name

import SwiftUI
import UIKit

enum TypeModal {
    case addModal
    case editModal
}

struct ContentView: View {

    @State var showSheet = false
    @State var showWithoutPriceModal = false
    @State var isShowDeleteConfirmation = false

    @State var showLimitModal = false

    @State var itemSelect: ProductItem?
    #if os(iOS)
    @StateObject var shoppingListVM = ShoppingListViewModel()
    #else
    @StateObject var shoppingListVM: ShoppingListViewModel
    #endif

    @State var typeModal: TypeModal = .addModal
    @State var isEdit: Bool = false

    private var view: some View {
        VStack {
            #if os(iOS)
            MoneyDetails(shoppingListVM: shoppingListVM)
            #endif
            HStack {
                Text("Minha Lista")
                    .font(Font.custom(FontNameManager.Poppins.bold, size: 24))
                Spacer()
                Button(action: {
                    showSheet.toggle()
                    self.typeModal = .addModal
                    self.isEdit = false
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
            }
            .padding()
            List {
                ForEach(shoppingListVM.itens, id: \.id) { item in
                    #if os(iOS)
                    ListRow(item: item,
                            isShowingWithoutPriceModal: $showWithoutPriceModal,
                            isShowingLimitModal: $showLimitModal,
                            isShowDeleteConfirmation: $isShowDeleteConfirmation, action: {
                                self.itemSelect = item
                            },
                            shoppingListVM: shoppingListVM)
                        .onTapGesture {
                            self.itemSelect = item
                            self.typeModal = .editModal
                            self.showSheet.toggle()
                        }
                        .hideRowSeparator()
                    #else
                    ListRow(item: item,
                            isShowingWithoutPriceModal: $showWithoutPriceModal,
                            isShowingLimitModal: $showLimitModal,
                            isShowDeleteConfirmation: $isShowDeleteConfirmation,
                            action: {
                                self.itemSelect = item
                            },
                            shoppingListVM: shoppingListVM)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .onTapGesture {
                            self.itemSelect = item
                            self.isEdit = true
                            self.showSheet.toggle()
                        }
                    #endif
                }
                .onDelete(perform: deleteItem)
            }
            .listStyle(PlainListStyle())
            .colorMultiply(Color("BackgroundColor")).padding(.top)
        }
        .background(Color("BackgroundColor"))
    }
    #if os(iOS)
    init() {
        let appearance = UINavigationBar.appearance()
        appearance.largeTitleTextAttributes = [.font : UIFont(name: FontNameManager.Poppins.bold, size: 30)!]
        appearance.backgroundColor = UIColor(named: "BackgroundColor")
    }
    #endif
    var body: some View {
        ZStack {
            #if os(macOS)
            view
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: {
                            NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
                        }) {
                            Image(systemName: "sidebar.left")
                        }
                        .keyboardShortcut("S", modifiers: .command)
                    }
                }
                .onAppear(perform: {
                    shoppingListVM.getAllItens()
                })
                .sheet(isPresented: $showSheet, content: {
                    AddProductMac(shoppingListVM: shoppingListVM,
                                  showModal: $showSheet,
                                  isEdit: $isEdit,
                                  item: itemSelect)
                })
                .sheet(isPresented: $showLimitModal, content: {
                    LimitModalMac(showModal: $showLimitModal,
                                  shoppingListVM: shoppingListVM,
                                  item: itemSelect)
                })
                .sheet(isPresented: $showWithoutPriceModal, content: {
                    WithoutPriceMac(showModal: $showWithoutPriceModal,
                                  shoppingListVM: shoppingListVM,
                                  item: itemSelect)
                })
                .sheet(isPresented: $isShowDeleteConfirmation, content: {
                      DeleteConfirmationMac(showModal: $isShowDeleteConfirmation,
                      shoppingListVM: shoppingListVM,
                      item: itemSelect)
                })
            #else
            NavigationView {
                view
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(
                                destination: SettingsView(shoppingListVM: shoppingListVM),
                                label: {
                                    Image(systemName: "gearshape.fill")
                                })
                        }
                    }
                    .navigationBarTitle("\(shoppingListVM.objective)")
            }
            .onAppear(perform: {
                shoppingListVM.getAllItens()
            })
            LimitModalView(isShowing: $showLimitModal,
                           shoppingListVM: shoppingListVM,
                           item: itemSelect)
            WithoutPriceModalView(isShowing: $showWithoutPriceModal,
                                  shoppingListVM: shoppingListVM,
                                  item: itemSelect)
            modalView(typeModal)
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
    #if os(iOS)
    func modalView(_ type: TypeModal) -> some View {
        switch type {
        case .addModal:
            return AddProductModalView(isEdit: false,
                                       isShowing: $showSheet,
                                       shoppingListVM: shoppingListVM)
        case .editModal:
            return AddProductModalView(isEdit: true,
                                       item: itemSelect,
                                       isShowing: $showSheet,
                                       shoppingListVM: shoppingListVM)
        }
    }
    #endif

}

struct HideRowSeparatorModifier: ViewModifier {
    static let defaultListRowHeight: CGFloat = 44
    var insets: EdgeInsets
    var background: Color

    init(insets: EdgeInsets, background: Color) {
        self.insets = insets
        var alpha: CGFloat = 0
        UIColor(background).getWhite(nil, alpha: &alpha)
        self.background = background
    }

    func body(content: Content) -> some View {
        content
            .padding(insets)
            .frame(
                minWidth: 0, maxWidth: .infinity,
                minHeight: Self.defaultListRowHeight,
                alignment: .leading
            )
            .listRowInsets(EdgeInsets())
            .background(background)
    }
}

extension EdgeInsets {
    static let defaultListRowInsets = Self(top: 5, leading: 16, bottom: 14, trailing: 16)
}

extension View {
    func hideRowSeparator(insets: EdgeInsets = .defaultListRowInsets, background: Color = .white) -> some View {
        modifier(HideRowSeparatorModifier(insets: insets, background: background))
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

//
//  MoneyDetails.swift
//  SwiftUITests
//
//  Created by José Mateus Azevedo on 14/05/21.
//

import SwiftUI

struct MoneyDetails: View {
    var body: some View {
        HStack(spacing: 5) {
            VStack(alignment: .center) {
                Text("Orçamento")
                Text("R$ 100.00")
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray))

            VStack(alignment: .center, spacing: 2) {
                VStack {
                    Text("Total da lista")
                    Text("R$ 100.00")
                        .bold()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray))

                VStack {
                    Text("Disponível")
                    Text("R$ 100.00")
                        .bold()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray))
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white))
        .frame(width: 400, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct MoneyDetails_Previews: PreviewProvider {
    static var previews: some View {
        MoneyDetails()
    }
}

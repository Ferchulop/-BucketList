//
//  ProtocolComparable.swift
//  Project 14. BucketList
//
//  Created by Fernando Jurado on 9/12/24.
//

import SwiftUI
// Uso de protocolo Comparable para implementar funcionalidades de ordenación en este caso, aun que también pueden ser de utilidad en búsqueda o filtrado
struct User: Comparable,Identifiable {
    let id = UUID()
    var firstName: String
    var lastName: String
    // lhs(left hand side), rhs(right hand side), para aclarar la posicion de los operandos en relacion con el operador 
       static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ProtocolComparable: View {
    
    let users = [
        User(firstName: "John", lastName:"Clariane"),
        User(firstName:"Mendoza", lastName: "Kelly"),
        User(firstName: "Orange", lastName: "Killo")
    ].sorted()
    var body: some View {
        List(users) { user in
            Text("\(user.firstName), \(user.lastName)")
        }
    }
}

#Preview {
    ProtocolComparable()
}

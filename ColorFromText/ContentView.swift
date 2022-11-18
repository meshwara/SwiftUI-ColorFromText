//
//  ContentView.swift
//  ColorFromText
//
//  Created by D. Prameswara on 18/11/22.
//

import SwiftUI

extension Color {
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // hex dalam 6 digit, contoh: FF00FF -> 1111111 1111111 1111111
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8: // hex dalam 8 digit, contoh: FF00FFFF -> 1111111 1111111 1111111 1111111
            (r, g, b, a) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
// #A3CCAB #F26800
struct ContentView: View {
    @State private var warnaHex: String = ""
    @State private var warna: Color?
    var body: some View {
        VStack {
            HStack {
                TextField("Kode warna", text: $warnaHex)
                Button("Ganti warna") {
                    warna = Color(hex: warnaHex)
                }
            }

            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean luctus, turpis tristique venenatis lobortis, leo magna posuere magna, ac varius arcu magna at turpis")
                .padding()
                .background(warna != nil ? warna! : .gray)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

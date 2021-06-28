//
//  ContentView.swift
//  BetterRest
//
//  Created by Bruce Gilmour on 2021-06-27.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()

    var body: some View {
        Form {
            stepper1

            datePicker1

            datePicker2
        }
        .padding()
    }

    var stepper1: some View {
        Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
            Text("\(sleepAmount, specifier: "%g") hours")
        }
    }

    var datePicker1: some View {
        DatePicker("Wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
    }

    var datePicker2: some View {
        Section(header: Text("Wake up time")) {
            DatePicker("Wake up time", selection: $wakeUp, in: Date()...)
                .labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

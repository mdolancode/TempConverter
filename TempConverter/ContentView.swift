//
//  ContentView.swift
//  TempConverter
//
//  Created by Matthew Dolan on 2022-09-22.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 0.0
    @State private var inputUnit = UnitTemperature.celsius
    @State private var outputUnit = UnitTemperature.fahrenheit
    @FocusState private var inputFocused: Bool
    
    let units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    let formatter: MeasurementFormatter
    
    var result: String {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Temperature", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputFocused)
                } header: {
                    Text("Amount to Convert")
                }
                Section {
                    Picker("Convert from", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    
                    Picker("Convert to", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                }
                
                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputFocused = false
                    }
                    
                }
            }
        }
    }
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

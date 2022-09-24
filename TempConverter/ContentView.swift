//
//  ContentView.swift
//  TempConverter
//
//  Created by Matthew Dolan on 2022-09-22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Celsius"
    @State private var inputNumber = 0.0
    @FocusState private var inputFocused: Bool
    
    var tempUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertInputUnit: Double {
        // First convert all inputs to Celsius
        var input = inputNumber
        if inputUnit == "Celsius" {
            input += 0
        } else if inputUnit == "Fahrenheit" {
            input = (input - 32) / 1.8
        } else {
            input -= 273.15
        }
        return input
    }

    var convertOutputUnit: Double {
        // Second convert input to output temperature units
        var output = convertInputUnit
        if outputUnit == "Celsius" {
            output += 0
        } else if outputUnit == "Fahrenheit" {
            output = output * 1.8 + 32
        } else {
            output = output + 273.15
        }
        
        return output
    }
    
    var outputUnitToString: String {
        // Convert to string and format.
        let outputString = convertOutputUnit.formatted()
        return "\(outputString) \(outputUnit.lowercased())"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit of temperature", selection: $inputUnit) {
                        ForEach(tempUnits, id: \.self) {
                            Text("\($0)")
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Input Unit")
                }
                
                Section {
                    TextField("Temperature", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputFocused)
                } header: {
                    Text("Temperature to Convert")
                }
                
                Section {
                    Picker("Unit of temperature", selection: $outputUnit) {
                        ForEach(tempUnits, id: \.self) {
                            Text("\($0)")
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Output Unit")
                }
                
                Section {
                    Text(outputUnitToString)
                } header: {
                    Text("Converted Temperature")
                }
            }
            .navigationTitle("TempConverter")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

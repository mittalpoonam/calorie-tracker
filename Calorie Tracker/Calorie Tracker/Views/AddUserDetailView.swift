//
//  SignUpView.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 12/02/24.
//

import SwiftUI

struct AddUserDetailView: View {
    
    // MARK: PROPERTIES
    @StateObject var userDetailVM = UserDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var showAlert: Bool = false
    @State var weight: String = ""
    @State var height: String = ""
    @State var age: String = ""
    @State var gender: String = "Male"
    @State private var showAlertForSuccess: Bool = false
    
    
    // MARK: BODY SECTION
    var body: some View {
        
        ZStack {
            Color.gray
            
                .ignoresSafeArea()
            
            VStack { // START VStack
              
                NameView
                weightView
                heightView
                genderView
                ageView
                instructionView
                buttonSignUp
                Spacer()
                   
                    .alert(isPresented: $showAlert) {
                        showAlert(title: "wrong input for weight or height or age")
                    }
                    .navigationTitle("Sign Up")
            } //END VStack
            .padding(.vertical)
        }
     
    }
    
 
}

struct AddUserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserDetailView()
    }
}

//MARK: COMPONENTS
extension AddUserDetailView {
        
    private var NameView: some View {
        VStack(spacing:10) {
            Text("Name")
                .font(.title)
                .frame(width: 350, alignment: .leading)
            
            TextField("Enter Name", text: $userDetailVM.name)
                .frame(height: 30)
                .background(Color.white)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
    }
    
        private var weightView: some View {
            VStack(spacing:10){
                Text("Weight")
                    .font(.title)
                    .frame(width: 350, alignment: .leading)
                
                TextField("Enter Weight", text: $weight)
                    .frame(height: 30)
                    .background(Color.white)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
        }
    }
    
    private var heightView: some View {
        VStack(spacing:10) {
            Text("Height")
                .font(.title)
                .frame(width: 350, alignment: .leading)
            
            TextField("Enter Height", text: $height)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 30)
                .background(Color.white)
                .padding(.horizontal)
        }
    }
    
    private var genderView: some View {
        VStack(spacing:10) {
            Text("Gender")
                .font(.title)
                .frame(width: 350, alignment: .leading)
            
            Picker(selection: $gender) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
            } label: {
                Text("Select Gender")
                    .frame(width: 350, height: 30)
                    .accentColor(.white)
                    .background(Color.white)
                    .padding(.horizontal)
            }
            .pickerStyle(MenuPickerStyle())
            .frame(width: 350, alignment: .leading)
            .background(Color.white)
            .cornerRadius(6)
            
        }
        
    }
    
    private var ageView: some View {
        VStack(spacing:10) {
            Text("Age")
                .font(.title)
              
                .frame(width: 350, alignment: .leading)
            
            TextField("Enter Age", text: $age)
                .frame(height: 30)
                .background(Color.white)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
    }
    
    private var instructionView: some View {
        Text("Weight should be in kg, Height should be in cm. Write input without Units")
        
            .frame(width: 350, height: 45, alignment: .leading)
            .padding()
    }
    
    private var buttonSignUp: some View {
        
        
        Button {
            
            if let wei = Float(weight),
               let hei = Float(height),
               let ag = Int(age)
            {
                userDetailVM.weight = String(wei)
                userDetailVM.height = String(hei)
                userDetailVM.age = String(ag)
                userDetailVM.sex = gender
                
                afterSaveCallForBMR(weight: wei, height: hei, age: ag)
                userDetailVM.save()
                showAlertForSuccess = true
                //presentationMode.wrappedValue.dismiss()
                
            }else{
                showAlert = true
            }
            print(URL.documentsDirectory)
        } label: {
            Text("Save")
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .font(.title2)
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 30)
        }
        .alert(isPresented: $showAlertForSuccess) {
           Alert(title: Text("Information saved successfully"), message: nil, dismissButton: .default(Text("OK")) {
               presentationMode.wrappedValue.dismiss()
           })
        }

    }
    
}


//MARK: LOGIC/FUNCTION
extension AddUserDetailView {
    func showAlert(title: String) -> Alert {
        return Alert(title: Text(title))
    }
    
    
    func calculateBMRForMen(weight: Float, height: Float, age: Int) -> Float{
        
        let a:Float = 66.4730
        let b = 13.7516*weight
        let c = 5.0033*height
        let d = 6.7550*Float(age)
        
        return (a+b+c-d)
        
    }
    
    func calculateBMRForWomen(weight: Float, height: Float, age: Int) -> Float{
        
        let a:Float = 655.0955
        let b = 9.5634*weight
        let c = 1.8496*height
        let d = 4.6756*Float(age)
        
        return (a+b+c-d)
    }
    
    func afterSaveCallForBMR(weight: Float, height: Float, age: Int){
        if gender == "Male" {
            let bmr =  calculateBMRForMen(weight: weight, height: height, age: age)
         
            userDetailVM.bmr = String(format: "%.2f", bmr)
            
            
        }else{
            
            let bmr =  calculateBMRForWomen(weight: weight, height: height, age: age)
            
            userDetailVM.bmr = String(format: "%.2f", bmr)
        }
    }
    
}

//
//  AddDataView.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 14/02/24.
//

import SwiftUI

struct AddDataView: View {
    
    //MARK: PROPERTIES
    @State var selection: String = "Add Food"

    let filterOptions: [String] = ["Add Food", "Add Activity"]
  
    let filterOptionForFoodName: [String] = ["Beans", "Vegetable", "Fast Food", "fruits"]
    
    let filterOptionForMealType: [String] = ["Breakfast", "Lunch", "Dinner"]

    let filterOptionForFoodGroup: [String] = ["Beans", "Vegetable", "Fast Food", "fruits"]

    let filterOptionForActivity: [String] = ["Bicycling", "Mountain", "Racing"]
 
   
    @State var showAlert: Bool = false
    @StateObject var foodDetailVM = FoodDetailViewModel()
    @StateObject var activityDetailVM = ActivityDetailViewModel()
    @StateObject var userDetailVM = UserDetailViewModel()
    @State var individualUser: User
    
    @State var metValue: String = ""
    @State var startDate: Date = Date()
    @State var endDate: Date = Date()
    @State var calorieIn: String = ""
    @State var serving: String = ""
    
    @Environment(\.presentationMode) var presentationMode

   
    
    //MARK: BODY SECTION
    var body: some View {
        ZStack {
            Color.gray

            .ignoresSafeArea()
            VStack {
              addSegmentedPicker
                if selection == filterOptions[0]{
                  
                    addFoodContent
                }else{
                
                    addActivityContent
                }
                Spacer()
            }
            .alert(isPresented: $showAlert) {
                showAlert(title: "wrong input")
            }
            .navigationTitle("Add Data")
        }
    }
    
}


struct AddDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddDataView(individualUser: User())
    }
}

//MARK: COMPONENETS
extension AddDataView {
    
    private var addSegmentedPicker: some View {
        Picker(selection: $selection) {
            ForEach(filterOptions.indices) { index in
                Text(filterOptions[index]).tag(filterOptions[index])
            }
                
        } label: {
           
            Text("Picker")
        }
        .pickerStyle(SegmentedPickerStyle())
        .background(Color.white)
        .padding()
    }
    
    private var addFoodContent: some View {
        
        VStack {
            HStack {
                Text("Select Date")
                Spacer()
                DatePicker("", selection: $foodDetailVM.date, displayedComponents: .date)
            }

            HStack {
                Text("Select Food Name")
                Spacer()
                
                Picker(selection: $foodDetailVM.foodName) {
                    ForEach(filterOptionForFoodName.indices) { index in
                        Text(filterOptionForFoodName[index]).tag(filterOptionForFoodName[index])
                    }
                } label: {
                    Text("Picker")
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 150)
                .background()
                
            }
            
            HStack {
                Text("Select Meal Type")
                Spacer()
                
                Picker(selection: $foodDetailVM.mealType) {
                    ForEach(filterOptionForMealType.indices) { index in
                        Text(filterOptionForMealType[index]).tag(filterOptionForMealType[index])
                    }
                } label: {
                    Text("Picker")
                }
                .frame(width: 150)
                .background()
                
            }
            
            HStack {
                Text("Select Food Group")
                Spacer()
                
                Picker(selection: $foodDetailVM.foodGroup) {
                    ForEach(filterOptionForFoodGroup.indices) { index in
                        Text(filterOptionForFoodGroup[index]).tag(filterOptionForFoodGroup[index])
                    }
                } label: {
                    Text("Picker")
                }
                .frame(width: 150)
                .background()
                
            }
            
            HStack {
                Text("Serving")
                Spacer()
                TextField("Serving", text: $serving)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .frame(width: 150)
                    .background(Color.white)
            }
            HStack {
                Text("Calorie In")
                Spacer()
                TextField("CaloriIn", text: $calorieIn)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .frame(width: 150)
                    .background(Color.white)
            }
            
            HStack {
                Button {
                    
                    if let calorie = Float(calorieIn),
                       let serve = Float(serving)
                       
                    {
                        
                        if let id = individualUser.userId {
                            foodDetailVM.userId = id
                        }
                        foodDetailVM.serving = String(serve)
                        foodDetailVM.calorieIn = String(calorie)
                        
                        foodDetailVM.save()
                      
                        presentationMode.wrappedValue.dismiss()
                        
                    }else{
                        showAlert = true
                    }

                } label: {
                    Text("Save")
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(20)
                        .padding(.vertical, 50)
                       
                }

            }
        }
    }
    
    private var addActivityContent: some View {
        VStack {
            HStack {
                Text("Select Date")
                Spacer()
                DatePicker("", selection: $activityDetailVM.date, displayedComponents: .date)
            }
            HStack {
                Text("Activity Name")
                Spacer()
                
                Picker(selection: $activityDetailVM.activityName) {
                    ForEach(filterOptionForActivity.indices) { index in
                        Text(filterOptionForActivity[index]).tag(filterOptionForActivity[index])
                    }
                } label: {
                    Text("Picker")
                }
                .frame(width: 150)
                .background()
                
            }
            
            HStack {
                Text("Activity Description")
                Spacer()
                TextField("Description", text: $activityDetailVM.activityDesc)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .frame(width: 150, height: 100)
                    .background(Color.white)
            }
            
      
            HStack {
                Text("MET Value")
                Spacer()
                TextField("value", text: $metValue)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    .frame(width: 150)
                    .background(Color.white)
            }
            HStack {
                Text("Start Time")
                Spacer()
                DatePicker("", selection: $startDate, displayedComponents: [.hourAndMinute])
            }
            
            HStack {
                Text("End Time")
                Spacer()
                DatePicker("", selection: $endDate, displayedComponents: [.hourAndMinute])
            }
            
            
            HStack {
                Button {
                    
                    if let met = Float(metValue)
                    {
                        
                        if let id = individualUser.userId {
                            activityDetailVM.userId = id
                        }
                       
                        activityDetailVM.metValue = String(met)
                        activityDetailVM.startTime = startDate
                        activityDetailVM.endTime = endDate
                        
                       
                        if let unwrapMetValue = Float(metValue),
                           let unwrapWeight1 = individualUser.weight
                        {
                            if let unwrapWeight2 = Float(unwrapWeight1) {
                                let calorieOut = CommonFuncs.calculateCaloriesOutDuringActivities(metValue: unwrapMetValue, weight: unwrapWeight2 , startDate: startDate, endDate: endDate)
                                
                                activityDetailVM.calorieOut = String(format: "%.2f" , calorieOut)
                            }
                        }
                        activityDetailVM.save()
                       
                        presentationMode.wrappedValue.dismiss()
                        print(URL.documentsDirectory)
                       
                    }else{
                        showAlert = true
                    }

                } label: {
                    Text("Save")
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(20)
                        .padding(.vertical, 50)
                       
                }

            }
        }
    }
}


extension AddDataView {
    func showAlert(title: String) -> Alert {
        return Alert(title: Text(title))
    }
}

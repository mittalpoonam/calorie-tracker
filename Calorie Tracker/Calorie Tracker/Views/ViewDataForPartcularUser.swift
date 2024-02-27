//
//  ViewDataForPartcularUser.swift
//  Calorie Tracker
//
//  Created by poonam mittal on 14/02/24.
//

import SwiftUI

struct ViewDataForPartcularUser: View {
    
    
    //MARK: PROPERTIES
    @State var foodDetailVM: FoodDetailViewModel = FoodDetailViewModel()
    
    @State var activityDetailVM: ActivityDetailViewModel = ActivityDetailViewModel()
    
    @State var currentUser: User
 
    @State var arrCombineFoodAndActivityDate = [Date]()
    @State var uniqueDates: Set<String> = []
    
    
    //MARK: BODY SECTION
    var body: some View {
        ZStack { //START ZStack
            Color.gray
            
            .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: true) {
                VStack { //Start VStack
                    
                    headerViewForData
                    viewForData
                   
                    Spacer()
                    
                }// ENd VStack
                
                .navigationTitle("All Data")
                .onAppear {
                    foodDetailVM = FoodDetailViewModel()
                    activityDetailVM = ActivityDetailViewModel()
                    filterOutUniqueDates()
                    
                }
            }
        } //END ZStack

    }
}

struct ViewDataForPartcularUser_Previews: PreviewProvider {
    
    static var previews: some View {
        ViewDataForPartcularUser(currentUser: User())
    }
}

//MARK: COMPONENTS
extension ViewDataForPartcularUser {
    
    private var headerViewForData: some View {
        HStack {
            Text("Date")
                .font(.system(size: 10))
                .frame(width: 60, height: 17, alignment: .leading)
                .bold()
            Text("BMR")
                .font(.system(size: 10))
                .frame(width: 45, height: 17, alignment: .leading)
                .bold()
            Text("Calorie In")
                .font(.system(size: 10))
                .frame(width: 65, height: 17, alignment: .leading)
                .bold()
            Text("Calorie Out")
                .font(.system(size: 10))
                .frame(width: 65, height: 17, alignment: .leading)
                .bold()
            Text("Net Calorie")
                .font(.system(size: 10))
                .frame(width: 70, height: 17, alignment: .leading)
                .bold()
            Text("Action")
                .font(.system(size: 10))
                .frame(width: 40, height: 17, alignment: .leading)
                .bold()
        }
    }
    
    private var viewForData: some View {
        ForEach(uniqueDates.sorted(by: >), id: \.self) { date in
            HStack {
                Text("\(date)")
                    .font(.system(size: 10))
                    .frame(width: 60, height: 17, alignment: .leading)
                if let bmr = currentUser.bmr {
                    Text(bmr)
                        .font(.system(size: 10))
                        .frame(width: 45, height: 17, alignment: .leading)
                }
                
                let calorieIn = calculateCalorieInTotal(date: date)
                Text("\(calorieIn, specifier: "%.2f")")
                    .font(.system(size: 10))
                    .frame(width: 65, height: 17, alignment: .leading)
                
                let calorieOut = calculateCaloriesOutInTotal(date: date)
                Text("\(calorieOut, specifier: "%.2f")")
                    .font(.system(size: 10))
                    .frame(width: 65, height: 17, alignment: .leading)
                
                if let bmr = currentUser.bmr {
                    
                    if let unwrapBMR = Float(bmr) {
                        let netCalorie = calorieIn - (calorieOut + unwrapBMR)
                        
                        Text("\(netCalorie, specifier: "%.2f")")
                            .font(.system(size: 10))
                            .frame(width: 70, height: 17, alignment: .leading)
                    }
                    
                }
                
                
                NavigationLink {
                    
                    DetailView(currentUser: currentUser, date: date)
                } label: {
                    Text("View")
                        .font(.system(size: 10))
                        .frame(width: 40, alignment: .leading)
                        .foregroundColor(.white)
                        .background(Color.black)
                }
            }
            
        }
    }
    
}



//MARK: LOGIC/FUNCTIONS
extension ViewDataForPartcularUser {
  
  
    func calculateCalorieInTotal(date: String) -> Float{
        var totalCalorieIn: Float = 0.0
               for food in foodDetailVM.foods {
                   if let userDate1 = food.date {
                       let userDate = CommonFuncs.dateFormatting(date: userDate1)
                       if food.userId == currentUser.userId  && date == userDate  {
                           
                           if let caloriIn = food.calorieIn
                                
                           {
                               let wrapppedCalorieIn = Float(caloriIn)
                               if let wrapppedCalorieIn {
                                   totalCalorieIn += wrapppedCalorieIn
                               }
                           }
                           
                       }
                       
                   }
               }
        return totalCalorieIn
    }
    
    
    func calculateCaloriesOutInTotal(date: String) -> Float{
        var totalCaloriOut: Float = 0.0
        
        for activity in activityDetailVM.activities{ // for loop start
            if let userDate1 = activity.date{
                
                let userDate = CommonFuncs.dateFormatting(date: userDate1)
                if activity.userId == currentUser.userId && date == userDate{ // if condition start
                   
                    if let metValue = activity.metValue,
                        let weight = currentUser.weight,
                        let startTime = activity.startTime,
                        let endTime = activity.endTime {
                         
                         let unwrappedMetValue = Float(metValue)
                         let unwrappedWeight = Float(weight)
                             
                         if let met = unwrappedMetValue, let w = unwrappedWeight {
                             let calorieOutForActivity = CommonFuncs.calculateCaloriesOutDuringActivities(metValue: met, weight: w, startDate: startTime, endDate: endTime)
                             
                             totalCaloriOut += calorieOutForActivity
                         }
                 }
   
                } // if condition end
            }
        } // for loop close
        return totalCaloriOut
    }
    
    func filterOutUniqueDates(){
      
       for food in foodDetailVM.foods {
           if food.userId == currentUser.userId {
               if let date = food.date{
                   arrCombineFoodAndActivityDate.append(date)
               }
          
           }
       }
        for activity in activityDetailVM.activities {
            if activity.userId == currentUser.userId {
                
                if let date = activity.date
                {
                    arrCombineFoodAndActivityDate.append(date)
                    
                }
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDates = arrCombineFoodAndActivityDate.map { dateFormatter.string(from: $0) }
        
       uniqueDates = Set(formattedDates)

    }
    
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/components/widget/custom_text_widget.dart';
import 'package:weather_app/core/constants/color_constants.dart';
import 'package:weather_app/core/constants/string_constants.dart';
import 'package:weather_app/core/enums/image_constants.dart';
import 'package:weather_app/ui/cubit/home_cubit.dart';
import 'package:weather_app/ui/cubit/weather_state.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {
  var cityList = StringConstants.cityList;
  var currentIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getWeather();
    context.read<HomeCubit>().getCityFromLocation();
  }
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(gradient: ColorConstants.backgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocBuilder<HomeCubit,WeatherState>(
                  builder: (context,state) {
                    var selectedCity = "";
                    if(state is WeatherCompleted){
                      return SizedBox(
                        width: 250,
                        height: 50,
                        child: DropdownButtonFormField(
                          dropdownColor: ColorConstants.white10,
                          decoration: const InputDecoration(border: InputBorder.none,icon: Icon(Icons.location_on_outlined,color: ColorConstants.white,)),
                          value: state.city,
                          icon: const Icon(Icons.keyboard_arrow_down,color: ColorConstants.white,),
                          items: cityList.map((city){
                            return DropdownMenuItem(
                                value: city,
                                child: Text(city,style: const TextStyle(  fontSize: 18,fontWeight: FontWeight.normal,color: ColorConstants.white),));
                          }).toList(), onChanged: (value) {
                            selectedCity = value!;
                            context.read<HomeCubit>().getWeatherByCity(selectedCity);
                        },),
                      );

                    }else{
                      return  SizedBox(width: screenWidth * 0.09,height: screenWidth * 0.09,child: const CircularProgressIndicator(color: ColorConstants.white,));
                    }
                  }
                ),
              ),
              BlocBuilder<HomeCubit,WeatherState>(builder: (context, state) {
                if(state is WeatherCompleted){
                  var currentDay = state.response[currentIndex];
                  var word = currentDay.description.toString();
                  String description = word[0].toUpperCase() + word.substring(1);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(currentDay.icon,width: screenWidth * 0.6,height: screenWidth * 0.35,),
                      Text("${double.parse(currentDay.degree).toInt()}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 64,color: ColorConstants.white),),
                      Text(description,style: const TextStyle( fontSize: 18,fontWeight: FontWeight.normal,color: ColorConstants.white),),
                      Text("Max ${double.parse(currentDay.max).toInt()}°  Min ${double.parse(currentDay.min).toInt()}°",style: const TextStyle( fontSize: 18,fontWeight: FontWeight.normal,color: ColorConstants.white),),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: const Color(
                              0xFF0E366C)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(CupertinoIcons.moon,color: ColorConstants.white,),
                                     SizedBox(width: screenWidth * 0.01),
                                    Text(double.parse(currentDay.night).toInt().toString(),style: const TextStyle( fontSize: 14,fontWeight: FontWeight.normal,color: ColorConstants.white),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(ImageConstants.humidity.toPng,color: ColorConstants.white,height: 24,width: 24,),
                                    SizedBox(width: screenWidth * 0.01),
                                    Text(currentDay.humidity,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: ColorConstants.white),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.air,color: ColorConstants.white,),
                                    SizedBox(width: screenWidth * 0.01),
                                    const Text("20",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: ColorConstants.white),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: const Color(
                              0xFF0E366C)),
                          child: Column(
                            children: [
                               Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextWidget(text: StringConstants.nextForecast),
                                    const Icon(Icons.calendar_month,color: ColorConstants.white,),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: screenWidth * 0.7,
                                child: ListView.builder(
                                  itemCount: state.response.length - 1,
                                  itemBuilder: (context, index) {
                                    var nextForecast = state.response[index + 1];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                             flex: 4,
                                             child: Text(nextForecast.day.toString(),textAlign: TextAlign.start,style: const TextStyle(color: ColorConstants.white),)),
                                          Expanded(
                                              flex: 4,
                                              child: Image.network(nextForecast.icon,width: screenWidth * 0.06,height: screenWidth * 0.06,)),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              children: [
                                                Expanded(child: Text("${double.parse(nextForecast.max).toInt()}°",textAlign: TextAlign.end,style: const TextStyle(color: ColorConstants.white),)),
                                                Expanded(child: Text("${double.parse(nextForecast.night).toInt()}°",textAlign: TextAlign.end,style:  const TextStyle(color: ColorConstants.white60),))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                },),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }else if(state is WeatherInitial){
                  return  Center(
                    child: CustomTextWidget(text: StringConstants.hello),
                  );
                }else if(state is WeatherLoading){
                 return Center(child: CustomTextWidget(text: StringConstants.loading));
                }else{
                  final error = state as WeatherError;
                  return CustomTextWidget(text:error.message);
                }

              },),

            ],
          ),
        ),
      ),
    );
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/string_constants.dart';
import 'package:weather_app/core/model/weather_model.dart';
import 'package:weather_app/ui/cubit/home_cubit.dart';
import 'package:weather_app/ui/cubit/weather_state.dart';



class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getWeatherData();
  }
  @override
  Widget build(BuildContext context) {
    var cityList = StringConstants.cityList;
    var selectedCity = "Ankara";
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF08244F),Color(0xFF134CB5),Color(0xFF0B42AB)],begin: AlignmentDirectional.topCenter,end: AlignmentDirectional.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white10,
                        decoration: const InputDecoration(border: InputBorder.none,icon: Icon(Icons.location_on_outlined,color: Colors.white,)),
                        value: selectedCity,
                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                        items: cityList.map((city){
                        return DropdownMenuItem(
                            value: city,
                            child: Text(city,style: const TextStyle(  fontSize: 18,fontWeight: FontWeight.normal,color: Colors.white),));
                      }).toList(), onChanged: (value) {
                        setState(() {
                          selectedCity = value!;
                          context.read<HomeCubit>().getWeatherDataByCity(selectedCity);
                        });
                      },),
                    ),
                    IconButton(onPressed: () {

                    }, icon: const Icon(Icons.notifications_none,color: Colors.white,))
                  ],
                ),
              ),
              BlocBuilder<HomeCubit,WeatherState>(builder: (context, state) {
                if(state is WeatherCompleted){
                  return Column(
                    children: [
                      Image.network(state.response.first.icon,width: 250,height: 150,),
                      Text(double.parse(state.response.first.degree).toInt().toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 64,color: Colors.white),),
                      Text(state.response.first.status,style: const TextStyle( fontSize: 18,fontWeight: FontWeight.normal,color: Colors.white),),
                      Text("Max ${double.parse(state.response.first.max).toInt()}°  Min ${double.parse(state.response.first.min).toInt()}°",style: const TextStyle( fontSize: 18,fontWeight: FontWeight.normal,color: Colors.white),),

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
                                    const Icon(CupertinoIcons.moon,color: Colors.white,),
                                    const SizedBox(width: 5,),
                                    Text(state.response.first.night,style: const TextStyle( fontSize: 14,fontWeight: FontWeight.normal,color: Colors.white),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset("asset/image/im_humidity2.png",color: Colors.white,height: 24,width: 24,),
                                    const SizedBox(width: 5,),
                                    Text(state.response.first.humidity,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.white),),
                                  ],
                                ),
                                const Row(
                                  children: [
                                    Icon(Icons.air,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    Text("20",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.white),),
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
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Next Forecast",style: TextStyle(color: Colors.white),),
                                    Icon(Icons.calendar_month,color: Colors.white,),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 300,
                                child: ListView.builder(
                                  itemCount: state.response.length - 1,
                                  itemBuilder: (context, index) {
                                    var nextForecast = state.response[index + 1];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: 110,child: Text(nextForecast.day.toString(),textAlign: TextAlign.start,style: const TextStyle(color: Colors.white),)),
                                          Image.network(nextForecast.icon,width: 24,height: 24,),
                                          SizedBox(width:110,child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [

                                              Text("${double.parse(nextForecast.max).toInt()}°",textAlign: TextAlign.end,style: const TextStyle(color: Colors.white),),
                                              Text("${double.parse(nextForecast.night).toInt()}°",textAlign: TextAlign.end,style: const TextStyle(color: Colors.white60),)
                                            ],
                                          )),
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
                  return const Center(
                    child: Text("Hello"),
                  );
                }else if(state is WeatherLoading){
                 return Center(child: CircularProgressIndicator());
                }else{
                  final error = state as WeatherError;
                  return Text(error.message);
                }

              },),

            ],
          ),
        ),
      ),





    );
  }
}

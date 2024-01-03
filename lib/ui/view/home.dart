import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/model/weather_model.dart';
import 'package:weather_app/ui/cubit/home_cubit.dart';



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
    var cityList = <String>["Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale",
      "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay",
      "Isparta", "Mersin", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa",
      "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat",
      "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"];
    var selectedCity = "Ankara";
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF08244F),Color(0xFF134CB5),Color(0xFF0B42AB)],begin: AlignmentDirectional.topCenter,end: AlignmentDirectional.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white10,
                        decoration: InputDecoration(border: InputBorder.none,icon: Icon(Icons.location_on_outlined,color: Colors.white,)),
                        value: selectedCity,

                        icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                        items: cityList.map((city){
                        return DropdownMenuItem(
                            value: city,
                            child: Text(city,style: TextStyle(  fontSize: 18,fontWeight: FontWeight.normal,color: Colors.white),));
                      }).toList(), onChanged: (value) {
                        setState(() {
                          selectedCity = value!;
                        });
                      },),
                    ),
                    IconButton(onPressed: () {

                    }, icon: Icon(Icons.notifications_none,color: Colors.white,))
                  ],
                ),
              ),
              BlocBuilder<HomeCubit,List<WeatherModel>>(builder: (context, state) {
                  return Column(
                    children: [
                      Image.network(state.first.icon,width: 250,height: 150,),
                      Text(state.first.degree,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 64,color: Colors.white),),
                      Text(state.first.status,style: TextStyle( fontSize: 18,fontWeight: FontWeight.normal,color: Colors.white),),
                      Text("Max ${state.first.max}°  Min ${state.first.min}°",style: TextStyle( fontSize: 18,fontWeight: FontWeight.normal,color: Colors.white),),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(
                              0xFF0E366C)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.moon,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    Text(state.first.night,style: TextStyle( fontSize: 14,fontWeight: FontWeight.normal,color: Colors.white),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset("asset/image/im_humidity2.png",color: Colors.white,height: 24,width: 24,),
                                    SizedBox(width: 5,),
                                    Text(state.first.humidity,style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.white),),
                                  ],
                                ),
                                Row(
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
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(
                              0xFF0E366C)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
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
                                  itemCount: state.length - 1,
                                  itemBuilder: (context, index) {
                                    var nextForecast = state[index + 1];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: 110,child: Text(nextForecast.day,textAlign: TextAlign.start,style: TextStyle(color: Colors.white),)),
                                          Image.network(nextForecast.icon,width: 24,height: 24,),
                                          SizedBox(width:110,child: Text("${nextForecast.max.toString()}° ${nextForecast.min}°",textAlign: TextAlign.end,style: TextStyle(color: Colors.white),)),
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

              },),

            ],
          ),
        ),
      ),





    );
  }
}

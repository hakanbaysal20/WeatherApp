import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/model/namaz_model.dart';
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
    return  Scaffold(
      body: BlocBuilder<HomeCubit,List<WeatherModel>>(builder: (context, states) {
        return ListView.builder(
          itemCount: states.length,
          itemBuilder: (context, index) {
        var state = states[index];
        return Column(
            children: [
              Text(state.description),
              Text(state.status),
            ],
        );
        },);

      },),
    );
  }
}

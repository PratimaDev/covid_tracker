import 'package:covid_tracker/View/countries_list.dart';
import 'package:covid_tracker/models/WorldStatsModel.dart';
import 'package:covid_tracker/services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({Key? key}) : super(key: key);
  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}
class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin{
  late final AnimationController _counter = AnimationController(
      duration: Duration(
        seconds: 3,),
      vsync: this)
    ..repeat();
  @override
  void dispose(){
    // TODO: implement dispose
    super.dispose();
    _counter.dispose();
  }
  final colorList = <Color> [
Color(0xff4285F4),
  Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            FutureBuilder(

          future: statsServices.fetchWorldStatsRecords(),
          builder: (context,AsyncSnapshot<WorldStatsModel> snapshot){
              if(!snapshot.hasData){
          return Expanded(
              flex: 1,
              child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
          controller: _counter,

              ));

          }
              else{
          return Column(children: [

           SizedBox(height: 50,),PieChart(
            dataMap:  {
              "Total": double.parse(snapshot.data!.cases.toString()),
              "Recovered": double.parse(snapshot.data!.recovered.toString()),
              "Deaths": double.parse(snapshot.data!.deaths.toString()),
            },
              chartValuesOptions: const ChartValuesOptions(
             showChartValuesInPercentage: true
              )
            ,animationDuration:const Duration(milliseconds: 1200),
            chartType: ChartType.ring,
            colorList: colorList,
            chartRadius: MediaQuery.of(context).size.width/3.2,
            legendOptions:const LegendOptions(
          legendPosition: LegendPosition.left
            ),
          ),
            Padding(
              padding: EdgeInsets.symmetric( vertical: MediaQuery.of(context).size.height * .06 ),
              child: Card(
          child: Column
            (children: [
            ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
            ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
            ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
            ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
            ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
            ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
            ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),


          ],),),)
            ,GestureDetector(


              child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: Color(0xff1aa260),
              borderRadius: BorderRadius.all(Radius.circular(13))
          ),
          child: Center(
            child: Text('Track Countries'),
          ),
              ),
              onTap: (){

          Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen()));
              },
            )


          ],
          );


          }

            })
          ,   ],),),),),
    );
  }
}
class ReusableRow extends StatelessWidget{
  String title,value;
   ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10,right: 10,top:10,bottom: 5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(title),
            Text(value)
        ],),
        SizedBox(height: 5,),
        Divider()

      ],),
    );
  }
}


import 'package:covid_tracker/details_screen.dart';
import 'package:covid_tracker/services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
appBar: AppBar(
  elevation: 0,
backgroundColor: Theme.of(context).scaffoldBackgroundColor,
),
body: SafeArea(child: Column(children: [
        Padding(
   padding: const EdgeInsets.all(8.0),
   child: TextFormField(
     onChanged: (value){
       setState(() {

       });
     },
     controller: searchEditingController,
     decoration: InputDecoration(
       contentPadding:const EdgeInsets.symmetric(horizontal: 20),
       hintText: 'Search with country name ',
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(50.0),

       )
     ),

   ),
 ),
  Expanded(child: FutureBuilder(
      future: statsServices.countriesListApi()
, builder: (context,AsyncSnapshot<List<dynamic>> snapshot){

    if(!snapshot.hasData){
      return ListView.builder(
          itemCount: 5  ,//4 can take numerical values which will repeat all the listview builder items snapshot.data!.length
          itemBuilder: (context,index){
            return Shimmer.fromColors(

                baseColor: Colors.grey.shade700,
                highlightColor: Colors.grey.shade300,
              child: Column(
                children: [
                  ListTile(
                    title: Container(height: 10,width: 89,color: Colors.white,),
                    subtitle: Container(height: 10,width: 89,color: Colors.white,),
                    leading: Container(height: 50,width: 50,color: Colors.white,)

                  )
                ],

              ),);


          });
    }else{
      return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context,index){
            String name = snapshot.data![index]['country'];
            if(searchEditingController.text.isEmpty){
             return Column(
                children: [
                  InkWell(
    onTap: (){
        Navigator.push(context,
  MaterialPageRoute(builder: (context)=>DetailsScreen(
 image: snapshot.data![index]['countryInfo']['flag'] ,
  name: snapshot.data![index]['country'] ,
        totalCases: snapshot.data![index]['cases']  ,
        todayRecovered: snapshot.data![index]['recovered'] ,
        totalDeaths: snapshot.data![index]['deaths'] ,
        active: snapshot.data![index]['active'] ,
        critical: snapshot.data![index]['critical'] ,
        test: snapshot.data![index]['tests'] ,
        totalRecovered: snapshot.data![index]['todayRecovered'] ,
      )));
                    },
                    child: ListTile(
                      title: Text(snapshot.data![index]['country']),
                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                      leading: Image(
                          height: 50,
                          width: 50,
                          image: NetworkImage(
                              snapshot.data![index]['countryInfo']['flag'])),

                    ),
                  )
                ],

              );  }
            else if(name.toLowerCase().contains(searchEditingController.text.toLowerCase()) ){
              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>DetailsScreen(
                            image: snapshot.data![index]['countryInfo']['flag'] ,
                            name: snapshot.data![index]['country'] ,
                            totalCases: snapshot.data![index]['cases']  ,
                            todayRecovered: snapshot.data![index]['recovered'] ,
                            totalDeaths: snapshot.data![index]['deaths'] ,
                            active: snapshot.data![index]['active'] ,
                            critical: snapshot.data![index]['critical'] ,
                            test: snapshot.data![index]['tests'] ,
                            totalRecovered: snapshot.data![index]['todayRecovered'] ,
                          )));
                    }
                    ,child: ListTile(
                      title: Text(snapshot.data![index]['country']),
                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                      leading: Image(
                          height: 50,
                          width: 50,
                          image: NetworkImage(
                              snapshot.data![index]['countryInfo']['flag'])),

                    ),
                  )
                ],

              );
            } else{
              return Container();
            }





      });

    }


  }



  ))
  
  
],)),

    );
  }
}

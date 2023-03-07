
import 'package:covid_tracker/Models/world_states_model.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/Views/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats>with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)
    ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  final colorlist=<Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde4246),

  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices =StatesServices();
  return WillPopScope(
    onWillPop: () async{
      SystemNavigator.pop();
      return true;
    },
    child: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children:[
            SizedBox(height: MediaQuery.of(context).size.height*.01,),
            FutureBuilder(
              future: statesServices.fetchWorldStatesRecords(),
                builder:(context,AsyncSnapshot<WorldStatesModel> snapshot){

                 if(!snapshot.hasData){
                    return Expanded(
                    flex: 1,
                     child: SpinKitFadingCircle(
                     color: Colors.white,
                      size: 50.0,
                     controller:_controller,
                   )

                   );}
                 else{
                   return Column(
                     children: [
                       PieChart(dataMap: {
                         "Total":double.parse(snapshot.data!.cases!.toString()),
                         "Recovered":double.parse(snapshot.data!.recovered.toString()),
                         "Deaths":double.parse(snapshot.data!.deaths.toString()),

                       },
                         chartValuesOptions: const ChartValuesOptions(
                             showChartValuesInPercentage: true
                         ),
                         chartRadius: MediaQuery.of(context).size.width/3.2,
                         legendOptions: const LegendOptions(
                             legendPosition: LegendPosition.left
                         ),
                         animationDuration: const Duration(milliseconds: 1200),
                         chartType: ChartType.ring,
                         colorList: colorlist,
                       ),
                       Padding(
                         padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
                         child: Card(
                           child: Column(
                             children: [
                               ReusableRow(title: "TOTAL", value: snapshot.data!.cases.toString()),
                               ReusableRow(title: "DEATH", value: snapshot.data!.deaths.toString()),
                               ReusableRow(title: "RECOVERED", value:snapshot.data!.recovered.toString()),
                               ReusableRow(title: "TODAY CASES", value: snapshot.data!.todayCases.toString()),
                               ReusableRow(title: "TODAY DEATHS", value: snapshot.data!.todayDeaths.toString()),
                               ReusableRow(title: "TODAY RECOVERED", value: snapshot.data!.todayRecovered.toString()),
                               ReusableRow(title: "ACTIVE", value:snapshot.data!.active.toString()),
                               ReusableRow(title: "CRITICAL", value:snapshot.data!.critical.toString()),
                             ],
                           ),
                         ),
                       ),
                       GestureDetector(
                       onTap:(){
                       Navigator.push(context,MaterialPageRoute(builder:(context)=>const CountriesList()));
                       },
                     child:  Container(
                         height: 50,
                         decoration: BoxDecoration(
                             color: Colors.deepPurple,
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child: Center(
                           child: Text("TRACK COUNTRIES",style: GoogleFonts.lato(fontSize: 17,fontWeight:FontWeight.bold),),
                         ),)
                       )],
                   );

                 }
                }),

      ],),
        ),
      ),
    ),
  );
  }}

class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 5,top: 5 ,bottom: 2.5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title ,style: GoogleFonts.lato()),
              Text(value,style: GoogleFonts.lato()),
            ],
          ),
           SizedBox(height: 5,),
           Divider(),
        ],
      ),
    );
  }
}


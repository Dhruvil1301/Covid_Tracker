import 'package:covid_tracker/Views/World_Stats.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalcases,totalDeaths,totalRecovered,active,critical,todayRecovered,todayDeaths;
  DetailScreen({
    required this.name,
    required this.image,
    required this.totalcases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.todayDeaths,

});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name,style: GoogleFonts.lato()),
        centerTitle: true ,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*.02,
                        ),
                        ReusableRow(title: "TOTAL CASES", value: widget.totalcases.toString(),),
                        ReusableRow(title: "DEATHS", value: widget.totalDeaths.toString(),),
                        ReusableRow(title: "RECOVERED", value: widget.totalRecovered.toString(),),
                        ReusableRow(title: "TODAY RECOVERED", value: widget.todayRecovered.toString(),),
                        ReusableRow(title: "TODAY DEATHS", value: widget.todayDeaths.toString(),),
                        ReusableRow(title: "ACTIVE", value: widget.totalcases.toString(),),
                        ReusableRow(title: "CRITICAL", value: widget.totalcases.toString()),
                      ],
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],

          )
        ],
      ),
    );
  }
}

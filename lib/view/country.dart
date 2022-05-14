import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api_handler/api_handler.dart';
import '../model/apimodel.dart';
import '../service/apiservice.dart';
import '../service/serchservice.dart';

class Country extends StatefulWidget {
  const Country({Key? key}) : super(key: key);

  @override
  State<Country> createState() => _CountryState();
}

class _CountryState extends State<Country> {
  List? Countrydata;
  getCovid() async {
    var response = await API.apiHandler(
        url: 'https://corona.lmao.ninja/v3/covid-19/countries',
        apiType: ApiType.aGet);
    print(jsonDecode(response));
    setState(() {
      Countrydata = jsonDecode(response);
    });
  }

  @override
  void initState() {
    getCovid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
              )),
          title: Text(
            'COUNTRY STATS',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Search(Countrydata!));
                },
                icon: Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                ))
          ],
        ),
        body: FutureBuilder(
          future: ApiService.getCovid(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ApiModel>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var info1 = snapshot.data![index];
                    return Column(
                      children: [
                        Container(
                          height: height * .18,
                          width: double.infinity,
                          color: Colors.grey.shade100,
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: height * .17,
                                    width: width * .3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '${info1.country}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Container(
                                          height: height * .07,
                                          width: width * .3,
                                          color: Colors.black,
                                          child: Image.network(
                                            "${info1.countryInfo?.flag}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Confirm Case : ${info1.cases}',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'Today\'s Case :[+ ${info1.todayCases}]',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'Active Case : ${info1.active}',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'Deaths : ${info1.deaths}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                      ],
                    );
                  });
            } else {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ));
  }
}

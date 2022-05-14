import 'package:example_firebase/view/country.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/apimodel.dart';
import '../service/apiservice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var height = Get.height;
  var width = Get.width;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text('COVID-19 TRACKER APP '),
        ),
        body: FutureBuilder(
          future: ApiService.getCovid(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ApiModel>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'WorldWide',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(Country());
                            },
                            child: Container(
                              height: height * .06,
                              width: width * .3,
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  'Regional',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      WorldWide(),
                      SizedBox(
                        height: height * .02,
                      ),
                      Text(
                        'Most Affected Countries',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      SizedBox(
                        height: height * .28,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var info = snapshot.data![index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: height * .05,
                                      width: width * .2,
                                      color: Colors.black,
                                      child: Image.network(
                                        "${info.countryInfo?.flag}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * .04,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${info.country}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          'DEATHS : ${info.cases}',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .02,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Container(
                        height: height * .06,
                        color: Colors.deepPurple,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'FAQs',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchInBrowser(Uri.parse('https://www.who.int/'));
                        },
                        child: Container(
                          height: height * .06,
                          color: Colors.deepPurple,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'DONATE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Container(
                        height: height * .06,
                        color: Colors.deepPurple,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'MYTH BUSTERS',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

class WorldWide extends StatefulWidget {
  const WorldWide({Key? key}) : super(key: key);

  @override
  State<WorldWide> createState() => _WorldWideState();
}

class _WorldWideState extends State<WorldWide> {
  var height = Get.height;
  var width = Get.width;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CovidService.getAllCovid(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: GridView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2),
              children: [
                StatusPanel(
                  title: 'CONFIRMED',
                  textColor: Colors.pink,
                  count: snapshot.data['cases'].toString(),
                  panelColor: Colors.pink.withOpacity(0.4),
                ),
                StatusPanel(
                  title: 'ACTIVE',
                  textColor: Colors.blue,
                  count: snapshot.data['active'].toString(),
                  panelColor: Colors.blue.withOpacity(0.4),
                ),
                StatusPanel(
                  title: 'RECOVERED',
                  textColor: Colors.green,
                  count: snapshot.data['recovered'].toString(),
                  panelColor: Colors.green.withOpacity(0.4),
                ),
                StatusPanel(
                  title: 'DEATHS',
                  textColor: Colors.black54,
                  count: snapshot.data['deaths'].toString(),
                  panelColor: Colors.grey.withOpacity(0.4),
                ),
              ],
            ),
          );
        } else {
          return Center(child: LinearProgressIndicator());
        }
      },
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color? panelColor;
  final Color? textColor;
  final String? title;
  final String? count;

  const StatusPanel(
      {Key? key,
      required this.panelColor,
      required this.textColor,
      required this.title,
      required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;

    return Container(
      margin: EdgeInsets.all(4),
      height: height * .14,
      width: width * .6,
      color: panelColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title!,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              count!,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

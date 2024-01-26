import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class green_farm extends StatefulWidget {
  const green_farm({Key? key}) : super(key: key);

  @override
  State<green_farm> createState() => _green_farmState();
}

class _green_farmState extends State<green_farm> {
  final database = FirebaseDatabase.instance.reference();
  TextEditingController waterTimeStart_1 = TextEditingController();
  TextEditingController waterTimeStart_2 = TextEditingController();
  TextEditingController waterTimeStart_3 = TextEditingController();

  TextEditingController waterTimeEnd_1 = TextEditingController();
  TextEditingController waterTimeEnd_2 = TextEditingController();
  TextEditingController waterTimeEnd_3 = TextEditingController();

  TextEditingController fertilizerTimeStart_1 = TextEditingController();
  TextEditingController fertilizerTimeStart_2 = TextEditingController();
  TextEditingController fertilizerTimeStart_3 = TextEditingController();

  TextEditingController fertilizerTimeEnd_1 = TextEditingController();
  TextEditingController fertilizerTimeEnd_2 = TextEditingController();
  TextEditingController fertilizerTimeEnd_3 = TextEditingController();

  TextEditingController setTempFanHigh = TextEditingController();
  TextEditingController setTempFanLow = TextEditingController();
  TextEditingController pump = TextEditingController();

  TextEditingController setTempSprinkerHigh = TextEditingController();
  TextEditingController setTempSprinkerLow = TextEditingController();

  double temp = 0;
  double hump = 0;

  double tempOut = 0;
  double humpOut = 0;
  int waterL = 0;
  final _formKey = GlobalKey<FormState>();

  // Color mainclr = const Color(0xff009B10);

  void initState() {
    super.initState();
    listeners("GreenHouse_01");
  }

  String type = "GreenHouse_01";
  bool mister = false;
  bool water = false;
  static List<String> houselist = [
    'GreenHouse_01',
    'GreenHouse_02',
    'GreenHouse_03',
    'GreenHouse_04',
    'GreenHouse_05',
    'GreenHouse_06',
    'GreenHouse_07',
    'GreenHouse_08',
    'GreenHouse_09',
    'GreenHouse_10'
  ];
  String firstvalue = houselist.first;
  static List<String> pumplist = [
    'Pump 01',
    'Pump 02',
    'Pump 03',
    'Pump 04',
    'Pump 05',
    'Pump 06',
    'Pump 07',
  ];

  // String pumpvalue = "1";
  String pumpvalue = 'Pump 02';

  bool buttonvalid = false;

  bool buttonclicked = false;
  bool buttonclicked1 = false;
  bool buttonclicked2 = false;
  bool buttonclicked3 = false;
  bool buttonclicked4 = false;
  bool buttonclicked5 = false;
  bool buttonclicked6 = false;
  bool buttonclicked7 = false;

  @override
  Widget build(BuildContext context) {
    var wid = MediaQuery.of(context).size.width;
    var hid = MediaQuery.of(context).size.height;

    var screenheightratio = hid / 1234;
    var screenwidthratio = wid / 412;
    Future<void> alert_dialog(String tool, TextEditingController t_high,
        TextEditingController t_low) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Text(
                "Set Temperature ($tool)",
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                height: 310.75 * screenheightratio,
                // width: 357.5*screenwidthratio,
                width: wid,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "High Temp",
                              style: TextStyle(
                                  fontFamily: 'Montserrat Alternates',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff001802)),
                            ),
                            SizedBox(width: 39 * screenwidthratio),
                            SizedBox(
                              height: 49 * screenheightratio,
                              width: 158 * screenwidthratio - 27,
                              child: TextFormField(
                                  controller: t_high,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Must fill the space';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    suffixText: '°C',
                                    suffixStyle: TextStyle(
                                        fontFamily: 'Montserrat Alternates',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.5484,
                                        color: Color(0xff009B10)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff009B10))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff009B10))),
                                  )),
                            )
                          ],
                        ),
                        SizedBox(height: 31 * screenheightratio),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Low Temp",
                              style: TextStyle(
                                  fontFamily: 'Montserrat Alternates',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color(0xff001802)),
                            ),
                            SizedBox(width: 39 * screenwidthratio),
                            SizedBox(
                              height: 49 * screenheightratio,
                              width: 158 * screenwidthratio - 27,
                              child: TextFormField(
                                  controller: t_low,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Must fill the space';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    suffixText: '°C',
                                    suffixStyle: TextStyle(
                                        fontFamily: 'Montserrat Alternates',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.5484,
                                        color: Color(0xff009B10)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff009B10))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff009B10))),
                                  )),
                            )
                          ],
                        ),
                        SizedBox(height: 31.15),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 12.97, top: 15.75),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 45.44 * screenheightratio,
                                width: 139.11 * screenwidthratio -
                                    35 * screenwidthratio,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffB5B5B5)),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat Alternates',
                                          fontSize: 18.5484,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffFFFFFF)),
                                    )),
                              ),
                              SizedBox(
                                width: 9.27,
                              ),
                              SizedBox(
                                height: 45.44 * screenheightratio,
                                width: 139.11 * screenwidthratio -
                                    35 * screenwidthratio,
                                child: ElevatedButton(
                                    onPressed: () {
                                      update(type!);

                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat Alternates',
                                          fontSize: 18.5484,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffFFFFFF)),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    }

    Color mainclr = const Color.fromRGBO(0, 155, 16, 1);
    //rgba(0, 155, 16, 1)
    Color whitetext = const Color.fromRGBO(255, 255, 255, 1);
    Color distext = Colors.grey;
    Color blktext = Colors.black;

    return Scaffold(
      appBar: AppBar(title: Text("Plant Pal")),
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // green house no
        /*      Padding(
                padding: const EdgeInsets.only(top: 20),
                child: *//*SizedBox(
                  width: wid * 0.5,
                  child: DropdownButton<String>(
                      iconEnabledColor: mainclr,
                      // dropdownColor: ,
                      value: firstvalue,
                      items: houselist.map((String val) {
                        return DropdownMenuItem<String>(
                            value: val,
                            child: Text(
                              val,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: mainclr,
                                  fontFamily: 'Montserrat Alternates'),
                            ));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          database.child('$type/temp').onValue.distinct();
                          type = value!;
                          firstvalue = value!;
                          listeners(value);
                        });
                      }),
                )*//*Text('Green House'),
              ),*/
              // picture along with temperature
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                    child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [

                    Image.asset(
                      "assets/Images/img.png",
                      width: wid * 0.8,
                      height: 211,
                    ),
                    Column(
                      children: [
                        Text('Environment',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 21),
                          child: Container(
                            width: wid * 0.8,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.75),
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.thermostat_sharp,
                                      size: 25,
                                    ),
                                    Text(
                                      "${tempOut.toStringAsFixed(2).toString()} °C",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat Alternates'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.energy_savings_leaf_rounded,
                                      size: 25,
                                    ),
                                    Text(
                                      "${humpOut.toStringAsFixed(2).toString()} %",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat Alternates'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text('Green House',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,backgroundColor: Colors.white60),),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 21),
                          child: Container(
                            width: wid * 0.8,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.75),
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.thermostat_sharp,
                                      size: 25,
                                    ),
                                    Text(
                                      "${temp.toStringAsFixed(2).toString()} °C",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat Alternates'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.energy_savings_leaf_rounded,
                                      size: 25,
                                    ),
                                    Text(
                                      "${hump.toStringAsFixed(2).toString()} %",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat Alternates'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: wid * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Water Level",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat Alternates'),
                      ),
                      Text(
                        "$waterL %",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat Alternates'),
                      ),
                    ],
                  ),
                ),
              ),
              // auto farming switch
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: wid * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Temperature Control",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat Alternates'),
                      ),
                      CupertinoSwitch(
                          value: mister,
                          activeColor: mainclr,
                          onChanged: (value) {
                            setState(() {
                              mister = value;
                              auto(type, mister.toString(), water.toString());
                              if (mister) {
                                buttonclicked = false;
                                buttonclicked1 = false;
                                buttonclicked2 = false;
                                updateButtons(type);
                              }

                              buttonvalid = !buttonvalid;
                            });
                          })
                    ],
                  ),
                ),
              ),

              // fan or mister or sprink or water or fert
              if (!mister)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: wid * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: wid * 0.25,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    buttonclicked ? mainclr : whitetext,
                                foregroundColor:
                                    buttonclicked ? whitetext : blktext,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                side: BorderSide(color: mainclr)),
                            onPressed: () {
                              setState(() {
                                buttonclicked = !buttonclicked;
                                updateButtons(type);
                              });
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Fan",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: wid * 0.28,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    buttonclicked1 ? mainclr : whitetext,
                                foregroundColor:
                                    buttonclicked1 ? whitetext : blktext,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                side: BorderSide(color: mainclr)),
                            onPressed: () {
                              setState(() {
                                buttonclicked1 = !buttonclicked1;
                                updateButtons(type);
                              });
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Fan 2",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: wid * 0.25,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    buttonclicked2 ? mainclr : whitetext,
                                foregroundColor:
                                    buttonclicked2 ? whitetext : blktext,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                side: BorderSide(color: mainclr)),
                            onPressed: () {
                              setState(() {
                                buttonclicked2 = !buttonclicked2;
                                updateButtons(type);
                              });
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Sprinkler",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // temperature fan and sprinkler
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Container(
                        width: wid * 0.4,
                        height: 103,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(13.5302)),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 11, right: 12),
                              child: Text(
                                "Set Temperature",
                                textAlign: TextAlign.left,
                                // textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Montserrat Alternates'),
                              ),
                            ),
                            Text(
                              "(Fan)",
                              textAlign: TextAlign.left,
                              // textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat Alternates',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "assets/Images/img_1.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "H ${setTempFanHigh.text}°C",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat Alternates',
                                        ),
                                      ),
                                      Text(
                                        "L ${setTempFanLow.text}°C",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat Alternates',
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        alert_dialog('Fan', setTempFanHigh, setTempFanLow);
                      },
                    ),
                    InkWell(
                      child: Container(
                        width: wid * 0.4,
                        height: 103,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(13.5302)),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 11, right: 12),
                              child: Text(
                                "Set Temperature",
                                textAlign: TextAlign.left,
                                // textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Montserrat Alternates'),
                              ),
                            ),
                            Text(
                              "(Sprinkler)",
                              textAlign: TextAlign.left,
                              // textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat Alternates',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    "assets/Images/img_2.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "H ${setTempSprinkerHigh.text}°C",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat Alternates',
                                        ),
                                      ),
                                      Text(
                                        "L ${setTempSprinkerLow.text}°C",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Montserrat Alternates',
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        alert_dialog('Sprinkler', setTempSprinkerHigh,
                            setTempSprinkerLow);
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: wid * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Water Control",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat Alternates'),
                      ),
                      CupertinoSwitch(
                          value: water,
                          activeColor: mainclr,
                          onChanged: (value) {
                            setState(() {
                              water = value;
                              auto(type, mister.toString(), water.toString());
                              if (water) {
                                buttonclicked3 = false;
                                buttonclicked4 = false;
                                updateButtons(type);
                              }

                              buttonvalid = !buttonvalid;
                            });
                          })
                    ],
                  ),
                ),
              ),

              if (!water)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: wid * 0.8,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: wid * 0.38,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        buttonclicked3 ? mainclr : whitetext,
                                    foregroundColor:
                                        buttonclicked3 ? whitetext : blktext,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    side: BorderSide(color: mainclr)),
                                onPressed: () {
                                  setState(() {
                                    buttonclicked3 = !buttonclicked3;
                                    updateButtons(type);
                                  });
                                },
                                child: Container(
                                  child: Center(
                                    child: Image.asset('assets/button Icons/Fill tank.png'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: wid * 0.38,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        buttonclicked4 ? mainclr : whitetext,
                                    foregroundColor:
                                        buttonclicked4 ? whitetext : blktext,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    side: BorderSide(color: mainclr)),
                                onPressed: () {
                                  setState(() {
                                    updateButtons(type);
                                    buttonclicked4 = !buttonclicked4;
                                    updateButtons(type);
                                  });
                                },
                                child: Container(
                                  child: Center(
                                    child:  Image.asset('assets/button Icons/Tea Sprinklers.png'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            width: wid * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                SizedBox(
                                  width: wid /4,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        buttonclicked5 ? mainclr : whitetext,
                                        foregroundColor:
                                        buttonclicked5 ? whitetext : blktext,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)),
                                        side: BorderSide(color: mainclr)),
                                    onPressed: () {
                                      setState(() {
                                        buttonclicked5 = !buttonclicked5;
                                        updateButtons(type);
                                      });
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Image.asset('assets/button Icons/grn house watering.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: wid /4,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        buttonclicked6 ? mainclr : whitetext,
                                        foregroundColor:
                                        buttonclicked6 ? whitetext : blktext,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)),
                                        side: BorderSide(color: mainclr)),
                                    onPressed: () {
                                      setState(() {
                                        buttonclicked6 = !buttonclicked6;
                                        updateButtons(type);
                                      });
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Image.asset('assets/button Icons/fertilizer sprinkler.png')
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: wid /4,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        buttonclicked7 ? mainclr : whitetext,
                                        foregroundColor:
                                        buttonclicked7 ? whitetext : blktext,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)),
                                        side: BorderSide(color: mainclr)),
                                    onPressed: () {
                                      setState(() {
                                        buttonclicked7 = !buttonclicked7;
                                        updateButtons(type);
                                      });
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Image.asset('assets/button Icons/Fertilizer Drip.png')
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: Container(
                    width: wid * 0.8,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(13.5302),
                        border: Border.all(color: mainclr)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*      Text(
                          "Pump",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: 'Montserrat Alternates'
                          ),
                        ),
                        SizedBox(
                          height: 49*screenheightratio,
                          width: wid - 200,
                          child: TextFormField(
                              controller: pump,
                              keyboardType: TextInputType.number,


                          ),
                        ),*/
                        SizedBox(
                          width: wid * 0.3,
                          child: DropdownButton<String>(
                              iconEnabledColor: mainclr,
                              // dropdownColor: ,
                              value: pumpvalue,
                              items: pumplist.map((String val) {
                                return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(
                                      val,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: mainclr,
                                          fontFamily: 'Montserrat Alternates'),
                                    ));
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  pumpvalue = value!;
                                  update(type);
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // watering time
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: wid * 0.8,
                  height: 220,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(13.5302),
                      border: Border.all(color: mainclr)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Text(
                              "Watering Time",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  waterTimeStart_1.text = '00:00';
                                  waterTimeStart_2.text = '00:00';
                                  waterTimeStart_3.text = '00:00';
                                  waterTimeEnd_1.text = '00:00';
                                  waterTimeEnd_2.text = '00:00';
                                  waterTimeEnd_3.text = '00:00';
                                  update(type);
                                });
                              },
                              icon: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: mainclr,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(child: Text("R")))),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Start",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: waterTimeStart_1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    // time0.text = pickedTime.format(context).toString();
                                    waterTimeStart_1.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                            Text(
                              "End",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: waterTimeEnd_1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    waterTimeEnd_1.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Start",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: waterTimeStart_2,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    waterTimeStart_2.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                            Text(
                              "End",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: waterTimeEnd_2,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    waterTimeEnd_2.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Start",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: waterTimeStart_3,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    waterTimeStart_3.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                            Text(
                              "End",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: waterTimeEnd_3,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    waterTimeEnd_3.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // fertilizer time
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: wid * 0.8,
                  height: 216,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(13.5302),
                      border: Border.all(color: mainclr)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 13, top: 11),
                            child: Text(
                              "Fertilizer Time",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  fertilizerTimeStart_1.text = '00:00';
                                  fertilizerTimeStart_2.text = '00:00';
                                  fertilizerTimeStart_3.text = '00:00';
                                  fertilizerTimeEnd_1.text = '00:00';
                                  fertilizerTimeEnd_2.text = '00:00';
                                  fertilizerTimeEnd_3.text = '00:00';
                                  update(type);
                                });
                              },
                              icon: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: mainclr,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(child: Text("R")))),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Start",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: fertilizerTimeStart_1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    fertilizerTimeStart_1.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                            Text(
                              "End",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: fertilizerTimeEnd_1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    fertilizerTimeEnd_1.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Start",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: fertilizerTimeStart_2,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    fertilizerTimeStart_2.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                            Text(
                              "End",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: fertilizerTimeEnd_2,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    fertilizerTimeEnd_2.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Start",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: fertilizerTimeStart_3,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    fertilizerTimeStart_3.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                            Text(
                              "End",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Alternates'),
                            ),
                            SizedBox(
                              width: 80,
                              height: 31.21,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: fertilizerTimeEnd_3,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: '00.00',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: mainclr)),
                                ),
                                onTap: () async {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  TimeOfDay time = TimeOfDay.now();
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: time,
                                    builder: (context, childWidget) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1),
                                        child: childWidget!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null) {
                                    fertilizerTimeEnd_3.text =
                                        pickedTime.toString().substring(10, 15);
                                    setState(() {
                                      update(type!);
                                      time = pickedTime;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // pump selection using dropdown
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  void listeners(String type1) {
    database.child('out/hum').onValue.listen((event1) {
      final description = event1.snapshot.value;

      setState(() {
       humpOut = double.parse(description.toString());

        print(description.toString());
      });
    });
    database.child('$type1/waterLevel').onValue.listen((event1) {
      final description = event1.snapshot.value;

      setState(() {
        waterL = int.parse(description.toString());

        print(description.toString());
      });
    });

    database.child('out/temp').onValue.listen((event1) {
      final description = event1.snapshot.value;

      setState(() {
        tempOut = double.parse(description.toString());

        print(description.toString());
      });
    });
    database.child('$type1/temp').onValue.listen((event) {
      final description = event.snapshot.value;

      setState(() {
        if (type1 == firstvalue) temp = double.parse(description.toString());

        print(description.toString());
      });
    });
    database.child('$type1/temp').onValue.distinct();
    database.child('$type1/hum').onValue.listen((event1) {
      final description = event1.snapshot.value;

      setState(() {
        if (type1 == firstvalue) hump = double.parse(description.toString());

        print(description.toString());
      });
    });
    database.child('$type1/timer').onValue.listen((event1) {
      final description = event1.snapshot.value;

      setState(() {
        String timer = description.toString();
        List<String> a = timer.split(',');
        if (type1 == firstvalue) {
          setTempFanHigh.text = a[0];
          setTempFanLow.text = a[1];
          setTempSprinkerHigh.text = a[2];
          setTempSprinkerLow.text = a[3];
          pumpvalue = a[4];
          waterTimeStart_1.text = a[5];
          waterTimeEnd_1.text = a[6];
          waterTimeStart_2.text = a[7];
          waterTimeEnd_2.text = a[8];
          waterTimeStart_3.text = a[9];
          waterTimeEnd_3.text = a[10];

          fertilizerTimeStart_1.text = a[11];
          fertilizerTimeEnd_1.text = a[12];
          fertilizerTimeStart_2.text = a[13];
          fertilizerTimeEnd_2.text = a[14];
          fertilizerTimeStart_3.text = a[15];
          fertilizerTimeEnd_3.text = a[16];
        }
      });
    });
    database.child('$type1/buttons').onValue.listen((event1) {
      final description = event1.snapshot.value;

      setState(() {
        String buttons = description.toString();
        List<String> a = buttons.split(',');
        if (type1 == firstvalue) {
          buttonclicked = a[0].toLowerCase() != "false";
          buttonclicked1 = a[1].toLowerCase() != "false";
          buttonclicked2 = a[2].toLowerCase() != "false";
          buttonclicked3 = a[3].toLowerCase() != "false";
          buttonclicked4 = a[4].toLowerCase() != "false";
        }

        print("this type : ${a[0]}");
      });
    });
    database.child('$type1/auto').onValue.listen((event1) {
      final description = event1.snapshot.value;
      String timer = description.toString();
      List<String> a = timer.split(',');

      setState(() {
        String buttons = description.toString();
        if (type1 == firstvalue) {
          mister = a[0].toLowerCase() != "false";
          water = a[1].toLowerCase() != "false";
        }

        print("this auto button : $buttons");
      });
    });
  }

  void updateBool(String type) {
    print('test');
    database.child("$type/check").set(1);
  }

  void update(String type) {
    updateBool(type);
    database.child("$type/timer").set(
        '${setTempFanHigh.text},${setTempFanLow.text},${setTempSprinkerHigh.text},${setTempSprinkerLow.text},${pumpvalue},${waterTimeStart_1.text},${waterTimeEnd_1.text},${waterTimeStart_2.text},${waterTimeEnd_2.text},${waterTimeStart_3.text},${waterTimeEnd_3.text},${fertilizerTimeStart_1.text},${fertilizerTimeEnd_1.text},${fertilizerTimeStart_2.text},${fertilizerTimeEnd_2.text},${fertilizerTimeStart_3.text},${fertilizerTimeEnd_3.text}');
  }

  void updateButtons(String type) {
    updateBool(type);
    database.child("$type/buttons").set(
        '$buttonclicked,$buttonclicked1,$buttonclicked2,$buttonclicked3,$buttonclicked4,$buttonclicked5,$buttonclicked6,$buttonclicked7');
  }


  void auto(String type, String mister, String water) {
    updateBool(type);
    database.child("$type/auto").set('$mister,$water');
  }
}

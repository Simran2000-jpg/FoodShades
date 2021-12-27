import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shades_food/screens/Food_Detail/fooddeatils.dart';
import 'package:shades_food/screens/home/homescreen.dart';
import 'package:shades_food/screens/payment.dart';

int currentprice = 0;

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;
  int totalprice = 0;
  var udata = FirebaseAuth.instance.currentUser;
  List<String> did = <String>[];
  List<int> cnt = <int>[];
  List<int> fcnt = <int>[];
  List<String> cartid = <String>[];
  List<String> fcartid = <String>[];
  List<DocumentSnapshot> datas = <DocumentSnapshot>[];

  getData() async {
    // print(uid);
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection("cart").get();
    QuerySnapshot sp =
        await FirebaseFirestore.instance.collection("Dish").get();
    if (this.mounted) {
      setState(() {
        for (var it in snap.docs) {
          if (it.get("userid") == udata!.uid) {
            did.add(it.get("dishid").toString().trim());
            cnt.add(it.get("count"));
            cartid.add(it.id);
          }
        }
        print(cartid.length);
        for (var it in sp.docs) {
          if (did.contains((it.id).toString())) {
            int ind = did.indexOf(it.id);
            datas.add(it);

            fcnt.add(cnt[ind]);
            fcartid.add(cartid[ind]);
            totalprice += int.parse(it.get("price")) * cnt[ind];
          }
        }
        isLoading = false;
      });
    }
  }

  @override
  initState() {
    super.initState();
    getData();
  }

  var tp = currentprice;
  void totalpriceinc(int i) {
    setState(() {
      fcnt[i]++;

      totalprice += int.parse(datas[i]["price"]);
      print(currentprice);
    });
    update(fcnt[i], fcartid[i]);
  }

  void totalpricedec(int i) {
    setState(() {
      if (fcnt[i] >= 1) {
        fcnt[i]--;
        totalprice -= int.parse(datas[i]["price"]);
      }
    });
    if (fcnt[i] > 0) {
      update(fcnt[i], fcartid[i]);
    } else {
      setState(() {
        FirebaseFirestore.instance.collection("cart").doc(fcartid[i]).delete();
        fcnt.removeAt(i);
        fcartid.removeAt(i);
        datas.removeAt(i);
      });
    }
  }

  void update(int cnt, String id) {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(id)
        .update({"count": cnt});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (Route<dynamic> route) => false),
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 10,
                        color: Colors.white,
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.orange,
                          ),
                        )),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                alignment: Alignment.center,
                child: Text(
                  "YOUR CART",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat Bold',
                      fontSize: MediaQuery.of(context).size.aspectRatio * 60),
                ),
              ),
              isLoading == true
                  ? Container(
                      // margin: EdgeInsets.only(
                      //   bottom: MediaQuery.of(context).size.height * .07,
                      // ),
                      child: Center(
                        child: (CircularProgressIndicator()),
                      ),
                    )
                  : (datas.length > 0)
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: datas.length,
                            itemBuilder: (context, index) {
                              // counter = fcnt[index];
                              return Container(
                                // color: Colors.amber,
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02,
                                    left: MediaQuery.of(context).size.width *
                                        0.03,
                                    right: MediaQuery.of(context).size.width *
                                        0.03,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01),
                                child: Container(
                                    // margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.18,
                                          margin: EdgeInsets.only(right: 15),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15)),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    datas[index]["imageurl"]),
                                                fit: BoxFit.cover,
                                              )),
                                          // child: Image.network(
                                          //   datas[index]["imageurl"],
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  Text(
                                                    datas[index]["name"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 20),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '\u{20B9}${datas[index]["price"]}',
                                                      // textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 15,
                                                          color: Colors.orange),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.06),
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          255, 242, 230, .7),
                                                      border: Border.all(
                                                          color: Colors.orange,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: GestureDetector(
                                                    child: Icon(Icons.remove),
                                                    onTap: () =>
                                                        {totalpricedec(index)},
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Text(
                                                      (fcnt[index]).toString()),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          255, 242, 230, .7),
                                                      border: Border.all(
                                                          color: Colors.orange,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: GestureDetector(
                                                    // padding: EdgeInsets.all(25),
                                                    // alignment: Alignment.center,
                                                    child: Icon(Icons.add),
                                                    onTap: () =>
                                                        {totalpriceinc(index)},
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              );
                            },
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.2),
                          // alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Image.asset(
                            "assets/images/cartempty.jpg",
                            fit: BoxFit.fill,
                          )),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.1,
              // ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * .07,
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  // flex: 2,
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "\u{20B9} $totalprice",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize:
                              MediaQuery.of(context).size.aspectRatio * 40),
                    ),
                  ),
                ),
                Flexible(
                  // flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      if (totalprice > 0)
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => Payment(
                                price: totalprice,
                                cartid: fcartid,
                                datas: datas,
                                cnt: fcnt)));
                    },
                    child: Container(
                      color: Colors.orange,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.aspectRatio * 40),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'Cardetails.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  final List<CarDetails> carList = <CarDetails>[ //items
    new CarDetails(1, 'Range Rover', 'White', 1,  89000.0, 'rangerover.jpg'),
    new CarDetails(2, 'Audi', 'Blue', 1, 50000.0, 'audi.jpg'),
    new CarDetails(3, 'Lamborghini', 'Yellow', 1, 200000.0, 'Lamborghini.jpg'),
    new CarDetails(4, 'Mercedes Benz', 'White', 1, 53400.0, 'mercedes.jpg'),
  ];
  var id;
  static final TextStyle _boldStyle =  new TextStyle(fontWeight: FontWeight.bold);
  static final TextStyle _greyStyle = new TextStyle(color: Colors.grey);
  final dropDownVal = <int>[1, 2, 3, 4]; // for drop down

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: new FlexibleSpaceBar(
              title: const Text("Choose your Car"),
              background: new Image.asset("assets/bmw.jpg",
                  fit: BoxFit.cover),
            ),
          ),
          new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              sliver: new SliverFixedExtentList(
                itemExtent: 200.0,
                delegate: new SliverChildBuilderDelegate(
                        (builder, index) => _buildListItem(carList[index]),
                    childCount: carList.length),
              )),
          new SliverToBoxAdapter(
              child: new Container(
                alignment: Alignment.center,
                height: 50.0,
                color: Colors.purple,
                child: new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text( // still doesn't work
                        'More Cars',
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0),
                      ),
                      new SizedBox(
                        width: 10.0,
                      ),
                      new Hero(
                          tag: "more",
                          child: new Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 24.0,
                          ))
                    ],
                  ),
                  onTap: () {},
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildListItem(CarDetails itm) {
    return new Card(
      child: new Column(
        children: <Widget>[

          new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Flexible(
                child: _buildColumn1(itm), // for image
                flex: 8,
              ),
              new Flexible(child: _buildColumn2(itm), flex: 4), //for info
            ],
          ),
          _buildBottomRow(itm.price, itm.quantity), // for price
        ],
      ),

    );
  }

  Widget _buildColumn1(CarDetails itm) {
    return new Column(
      children: <Widget>[
        new Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            child: new InkWell(
              child: new Hero(
                child: new Image.asset(
                  'assets/${itm.icon}',
                  width: 300.0,
                  height: 140.0,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
                tag: itm.id,
              ),
              onTap: () { // on image click
                Navigator.of(context).push(new PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context,_,__) {
                      return new Material(
                          color: Colors.black38,
                          child: new Container(
                            padding: const EdgeInsets.all(20.0),
                            child: new InkWell(
                              child: new Hero(
                                child: new Image.asset(
                                  'assets/${itm.icon}',
                                  width: 300.0,
                                  height: 200.0,
                                  alignment: Alignment.center,
                                  fit: BoxFit.contain,
                                ),
                                tag: itm.id,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ));
                    }));
              },
            ))
      ],
    );
  }

  Widget _buildColumn2(CarDetails itm) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(bottom: 5.0, top: 10.0),
          child: new Text(
            itm.item,
            style: _boldStyle,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: new Text(itm.carColor),
        ),
        new Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: new  Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[

                  new Text(
                    "Quantity : ",
                    style: _greyStyle,
                  ),
                  new SizedBox(
                    width: 20.0,
                  ),
                  new DropdownButton<int>(
                    items: dropDownVal.map((Q) {
                      return new DropdownMenuItem<int>(
                        value: Q,
                        child: new Text(Q.toString()),
                      );
                    }).toList(),
                    value: itm.quantity,
                    onChanged: (int newVal) {
                      itm.quantity = newVal;
                      this.setState(() {});
                    },
                  )
                ],
              ),

            ],
          ),


        ),
//        _buildBottomRow(itm.price, itm.qty),
      ],
    );
  }

  Widget _buildBottomRow(double itemPrice, int qty) {
    return new Container(
        margin: const EdgeInsets.only(bottom: 10.0, right: 10.0,top: 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Flexible(
              flex: 1,
              child: new Text(
                " Item Price : ",
                style: _greyStyle,
              ),
            ),
            //  new SizedBox(width: 5.0,),
            new Flexible(
                flex: 1,
                child: new Text(
                  " \$ "+itemPrice.toString(),
                  style: _boldStyle,
                )),
            // new SizedBox(width: 10.0,),
            new Flexible(
              flex: 1,
              child: new Text(
                "Total",
                style: _greyStyle,
              ),
            ),
            new SizedBox(
              width: 5.0,
            ),
            new Flexible(
                flex: 1,
                child: new Text(
                  " \$ "+(qty * itemPrice).toString(),
                  style: _boldStyle,
                ))
          ],
        ));
  }
}

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isZoomed = false;

  void _toggleZoom() {
    setState(() {
      _isZoomed = !_isZoomed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _toggleZoom();
              },
              child: Hero(
                tag: 'imageHero',
                child: Container(
                  height: _isZoomed
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 69, 39, 160),
                        Colors.deepPurpleAccent
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: _isZoomed ? 150.0 : 65.0,
                        backgroundImage: AssetImage('assets/rizal.jpg'),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Rizal Naufal Robbani',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Informatics Engineer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Information",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Color.fromARGB(255, 39, 10, 153),
                        size: 24,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "WhatsApp",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            "+6289528009333",
                            style: TextStyle(
                              fontSize: 13.0,
                              color: const Color.fromARGB(255, 105, 104, 104),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.people,
                        color: Color.fromARGB(255, 47, 5, 187),
                        size: 24,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Instagram",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          Text(
                            "@rzl.n.r",
                            style: TextStyle(
                              fontSize: 13.0,
                              color: const Color.fromARGB(255, 105, 104, 104),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Semester',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '5th',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Birthday',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'September 3rd',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Age',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '20 yrs',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

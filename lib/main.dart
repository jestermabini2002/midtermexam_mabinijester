import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String birthday;
  final String imageUrl;

  Person(this.name, this.address, this.birthday, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Jester Mabini', '21', 'March, 2002',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t39.30808-6/278704051_1644806162535790_3242655338848475949_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=174925&_nc_eui2=AeG36FOup0oQPvsGfMWh5IUFgXEmaAkM4xyBcSZoCQzjHK1zufF7TN2_tp0eYWn9U2ue7Oh5_yHc95XI1GLfaW2b&_nc_ohc=9qhvLrUCIOAAX-Dhi_g&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfCIbXCpag6xzrFCFV7-CIBIcUI38w1BkBsOs4933m905g&oe=645117B4'),
    Person('Angel May Dela Cruz', '20', 'June 09, 2002',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t39.30808-6/308174705_617177653191525_8552861808259868028_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=174925&_nc_eui2=AeEvg_o_S3r1EbRpswMgE80MCp-BThZ6BqYKn4FOFnoGpm3_5Rio5kz2bJW1G6GirwOtSBT_4hoAX-V53ThzoQGX&_nc_ohc=cPT6mYdYhyoAX8LwCJO&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfCL4YMOG3KCJjQJj39StaF_4vnvXyfxz-w4igPKFk1H9Q&oe=6450F1FF'),
    Person('Bill Gates', '17', 'July 22, 1987',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/237125121_387368572754081_8106472968480350863_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEPFOcdDMyvA9sl44Utu_Iq6gXPwPmdbkbqBc_A-Z1uRlMycBPiohAF7pLlQvw_uiPtx3y5wO5YRQ316Rnw0tCK&_nc_ohc=Mfd2ZXRI9eAAX_lWCLd&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfDuzRUoE8tPhrqYCdXxnhMYHLp8rSmJV5vA6DKo1hAH8w&oe=64508937'),
  ];

  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIDTERM EXAM',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('USER PROFILE'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/colorful.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];

              return Card(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Age:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Birthday:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.birthday,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.lightBlue,
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:facial_recognizer/src/models/Person.dart';
import 'package:facial_recognizer/src/models/PersonInformationController.dart';
import 'package:flutter/material.dart';

class HorizontalImageListView extends StatelessWidget {
  final List<Person> persons;

  HorizontalImageListView({@required this.persons});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
          itemCount: persons.length,
          controller: PageController(viewportFraction: 0.3, initialPage: 1),
          itemBuilder: (context, i) => _personCard(context, persons[i], _screenSize)),
    );
  }

  Widget _personCard(BuildContext context, Person person, Size screenSize) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacementNamed(context, "information", arguments: PersonInformationController(person: person));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                  width: screenSize.height * 0.16,
                  height: screenSize.height * 0.23,
                  child: person.getImage()),
            ),
            Text(
              person.name,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}

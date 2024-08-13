import 'package:flutter/material.dart';
import 'package:refulgenceinc/constants/constants.dart';
import 'package:refulgenceinc/model/model.dart';

class DetailsPage extends StatelessWidget {
  DataModel data;
  DetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DETAILS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${Url.imageBaseUrl}${data.imageBig}'))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Page Views :${data.pageviews}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Page Views :${data.languageId}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Page Views :${data.content}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

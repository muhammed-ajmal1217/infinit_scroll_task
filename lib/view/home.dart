import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refulgenceinc/constants/constants.dart';
import 'package:refulgenceinc/controller/home_controller.dart';
import 'package:refulgenceinc/model/model.dart';
import 'package:refulgenceinc/view/details_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
@override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<HomeController>(context, listen: false).getAllDatas());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('KUMUDHAM NEWS', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Consumer<HomeController>(
        builder: (context, provider, child) {
          if (provider.datas.isEmpty && provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.datas.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return RefreshIndicator(
              onRefresh: provider.refresh,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollEndNotification &&
                      notification.metrics.extentAfter == 0 &&
                      !provider.isLoading &&
                      provider.hasMore) {
                    provider.loadMore();
                  }
                  return false;
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(color: const Color.fromARGB(255, 223, 222, 222));
                  },
                  itemCount: provider.datas.length + 1,
                  itemBuilder: (context, index) {
                    if (index == provider.datas.length) {
                      return provider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : SizedBox.shrink();
                    }

                    DataModel data = provider.datas[index];
                    String imageUrl = data.imageBig != null ? '${Url.imageBaseUrl}${data.imageBig}' : '';

                    return Card(
                      key: ValueKey(data.id),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder:(context)=> DetailsPage(data: data,)));
                                },
                                child: Container(
                                  height: size.height * 0.2,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: imageUrl.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(imageUrl),
                                            //image: AssetImage("assets/news.jpg"),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: imageUrl.isEmpty
                                      ? Center(child: Text('No image available'))
                                      : null,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data.keyWord ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

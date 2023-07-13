import 'package:flutter/material.dart';
import 'package:galerie/widgets/AppLargeText.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GridPage extends StatefulWidget {
  GridPage({Key? key}) : super(key: key);

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  List<dynamic> urlData = [];

  List<dynamic> filteredData = [];
  String selectedCategory = '';
  List<String> selectedTags = [];
  dynamic selectedImage;

  void getApiData() async {
    var url = Uri.parse(
        'https://api.unsplash.com/photos/?client_id=sbVKKcD1AiYaaUe-09gwcro4_6VxWW9QOgLXlrCb9CI');
    final res = await http.get(url);
    setState(() {
      urlData = jsonDecode(res.body);
      filteredData = urlData;
    });
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      selectedTags = [];
      filteredData = urlData.where((photo) => photo['category'] == category).toList();
    });
  }

  void filterByTag(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }

      if (selectedTags.isNotEmpty) {
        filteredData = urlData.where((photo) =>
            List<String>.from(photo['tags']).any((t) => selectedTags.contains(t))).toList();
      } else {
        filteredData = urlData;
      }
    });
  }

  void onCategorySelected(String category) {
    filterByCategory(category);
  }

  void onTagSelected(String tag) {
    filterByTag(tag);
  }
  //function suprimer
  void deletePhoto(int index) {
    setState(() {
      filteredData.removeAt(index);
    });
  }

//afficher image
  void showFullScreenImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(selectedImage['urls']['full']),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Fermer'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppLargeText(text: 'Photos', color: Colors.black, size: 60,),
                  SizedBox(width: 170,),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.filter_list_sharp,size: 30,color: Colors.grey,),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add) ,
                    label: Text("Ajouter"),

                  ),
                ],
              ),

              SizedBox(height: 50,),
              Expanded(
                flex: 13,
                child: urlData.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 6,
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                    ),
                    itemCount: filteredData.length,
                    itemBuilder: (context,i){
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = filteredData[i];
                          });
                          showFullScreenImage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(filteredData[i]['urls']['full']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                deletePhoto(i);
                              },
                              icon: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:todoappsqlite/Screens/home_screen.dart';
import '../services/category_service.dart';
import '../models/category.dart';



class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  final _categoryNameController = TextEditingController();
  final _categoryDescController = TextEditingController();
  final _editCategoryNameController = TextEditingController();
  final _editCategoryDescController = TextEditingController();



  final _category = Category();
  final _categoryService = CategoryService();
  final List<Category> _categoryList = [];
  var category;

 @override
  void  initState(){
    super.initState();
    getAllCategories();
  }
    getAllCategories() async{
    var categories = await  _categoryService.readCategories();
    categories.map((category) => Category(
    )).toList();
     categories.forEach((category){
       setState(() {
    var categoryModel = Category();
    categoryModel.name = category['name'];
    categoryModel.desc = category['desc'];
    categoryModel.id = category['id'];
    _categoryList.add(categoryModel);
    });
     });
  }
  _editCategory(BuildContext context, categoryId) async {
  category = await _categoryService.readCategoryById(categoryId);
  setState(() {
 _editCategoryNameController.text = category[0]['name']??'no name';
 _editCategoryDescController.text = category[0]['desc']??'no desc';
  });
  _editFormDialogue(context);
  }

  _showFormDialogue(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
  return

    AlertDialog(
      actions: [
      TextButton(

        onPressed: ()=> Navigator.pop(context),
        child: Text('Cancle',
          style: TextStyle(color: Colors.red),
        ) ,
      ),

        TextButton(onPressed: () async{
         _category.name =  _categoryNameController.text;
         _category.desc = _categoryDescController.text;
          var result = await _categoryService.saveCategory(_category);
         print(result);
        },
        child: Text('Save',
            style: TextStyle(color: Colors.green),
        )
          ,
      ),
    ],
    title: Text('Categories Form'),
    content: SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _categoryNameController,
            decoration: InputDecoration(
              hintText: 'write a category',
              labelText: 'Category'

            ),
          ), TextField(
            controller: _categoryDescController,
            decoration: InputDecoration(
              hintText: 'write a Description',
              labelText: 'Category'

            ),
          ),
        ],
      ),
    ),
  );
    });
  }

  _editFormDialogue(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return

        AlertDialog(
          actions: [
            TextButton(

              onPressed: ()=> Navigator.pop(context),
              child: Text('Cancle',
                style: TextStyle(color: Colors.red),
              ) ,
            ),

            TextButton(onPressed: () async{
              _category.id = category[0]['id'];
              _category.name =  _editCategoryNameController.text;
              _category.desc = _editCategoryDescController.text;
              var result = await _categoryService.updateCategory(_category);
              if(result>0){
                Navigator.pop(context);
                getAllCategories();
              }
            },
              child: Text('Update',
                style: TextStyle(color: Colors.green),
              )
              ,
            ),
          ],
          title: Text('Edit Categories Form'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _editCategoryNameController,
                  decoration: InputDecoration(
                      hintText: 'write a category',
                      labelText: 'Category'

                  ),
                ), TextField(
                  controller: _editCategoryDescController,
                  decoration: InputDecoration(
                      hintText: 'write a Description',
                      labelText: 'Category'

                  ),
                ),
              ],
            ),
          ),
        );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          // iconSize: 72,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
            }
        ),
        backgroundColor: Colors.white12,
        foregroundColor: Colors.blue,
        title: Center(child: Text("Ctegories")),
      ),
      // drawer: DrawerNavigation(),
      body: ListView.builder(itemCount: _categoryList.length, itemBuilder: (context, index){
return Padding(
  padding:  EdgeInsets.only(top: 8.0, left: 16, right: 16.0),
  child: Card(
    elevation: 8.0,
      child:ListTile(
        leading: IconButton(icon: Icon(Icons.edit),
        onPressed: (){
           _editCategory(context, _categoryList[index].id);
        },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_categoryList[index].name.toString()),
            IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed:  (){})
          ],
        ),
        // subtitle:  Text(_categoryList[index].desc.toString()),
      ),
  ),
);

      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showFormDialogue(context);
      },
      child: Icon(Icons.add),
      ),
    );
  }
}

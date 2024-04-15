import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoappsqlite/Screens/categories_screen.dart';
import 'package:todoappsqlite/Screens/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                 currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('https://scontent.fisb5-2.fna.fbcdn.net/v/t39.30808-6/415038690_1496288867585458_3455923221765177275_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=5f2048&_nc_ohc=jDEINWjnx74Ab5yDVCg&_nc_ht=scontent.fisb5-2.fna&oh=00_AfAPm_cXZRRpuYqJ_Y2NLGuAYtgw_zzKrpL6o8LVjQj7Qg&oe=662034F6'),
                 ) ,

                accountName: Text('Haider Ali'),
                accountEmail: Text("coderhaider98@gmail.com")

            ),
        ListTile(
          leading: Icon(Icons.home_filled),
          title: Text('Home'),
          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen())),
        ),ListTile(
          leading: Icon(Icons.view_list),
          title: Text('Ctegories'),
          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriesScreen())),
        ),
          ],

        ),

      ),
    );
  }
}

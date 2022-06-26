/**
 * This File Contain Code of all User and Trending Products
 */
import 'package:buying_final/model_provider/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model_provider/products_model.dart';
import '../screens/detail_screen.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
   List<Product> data =[];
   List<Product> enterdata =[];
  void _runFilter(String enteredKeyword) {
    List<Product> results = [];
    if (enteredKeyword.isEmpty) {
      results = data;
    } else {
      results = data
          .where((element) =>
              element.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      enterdata = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final prod = Provider.of<Products>(context,listen: false);
    data = prod.items + prod.trendingItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: enterdata.isNotEmpty
                  ? ListView.builder(
                      itemCount: enterdata.length,
                      itemBuilder: (context, index) => 
                      
                      Card(
                        
                        key: ValueKey(data[index].id),
                        color: Colors.white,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          onTap: ()
                          {
                             Navigator.of(context).
                             pushNamed(
                             DetailScreen.routeName ,
                            arguments: enterdata[index].id);
                          },
                          leading: Text(
                            enterdata[index].title,
                            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                          title:    Text('Category: '+ enterdata[index].category),
                          subtitle: Text( 'Price:'+ enterdata[index].price.toString()),
                          trailing: CircleAvatar(
                          radius: 30,
                          child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                          child: Image(image: NetworkImage(enterdata[index].productImage),
                          fit: BoxFit.cover,),
                           ),
                           ),               
                          )
                        ),
                      ),
                    )
                  : 
                  const 
                  Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                       ),
            ),
          ],
        ),
      ),
    );
  }
}
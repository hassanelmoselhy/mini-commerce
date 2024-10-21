import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map> products = [
    {
      'img': 'images/img1.png',
      'title': 'product 1',
      'des': 'description ...',
      'price': '340\$'
    },
    {
      'img': 'images/img2.png',
      'title': 'product 2',
      'des': 'description ...',
      'price': '340\$'
    },
    {
      'img': 'images/img3.png',
      'title': 'product 3',
      'des': 'description ...',
      'price': '340\$'
    },
    {
      'img': 'images/img4.png',
      'title': 'product 4',
      'des': 'description ...',
      'price': '340\$'
    },
  ];

  final List<Map> cats = [
    {
      'icon': Icons.sports_baseball,
      'active': true,
      'txt': 'Sports'
    },
    {
      'icon': Icons.devices,
      'active': false,
      'txt': 'Devices'
    },
    {
      'icon': Icons.book,
      'active': false,
      'txt': 'Books'
    },
    {
      'icon': Icons.local_mall,
      'active': false,
      'txt': 'Clothes'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Icon(Icons.menu, color: Colors.black),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: cats.map((category) {
                return categoryIcon(category['icon'], category['txt'], category['active']);
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              "Best Selling",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: products.length, // Use the length of the products list
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to ProductDetailPage when a product is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            imagePath: product['img'],
                            title: product['title'],
                            description: product['des'],
                            price: product['price'],
                          ),
                        ),
                      );
                    },
                    child: productCard(product['img'], product['title'], product['des'], product['price']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget categoryIcon(IconData iconData, String title, bool active) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: active ? Colors.orangeAccent : Colors.grey[300],
          child: Icon(iconData, color: Colors.white, size: 30),
        ),
        SizedBox(height: 5),
        Text(title),
      ],
    );
  }

  Widget productCard(String imagePath, String title, String description, String price) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.grey[300],
              ),
              child: Center(
                child: Image.asset(
                  imagePath, // Dynamically loads the image from the assets
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(description),
                SizedBox(height: 5),
                Text(price, style: TextStyle(color: Colors.orange)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String price;

  ProductDetailPage({required this.imagePath, required this.title, required this.description, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  imagePath, // Displays the product image in large
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text(price, style: TextStyle(fontSize: 20, color: Colors.orange, )),
          ],
        ),
      ),
    );
  }
}

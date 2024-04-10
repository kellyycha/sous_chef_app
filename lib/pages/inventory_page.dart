import 'package:flutter/material.dart';
import 'package:sous_chef_app/widgets/custom_input.dart';
import 'package:sous_chef_app/widgets/dropdown.dart';
import 'package:sous_chef_app/widgets/item_square.dart';
import 'package:sous_chef_app/widgets/custom_radio.dart';
import 'package:sous_chef_app/widgets/search_bar.dart';

class InventoryPage extends StatelessWidget {
  InventoryPage({super.key});

  //TODO: use DB. [ingredient, qty, days left from today to expiration, location, image]
  // https://www.dhiwise.com/post/flutter-mysql-exploring-the-power-of-database-managemen
  final List _inventory = [
    ["Tomato", 2, 7, "Refrigerator", 'https://i5.walmartimages.com/seo/Fresh-Slicing-Tomato-Each_9f8b7456-81d0-4dc2-b422-97cf63077762.0ddba51bbf14a5029ce82f5fce878dee.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF'], 
    ["Potato", 4, 28, "Pantry", 'https://i5.walmartimages.com/seo/Russet-Baking-Potatoes-Whole-Fresh-Each_c638c006-a982-48f7-aa33-6d3a8dc2983c.8fd015937ebfdd46c8fcb6177d0d1b1d.jpeg'],
    ["Garlic", 3, 120, "Pantry", 'https://www.chicagosfoodbank.org/wp-content/uploads/2022/03/Garlic-1.jpg'],
    ["Broccoli", 2, 10, "Refrigerator", 'https://i5.walmartimages.com/seo/Fresh-Broccoli-Crowns-Each_c721459d-3826-4461-9e79-c077d5cf191e_3.ca214f10bb3c042f473588af8b240eca.jpeg'],
    ["Banana", 5, 7, "Pantry", 'https://target.scene7.com/is/image/Target/GUEST_cf4773e6-afec-4aa1-89e7-74b7dfc09973'],
    ["Cabbage", 1, 20, "Refrigerator", 'https://www.advancedagservices.net/wp-content/uploads/2020/12/p5.jpg'],
    ["Corn", 2, 5, "Refrigerator", 'https://richmondmagazine.com/downloads/39615/download/Eat%26Drink_Ingredient_Corn1_GETTYIMAGES_rp0723.jpg?cb=226f9397bea90b2573b21c6ed73c69a6&w=1200'],
    ["Eggplant", 1, 10, "Refrigerator", "https://i5.walmartimages.com/seo/Fresh-Purple-Eggplant_4307b532-ea7b-4b41-82b0-5ece9e9ab30c.431696526ff3c9ed9dbb45c1f9f233e7.jpeg"],
    ["Lemon", 4, 30, "Refrigerator", "https://m.media-amazon.com/images/S/assets.wholefoodsmarket.com/PIE/product/5aa983d911dc09df89bfbf8e_56e71354c5cb2f11004367b6-365-lemons-2.jpg"],
    ["Carrot", 5, 25, "Refrigerator", "https://cdn11.bigcommerce.com/s-kc25pb94dz/images/stencil/1280x1280/products/271/762/Carrot__40927.1634584458.jpg?c=2"],
    ["Steak", 1, 4, "Refrigerator", "https://www.mashed.com/img/gallery/why-you-probably-shouldnt-use-raw-steak-to-heal-a-black-eye/l-intro-1639165775.jpg"],
    ["Egg", 12, 50, "Refrigerator", "https://images.squarespace-cdn.com/content/v1/5b9f0c8a506fbe9caf8554e1/1664833738783-ISLK77YN0G9Z3TGRC13L/2ADDF88B-7623-4312-9E48-6223A899E8AD.jpg?format=2500w"],
    ["Avocado", 1, 5, "Pantry", "https://images.immediate.co.uk/production/volatile/sites/30/2020/02/Avocados-3d84a3a.jpg?resize=768,574"],
    ["Onion", 4, 60, "Pantry", "https://images.heb.com/is/image/HEBGrocery/000377484-1"],
    ["Orange", 3, 20, "Refrigerator", "https://media.istockphoto.com/id/172411313/photo/juicy-orange-refreshment.jpg?b=1&s=612x612&w=0&k=20&c=WUX7uvPbsRPsdAn4-qLQSKeVqmc-h-uxz11MQma-9L0="],
    ["Scallion", 6, 14, "Refrigerator", "https://www.495expressfoods.com/cdn/shop/products/00000743_eif_460x.jpg?v=1586982150"],
    ["Jalapeno", 4, 9, "Refrigerator", "https://www.melissas.com/cdn/shop/files/2-pounds-image-of-jalapeno-peppers-vegetables-34229197176876_600x600.jpg?v=1687265421"],
    ["Mushroom", 5, 10, "Refrigerator", "https://media.licdn.com/dms/image/D4D12AQHAzgSf05_7fQ/article-cover_image-shrink_600_2000/0/1674632207166?e=2147483647&v=beta&t=DsSP3I7wk7HxImXXRb-sUCyeCAKKw9y9oo3QEad6ao8"],
    ["Cauliflower", 1, 12, "Refrigerator", "https://img.freepik.com/premium-photo/fresh-cauliflower-white-background_35712-351.jpg"],
    ["Soy Sauce", -1, -1, "Spices/Sauces", null],
    ["Salt", -1, -1, "Spices/Sauces", null],
    ["Pepper", -1, -1, "Spices/Sauces", null],
    ["Paprika", -1, -1, "Spices/Sauces", null],
    ["Cinnamon", -1, -1, "Spices/Sauces", null],
    ["Vinegar", -1, -1, "Spices/Sauces", null],
    ["Sesame Oil", -1, -1, "Spices/Sauces", null],
    ["Chili Oil", -1, -1, "Spices/Sauces", null],
    ["Parsley", -1, -1, "Spices/Sauces", null],
    ];

  final List<String> _location = <String>[
    'All', 
    'Refrigerator', 
    'Freezer', 
    'Pantry',
    'Spices/Sauces'
    ];

  void handleLocationSelection(String location) {
    // TODO: Filter inventory based on selected location
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ColoredBox(color: Colors.white),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              height: 630,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 250, 250, 245),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), 
                  topRight: Radius.circular(30),
                ),
              ),
            )
          ),
          Column(
            children: [
              const SizedBox(
                height:135,
                child: Align(
                  alignment: Alignment.topLeft,
                    child:Padding(
                    padding:EdgeInsets.only(top:40,left:20),
                    child: Text(
                      'Inventory',
                      style: TextStyle(
                        color:Colors.black,
                        fontSize: 64.0,
                        fontFamily: 'Italiana',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height:5), 
              IntrinsicHeight(
                child: Row(
                  children: [
                    const SizedBox(width:20),
                    // location dropdown
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: MyDropdown(
                        data: _location,
                        onSelect: handleLocationSelection,
                      ), 
                    ),
                    const Spacer(),
                    const VerticalDivider(
                      thickness: 1,
                      width: 1,
                      indent: 3,
                      endIndent: 3,
                    ),
                    const Spacer(),
                    // video button
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white,
                          ),
                          child: IconButton.outlined(
                            icon: const Icon(Icons.videocam_outlined),
                            iconSize: 40,
                            color: Colors.black,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(width: 1.0, color:Color.fromARGB(255, 194, 194, 194)),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(1),
                            onPressed: () {
                              Navigator.pushNamed(context, '/video');
                            },
                          ), 
                        )
                      ), 
                    const SizedBox(width:20),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height:5),
              Row(
                children: [
                  const SizedBox(width:20),
                  // search bar
                  const SizedBox(
                    width: 290,
                    height: 40,
                    child: MySearchBar(),
                    ),
                  const Spacer(),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 230, 230, 230),
                        ),
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        iconSize: 35,
                        color: Colors.black,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(1),
                         onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomInput(); 
                            },
                          );
                        },
                        ),
                      ), 
                    ), 
                  const SizedBox(width:20),
                ],
              ),
              const SizedBox(height:8),
              // sort by options
              const Row(
                children: [
                  Spacer(),
                  SizedBox(
                    height:40,
                    child: Align(
                      alignment: Alignment.centerRight,
                        child:Padding(
                        padding:EdgeInsets.all(0),
                        child: Text(
                          'Sort By',
                          style: TextStyle(
                            color:Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ), 
                  SizedBox(width:5), 
                  MyRadio(
                    firstText: "Expiration",
                    firstWidth: 105,
                    secondText: "A-Z",
                    secondWidth: 55,
                  ),
                  SizedBox(width:20), 
                ],
              ),
              const SizedBox(height:20), 
              //inventory list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _inventory.length,
                  itemBuilder: (context, index) {
                    return MySquare(
                      title: _inventory[index][0],
                      qty: _inventory[index][1],
                      expiration: _inventory[index][2],
                      img: _inventory[index][4],
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomInput(
                              title: _inventory[index][0],
                              qty: _inventory[index][1],
                              expiration: _inventory[index][2],
                              location: _inventory[index][3],
                              image: _inventory[index][4],
                            );
                          },
                        );
                      }, 
                    );
                  },
                ),
              ),
            ],
          ),
        ]
      )
    );
  }
} 
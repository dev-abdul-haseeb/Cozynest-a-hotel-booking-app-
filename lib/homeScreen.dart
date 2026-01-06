import 'package:flutter/cupertino.dart' hide ImageProvider;
import 'package:flutter/material.dart' hide ImageProvider;
import 'package:hotel_booking/BookingsScreen.dart';
import 'package:hotel_booking/Providers/DateTimeProvider.dart';
import 'package:hotel_booking/detailsScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'Providers/ImageProvider.dart';

import 'Functions/TextStyles.dart';
import 'loginScreen.dart';

class homeScreen extends StatefulWidget {
  final username;
  final name;
  final city;
  final country;
  const homeScreen({
    required this.username,
    this.name,
    this.city,
    this.country,
  });
  @override
  State<homeScreen> createState() => _homeScreenState();
}

var FirstView = [
  "Assets/Images/WheelImage2.jpg",
  "Assets/Images/WheelImage1.jpg",
];

List<Map<String, String>> hotels = [
  {
    'name': 'Villa Vista',
    'location': 'Islamabad',
    'address1': 'Assets/Images/Hotel1img1.jpg',
    'address2': 'Assets/Images/Hotel1img2.jpg',
    'address3': 'Assets/Images/Hotel1img3.jpg',
  },
  {
    'name': 'Luxury family properties ',
    'location': 'Islamabad',
    'address1': 'Assets/Images/Hotel2img1.jpg',
    'address2': 'Assets/Images/Hotel2img2.jpg',
    'address3': 'Assets/Images/Hotel2img3.jpg',
  },
  {
    'name': 'Travis Executive Guest House',
    'location': 'Islamabad',
    'address1': 'Assets/Images/Hotel3img1.jpg',
    'address2': 'Assets/Images/Hotel3img2.jpg',
    'address3': 'Assets/Images/Hotel3img3.jpg',
  },
  {
    'name': 'Luxury Centaurus Apartments',
    'location': 'Islamabad',
    'address1': 'Assets/Images/Hotel4img1.jpg',
    'address2': 'Assets/Images/Hotel4img2.jpg',
    'address3': 'Assets/Images/Hotel4img3.jpg',
  },
  {
    'name': 'Comfort Family Villa',
    'location': 'Islamabad',
    'address1': 'Assets/Images/Hotel5img1.jpg',
    'address2': 'Assets/Images/Hotel5img2.jpg',
    'address3': 'Assets/Images/Hotel5img3.jpg',
  },
  {
    'name': 'Elysium Luxury Apartment',
    'location': 'Islamabad',
    'address1': 'Assets/Images/Hotel6img1.jpg',
    'address2': 'Assets/Images/Hotel6img2.jpg',
    'address3': 'Assets/Images/Hotel6img3.jpg',
  },
  {
    'name': 'Furnished Luxury Studio Apartment',
    'location': 'Islamabad',
    'address1': 'Assets/Images/Hotel7img1.jpg',
    'address2': 'Assets/Images/Hotel7img2.jpg',
    'address3': 'Assets/Images/Hotel7img3.jpg',
  },
  {
    'name': 'Alpine lodges',
    'location': 'Islamabad',
    'address1': 'Assets/Images/Hotel8img1.jpg',
    'address2': 'Assets/Images/Hotel8img2.jpg',
    'address3': 'Assets/Images/Hotel8img3.jpg',
  },
  {
    'name': 'Luxury Apartments - Elysium',
    'location': 'Islamabad',
    'address1': 'Assets/Images/Hotel9img1.jpg',
    'address2': 'Assets/Images/Hotel9img2.jpg',
    'address3': 'Assets/Images/Hotel9img3.jpg',
  },
  {
    'name': 'Lavish Furnished apartment',
    'location': 'Islamabad',
    'address1': 'Assets/Images/Hotel10img1.jpg',
    'address2': 'Assets/Images/Hotel10img2.jpg',
    'address3': 'Assets/Images/Hotel10img3.jpg',
  },

];
var ratings = [3,2,4,5,1,5,4,4,3,5];

var prices = [10000,8000,5000,3500,9000,8900,5600,4000,9999,15000];

List<String> hotelDescriptions = [
  "Villa Vista offers a peaceful escape in the heart of Islamabad, surrounded by lush greenery and scenic views. With elegant architecture and modern interiors, it’s perfect for both business and leisure travelers. The rooms are spacious, tastefully decorated, and offer all the comforts you expect from a luxury stay. Wake up to a complimentary breakfast and enjoy your coffee on the private balcony. The staff is warm, attentive, and always ready to assist. The hotel also features a relaxing garden and a rooftop terrace. Nearby, you’ll find shopping centers and top-rated restaurants. The location offers both tranquility and connectivity. Whether you’re here for a weekend or a long stay, Villa Vista ensures a memorable experience. It’s a home away from home, with a touch of elegance.",
  "Located near the iconic Centaurus Mall and Blue Area, this luxurious family property blends comfort and convenience seamlessly. Ideal for families, it features spacious suites with separate living areas and kid-friendly amenities. Each unit is fully furnished with modern appliances and stylish decor. A lush park is within walking distance, perfect for morning walks and children's play. The area is secure and well-connected to the rest of the city. Guests can enjoy free Wi-Fi, a fully equipped kitchen, and a cozy lounge. Private parking and 24/7 security are also available. With major attractions nearby, this property is perfect for tourists and business visitors alike. It’s a peaceful retreat in the middle of city life. Designed for long stays and family bonding, it feels like your very own urban sanctuary.",
  "Travis Executive Guest House is an ideal choice for professionals and business travelers. With a reputation for hospitality, it offers a peaceful and productive environment. Each room is air-conditioned and comes with a dedicated workspace. High-speed internet and meeting rooms make it suitable for corporate needs. Breakfast is served daily with a variety of local and continental options. The property has a modern minimalist style that’s both clean and functional. It’s located close to Islamabad’s diplomatic enclave and major government offices. On-site laundry and transport facilities add to the convenience. The atmosphere is quiet and respectful, perfect for relaxation after a long day. This guest house is where work meets comfort in perfect balance.",
  "These high-end apartments are situated right inside the prestigious Centaurus complex. The interior design is chic, featuring marble floors, ambient lighting, and panoramic views of the city skyline. Guests enjoy access to the Centaurus Mall, cinema, restaurants, and indoor pool. The apartments come with full kitchens, luxury bedding, and smart TVs. Perfect for couples or solo travelers looking for sophistication and accessibility. Security is top-tier, with biometric entry and CCTV monitoring. Each apartment also includes a balcony with breathtaking views. Daily housekeeping and concierge services are available upon request. You'll feel like you're living in a five-star suite with the freedom of an apartment. Experience modern living in one of Islamabad’s most iconic locations.",
  "Comfort Family Villa lives up to its name with a cozy and inviting atmosphere tailored for families. It boasts multiple bedrooms, a spacious lounge, and a fully equipped kitchen. The villa is located in a peaceful neighborhood, away from the city noise but still well-connected. Children can enjoy the private lawn, while adults relax in the comfortable outdoor seating. Interiors are bright, clean, and styled with modern furniture. The property is perfect for reunions, family holidays, or even long-term stays. With a washing machine, Wi-Fi, and ample storage, it covers all your practical needs. There’s also a barbecue area for weekend gatherings. Free private parking and around-the-clock assistance make the stay hassle-free. Whether it’s summer or winter, the villa offers year-round comfort.",
  "This one-bedroom apartment is the perfect escape for couples or solo travelers looking for luxury on a smaller scale. Despite its compact size, it offers elegance and sophistication in every corner. The bedroom features high-thread-count sheets, mood lighting, and a plush mattress. A sleek kitchen and marble-tiled bathroom complete the high-end feel. The building includes a rooftop garden and fitness center for your convenience. Security is tight, with guards stationed at all hours. Enjoy fast internet, a smart TV with streaming apps, and in-room dining options. Located centrally, it's easy to reach any part of the city. With panoramic city views and impeccable cleanliness, it feels like a boutique hotel suite. Ideal for weekend getaways or romantic holidays.",
  "This fully furnished studio is a smart blend of style and efficiency. Ideal for digital nomads, solo travelers, or couples, it’s designed to provide maximum comfort in a limited space. The interior includes designer furniture, a compact kitchen, and an en-suite bathroom. Natural light fills the space through large windows, creating a warm and welcoming vibe. Amenities include high-speed Wi-Fi, Netflix-enabled TV, and a work desk. It’s a secure building with private parking and a responsive host. The central location ensures easy access to cafes, shopping areas, and transport. A cozy queen bed and blackout curtains make for restful nights. Laundry services and weekly cleaning are available. It’s a perfect mix of affordability and elegance.",
  "Alpine Lodges offer a unique mountain-resort feel right in the city. Designed with wooden interiors and rustic decor, it’s a breath of fresh air for nature lovers. Guests are welcomed with traditional hospitality and a complimentary drink. The lodge rooms are cozy, each with a fireplace and stunning garden or hill views. Outdoor seating areas provide a great place for morning tea or evening chats. There are also hiking trails nearby for the adventurous. Families will appreciate the open lawns and barbecue pits. Breakfast includes homemade items and fresh fruit juices. It’s quiet, safe, and surrounded by greenery. Alpine Lodges offer a peaceful escape from the concrete jungle.",
  "The Elysium Luxury Apartments combine ultra-modern design with homely warmth. Every apartment is fitted with imported furniture, automated lighting, and premium fixtures. The complex offers amenities like a heated swimming pool, spa, and yoga deck. Located in a prestigious sector of Islamabad, it ensures both security and serenity. The open-plan layout makes the apartment feel even more spacious. Large windows invite in plenty of sunlight and cityscape views. A dedicated concierge is always ready to help with any needs. The environment is smoke-free and suitable for both professionals and families. Every detail reflects comfort and class. Elysium is truly the future of city living.",
  "This lavishly furnished apartment is all about indulgence and convenience. From the elegant decor to the top-notch amenities, everything is curated for luxury. The living room features a 4K smart TV, designer couches, and ambient lighting. Bedrooms come with velvet drapes, memory foam mattresses, and walk-in closets. The kitchen is a gourmet’s dream, complete with a microwave, oven, and espresso machine. Guests also enjoy a balcony with skyline views. Security, cleanliness, and privacy are maintained to the highest standards. The apartment is within walking distance of restaurants, gyms, and public transport. Perfect for business travelers, couples, or small families. This is where upscale comfort meets prime location.",
];


class _homeScreenState extends State<homeScreen> {
  String selectedFilter = 'None';
  void applySorting() {
    List<int> indices = List.generate(hotels.length, (index) => index);

    switch (selectedFilter) {
      case 'Highest Rating':
        indices.sort((a, b) => ratings[b].compareTo(ratings[a]));
        break;
      case 'Lowest Rating':
        indices.sort((a, b) => ratings[a].compareTo(ratings[b]));
        break;
      case 'Price High to Low':
        indices.sort((a, b) => prices[b].compareTo(prices[a]));
        break;
      case 'Price Low to High':
        indices.sort((a, b) => prices[a].compareTo(prices[b]));
        break;
      default:
        return;
    }

    setState(() {
      hotels = [for (var i in indices) hotels[i]];
      ratings = [for (var i in indices) ratings[i]];
      prices = [for (var i in indices) prices[i]];
      hotelDescriptions = [for (var i in indices) hotelDescriptions[i]];
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.black),
          tooltip: 'Logout',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => loginScreen()),
            );
          },
        ),
        title: Text('CozyNest', style: LogoHead(screenWidth * 0.07)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.menu_book, color: Colors.black),
            tooltip: 'Bookings',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>bookingsScreen(username: widget.username,)));
            },
          ),
        ],
      ),

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.green.shade100,
          ),
          Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.25,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        SizedBox(width: screenWidth*0.005,),
                        Container(
                          width: screenWidth*0.99,
                          height: screenHeight * 0.25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20), // adjust as needed
                            child: Image.asset(
                              FirstView[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: FirstView.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),    //Company Promotion
              Divider(thickness: 2,color: Colors.grey.shade600,),
              Container(
                height: screenHeight*0.04,
                color: Colors.blue.shade200.withOpacity(0.8),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_list_alt),
                      SizedBox(width: screenWidth*0.01),
                      DropdownButton<String>(
                        value: selectedFilter,
                        items: [
                          'None',
                          'Highest Rating',
                          'Lowest Rating',
                          'Price High to Low',
                          'Price Low to High'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedFilter = newValue;
                              applySorting();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),    //Filter
              Container(
                width: screenWidth,
                height: screenHeight*0.573,
                child: ListView.builder(itemBuilder: (context,index){
                  return Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight*0.16,
                        color: Colors.blue.shade200.withOpacity(0.5),
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Colors.green.shade100,
                                    child: Container(
                                      width: screenWidth * 0.9,
                                      height: screenHeight*0.7,
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: Text(
                                              hotels[index]['name']!,
                                              style: TextStyle(
                                                  fontSize: screenHeight * 0.035,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'RobotoCondensed'
                                              ),
                                            ),
                                          ),            //Name
                                          SizedBox(height: screenHeight*0.02),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.asset(
                                              hotels[index]['address1']!,
                                              width: screenWidth * 0.7,
                                              height: screenHeight * 0.2,
                                              fit: BoxFit.cover,
                                            ),
                                          ),      //Image
                                          SizedBox(height: screenHeight*0.02),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Description:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: screenHeight * 0.022,
                                                  fontFamily: 'RobotoCondensed'
                                              ),
                                            ),
                                          ),    //"Description" text
                                          SizedBox(height: screenHeight * 0.005),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              hotelDescriptions[index],
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: screenHeight * 0.018),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),    //Description
                                          SizedBox(height: screenHeight*0.02),
                                          Row(
                                            children: [
                                              Text('Location: ', style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.022,fontFamily: 'RobotoCondensed'),),
                                              Text(
                                                '${hotels[index]['location']}',
                                                style: TextStyle(fontSize: screenHeight*0.018),
                                              ),
                                            ],
                                          ),    //Location
                                          SizedBox(height: screenHeight*0.02),
                                          Row(
                                            children: [
                                              Text('Rating:   ', style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.02),),
                                              Center(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: List.generate(5, (i) {
                                                    return Icon(
                                                      Icons.star,
                                                      color: i < ratings[index] ? Colors.black : Colors.grey,
                                                      size: screenHeight * 0.02,
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: screenHeight*0.02),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: Text('Cancel', style: TextStyle(fontSize: screenHeight*0.018,fontWeight: FontWeight.bold, color: Colors.white ),),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red.shade900
                                                ),
                                              ),
                                              SizedBox(width: screenWidth*0.1,),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => MultiProvider(
                                                        providers: [
                                                          ChangeNotifierProvider(create: (context)=>ImageProvider()),
                                                          ChangeNotifierProvider(create: (context)=>DateTimeProvider()),
                                                        ],
                                                        child: detailsScreen(
                                                          username: widget.username,
                                                          name: widget.name,
                                                          hotelDetails: hotels[index],
                                                          hotelDescription: hotelDescriptions[index],
                                                          rating: ratings[index],
                                                          price: prices[index],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },

                                                child: Text('See details', style: TextStyle(fontSize: screenHeight*0.018,fontWeight: FontWeight.bold,fontFamily: 'RobotoCondensed', color: Colors.white ),),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.grey.shade600
                                                ),
                                              ),
                                            ],
                                          ),    //Buttons
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                hotels[index]['address1']!,
                                width: screenWidth * 0.2,
                                height: screenHeight * 0.2,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(hotels[index]['name']!,style: TextStyle(fontSize: screenHeight*0.023,fontWeight: FontWeight.bold,fontFamily: 'RobotoCondensed'),),
                            subtitle: Text(hotels[index]['location']!,style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('PKR ${prices[index]}',style: TextStyle(fontSize: screenHeight*0.023,fontWeight: FontWeight.bold),),
                                SizedBox(height: screenHeight*0.005,),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(5, (i) {
                                    return Icon(
                                      Icons.star,
                                      color: i < ratings[index] ? Colors.black : Colors.grey,
                                      size: screenHeight*0.018,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(thickness: 5,color: Colors.grey.shade600,),
                    ],
                  );
                },itemCount: hotels.length,
                ),
              ),    //ListView
            ],
          ),
        ],
      ),
    );
  }
}
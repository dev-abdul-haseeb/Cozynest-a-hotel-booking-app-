import 'package:flutter/cupertino.dart' hide ImageProvider;
import 'package:flutter/material.dart' hide ImageProvider;
import 'package:flutter_provider/flutter_provider.dart' hide Consumer, Provider;
import 'package:hotel_booking/Data/Database.dart';
import 'package:hotel_booking/Providers/DateTimeProvider.dart';
import 'package:hotel_booking/homeScreen.dart';
import 'package:provider/provider.dart';
import 'CardEntryWidget.dart';
import 'Providers/ImageProvider.dart';

var cardImages = ['Assets/Images/Visa.jpg',
                  'Assets/Images/Master.png',
                  'Assets/Images/AmericanExpress.jpeg',
                  'Assets/Images/Discover.jpeg'];


class detailsScreen extends StatefulWidget {
  final username;
  final name;
  final hotelDetails;
  final hotelDescription;
  final rating;
  final price;
  const detailsScreen({
    required this.username,
    required this.name,
    required this.hotelDetails,
    required this.hotelDescription,
    required this.rating,
    required this.price,
  });
  @override
  State<detailsScreen> createState() => _detailsScreenState();
}

class _detailsScreenState extends State<detailsScreen> {
  void book() async{
    final provider = Provider.of<DateTimeProvider>(context, listen: false);

    // Insert booking into database
    await DBManager.getInstance().insertBooking(
      hotelName: widget.hotelDetails['name'],
      hotelDescription: widget.hotelDescription,
      address1: widget.hotelDetails['address1'],
      username: widget.username,
      checkInDate: '${provider.checkInDate!.year}-${provider.checkInDate!.month.toString().padLeft(2, '0')}-${provider.checkInDate!.day.toString().padLeft(2, '0')}',
      checkInTime: provider.checkInTime!.format(context),
      checkOutDate: '${provider.checkOutDate!.year}-${provider.checkOutDate!.month.toString().padLeft(2, '0')}-${provider.checkOutDate!.day.toString().padLeft(2, '0')}',
      checkOutTime: provider.checkOutTime!.format(context),
      totalPrice: provider.totalPrice,
      numberOfGuests: provider.numberOfGuests,
      status: 'paid',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking successful!')),
    );
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DateTimeProvider>(context, listen: false)
          .setBasePrice(double.tryParse(widget.price.toString()) ?? 0);
    });


    return Scaffold(
      appBar: AppBar(
        title: Text('What a fine, cozy nest!',style: TextStyle(fontFamily: 'RobotoCondensed',fontSize: screenHeight*0.03),),
        centerTitle: true,
        backgroundColor: Colors.green.shade50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: screenHeight*0.02,color:Colors.green.shade50),
            Container(
              width: screenWidth,
              color: Colors.blue.shade100,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(widget.hotelDetails['name'],style: TextStyle(fontSize: screenHeight*0.04,fontFamily: 'RobotoCondensed',fontWeight: FontWeight.bold),),
                ),
              ),
            ),    //HotelName
            Divider(thickness: 4,),
            Container(
              child: Consumer(
                builder: (ctx,_,_){
                  return (
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth*0.01, right: screenWidth*0.01),
                          child: Container(
                            width: screenWidth,
                            height: screenHeight*0.3,
                            child: ClipRRect(
                              child: Image.asset(
                                widget.hotelDetails[ctx.watch<ImageProvider>().getmainPhoto()],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),    //MainImage
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: screenHeight*0.005,left: screenWidth*0.01,right: screenWidth*0.01),
                              child: InkWell(
                                onTap:() {
                                  ctx.read<ImageProvider>().setFirst();
                                },
                                child: Container(
                                  width: screenWidth*0.48,
                                  height: screenHeight*0.15,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      widget.hotelDetails[ctx.watch<ImageProvider>().getfirstSmall()],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),    //FirstImage
                            Padding(
                              padding: EdgeInsets.only(top: screenHeight*0.005,left: screenWidth*0.01,right: screenWidth*0.01),
                              child: InkWell(
                                onTap:() {
                                  ctx.read<ImageProvider>().setSecond();
                                },
                                child: Container(
                                  width: screenWidth*0.48,
                                  height: screenHeight*0.15,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      widget.hotelDetails[ctx.watch<ImageProvider>().getSecondSmall()],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),    //SecondImage
                          ],
                        )         //SmallImages
                      ],
                    )
                  );    //Left side
                }
              ),
            ),      //Images
            Divider(thickness: 4,),
            Container(
              color: Colors.green.shade50,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight*0.01, left: screenHeight*0.01),
                child: Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('About hotel:',style: TextStyle(fontSize: screenHeight*0.03,fontWeight: FontWeight.bold,fontFamily: 'RobotoCondensed'),)
                  ),
                ),
              ),
            ),      //About Hotel
            Container(
              color: Colors.green.shade50,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight*0.007, left: screenHeight*0.009, right: screenHeight*0.009, bottom: screenHeight*0.01),
                child: Container(
                  child: Text(widget.hotelDescription, style: TextStyle(fontSize: screenHeight*0.023,),),
                ),
              ),
            ),      //Description
            Container(
              margin: EdgeInsets.only(left: screenHeight*0.009,right: screenHeight*0.009),
              color: Colors.blue.shade100,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Location: ${widget.hotelDetails['location']}',style: TextStyle(fontSize: screenHeight*0.025,fontStyle: FontStyle.italic),)
              ),
            ),        //Location
            Consumer<DateTimeProvider>(
              builder: (ctx, provider, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.green.shade50,
                      width: screenWidth,
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.02),
                        child: Text('Check in:', style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold,fontFamily: 'RobotoCondensed')),
                      ),
                    ),      //CheckIn Text
                    Container(color: Colors.green.shade50,height: screenHeight*0.01),
                    Container(
                      color: Colors.green.shade50,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                backgroundColor: Colors.blue.shade200,
                              ),
                              onPressed: () async {
                                DateTime? datePicked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (datePicked != null) {
                                  provider.setcheckInDate(datePicked);
                                }
                              },
                              child: Text(
                                provider.checkInDate == null
                                    ? 'Pick Date'
                                    : '${provider.checkInDate!.day}/${provider.checkInDate!.month}/${provider.checkInDate!.year}',
                                style: TextStyle(fontSize: screenHeight * 0.025, color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                backgroundColor: Colors.blue.shade200,
                              ),
                              onPressed: () async {
                                TimeOfDay? timePicked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.dial,
                                );
                                if (timePicked != null) {
                                  provider.setcheckInTime(timePicked);
                                }
                              },
                              child: Text(
                                provider.checkInTime == null
                                    ? 'Pick Time'
                                    : provider.checkInTime!.format(context),
                                style: TextStyle(fontSize: screenHeight * 0.025, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),      //Checkin Date/Time
                    Container(
                      color: Colors.green.shade50,
                      width: screenWidth,
                      child: Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.02),
                        child: Text('Check out:', style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold,fontFamily: 'RobotoCondensed')),
                      ),
                    ),      //Checkout Text
                    Container(color: Colors.green.shade50,height: screenHeight*0.01),
                    Container(
                      color: Colors.green.shade50,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
                            child: ElevatedButton(
                              onPressed: () async {
                                DateTime? datePicked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (datePicked != null) {
                                  provider.setcheckOutDate(datePicked);
                                }
                              },
                              child: Text(
                                provider.checkOutDate == null
                                    ? 'Pick Date'
                                    : '${provider.checkOutDate!.day}/${provider.checkOutDate!.month}/${provider.checkOutDate!.year}',
                                style: TextStyle(fontSize: screenHeight * 0.025, color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                backgroundColor: Colors.blue.shade200,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                backgroundColor: Colors.blue.shade200,
                              ),
                              onPressed: () async {
                                TimeOfDay? timePicked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.dial,
                                );
                                if (timePicked != null) {
                                  provider.setcheckOutTime(timePicked);
                                }
                              },
                              child: Text(
                                provider.checkOutTime == null
                                    ? 'Pick Time'
                                    : provider.checkOutTime!.format(context),
                                style: TextStyle(fontSize: screenHeight * 0.025, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),      //Checkout Date/Time
                    Container(color: Colors.green.shade50,height: screenHeight*0.03),
                    Container(
                      color: Colors.green.shade50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Number of ', style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold,fontFamily: 'RobotoCondensed')),
                          Icon(Icons.person),
                          Text(':', style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold,fontFamily: 'RobotoCondensed')),
                          SizedBox(width: screenWidth * 0.03),
                          Container(
                            height: screenHeight * 0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.shade200,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: provider.decreaseGuests,
                                ),
                                Text('${provider.numberOfGuests}',
                                    style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: provider.increaseGuests,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),      //Guests
                    Container(color: Colors.green.shade50,height: screenHeight*0.04),
                    Container(
                      color: Colors.green.shade50,
                      width:screenWidth,
                      child: Center(
                        child: Text(
                          'Total Price: PKR ${provider.totalPrice.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: screenHeight * 0.03,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'RobotoCondensed'
                          ),
                        ),
                      ),
                    ),    //Total Price
                  ],
                );
              },
            ),    //Check-Ins and prices
            Container(height: screenHeight*0.05,color: Colors.green.shade50,),
            Container(
              color: Colors.green.shade50,
              child: Padding(
                padding: EdgeInsets.only(left: screenHeight*0.05,right: screenHeight*0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: screenHeight*0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel',style: TextStyle(fontSize: screenHeight*0.025,fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                    ),    //Cancel buttons
                    Container(
                      height: screenHeight*0.05,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade600
                        ),
                        onPressed: () {
                          final provider = Provider.of<DateTimeProvider>(context, listen: false);

                          // Validate required fields
                          if (provider.checkInDate == null ||
                              provider.checkOutDate == null ||
                              provider.checkInTime == null ||
                              provider.checkOutTime == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please select all check-in and check-out details.')),
                            );
                            return;
                          }

                          // Validate check-out after check-in
                          final checkIn = DateTime(
                            provider.checkInDate!.year,
                            provider.checkInDate!.month,
                            provider.checkInDate!.day,
                            provider.checkInTime!.hour,
                            provider.checkInTime!.minute,
                          );
                          final checkOut = DateTime(
                            provider.checkOutDate!.year,
                            provider.checkOutDate!.month,
                            provider.checkOutDate!.day,
                            provider.checkOutTime!.hour,
                            provider.checkOutTime!.minute,
                          );

                          if (!checkOut.isAfter(checkIn)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Check-out must be after check-in.')),
                            );
                            return;
                          }
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) => SizedBox(
                              height: MediaQuery.of(context).size.height * 0.85,
                              child: CardEntryWidget(
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                amount: provider.totalPrice,
                                onSuccess: () {
                                  book(); // Your defined booking function
                                },
                              ),
                            ),
                          );

                        },
                        child: Text('Book now',style: TextStyle(fontSize: screenHeight*0.025,fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                    ),

                  ],
                ),
              ),
            ),    //Buttons
            Container(color: Colors.green.shade50,height: screenHeight*0.08,),
          ],
        ),
      ),
    );
  }
}

Widget cardEntry(var screenWidth, var screenHeight, var amount) {
  return Center(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight * 0.07,
            color: Colors.green.shade100,
            child: Center(
              child: Text(
                'Bill Invoice',
                style: TextStyle(
                  fontSize: screenHeight * 0.04,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed', // fixed typo
                ),
              ),
            ),
          ),      //BillInvoice
          SizedBox(height: screenHeight * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: cardImages.map((imgPath) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                child: Container(
                  width: screenWidth * 0.15,
                  height: screenHeight * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade700,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imgPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),            //CardsImages
          SizedBox(height: screenHeight * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment amount',
                  style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      color: Colors.blue.shade500,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'PKR $amount',
                  style: TextStyle(fontSize: screenHeight * 0.025),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Name on card
                Text(
                  'Name on card',
                  style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      color: Colors.blue.shade500,
                      fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'e.g. Abdul Haseeb',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Card number
                Text(
                  'Card number',
                  style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      color: Colors.blue.shade500,
                      fontWeight: FontWeight.bold),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'e.g. 1234 5678 9012 3456',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Expiry date and Security code
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expiry date',
                            style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                color: Colors.blue.shade500,
                                fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              hintText: 'MM/YY',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Security code',
                            style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                color: Colors.blue.shade500,
                                fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'CVV',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // ZIP/Postal Code
                Text(
                  'ZIP/Postal code',
                  style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      color: Colors.blue.shade500,
                      fontWeight: FontWeight.bold),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'e.g. 60000',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    ),
  );
}

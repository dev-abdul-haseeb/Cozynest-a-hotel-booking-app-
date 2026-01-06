import 'package:flutter/material.dart';
import 'Data/Database.dart';
import 'Functions/TextStyles.dart'; // Adjust path as per your project

class bookingsScreen extends StatefulWidget {
  final String username;
  const bookingsScreen({required this.username});

  @override
  State<bookingsScreen> createState() => _bookingsScreenState();
}

class _bookingsScreenState extends State<bookingsScreen> {
  late Future<List<Map<String, dynamic>>> userBookings;

  @override
  void initState() {
    super.initState();
    userBookings = DBManager.getInstance().getBookingsByUsername(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookings',
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: screenHeight * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green.shade100,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: userBookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No bookings found."));
          }

          final bookings = snapshot.data!;
          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: booking['status'] == 'paid'
                    ? Colors.green.shade300
                    : booking['status'] == 'Checked In'
                    ? Colors.lightGreen.shade100
                    : booking['status'] == 'Expired'
                    ? Colors.red.shade900
                    : Colors.blue.shade100.withOpacity(0.3),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      booking['address1'],
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.1,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Center(
                    child: Text(
                      booking['hotelName'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenHeight * 0.022,
                        fontFamily: 'RobotoCondensed',
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Check-in:  ", style: bookingStyle(screenHeight),),
                            Text("${booking['checkInDate']} at ${booking['checkInTime']}",style: bookingTiles(),)
                          ],
                        ),
                        Row(
                          children: [
                            Text("Check-out: ", style: bookingStyle(screenHeight),),
                            Text("${booking['checkOutDate']} at ${booking['checkOutTime']}",style: bookingTiles())
                          ],
                        ),
                        Row(
                          children: [
                            Text("Guests: ", style: bookingStyle(screenHeight),),
                            Text("${booking['numberOfGuests']}",style: bookingTiles())
                          ],
                        ),
                        Row(
                          children: [
                            Text("Total: ", style: bookingStyle(screenHeight),),
                            Text("PKR ${booking['totalPrice']}",style: bookingTiles())
                          ],
                        ),
                        Row(
                          children: [
                            Text("Status: ", style: bookingStyle(screenHeight),),
                            Text("${booking['status']}",style: bookingTiles())
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

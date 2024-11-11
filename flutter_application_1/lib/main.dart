import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SubscriptionScreen(),
    );
  }
}

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  // List to store subscribed services
  List<String> subscribedServices = [];

  // Function to subscribe to a service
  void subscribe(String service) {
    setState(() {
      // Check if the service is already in the list
      if (!subscribedServices.contains(service)) {
        subscribedServices.add(service); // Add to the list only if not already present

        // Show a snack bar message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Subscribed to $service'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  // Function to unsubscribe from a service
  void unsubscribe(String service) {
    setState(() {
      subscribedServices.remove(service); // Remove from the list

      // Show a snack bar message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unsubscribed from $service'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subscription App",
          style: TextStyle(
            color: Colors.yellow, // Set title color to yellow
            fontSize: 28, // Increased font size
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 88, 88, 88).withOpacity(0.5), // Translucent gray
        elevation: 0, // Remove shadow for a cleaner look
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFC2CFC5), // #c2cfc5
              Color(0xFFD2D9D4), // #d2d9d4
              Color(0xFFE3E3E4), // #e3e3e4
              Color(0xFFFEEEE5), // #feeee5
              Color(0xFFFCE4D8), // #fce4d8
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Subscription buttons and images
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildSubscriptionItem('IWantV', 'assets/iWantV.png'),
                  buildSubscriptionItem('Netflix', 'assets/netflix.png'),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildSubscriptionItem('YouTube', 'assets/youtube.png'),
                  buildSubscriptionItem('Spotify', 'assets/spotify.png'),
                ],
              ),
              SizedBox(height: 50),
              // Table-like display of subscribed services
              Expanded(
                child: ListView.builder(
                  itemCount: subscribedServices.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4), // Reduced gap
                        title: Text(
                          subscribedServices[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade700,
                          ),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 0.2), // Reduced space on the right
                          child: IconButton(
                            icon: Icon(Icons.remove_circle, color: Colors.red),
                            iconSize: 30, // Increased icon size
                            onPressed: () {
                              unsubscribe(subscribedServices[index]);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build subscription image and button
  Widget buildSubscriptionItem(String serviceName, String imagePath) {
    return GestureDetector(
      onTap: () => subscribe(serviceName),
      child: Card(
        elevation: 5,
        color: Colors.white.withOpacity(0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(imagePath, width: 500, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Subscribe to $serviceName",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

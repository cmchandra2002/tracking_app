import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Usage Demo',
      home: AppUsagePage(),
    );
  }
}

class AppUsagePage extends StatefulWidget {
  @override
  _AppUsagePageState createState() => _AppUsagePageState();
}

class _AppUsagePageState extends State<AppUsagePage> {
  List<AppUsageInfo> _usageInfoList = [];
  bool _isLoading = true;
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm a');

  @override
  void initState() {
    super.initState();
    _getUsageStats();
  }

  Future<void> _getUsageStats() async {
    try {
      // Set the time range for app usage stats
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 1));
      AppUsage appUsage = AppUsage();
      // Get app usage stats for the specified time range
      List<AppUsageInfo> usageStats =
          await appUsage.getAppUsage(startDate, endDate);
      // Sort the app usage stats by app name
      usageStats.sort((a, b) => a.appName.compareTo(b.appName));

      setState(() {
        _usageInfoList = usageStats;
        _isLoading = false;
      });
    } catch (e) {
      print('Error getting app usage stats: $e');
    }
    print(_usageInfoList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text(
          'Mobile Apps Activity',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _getUsageStats,
              child: ListView.builder(
                itemCount: _usageInfoList.length,
                itemBuilder: (BuildContext context, int index) {
                  final AppUsageInfo appUsage = _usageInfoList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 22, 76, 176),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        tileColor: Color.fromARGB(255, 101, 196, 231),
                        title: Text(
                          appUsage.appName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                            letterSpacing: 2.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Usage time: ${appUsage.usage.inMinutes} minutes',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 1.0,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            Text(
                              'Last used: ${formatter.format(appUsage.lastForeground)}',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 1.0,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

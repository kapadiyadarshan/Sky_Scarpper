import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/controllers/Weather_controller.dart';
import 'package:sky_scrapper/utils/colors_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.theme2,
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "asset/images/weather_bg1.jpg",
          ),
        ),
        // gradient: LinearGradient(
        //   colors: [
        //     Color(0xff91EAE4),
        //     Color(0xff86A8E7),
        //     Color(0xff7F7FD5),
        //   ],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Weather",
            style: TextStyle(
              color: MyColor.theme1,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == ConnectivityResult.none) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "asset/images/No_connection.png",
                        scale: 1.5,
                      ),
                      const Text(
                        "No Internet Connection",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                          "Please connect to the internet and try again."),
                      const SizedBox(
                        height: 48,
                      ),
                    ],
                  );
                } else {
                  return Consumer<WeatherController>(
                      builder: (context, provider, _) {
                    DateTime? sunrise;
                    DateTime? sunset;
                    if (provider.weather != null) {
                      sunrise = DateTime.fromMillisecondsSinceEpoch(
                          provider.weather!.sunrise * 1000);
                      sunset = DateTime.fromMillisecondsSinceEpoch(
                          provider.weather!.sunset * 1000);
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: MyColor.white,
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              child: TextFormField(
                                onFieldSubmitted: (value) {
                                  provider.getData(location: value);
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: "Search Location",
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    size: 24,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 30,
                                      color: MyColor.theme1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            (provider.weather == null)
                                ? SizedBox(
                                    height: 800,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "asset/images/404.png",
                                          scale: 1.2,
                                        ),
                                        Container(
                                          width: 300,
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: MyColor.theme1,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Location not found.",
                                            style: TextStyle(
                                              color: MyColor.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 100,
                                        )
                                      ],
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 120,
                                      ),
                                      Text(
                                        "${provider.weather!.temp.toInt()}°C",
                                        style: TextStyle(
                                          color: MyColor.theme1,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 70,
                                        ),
                                      ),
                                      Text(
                                        provider.weather!.name,
                                        style: TextStyle(
                                          color: MyColor.theme1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                      Text(
                                        "${provider.weather!.temp_min.toInt()}°/${provider.weather!.temp_max.toInt()}°   Feel like ${provider.weather!.feels_like.toInt()}°C",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: MyColor.theme1,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        height: 100,
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyColor.theme1,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons.sun_dust_fill,
                                              color: MyColor.white,
                                              size: 44,
                                            ),
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  provider.weather!.main,
                                                  style: TextStyle(
                                                    color: MyColor.white,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                                Text(
                                                  provider.weather!.description,
                                                  style: TextStyle(
                                                    color: MyColor.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 190,
                                            width: 190,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: MyColor.theme1,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.thermometer,
                                                  color: MyColor.white
                                                      .withOpacity(0.6),
                                                  size: 36,
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                  "Feels Like",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: MyColor.white
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                                Text(
                                                  "${provider.weather!.feels_like.toInt()}°C",
                                                  style: TextStyle(
                                                      fontSize: 28,
                                                      color: MyColor.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 190,
                                            width: 190,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: MyColor.theme1,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.water_drop_rounded,
                                                  color: MyColor.white
                                                      .withOpacity(0.6),
                                                  size: 36,
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                  "Humidity",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: MyColor.white
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                                Text(
                                                  "${provider.weather!.humidity} %",
                                                  style: TextStyle(
                                                    fontSize: 28,
                                                    color: MyColor.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 190,
                                            width: 190,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: MyColor.theme1,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.wind,
                                                  color: MyColor.white
                                                      .withOpacity(0.6),
                                                  size: 36,
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                  "Wind",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: MyColor.white
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                                Text(
                                                  "${provider.weather!.wind_speed} Mps",
                                                  style: TextStyle(
                                                    fontSize: 28,
                                                    color: MyColor.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 190,
                                            width: 190,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: MyColor.theme1,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.wind_snow,
                                                  color: MyColor.white
                                                      .withOpacity(0.6),
                                                  size: 36,
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                  "Wind Direction",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: MyColor.white
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                                Text(
                                                  "${provider.weather!.wind_degree.toInt()}°",
                                                  style: TextStyle(
                                                      fontSize: 28,
                                                      color: MyColor.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 190,
                                            width: 190,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: MyColor.theme1,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.eye_solid,
                                                  color: MyColor.white
                                                      .withOpacity(0.6),
                                                  size: 36,
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                  "Visibility",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: MyColor.white
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                                Text(
                                                  "${provider.weather!.visibility / 1000.toInt()} Km",
                                                  style: TextStyle(
                                                    fontSize: 28,
                                                    color: MyColor.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 190,
                                            width: 190,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: MyColor.theme1,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.air,
                                                  color: MyColor.white
                                                      .withOpacity(0.6),
                                                  size: 36,
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                  "Air Pressure",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: MyColor.white
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                                Text(
                                                  "${provider.weather!.pressure} hPa",
                                                  style: TextStyle(
                                                      fontSize: 28,
                                                      color: MyColor.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 190,
                                            width: 190,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: MyColor.theme1,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.sunrise,
                                                  color: MyColor.white
                                                      .withOpacity(0.6),
                                                  size: 36,
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                  "Sunrise",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: MyColor.white
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                                Text(
                                                  "${sunrise!.hour}:${sunrise.minute.toString().padLeft(2, "0")} AM",
                                                  style: TextStyle(
                                                    fontSize: 28,
                                                    color: MyColor.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 190,
                                            width: 190,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: MyColor.theme1,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.sunset,
                                                  color: MyColor.white
                                                      .withOpacity(0.6),
                                                  size: 36,
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Text(
                                                  "Sunset",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: MyColor.white
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                                Text(
                                                  "${sunset!.hour % 12}:${sunset.minute.toString().padLeft(2, "0")} PM",
                                                  style: TextStyle(
                                                    fontSize: 28,
                                                    color: MyColor.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    );
                  });
                }
              } else {
                return Center(
                  child: SpinKitChasingDots(
                    itemBuilder: (context, index) => Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: MyColor.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

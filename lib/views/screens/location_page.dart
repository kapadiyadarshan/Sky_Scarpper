import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/controllers/Weather_controller.dart';
import 'package:sky_scrapper/modals/Weather_modals.dart';
import 'package:sky_scrapper/utils/colors_utils.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "asset/images/weather_bg1.jpg",
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cities",
            style: TextStyle(
              color: MyColor.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              color: MyColor.white,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Consumer<WeatherController>(builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
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
                      Navigator.pop(context);
                    },
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    cursorColor: MyColor.theme1,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Search Location",
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 24,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: MyColor.theme1,
                        ),
                        borderRadius: BorderRadius.circular(10),
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
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.LocationList.length,
                    itemBuilder: (context, index) {
                      Weather? weather = provider.LocationList[index];
                      return GestureDetector(
                        onTap: () {
                          provider.getData(location: weather.name);
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.theme1,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    weather!.name.toString(),
                                    style: TextStyle(
                                      color: MyColor.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Text(
                                    weather.description.toString(),
                                    style: TextStyle(
                                      color: MyColor.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                "${weather.temp.toInt()}°C",
                                style: TextStyle(
                                  color: MyColor.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

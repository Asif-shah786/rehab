import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rehab/view_model/session_view_model.dart';
import '../common_widgets/custom_text_button.dart';

class RehabView extends StatelessWidget {
  const RehabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<SessionViewModel>(
            init: Get.isRegistered<SessionViewModel>()
                ? Get.find<SessionViewModel>()
                : Get.put(SessionViewModel()),
            builder: (controller) {
              int totalSessions = controller.sessionHistoryModel.length;
              // int totalSessionsTime = controller.sessionHistoryModel.toList().fold(0, (i, el){ return i + el['sessionTime']);
              if (controller.loading.value) {
                return Container(
                  alignment: Alignment.center,
                  height: 1,
                  width: 1,
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(top: 25.w, left: 25.w, right: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rehab Programme',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2.h),
                        height: 180.h,
                        width: double.infinity.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                          color: Colors.lightBlueAccent,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.sp),
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Knee Rehab\nProgramme',
                                    style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)),
                                Text(
                                  'Mon, Thu, Sat\n3 Sessions/day',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                // CustomRaisedButton(onPressed: (){},color: Colors.white,child: const Text('Left Shoulder'),),
                                Container(
                                  height: 30.h,
                                  margin: EdgeInsets.symmetric(vertical: 4.h),
                                  child: CustomTextButton(
                                    onPressed: () {},
                                    color: Colors.white,
                                    borderRadius: 4.sp,
                                    child: const Text(
                                      'Left Shoulder',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  ),
                                ),
                                Text('Assigned By',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    )),
                                Text('Jane Doe',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'History',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                            const Icon(
                              Icons.filter_alt_rounded,
                              size: 24,
                            )
                          ],
                        ),
                      ),
                      Container(
                          height: 50.h,
                          width: double.infinity.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.h),
                            color: Colors.grey.shade300,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total Sessions',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Row(children: [
                                      const Icon(
                                        Icons.fitness_center_outlined,
                                        size: 16,
                                        color: Colors.indigo,
                                      ),
                                      Text(
                                        ' $totalSessions',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 2,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total Time',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Row(children: [
                                      Icon(
                                        Icons.hourglass_full_rounded,
                                        size: 16,
                                        color: Colors.yellow.shade800,
                                      ),
                                      Text(
                                        ' 16',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ]),
                                  ],
                                )
                              ],
                            ),
                          )),
                      SizedBox(height: 6.h),
                      Expanded(
                        child: ListView.builder(
                            itemCount: controller.sessionHistoryModel.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SessionHistoryTile(
                                time:
                                controller.sessionHistoryModel[index].sessionTime,
                                date:
                                controller.sessionHistoryModel[index].sessionDate,
                              );
                            }),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}

class SessionHistoryTile extends StatelessWidget {
  const SessionHistoryTile({Key? key, required this.date, required this.time})
      : super(key: key);

  final String? time;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: double.infinity.w,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: SizedBox(
            height: 40.w,
            width: 40.w,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4.sp),
                child: Image.asset('assets/session_pic1.png'))),
        title: Row(
          children: [
            Icon(
              Icons.access_time_outlined,
              size: 16.sp,
              color: Colors.black,
            ),
            Text(
              ' ${time ?? 'null'}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.date_range_outlined,
              size: 16.sp,
              color: Colors.black,
            ),
            Text(
              ' ${date ?? 'null'}',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
          ],
        ),
        trailing: TextButton(
          onPressed: () {},
          child: Text(
            'View Results',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

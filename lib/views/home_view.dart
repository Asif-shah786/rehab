import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rehab/view_model/session_view_model.dart';
import '../common_widgets/custom_text_button.dart';
import '../helpers/constants.dart';
import '../models/session_model.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionViewModel>(
      init: Get.isRegistered<SessionViewModel>()
          ? Get.find<SessionViewModel>()
          : Get.put(SessionViewModel()),
      builder: (controller) => controller.loading.value ?
      const Center(child: CircularProgressIndicator(),) :
      SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: SizedBox(
              width: double.infinity.w,
              child: FloatingActionButton.extended(
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow_rounded,
                      size: 30.sp,
                    ),
                    Text(
                      'Start Session',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                onPressed: () => controller.startSession(context),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 25.w, left: 25.w, right: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(),
                buildContainer(controller),
                SizedBox(height: 10.h),
                Expanded(
                  child: SizedBox(
                    width: double.infinity.w,
                    height: 320.w,
                    child: GetBuilder<SessionViewModel>(
                      init: Get.isRegistered<SessionViewModel>()
                          ? Get.find<SessionViewModel>()
                          : Get.put(SessionViewModel()),
                      builder: (controller) {
                        print('Controller Session Model Length ${controller.sessionModel.length}');
                        return ListView.builder(
                            itemCount: controller.sessionModel.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SessionTile(
                                session: controller.sessionModel[index],
                              );
                            });}),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Good Morning\nJane',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26.sp,
          ),
        ),
      ],
    );
  }

  Container buildContainer(SessionViewModel controller) {
    String progressBarPercent = (controller.currentSessionIndex.value / controller.sessionModel.length * 100).toInt().toString();
    double progressBarValue = (controller.currentSessionIndex.value / controller.sessionModel.length * 100).toDouble();
    String completedTasks =  (controller.currentSessionIndex.value).toString();
    String pendingTasks =  (controller.sessionModel.length - controller.currentSessionIndex.value).toString();
    return Container(
      height: 110.h,
      width: double.infinity.w,
      decoration: BoxDecoration(
        border: Border.all(color: kTextGreyColor, width: 2.sp),
        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today\'s Progress',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: kTextGreyColor,
                    )),
                Text(
                  ' $progressBarPercent %',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                    color: Colors.blueAccent,
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.h),
              width: double.infinity.w,
              height: 8.h,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  value: progressBarValue,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_box_rounded,
                      color: Colors.green,
                      size: 30.sp,
                    ),
                    SizedBox(
                      height: 30.h,
                      child: FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Completed',
                              style: TextStyle(
                                color: kTextGreyColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              ' $completedTasks',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_circle_right_rounded,
                      color: Colors.blueAccent,
                      size: 30.sp,
                    ),
                    SizedBox(
                      height: 30.h,
                      child: FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pending',
                              style: TextStyle(
                                color: kTextGreyColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              ' $pendingTasks',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SessionTile extends StatelessWidget {
  const SessionTile({Key? key, required this.session}) : super(key: key);

  final SessionModel session;

  @override
  Widget build(BuildContext context) {
    final bool active = session.sessionCompleted ? true : false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 120.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              session.sessionNo == 1
                  ? Text('')
                  : Bar(active: session.sessionCompleted),
              session.sessionNo == 1
                  ? Text('')
                  : Bar(active: session.sessionCompleted),
              session.sessionNo == 1
                  ? Text('')
                  : Bar(active: session.sessionCompleted),
              session.sessionCompleted
                  ? Icon(
                      Icons.check_circle_rounded,
                      color: Colors.blueAccent,
                      size: 25.sp,
                    )
                  : Icon(
                      Icons.circle_outlined,
                      color: Colors.grey,
                      size: 25.sp,
                    ),
              Bar(active: session.sessionCompleted),
              Bar(active: session.sessionCompleted),
              Bar(active: session.sessionCompleted),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          height: 120.h,
          width: 280.w,
          decoration: BoxDecoration(
            border: Border.all(color: kTextGreyColor, width: 2.sp),
            borderRadius: BorderRadius.all(Radius.circular(8.sp)),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.h),
                  child: SizedBox(
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Session ${session.sessionNo}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                          child: CustomTextButton(
                            onPressed: () {},
                            color: Colors.blueAccent,
                            borderRadius: 16.sp,
                            child: FittedBox(
                              child: Text(
                                session.sessionCompleted
                                    ? 'Completed'
                                    : 'Pending',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          session.sessionCompleted
                              ? 'Performed At'
                              : 'Not Performed',
                          style: TextStyle(
                            color: kTextGreyColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          session.sessionTime ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                  child: Image.asset('assets/session_pic1.png'),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Bar extends StatelessWidget {
  const Bar({
    Key? key,
    required this.active,
  }) : super(key: key);

  final bool active;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 10,
        width: 10,
        child: VerticalDivider(
          color: active ? Colors.blueAccent : Colors.grey,
          thickness: 2,
          width: 2,
        ));
  }
}
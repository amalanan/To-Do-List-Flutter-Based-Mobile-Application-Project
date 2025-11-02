import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(DevicePreview(enabled: false, builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (_) => const SplashPage(),
        Routes.login: (_) => const LoginScreen(),
        Routes.signup: (_) => SignUp(),
        Routes.home: (_) => MainNavigationScreen(),
        Routes.tasks: (_) => TasksScreen(),
        Routes.profile: (_) => ProfileScreen(),
        Routes.createEdit: (_) => CreateEditScreen(),
        Routes.dashboard: (_) => DashboardScreen(),
      },
    );
  }
}

// SharedPreferences  عشان نحدد شاشة البداية
/* final prefs = await SharedPreferences.getInstance();
  final hasLoggedIn = prefs.getBool(LoginScreen.userCredentialsKey) ?? false;
  final initialRoute = hasLoggedIn ? Routes.home : Routes.splash;
*/

//A
/*First of all we have the main() function which takes the main widget and show it on screen what is the main widget here? It is the runApp(MyApp));
void main() {
  runApp(MyApp());
}
Which is MyApp which is the main widget of all app and everything in the application will be under it
The first thing is making sure that the flutter engine is ready before running the application how??  via
عن طريق ال WidgetsFlutterBinding.ensureInitialized();
Why?
Because it is very important for the Sharedpreferences  اللي هو التخزين المحلي للبيانات
And for Sqflite which is  قواعد البيانات اللي هو تخزين البيانات في داتا بيز
And for any async processes before running the app runApp

*/

//A
/*Now we’ll talk about Device Preview which is used for running the application without an emulator
DevicePreview(
  enabled: true,
  builder: (context) => MyApp(),
)
بتنحط فوق ال myApp  و لازم يتم تفعيلها
By setting enabled:true,
*/

//A
/* الماتريال اب هو مستخدم ك ماتريال ديزاين لأي تطبيق فلاتر فبالتالي هو مسؤول عن ال
theme (colors , fonts ) ,  و عن ال Routes  اللي هم شاشات التطبيق
في  عنا  كمان قصة تحديد شاشة ك initial  اللي هي هتكون السبلاش
و طبعا في كمان ال debug banner  اللي هي الاشارة الحمرا اللي على جنب الايميوليتور
-- طيب هلقيت بدنا نحدد الثيم تبع التطبيق بحيث اي سكافولد هيكون الثيم تبعها موحد مع باقي الواجهات
طيب كيف احدد الثيم داتا هاي؟
  theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Poppins',
      ),
      عن طريق ال theme  هيك بنقدر نحدد السواتش الاساسية لكل واجهات البرنامج
      و قدرنا نحدد نوع الخط
-- طيب هلقيت عن طريق هاي الجملة هيك حددنا انه الشاشة الهوم تبعت الماتيريال اب هي السبلاششششششش
        initialRoute: Routes.splash,
او انها الانيشيال راوت يعني

-- بعد هيك احنا بنحدد شو هم الراوتس اللي عندي في التطبيق عن طريق اني احدد كل راوت في التطبيق
  routes: {
          Routes.splash: (_) => const SplashPage(),
          Routes.login: (_) => const LoginScreen(),
          Routes.signup: (_) => SignUp(),
          Routes.home: (_) => const HomeScreen(),
        },

      طبعا لازم يكون عنا كلاس خاص جنب المين اسمه Routes
*/

//A
/*
بعد هيك بدنا نضيف شغلات
اساسية للكيوبيت و للapi و لل shared preferences
اول اشي هنضيف الشغلات اللي الها علاقة بالشيرد بريفرانسز
 هنعرف اوبجكت من الشيرد بريفرنسز
  final prefs = await SharedPreferences.getInstance();
  و نخزن قيمة البوليان تبع ال بريفز بحيث اتأكد هل اللوجين سكرين دخل اليوزر فيها الكريدينتالز كي تعته اللي هي بتسأل البريفرانسز هل المستخدم سجل دخول قبل كدا ولا لا
  final hasLoggedIn = prefs.getBool(LoginScreen.userCredentialsKey) ?? false;
  final initialRoute = hasLoggedIn ? Routes.home : Routes.splash;
*/

import '../../../imports.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    _redirectToNextScreen();
  }

  Future<void> _redirectToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final loggedEmail = prefs.getString(LoginScreen.userCredentialsKey);

    if (loggedEmail != null && loggedEmail.isNotEmpty) {
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      Navigator.pushReplacementNamed(context, Routes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                child: Image.asset(
                  'assets/images/logo1.jpg',
                  fit: BoxFit.scaleDown,
                ),
              ),

              /*const Icon(Icons.check_circle_outline,
                  size: 90, color: Colors.black),*/
              const SizedBox(height: 20),
              const Text(
                'Welcome to ToDoList',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//A
/*
هنا استخدمنا الستيتفول ودجت عشان سلوك الواجهة بيتغير مغ الزمن و في عنا انيميشن و انتظار اللي هو اويت و سينكينج مع الفيوتشر و كمان عنا هيصير نافيجيشن ع شاشات بعدين
و هنعمل كرييشن للستيت اللي هي كرييت ستيت عشان ينفذ كل اللوجيك اللي في الواجهة
 class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}
////
class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {

هلقيت الستيتس هنا شو بتعمل بهادا السطر بتستخدم الميكسين SingleTickerProviderStateMixin
عشان يوفرلنا vsync
لل AnimationController
بحيث هنا بيمنع الانيميشن من انه يضل مستمر لوقت انا مش محتاجاه يشتغل فيه او مثلا يستهلك بطارية و مساحة من المعالج السي بي يو اكتر من اللازم
ف في فكرة هنا و هي انه لو انا بدي كونترولر واحد  فقط و الل يهو بس لكلمة ويلكم
انا بستخدم هادا الميكسين لكن لو بدي اكتر من كنترولر و انفذ اكتر من انيميشن  بستخدم ميكسن تاني
TickerProviderStateMixin اللي هو هادا


طيب نيجي نشوف
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

الكونترولر هنا بيتحكم بالتوقيت بتع الانيميشن و
ال fade animation
هاي بيكون نوعها دابل بحيث بتحكم من خلالها بكمية الشفافية او الاوبوسيتي تعت ال انتقال اللي هو fade transation
////
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    _redirectToNextScreen();
  }
هلقيت الinitstate بستدعيها مرة واحدة لما انشئ الستيت
بعدين بهيئ الكونترولر عن طريق اني احددله ديوريشن مع ال
   تعت الميكسين
   vsync  تعت ال
   طيب هنا بدنا نحدد نطاق القيم اللي ممكن تاخدها الاوبوسيتي تعت ال ترانسيشن
   و بعدها المفروض نحكي للكونترولر ابدأ فورا من البداية للنهاية اللي هو بداية النطاق لاخره
   بعدين هنستدعي الميثود تعت التنقل تعت النافيجيشن  اللي هي مسؤولة عن العرض و فحص الشيرد بريفرانسز و كمان بعدها التنقل للواجهة التالية
   ///
     Future<void> _redirectToNext() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final loggedEmail = prefs.getString(LoginScreen.userCredentialsKey);

    if (loggedEmail != null && loggedEmail.isNotEmpty) {
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      Navigator.pushReplacementNamed(context, Routes.login);
    }
  }
هنا هنستنى 3 ثواني قبل الانتقال اللي هو النافيجيشن ف هنا بيسمح لليوزر يشوف السبلاش و الانيميشن
هلقيت في عنا بعدها الماونتد هنا بتشكل حماية عشان اتاكد انه الودجت ضايلة بالودجت تري
قبل محاول استخدام الكونتكست او الانتقال ف هنا بحمي الكود من انه يصير اي اكسبشنز زب ال set state called after dispose()
او اني استخدم نافيجيتور على ودجت مش موجودة
يعني مثلا اني اعمل اغلاق للصفحة قبل انتهاء وقت الdelay

بعدها عملنا اوبجكت من الشيرد بريفرانسز عشان نخزن فيه محليا
و بنقرأ بعدها من جيت سترينج  من شاشة اللوجين اللي عو اليوزر كريدينتالز كي  اللي نوعها سترينج اصلا


بعدها هنفحص اذا كان الايميل الل ياخدته من الجيت سترينح موجود او مسجل مسبقا يبقى هيروج عالهووم
غير هيك هيروح عال لوجين و يسجل ك يوزر جديد

pushReplacementNamed يستبدل الشاشة الحالية ولا يسمح بالعودة إليها بزر الـBack.

/////
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
هنا عشان نحمي الكود من اي تسريبات من الميموري  memory leaks
ف بتأكد اني اعمل للكونترولر ديسبوز اولا  بعدين ديسبوس لكل الواجهة



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline,
                  size: 90, color: Colors.black),
              const SizedBox(height: 20),
              const Text(
                'Welcome to ToDoList',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
هنا السكافولد هي البنية الاساسية للواجهة و هيكون جواتها او بالمنتصف عنا ك تشايلد الفيد ترانزيتسن
و هنحددله الاوباستي و بعدها هنحط كولوم هيكون جواته الايقونة و التكست ودجت اللي مكتوب فيها ويلكم
 */

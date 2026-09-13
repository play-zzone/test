PLAYZONE GOLD v2.1 — PS4 WebKit host
====================================
واجهة ذهبية خفيفة • Gold, featherweight UI
PRIMARY CHAIN: POOPS  (chain_poops.js / run_poops.html)

===========================================================
 WHAT CHANGED IN v2 (ملخص التحديث)
===========================================================
1) واجهة التحميل أصبحت بار تحميل حقيقيًا + نسبة مئوية ذهبية.
   Downloading now shows a real gold progress bar + percentage.

2) يظهر رقم إصدار الجهاز (FW) في الشاشة الرئيسية وصفحتي الإقلاع،
   مع شارة التوافق (محلولة من User-Agent مثل سلاسل التفعيل نفسها).
   Device FW is detected from the User-Agent (same rule as the chains),
   shown as a big badge + SUPPORTED / UNVERIFIED pill.

3) الثيم: خلفية سوداء، النص والتحميل ذهبي (GOLD).
   Black background, gold text & gold download bar (dark + gold).

4) خفيفة جدًا: بلا صور، بلا backdrop-filter، بلا خطوط خارجية،
   CSS/JS مختصر — أقل من 8KB للصفحة الرئيسية.
   Featherweight: no images/filters/external fonts; index < 8KB.

5) استقرار أعلى (Stability):
   * انتهى الوقوف اليدوي: إعادة الفتح تتم تلقائيًا بعد مبادلة الكاش
     (auto swapCache + reload) بدل "أغلق المتصفح وافتحه بنفسك".
   * خطأ الكاش/تقادمه: محاولة تلقائية واحدة ثم تشغيل مباشر دون تعليق.
   * مؤقّت أمان (45 ث) — لا تدخل الشاشة في انتظار أبدي، تتابع تلقائيًا.
   * لا يوجد أي مسار يطلب ضغطة زر للإكمال (الزر طوارئ فقط).
   * إصلاح: مسار LAPSE كان يسرّب ?bug=lapse إلى رابط صفحات الإقلاع
     فيفشل تطابق الكاش الأوفلاين — الآن الرابط دقيق لملف cache.appcache.
   * البار الذهبي يظهر الآن أثناء التفعيل نفسه: شريط متحرك ذهبي مع سطر
     حالة ثنائي اللغة — "جارٍ التفعيل… / Activating…" ثم "تم التفعيل ✓ /
     Activated ✓" (وعند الفشل: "تعذّر التفعيل / Activation FAILED").
     The gold bar now runs through activation with bilingual status.

ملاحظة مهمة: سلاسل الاستغلال (chain_*.js / core.js / mem.js / int64.js /
ps4_offsets.js / rpc_worker.js) والملفات الثنائية (payload.bin / patches /
ko-files) لم تُمس — كل بايت مطابق للأصل. الاستقرار تحسن في الطبقة
الوسيطة (الإطلاق والانتقال) وليس في منطق الاستغلال.

===========================================================
 HOW TO SERVE (طريقة التشغيل)
===========================================================
Windows (هذا الجهاز):
    cd C:\temp\ps4-gold
    python -m http.server 8080
ثم من متصفح PS4 افتح:  http://<IP-الجهاز>:8080/
(BTW: أوجد IP-الجهاز بأمر ipconfig — يجب أن يكونا على نفس الشبكة)

أي استضافة ثابتة (GitHub Pages / nginx / Node): ارفع محتويات المجلد
كما هي وافتح رابط الجذر.

===========================================================
 FIRMWARE SUPPORT — ما قبل التشغيل
===========================================================
poops chain = مثبت على 13.00 (حسب README الأصلي)، جدول الإزاحات يشمل
             11.50 / 12.00 / 12.02 / 12.50 / 12.52 / 13.00 / 13.02 / 13.04.
lapse chain = بديل عند الحاجة (للإصدارات 12.02 وما دون أصلًا،
             وليس الافتراضي) — يُفعَّل بـ:  index.html?bug=lapse
افتراضيًا يذهب الجميع إلى poops (نفس سلوك الأصل — لا تغيير في التوجيه).

خيارات اختبار إضافية:
    index.html?fw=13.00   تجربة واجهة بإصدار محدد دون جهاز
    index.html?bug=lapse  فرض سلسلة LAPSE

===========================================================
 FILES
===========================================================
  index.html ................. launcher: FW badge + gold progress bar
  run_poops.html ............. poops entry (black/gold, FW chip)
  run_lapse.html ............. lapse entry
  chain_poops.js / chain_lapse.js / core.js / mem.js / int64.js /
  ps4_offsets.js / rpc_worker.js / payload.bin / patches/*.bin /
  ko-files/* / cache.appcache . ملفات أصلية دون تعديل (essential, untouched)

  النسخة الاحتياطية قبل التعديل: C:\temp\ps4_web_original
===========================================================
PLAYZONE GOLD v2 — with love, play_zzone
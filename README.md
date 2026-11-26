# Kişiselleştirme · Personalize (merkez-kisisellestirme)

Kişiselleştirme ailesinin **merkez uygulaması**: 13 çevrimdışı aracı tek uygulamada toplar.
Görünüm oyun merkezlerinin onaylı tasarım dilini izler (koyu degrade zemin, "13 Uygulama",
yuvarlak arama, vurgu çerçeveli kutular). Alt gezinme: Ana Sayfa · Uygulamalar · Favoriler · Profil.

- Çatı: [studio-core](https://github.com/taktemurr-ops/studio-core) `lib/apps` · Motor: [kisisel-motoru](https://github.com/taktemurr-ops/kisisel-motoru)
- 33 dil · telefon, tablet, web · çevrimdışı
- Reklamsız / Premium satın alma; ödüllü reklam isteğe bağlı ekstralar için; geçiş reklamı yalnızca
  bir araçtan çıkarken ve en az 3 dakika arayla.
- Play politikası (PLAN.md §6): kilit ekranı değiştirilmez → "Şarj saati (ekran koruyucu)";
  ikon paketi yalnız genel kategori ikonları (appfilter/marka eşlemesi yok); zil sesi atanmaz, WAV kaydedilir.
- Android yerel bileşenleri kisisel-motoru eklentisiyle uygulamaya girer: sistem canlı duvar kağıdı
  (WallpaperService), 5 ana ekran widget'ı (AppWidget) ve ekran koruyucu saat (DreamService), şarj animasyonu
  (DreamService), kenar ışıklandırma (bildirim dinleyici + kaplama penceresi), dinamik bildirim adası
  (bildirim dinleyici + kaplama), her zaman açık ekran (DreamService), gelen aramada flaş (bildirim
  dinleyici + fener) ve estetik ana ekran (kısayol sabitleme). Hepsi kullanıcı ilgili aracı açana dek
  kapalıdır. iOS widget uzantısı: ios_widget/README.md (App Group gerekir).
- İzinler: yalnız SYSTEM_ALERT_WINDOW (diğer uygulamaların üzerinde göster: kenar ışığı, ada, arama flaşı
  kenarı) ve kullanıcının sistem ayarlarından açtığı bildirim erişimi (kenar, ada ve arama için ayrı
  dinleyiciler). Kamera, konum, depolama, WRITE_SETTINGS istenmez.
- Play politikası, en az yetki (4. tur): arama flaşı READ_PHONE_STATE / READ_CALL_LOG / READ_CONTACTS /
  ANSWER_PHONE_CALLS / CAMERA **istemez** (gelen arama sistem bildiriminden anlaşılır, fener
  setTorchMode ile); estetik ana ekran QUERY_ALL_PACKAGES istemez (LAUNCHER `<queries>`); erişilebilirlik
  hizmeti ve ön plan hizmeti yoktur. Ayrıntı ve gerekçeler: kisisel-motoru README "Play politikası".
  Play Console beyanı: Veri güvenliği formunda "uygulama etkinliği / diğer" altında bildirim verisi cihazda
  işlenir, toplanmaz/paylaşılmaz. İzin beyan formu gerektiren kısıtlı izin kullanılmaz.
- iOS'ta kenar ışıklandırma, ada, arama flaşı ve şarj ekranı uygulamalara kapalıdır: uygulama içi önizleme
  ve dürüst açıklama (iOS "Uyarılar için LED Flaşı", sistem AOD ayarı, Kestirmeler ile ana ekran simgesi).

| Araç | Depo |
|---|---|
| Canlı Duvar Kağıdı | [uyg-canli-duvar-kagidi](https://github.com/taktemurr-ops/uyg-canli-duvar-kagidi) |
| Widget Paketi | [uyg-widget-paketi](https://github.com/taktemurr-ops/uyg-widget-paketi) |
| Özgün İkon Paketi | [uyg-ozgun-ikon-paketi](https://github.com/taktemurr-ops/uyg-ozgun-ikon-paketi) |
| Bildirim ve Zil Sesi Paketi | [uyg-bildirim-ve-zil-sesi-paketi](https://github.com/taktemurr-ops/uyg-bildirim-ve-zil-sesi-paketi) |
| Şarj Saati (Ekran Koruyucu) | [uyg-kilit-ekrani-saati](https://github.com/taktemurr-ops/uyg-kilit-ekrani-saati) |
| Tema ve Renk Paleti Üretici | [uyg-renk-paleti-uretici](https://github.com/taktemurr-ops/uyg-renk-paleti-uretici) |
| Şık Yazı ve Sembol Üretici | [uyg-sik-yazi-uretici](https://github.com/taktemurr-ops/uyg-sik-yazi-uretici) |
| Kenar Işıklandırma | [uyg-kenar-isiklandirma](https://github.com/taktemurr-ops/uyg-kenar-isiklandirma) |
| Şarj Animasyonu | [uyg-sarj-animasyonu](https://github.com/taktemurr-ops/uyg-sarj-animasyonu) |
| Dinamik Bildirim Adası | [uyg-dinamik-ada](https://github.com/taktemurr-ops/uyg-dinamik-ada) |
| Her Zaman Açık Ekran | [uyg-her-zaman-acik-ekran](https://github.com/taktemurr-ops/uyg-her-zaman-acik-ekran) |
| Gelen Aramada Flaş | [uyg-arama-flasi](https://github.com/taktemurr-ops/uyg-arama-flasi) |
| Estetik Ana Ekran | [uyg-estetik-ana-ekran](https://github.com/taktemurr-ops/uyg-estetik-ana-ekran) |

NB. =====================================================
NB. MONTE CARLO ALGORITMASI
NB. Algoritma Final Degerlendirme Odevi
NB. =====================================================
NB. Ogrenci No : 1240505010
NB. Yaklasim   : Monte Carlo (son iki hane 10, cift)
NB. Veri Boyutu: n = 10^5 (son rakam 0 < 5)
NB. Kosul      : mod 7 = 0
NB. Seed       : 1240505010
NB. =====================================================

cocurrent 'base'

NB. =====================================================
NB. 1. PARAMETRELER
NB. =====================================================

SEED    =: 1240505010
N       =: 100000
TEKRAR  =: 100
EPSILON =: 0.01
K_LIST  =: 100 500 1000 5000 10000 50000

NB. =====================================================
NB. 2. YARDIMCI FONKSIYONLAR
NB. =====================================================

NB. Ortalama
ort =: +/ % #

NB. Standart sapma (orneklem, n-1 ile bolme)
stddev =: 3 : 0
  mu =. ort y
  %: (+/ *: y - mu) % ((# y) - 1)
)

NB. Sabit genislikte sayi formatlama
fmt =: 4 : 0
  w =. x
  s =. ": y
  w {. s
)

NB. =====================================================
NB. 3. SEED AYARI VE VERI URETIMI
NB. =====================================================

smoutput ''
smoutput '============================================================'
smoutput '  MONTE CARLO ALGORITMASI'
smoutput '  Algoritma Final Degerlendirme Odevi'
smoutput '============================================================'
smoutput '  Ogrenci No : 1240505010'
smoutput '  Seed       : 1240505010'
smoutput '  n          : 100000'
smoutput '  Kosul      : mod 7 = 0'
smoutput '  Tekrar     : 100'
smoutput '  Epsilon    : 0.01'
smoutput '============================================================'
smoutput ''

9!:1 SEED

NB. 0 ile 999999 arasi rastgele tam sayi dizisi
DIZI =: ? N $ 1000000

NB. =====================================================
NB. 4. GERCEK DEGER (GROUND TRUTH)
NB. =====================================================

GERCEK_SAYI =: +/ 0 = 7 | DIZI
GERCEK_ORAN =: GERCEK_SAYI % N

smoutput '--- GERCEK DEGERLER ---'
smoutput 'mod 7=0 eleman sayisi : ', ": GERCEK_SAYI
smoutput 'Gercek oran (p)       : ', ": GERCEK_ORAN
smoutput 'Teorik oran (1/7)     : ', ": 1 % 7
smoutput ''

NB. =====================================================
NB. 5. MONTE CARLO FONKSIYONU
NB. =====================================================

NB. k elemanli rastgele orneklem ile oran tahmini
monte_carlo =: 3 : 0
  k =. y
  idx =. ? k $ N
  secilen =. DIZI {~ idx
  (+/ 0 = 7 | secilen) % k
)

NB. =====================================================
NB. 6. TEK BIR K DEGERI ICIN 100 CALISTIRMA ANALIZI
NB. =====================================================

analiz_k =: 3 : 0
  k =. y
  smoutput 'Analiz basliyor: k = ', ": k

  tahminler =. 0 $ 0
  sureler   =. 0 $ 0

  for_i. i. TEKRAR do.
    t0 =. 6!:1 ''
    tahmin =. monte_carlo k
    t1 =. 6!:1 ''
    tahminler =. tahminler , tahmin
    sureler   =. sureler , t1 - t0
  end.

  NB. --- Hata Analizi ---
  hatalar      =. | tahminler - GERCEK_ORAN
  ort_hata     =. ort hatalar
  std_hata     =. stddev hatalar
  max_hata     =. >. / hatalar
  min_hata     =. <. / hatalar

  NB. Deneysel P(error): hata > epsilon olan calistirma orani
  deneysel_pe  =. (+/ hatalar > EPSILON) % TEKRAR

  NB. --- Teorik P(error) ---
  p =. GERCEK_ORAN

  NB. Chebyshev: P(|p_hat - p| > e) <= p(1-p) / (k * e^2)
  chebyshev    =. 1 <. (p * 1 - p) % k * EPSILON ^ 2

  NB. Hoeffding: P(|p_hat - p| > e) <= 2 * exp(-2*k*e^2)
  hoeffding    =. 2 * ^ - 2 * k * EPSILON ^ 2

  NB. --- Zaman Analizi ---
  ort_sure     =. ort sureler
  std_sure     =. stddev sureler

  NB. --- Cikti ---
  smoutput '+-----------------------------------------------+'
  smoutput '|  k = ', (8 fmt k), '                                |'
  smoutput '+-----------------------------------------------+'
  smoutput '|  Ort. Hata          : ', (12 fmt ort_hata), '         |'
  smoutput '|  Std. Sapma (hata)  : ', (12 fmt std_hata), '         |'
  smoutput '|  Max Hata           : ', (12 fmt max_hata), '         |'
  smoutput '|  Min Hata           : ', (12 fmt min_hata), '         |'
  smoutput '|  Deneysel P(error)  : ', (12 fmt deneysel_pe), '         |'
  smoutput '|  Teorik P(err) Cheb : ', (12 fmt chebyshev), '         |'
  smoutput '|  Teorik P(err) Hoef : ', (12 fmt hoeffding), '         |'
  smoutput '|  Ort. Sure (sn)     : ', (12 fmt ort_sure), '         |'
  smoutput '|  Std. Sapma (sure)  : ', (12 fmt std_sure), '         |'
  smoutput '+-----------------------------------------------+'
  smoutput ''

  k , ort_hata , std_hata , deneysel_pe , chebyshev , hoeffding , ort_sure , std_sure
)

NB. =====================================================
NB. 7. BRUTE FORCE ZAMANLAMA (karsilastirma icin)
NB. =====================================================

brute_force =: 3 : 0
  (+/ 0 = 7 | DIZI) % N
)

main =: 3 : 0
  smoutput '--- BRUTE FORCE ZAMANLAMA ---'
  bf_sureler =: 0 $ 0
  for_i. i. TEKRAR do.
    t0 =. 6!:1 ''
    brute_force ''
    t1 =. 6!:1 ''
    bf_sureler =: bf_sureler , t1 - t0
  end.
  smoutput 'Brute Force Ort. Sure : ', ": ort bf_sureler
  smoutput 'Brute Force Std. Sure : ', ": stddev bf_sureler
  smoutput ''

  NB. =====================================================
  NB. 8. TUM K DEGERLERI ICIN ANALIZ
  NB. =====================================================

  smoutput '--- MONTE CARLO ANALIZI BASLIYOR ---'
  smoutput '(Her k degeri icin 100 calistirma)'
  smoutput ''

  SONUCLAR =: 0 8 $ 0
  for_k. K_LIST do.
    r =. analiz_k k
    SONUCLAR =: SONUCLAR , 1 8 $ r
  end.

  NB. =====================================================
  NB. 9. OZET TABLO
  NB. =====================================================

  smoutput '============================================================'
  smoutput '                    OZET SONUC TABLOSU'
  smoutput '============================================================'
  smoutput ''
  baslik =. '     k   | Ort.Hata | Std.Hata | Den.P(e) | Cheby.   | Hoeff.   | OrtSure  | StdSure'
  smoutput baslik
  smoutput '---------|----------|----------|----------|----------|----------|----------|--------'

  for_i. i. # K_LIST do.
    satir =. i { SONUCLAR
    s =. ''
    s =. s , (8 fmt 0 { satir) , ' | '
    s =. s , (8 fmt 1 { satir) , ' | '
    s =. s , (8 fmt 2 { satir) , ' | '
    s =. s , (8 fmt 3 { satir) , ' | '
    s =. s , (8 fmt 4 { satir) , ' | '
    s =. s , (8 fmt 5 { satir) , ' | '
    s =. s , (8 fmt 6 { satir) , ' | '
    s =. s , (8 fmt 7 { satir)
    smoutput s
  end.

  smoutput ''
  smoutput '============================================================'
  smoutput '  Epsilon = ', ": EPSILON
  smoutput '  Gercek oran p = ', ": GERCEK_ORAN
  smoutput '  Teorik oran 1/7 = ', ": 1 % 7
  smoutput '  Brute Force Ort. Sure = ', ": ort bf_sureler
  smoutput '============================================================'
  smoutput ''
  smoutput '--- YORUM ---'
  smoutput 'k arttikca:'
  smoutput '  - Ort. hata azalir (daha iyi tahmin)'
  smoutput '  - Deneysel P(error) azalir'
  smoutput '  - Teorik sinirlar ile uyumlu sonuclar elde edilir'
  smoutput '  - Sure artar ama brute force''a gore hala hizlidir'
  smoutput ''
  smoutput 'Rastgeleliğin etkisi:'
  smoutput '  - Kucuk k: yuksek std sapma (hem hata hem sure)'
  smoutput '  - Buyuk k: dusuk std sapma (daha kararli sonuclar)'
  smoutput ''
  smoutput '--- ANALIZ TAMAMLANDI ---'
)

main ''

exit ''

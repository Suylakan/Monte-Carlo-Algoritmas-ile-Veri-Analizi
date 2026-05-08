<div align="center">
  <h1>🎯 Monte Carlo Algoritması ile Veri Analizi</h1>
  <p>
    <b>Büyük Veri Setlerinde Rastgeleliğin Algoritmik Verimliliğe Etkisi</b>
  </p>
  <p>
    <i>Algoritma Dersi Final Değerlendirme Ödevi</i>
  </p>

  <!-- Badges -->
  <img src="https://img.shields.io/badge/Language-J_(jsoftware)-blue.svg?style=flat-square" alt="Language">
  <img src="https://img.shields.io/badge/Algorithm-Monte_Carlo-orange.svg?style=flat-square" alt="Algorithm">
  <img src="https://img.shields.io/badge/Status-Completed-success.svg?style=flat-square" alt="Status">
</div>

---

## 📌 Proje Hakkında

Bu proje, devasa büyüklükteki veri setlerinde aranan belirli bir özelliğin (örneğin belirli bir sayıya tam bölünebilme) tüm veriyi taramadan, **örneklem (sampling)** mantığıyla çok daha hızlı bir şekilde tespit edilmesini amaçlayan **Monte Carlo** randomize algoritmasını içermektedir.

Geleneksel Brute Force (Kaba Kuvvet) yöntemleri **O(n)** zaman karmaşıklığı ile kesin sonuç verirken, bu projede incelenen Monte Carlo yöntemi **O(k)** zaman karmaşıklığı ile çalışır ve hız için kesinlikten (%100 doğruluktan) istatistiksel bir sapma payıyla ödün verir.

### 📋 Öğrenci ve Ödev Parametreleri

| Parametre | Değer | Kriter (Öğrenci Numarasına Göre) |
| :--- | :--- | :--- |
| **Geliştirici** | Harun Berke Öztürk | - |
| **Öğrenci No** | `1240505010` | - |
| **Algoritma** | Monte Carlo | Son iki hane (`10`) Çift |
| **Veri Boyutu** | $n = 10^5$ (100.000) | Son rakam (`0`) < 5 |
| **Hedef Koşul** | `mod 7 = 0` | Belirli bir elemanın sayımı |
| **Seed** | `1240505010` | Öğrenci numarası |

---

## 🚀 Kurulum ve Çalıştırma

Proje **J programlama dilinde** geliştirilmiştir. Çalıştırmak için bilgisayarınızda J (jsoftware) yorumlayıcısı bulunmalıdır.

### 1. J Kurulumu
Eğer yüklü değilse [jsoftware.com](https://code.jsoftware.com/wiki/System/Installation) adresinden J9.7 veya güncel bir sürümünü indirin.

### 2. Depoyu Klonlama
```bash
git clone https://github.com/KULLANICI_ADINIZ/monte-carlo-algorithm.git
cd monte-carlo-algorithm
```

### 3. Kodu Çalıştırma (Windows PowerShell örneği)
```powershell
& "C:\Program Files\J9.7\bin\jconsole.exe" "monte_carlo.ijs"
```
> **Not:** `jconsole.exe` yolu sisteminizdeki J kurulum dizinine göre değişiklik gösterebilir.

---

## 📂 Dosya Yapısı

```bash
📦 monte-carlo-algorithm
 ┣ 📜 monte_carlo.ijs     # Ana simülasyon kodu (J dilinde)
 ┣ 📜 teorik_analiz.md    # Matematiksel P(error) analizleri
 ┣ 📜 sunum_taslagi.md    # Slayt oluşturucular için sunum taslağı
 ┗ 📜 README.md           # Proje dokümantasyonu
```

---

## 📊 Özet Bulgular

Algoritma $k$ (örneklem boyutu) değerleri için 100'er kez koşturularak deneysel analizler yapılmış ve Chebyshev/Hoeffding gibi matematiksel sınırlarla kıyaslanmıştır:

1. **Hız Kazanımı (Speedup):** Brute force algoritma tüm diziyi işlerken, Monte Carlo ($k=5000$) modeli yaklaşık **20 kat** daha hızlı çalışarak devasa bir zaman tasarrufu sağlamıştır.
2. **Hata Olasılığı ($P(error)$):** Deneysel hata oranları, teorik formüllerin sunduğu üst sınırların her zaman çok altında kalmış ve başarılı bir şekilde $1/7$ ($\approx 0.1428$) gerçek oranına yakınsamıştır.
3. **Standart Sapma ve Stabilite:** Örneklem boyutu ($k$) arttıkça, Büyük Sayılar Yasası (Law of Large Numbers) gereği hata payındaki standart sapma minimize olmuş ve sonuçlar stabil hale gelmiştir.

---

<div align="center">
  <i>Bu proje algoritma dersi final değerlendirmesi kapsamında hazırlanmıştır.</i>
</div>

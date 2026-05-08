# Monte Carlo Algoritması — Teorik Analiz

**Öğrenci No:** 1240505010  
**Yaklaşım:** Monte Carlo (son iki hane 10, çift)  
**Veri Boyutu:** n = 10⁵ (son rakam 0 < 5)  
**Koşul:** mod 7 = 0  
**Seed:** 1240505010  

---

## 1. Problem Tanımı

Rastgele üretilmiş `n = 100.000` elemanlı bir tam sayı dizisinde, **7'ye tam bölünen** (mod 7 ≡ 0) elemanların oranını bulmak istiyoruz.

### Brute Force Yaklaşım
Tüm `n` elemanı tek tek kontrol etmek → **O(n)** zaman karmaşıklığı.

### Monte Carlo Yaklaşımı
Diziden rastgele `k` eleman seçip (k << n), bu örneklemden genel oranı **tahmin etmek** → **O(k)** zaman karmaşıklığı.

**Trade-off:** Hızdan kazanıyoruz ama %100 doğruluktan vazgeçiyoruz.

---

## 2. Matematiksel Model

### 2.1. Rastgele Değişken Tanımı

Dizideki her eleman `[0, 999999]` aralığında uniform rastgele bir tam sayıdır.

Bir elemanın mod 7 ≡ 0 olma olasılığı:
- `[0, 999999]` aralığında 7'ye bölünen sayılar: 0, 7, 14, ..., 999999
- Sayısı: `⌊999999/7⌋ + 1 = 142857 + 1 = 142858`
- Teorik olasılık: `p = 142858 / 1000000 = 0.142858`
- Bu değer `1/7 ≈ 0.142857`'ye çok yakındır.

### 2.2. Monte Carlo Tahmincisi

`k` adet rastgele indeks seçelim: `i₁, i₂, ..., iₖ` (uniform, bağımsız)

Her bir seçim için Bernoulli rastgele değişkeni:

```
Xⱼ = 1,  eğer DIZI[iⱼ] mod 7 = 0
Xⱼ = 0,  aksi halde
```

Monte Carlo tahmincisi:

```
p̂ = (1/k) · Σⱼ Xⱼ
```

**Beklenen değer:** `E[p̂] = p` → **Yansız (unbiased) tahminci**

**Varyans:** `Var(p̂) = p(1-p) / k`

**Standart sapma:** `σ(p̂) = √(p(1-p) / k)`

---

## 3. P(error) — Hata Olasılığı Hesabı

Hata tanımı: Tahminimizin gerçek değerden `ε` kadar sapması.

```
P(error) = P(|p̂ - p| > ε)
```

Ödevde `ε = 0.01` alıyoruz.

### 3.1. Chebyshev Eşitsizliği

```
P(|p̂ - p| > ε) ≤ Var(p̂) / ε²
                 = p(1-p) / (k · ε²)
```

`p ≈ 1/7` için: `p(1-p) = (1/7)(6/7) = 6/49 ≈ 0.12245`

| k | Chebyshev Üst Sınırı |
|---|---------------------|
| 100 | 0.12245 / (100 × 0.0001) = **12.245** → min(1, 12.245) = **1.0000** |
| 500 | 0.12245 / (500 × 0.0001) = **2.4490** → min(1, 2.449) = **1.0000** |
| 1000 | 0.12245 / (1000 × 0.0001) = **1.2245** → min(1, 1.2245) = **1.0000** |
| 5000 | 0.12245 / (5000 × 0.0001) = **0.2449** |
| 10000 | 0.12245 / (10000 × 0.0001) = **0.1225** |
| 50000 | 0.12245 / (50000 × 0.0001) = **0.0245** |

> **Not:** Chebyshev eşitsizliği gevşek bir üst sınırdır. Küçük k değerlerinde 1'i aşabilir, bu durumda P(error) ≤ 1 olarak alınır.

### 3.2. Hoeffding Eşitsizliği (Daha Sıkı Sınır)

Bağımsız, [0,1] aralığında sınırlı rastgele değişkenler için:

```
P(|p̂ - p| > ε) ≤ 2 · exp(-2kε²)
```

| k | Hoeffding Üst Sınırı |
|---|---------------------|
| 100 | 2 · exp(-2 × 100 × 0.0001) = 2 · exp(-0.02) = **1.9604** → 1.0 |
| 500 | 2 · exp(-2 × 500 × 0.0001) = 2 · exp(-0.1) = **1.8097** → 1.0 |
| 1000 | 2 · exp(-2 × 1000 × 0.0001) = 2 · exp(-0.2) = **1.6375** → 1.0 |
| 5000 | 2 · exp(-2 × 5000 × 0.0001) = 2 · exp(-1.0) = **0.7358** |
| 10000 | 2 · exp(-2 × 10000 × 0.0001) = 2 · exp(-2.0) = **0.2707** |
| 50000 | 2 · exp(-2 × 50000 × 0.0001) = 2 · exp(-10.0) = **0.0000908** |

### 3.3. Normal Yaklaşım (Merkezi Limit Teoremi)

Büyük k için, `p̂ ~ N(p, p(1-p)/k)` yaklaşımı geçerlidir:

```
P(|p̂ - p| > ε) ≈ 2 · Φ(-ε / √(p(1-p)/k))
                = 2 · Φ(-ε · √(k / (p(1-p))))
```

Burada `Φ` standart normal CDF'dir.

| k | z = ε√(k/p(1-p)) | P(error) ≈ 2Φ(-z) |
|---|-------------------|-------------------|
| 100 | 0.01 × √(100/0.12245) = 0.2857 | ≈ 0.7751 |
| 500 | 0.01 × √(500/0.12245) = 0.6389 | ≈ 0.5229 |
| 1000 | 0.01 × √(1000/0.12245) = 0.9035 | ≈ 0.3663 |
| 5000 | 0.01 × √(5000/0.12245) = 2.0203 | ≈ 0.0434 |
| 10000 | 0.01 × √(10000/0.12245) = 2.8571 | ≈ 0.0043 |
| 50000 | 0.01 × √(50000/0.12245) = 6.3888 | ≈ 0.0000002 |

---

## 4. Deneysel Sonuçlar ile Karşılaştırma

> Bu bölüm, `monte_carlo.ijs` dosyası çalıştırıldıktan sonra elde edilen sonuçlarla doldurulacaktır.

### 4.1. Sonuç Tablosu

| k | Ort. Hata | Std. Hata | Den. P(err) | Cheby. | Hoeff. | CLT | Ort. Süre | Std. Süre |
|---|-----------|-----------|-------------|--------|--------|-----|-----------|-----------|
| 100 | 0.028176 | 0.020258 | 0.79 | 1.0 | 1.0 | 0.775 | ~0.00000 | ~0.00000 |
| 500 | 0.013374 | 0.009739 | 0.56 | 1.0 | 1.0 | 0.523 | 0.00001 | 0.00010 |
| 1000 | 0.007921 | 0.005304 | 0.31 | 1.0 | 1.0 | 0.366 | 0.00001 | 0.00010 |
| 5000 | 0.004562 | 0.003660 | 0.08 | 0.245 | 0.736 | 0.043 | 0.00005 | 0.00022 |
| 10000 | 0.002691 | 0.001960 | 0.01 | 0.123 | 0.271 | 0.004 | 0.00016 | 0.00037 |
| 50000 | 0.001358 | 0.001068 | 0 | 0.025 | 0.00009 | ~0 | 0.00090 | 0.00036 |

### 4.2. Beklenen Gözlemler

1. **k arttıkça ortalama hata azalmalıdır** — Daha fazla örneklem, daha iyi tahmin.
2. **Deneysel P(error), teorik üst sınırların altında kalmalıdır** — Chebyshev ve Hoeffding birer üst sınırdır.
3. **CLT yaklaşımı, deneysel sonuçlara en yakın tahmini vermelidir.**
4. **k arttıkça süre artmalı ama brute force'tan çok daha kısa kalmalıdır.**

---

## 5. Zaman Karmaşıklığı Analizi

### 5.1. Teorik Karmaşıklık

| Yöntem | Zaman Karmaşıklığı | n=100000 için |
|--------|-------------------|---------------|
| Brute Force | O(n) | 100.000 işlem |
| Monte Carlo (k=100) | O(k) | 100 işlem |
| Monte Carlo (k=1000) | O(k) | 1.000 işlem |
| Monte Carlo (k=10000) | O(k) | 10.000 işlem |

**Hızlanma Oranı (Speedup):** `n / k`

| k | Speedup |
|---|---------|
| 100 | 1000× |
| 500 | 200× |
| 1000 | 100× |
| 5000 | 20× |
| 10000 | 10× |
| 50000 | 2× |

### 5.2. Rastgeleliğin Çalışma Süresine Etkisi

Monte Carlo algoritmasının çalışma süresi, her çalıştırmada **aynı k** adet örneklem seçtiği için **deterministik bir zaman karmaşıklığına** sahiptir: O(k).

Ancak pratikteki süre farklılıkları şunlardan kaynaklanır:
- **Cache etkileri:** Rastgele erişim deseni, CPU cache performansını etkiler
- **Bellek erişim sırası:** Rastgele indeksler, sıralı erişime kıyasla daha yavaştır
- **İşletim sistemi gürültüsü:** Bağlam değişimleri, arka plan süreçleri

**Beklenti:** Zaman standart sapması, k büyüdükçe **göreceli olarak küçülür** (std/ort oranı azalır), çünkü büyük k'larda ortalamaya yakınsama (law of large numbers) zamanlama ölçümlerini de stabilize eder.

---

## 6. Sonuç

Monte Carlo yöntemi, büyük veri setlerinde doğruluktan kontrollü bir şekilde ödün vererek **önemli hız kazanımı** sağlar.

**Temel bulgular:**
1. **Doğruluk-hız dengesi:** k arttıkça doğruluk artar, hız azalır.
2. **P(error) teorik sınırları:** Chebyshev (gevşek), Hoeffding (orta), CLT (sıkı) sırasıyla giderek daha kesin tahminler sunar.
3. **Pratik kullanım:** k = 5000 gibi orta bir değer bile, %95'in üzerinde güvenilirlik sağlarken 20× hız kazancı sunar.
4. **Rastgelelik ve zaman:** Çalışma süresi Monte Carlo'da neredeyse sabit (O(k)), ancak cache erişim desenleri nedeniyle küçük bir varyans gözlenir.

---

## Referanslar

- Motwani, R., Raghavan, P. (1995). *Randomized Algorithms*. Cambridge University Press.
- Hoeffding, W. (1963). "Probability inequalities for sums of bounded random variables." *JASA*, 58(301), 13–30.
- Mitzenmacher, M., Upfal, E. (2005). *Probability and Computing*. Cambridge University Press.

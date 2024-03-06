- MVVM mimarisi kullanıldı.

- UI katmanı için AutoLayout kullanıldı. Proje genelinde sabit width height kullanımından kaçınıldı.

- Network iletişimi içi Alamofire kullanıldı. Object mapping için codable kullanıldı.

- Film listeleme sayfasında 100 item gösterilecek şekilde ayarlandı. Sayfa ilk açıldığında ilk servisten gelen 20 item gösterilmektedir. Scroll ile 20 itemın sonuna gelindiğinde tekrar istek atılıp bir sonraki servisten 20 item eklenerek devam etmektedir. Bu şeilde 100 item olana kadar sayfa scroll oldukça servis isteği atılmaktadır.

- Her bir film için filmin resmi, başlığı, tarihi ve 10 üzerinden puanı gösterilmektedir. Filmin puanına göre puan yazısı ve ikonu rengi değişiklik göstermektedir.

- Film listeleme sayfasından bir filme tıklandığında filmin detay sayfası açılmaktadır. Bu sayfanın ortasında filmin adı yazmaktadır. Bunun için filmin id' si ile  detay servisi çağırılmaktadır. Servise gidip gelme süresince loading gösterilmektedir.

- Servisten gelen veriler cache kaydedilmekte ve internetin olmadığı durumlarda önceden yüklenmiş olan veriler gösterilebilmektedir. 

- Ayrı bir UI componenti olarak tasarlanan Add butonuna tıklandığında sayfasının ortasında tıklandığı bilgisini gösteren bir alert açılmaktadır.

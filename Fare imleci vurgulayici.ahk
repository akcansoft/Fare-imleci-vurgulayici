; Fare imleci vurgulayıcı (Mouse cursor highlighter)
; v2.0
; 11/11/2025
; ---------------------------
; Mesut Akcan
; makcan@gmail.com
; mesutakcan.blogspot.com
; github.com/mesutakcan
; youtube.com/mesutakcan
;----------------------------
; Neler yeni:
; - Çoklu monitör desteği eklendi
; - DPI farkındalığı eklendi
;----------------------------

#Requires AutoHotkey v2.0
#SingleInstance Force

; DPI farkındalığını ayarla
DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr")

SetTimer(PencereTasi, 30) ; Pencere taşıma fonksiyonunu başlat
CoordMode("Mouse", "Screen") ; Fare koordinatlarını ekran referansına ayarla

; ------ Ayarlar ----------
cap := 52 ; Vurgulayıcı çapı
seffaflik := 130 ; Şeffaflık değeri
zeminRengi := "yellow" ; Zemin rengi
solTusRengi := "red" ; Sol tuş rengi
ortaTusRengi := "00f7ff" ; Orta tuş rengi
sagTusRengi := "00ff00" ; Sağ tuş rengi
;--------------------------
r := cap // 2 ; Vurgu yarıçap değeri

; GUI oluştur
g := Gui("+E0x20 -Caption +ToolWindow +AlwaysOnTop +Owner -DPIScale") ; DPI ölçeklemesini devre dışı bırak
g.MarginX := 0 ; Sol kenar boşluğu
g.MarginY := 0 ; Üst kenar boşluğu
g.BackColor := zeminRengi ; Zemin rengini ayarla
g.Show("NA w" cap " h" cap) ; Pencereyi gösterme, boyut ayarla

; Daire şeklinde bölge oluştur
WinSetRegion("E 0-0 w" cap " h" cap, g.Hwnd) ; Daire şeklinde pencere bölgesi oluştur
WinSetTransparent(seffaflik, g.Hwnd) ; Pencereyi şeffaf yap

; Pencere taşı
PencereTasi() {
	MouseGetPos &x, &y ; Fare konumunu al
	g.Move(x - r, y - r) ; Pencereyi fare konumunun yarıçap kadar sol üstüne taşı
}

; Fare tuş olayları
~LButton:: g.BackColor := solTusRengi ; Sol tuş rengi
~MButton:: g.BackColor := ortaTusRengi ; Orta tuş rengi
~RButton:: g.BackColor := sagTusRengi ; Sağ tuş rengi

~LButton Up:: ; Sol tuş bırakıldığında
~MButton Up:: ; Orta tuş bırakıldığında
~RButton Up:: ; Sağ tuş bırakıldığında
{
	g.BackColor := zeminRengi ; Zemin rengini geri yükle
}

; Pencere gizle/göster
^+F12:: {
	static p := true
	p := !p ; Durumu tersine çevir
	if p { 
		g.Show("NA") ; Pencereyi göster ama odaklama
		WinSetTransparent(seffaflik, g.Hwnd)
	} else { 
		g.Hide() ; Pencereyi gizle
	}
}

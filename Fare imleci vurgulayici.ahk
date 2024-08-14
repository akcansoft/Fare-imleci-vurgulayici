; Fare imleci vurgulayıcı
; Mouse cursor highlighter
; ------------------------
; Mesut Akcan
; 13/08/2024
; Mesut Akcan
; makcan@gmail.com
; akcansoft.blogspot.com
; mesutakcan.blogspot.com
; github.com/akcansoft
; youtube.com/mesutakcan

#Requires AutoHotkey v2.0
#SingleInstance Force ; tek örnek çalışsın

SetTimer(PencereTasi, 30) ; pencere taşı fonksiyonunu çalıştır
CoordMode("Mouse", "Screen") ; Koordinat modu fare, referans ekran

cap := 52 ; vurgulayıcı çapı
seffaflik := 125
zeminRengi := "yellow" ; zemin rengi
solTusRengi := "red" ; sol tuş rengi
ortaTusRengi := "00f7ff" ; orta tuş rengi
sagTusRengi := "00ff00" ; sağ tuş rengi
r := cap // 2 ; daire yarıçapı
g := Gui("+E0x20 -Caption +ToolWindow +AlwaysOnTop") ; pencere
g.BackColor := zeminRengi ; pencere zemin rengi
g.Show("w" cap "h" cap) ; pencereyi çap boyutunda göster
PencereTasi() ;pencereyi taşı
WinSetRegion("E 0-0 w" cap " h" cap, g.Hwnd) ; pencere sınırları daire
WinSetTransparent(seffaflik, g.Hwnd) ; pencereyi şeffaf yap

; Pencere taşıma fonksiyonu
PencereTasi() {
  MouseGetPos &x, &y ; fare konumunu al
  g.Move(x - r, y - r) ; pencereyi fare konumunun r piksel sol-üstüne taşı
}

;Esc::ExitApp() ; ESC tuşuyla programı kapat

;fare tuşları basıldığında zemin rengini değiştir
~LButton:: g.BackColor := solTusRengi ; fare sol tuşu basıldığında
~MButton:: g.BackColor := ortaTusRengi ; fare orta tuşu basıldığında
~RButton:: g.BackColor := sagTusRengi ; fare sağ tuşu basıldığında

;fare tuşları bırakıldığında zemin rengini değiştir
~LButton Up:: ; sol tuş bırakıldığında
~MButton Up:: ; orta tuş bırakıldığında
~RButton Up:: ; sağ tuş bırakıldığında
{
  g.BackColor := zeminRengi ; zemin rengini değiştir
}

; pencere gizle/göster
^+F12:: ; Ctrl+Shift+F12
{
  static p := true
  p := !p ; tersini al
  if p ; p true ise
    g.Show ; pencereyi göster
  else ; değilse
    g.Hide ; pencereyi gizle
}

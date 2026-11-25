#!/usr/bin/env python3
"""Kişiselleştirme merkezinin özgün simge, açılış ve mağaza görselleri (Pillow).
Üçüncü taraf görsel kullanılmaz.  pip install pillow && python tool/generate_assets.py"""
import os
from PIL import Image, ImageDraw

BG_TOP, BG_BOTTOM, ACCENT, LIGHT = (42, 27, 74), (13, 8, 25), (183, 148, 244), (250, 245, 255)


def gradient(w, h):
    im = Image.new("RGB", (w, h))
    d = ImageDraw.Draw(im)
    for y in range(h):
        t = y / max(1, h - 1)
        d.line([(0, y), (w, y)], fill=tuple(int(BG_TOP[i] * (1 - t) + BG_BOTTOM[i] * t) for i in range(3)))
    return im


def glyph(d, cx, cy, s, color=ACCENT):
    """Telefon çerçevesi içinde dört renkli kutucuk ve bir yıldız: özgün, sade çizim."""
    w = max(2, int(s // 16))
    d.rounded_rectangle([cx - s * 0.3, cy - s * 0.46, cx + s * 0.3, cy + s * 0.46], radius=s * 0.1, outline=LIGHT, width=w)
    cols = [color, (129, 230, 217), (251, 211, 141), (246, 135, 179)]
    k = 0
    for row in range(2):
        for col in range(2):
            x0 = cx - s * 0.2 + col * s * 0.22
            y0 = cy - s * 0.3 + row * s * 0.22
            d.rounded_rectangle([x0, y0, x0 + s * 0.17, y0 + s * 0.17], radius=s * 0.05, fill=cols[k])
            k += 1
    r = s * 0.08
    d.polygon([(cx, cy + s * 0.18 - r * 1.6), (cx + r, cy + s * 0.18), (cx, cy + s * 0.18 + r * 1.6), (cx - r, cy + s * 0.18)], fill=LIGHT)


def icon(size=1024):
    im = gradient(size, size)
    glyph(ImageDraw.Draw(im), size / 2, size / 2, size * 0.66)
    return im


def main():
    os.makedirs("assets/branding", exist_ok=True)
    os.makedirs("store", exist_ok=True)
    ic = icon()
    ic.save("assets/branding/icon.png")
    fg = Image.new("RGBA", (1024, 1024), (0, 0, 0, 0))
    glyph(ImageDraw.Draw(fg), 512, 512, 440)
    fg.save("assets/branding/icon_foreground.png")
    sp = Image.new("RGBA", (768, 768), (0, 0, 0, 0))
    glyph(ImageDraw.Draw(sp), 384, 384, 320)
    sp.save("assets/branding/splash.png")
    a12 = Image.new("RGBA", (1152, 1152), (0, 0, 0, 0))
    glyph(ImageDraw.Draw(a12), 576, 576, 400)
    a12.save("assets/branding/splash_android12.png")
    ic.resize((512, 512)).save("store/icon_512.png")
    fe = gradient(1024, 500)
    glyph(ImageDraw.Draw(fe), 512, 250, 320)
    fe.save("store/feature_graphic.png")
    print("assets ok")


if __name__ == "__main__":
    main()

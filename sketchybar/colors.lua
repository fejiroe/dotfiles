return {
  black = 0xaa000000,
  white = 0xaae2e2e3,
  FF = 0xbceeeeee,
  red = 0xddec3e6d,
  green = 0xccbfffab,
  blue = 0xdd36bcdf,
  yellow = 0xbce7c864,
  orange = 0xfff39660,
  magenta = 0xffb39df3,
  grey = 0xff7f8490,
  transparent = 0x00000000,

  bar = {
    bg = transparent,
    border = 0xff2c2e34,
  },
  popup = {
    bg = 0xc02c2e34,
    border = 0xff7f8490
  },
  bg1 = 0xff000000,
  bg2 = 0xff414550,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}

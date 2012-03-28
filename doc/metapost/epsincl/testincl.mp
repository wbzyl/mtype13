input epsincl;

tertiarydef p scaledto x = p scaled (x/xpart(urcorner(p)-llcorner(p))) enddef;

beginfig(100);
 label(use_eps("testinc0.eps") rotated 30 scaledto 100mm, origin);
 label(image(fill unitsquare scaled 2mm rotated 45), origin) withcolor .7white;
endfig;

end


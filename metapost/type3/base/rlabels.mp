%%%%
%%%%  This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \title{ROTATED LABELS}

if known included_rlabels: expandafter endinput
else: included_rlabels:=1.0;
fi

newinternal rotated_labels_debug; % the default value is 0
newinternal additional_rotation; % ditto 

color rotated_debug_color; rotated_debug_color:=red;
numeric rotated_debug_width; rotated_debug_width:=1;
pen rotated_debug_pen;
rotated_debug_pen:=pickup pencircle scaled rotated_debug_width;

vardef picture_width(expr p) = xpart(urcorner p - llcorner p) enddef;

vardef therlabel(expr s,z,a) = % position |s| near |z| at angle |a|
  save p, P, Q, rotation;
  picture p; pair P, Q; numeric rotation;
  if picture s: p=s
  else: p=s infont defaultfont scaled defaultscale
  fi;
  rotation=a+additional_rotation;
  P=z+(labeloffset*up+1/2picture_width(p)*left) rotated rotation;
  % debugging code
  if rotated_labels_debug>0:
    drawdot z withpen rotated_debug_pen withcolor rotated_debug_color;
  fi
  if rotated_labels_debug>1:
    Q=z+labeloffset*up rotated rotation;
    drawarrow z--Q withpen rotated_debug_pen withcolor rotated_debug_color;
    draw bbox p rotated rotation shifted P
      withpen rotated_debug_pen withcolor rotated_debug_color;
  fi  
  p rotated rotation shifted P
enddef;

def rlabel = drawproof therlabel enddef;

vardef thepathlabel(expr s,p,l) =
  % position |s| on path |p| at distance |l| from the begining of path
  save t; numeric t;
  t=arctime l of p;
  therlabel(s, point t of p, angle direction t of p)
enddef;

def pathlabel = draw thepathlabel enddef;

vardef string_to_path(expr s, p, c) = % draw string |s| along path |p| with color |c|
  save pic, pic_width, p_length, glyph_separation, pos, n;
  numeric pic_width, p_length, glyph_separation, pos, n; picture pic;
  pic:=s infont defaultfont scaled defaultscale;
  pic_width:=picture_width(pic);
  p_length=arclength p;
  if rotated_labels_debug>2:
    message "[[rotated_labels::p_length:" & decimal p_length & "]]";
  fi
  n=length(s);
  glyph_separation=(p_length-pic_width)/(n-1);
  pos:=0;
  for i:=1 upto n:
    pic:=substring(i-1,i) of s infont defaultfont scaled defaultscale;
    pic_width:=picture_width(pic);
    pathlabel(pic, p, pos+pic_width/2) withcolor c;
    pos:=pos+pic_width+glyph_separation;
  endfor
enddef;

%% Experimental: the `p' convention for paths.

vardef pathpiclabels(expr shift,scale)(text t) =
  if proofing>1:
    forsuffixes $=t: makepathpiclabel("p"&str$,p$,shift,scale); endfor
  fi
enddef;

vardef makepathpiclabel(expr s,p,shift,scale) =
  save p_; path p_; p_:=p shifted shift scaled scale;
  pathlabel(s,p_,(arclength p_)/2) withcolor labelcolor;
enddef;

%%\end

% 30-point (slim, left-skewed) METAFONT//METAPOST logo
input type1.mp;
pf_info_designsize 30pt#; % the "design size" of this font
ht#:=25pt#;		  % height of characters
xgap#:=1.5pt#;		  % horizontal adjustment
u#:=3/9pt#;		  % unit width
s#:=1/3pt#;		  % extra space at the left and the right
o#:=2/9pt#;		  % overshoot
px#:=1pt#;		  % horizontal thickness of pen
slant:=-1/9;

if unknown pf_info_set.WEIGHT: pf_info_weight "Normal"; fi
if unknown pf_info_set.FONT_NAME: pf_info_fontname "MFMPlogoxa30-Regular"; fi
if unknown pf_info_set.PFM_NAME: pf_info_pfm "MFMPlogoxa30", 0, 0; fi
don't_ignore_directions:=1;

input logo.mp             % now generate the font
endfont;                  % and stop.


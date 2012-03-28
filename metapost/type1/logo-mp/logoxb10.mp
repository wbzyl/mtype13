% 10-point (light, extended) METAFONT//METAPOST logo
input type1.mp;
pf_info_designsize 10pt#; % the "design size" of this font
ht#:=6pt#;		  % height of characters
xgap#:=2pt#;		  % horizontal adjustment
u#:=4/3pt#;		  % unit width
s#:=-2/3pt#;		  % extra space at the left and the right
o#:=1/9pt#;		  % overshoot
px#:=1/3pt#;		  % horizontal thickness of pen

if unknown pf_info_set.WEIGHT: pf_info_weight "Light"; fi
if unknown pf_info_set.FONT_NAME: pf_info_fontname "MFMPlogoxb10-Regular"; fi
if unknown pf_info_set.PFM_NAME: pf_info_pfm "MFMPlogoxb10", 0, 0; fi

input logo.mp             % now generate the font
endfont;                  % and stop.

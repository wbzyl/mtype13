% ---
input type1;
% ---
ht+dp=300; dp=90;
sw:=15; % stroke width
cs:=80; % corner size
min_wd:=200; inc_wd:=10; % minimal width and width increment
side_bar:=25; % side bar
fch=33; % first character code
lch=fch+174; % last character code (i.e., last character width=1990)
math_axis:=1/2[ht,-dp];
% ---
if unknown generating: introduce_selected _space, "frame100"; fi
% ---
pf_info_familyname "SoftFrames";
pf_info_weight "Normal";
pf_info_fontname "SoftFrames-Regular";
pf_info_version "0.01";
pf_info_capheight ht;
pf_info_xheight ht;
pf_info_space min_wd+2side_bar;
pf_info_adl ht, dp, 0;
pf_info_author "Made in BOP s.c.: no copyrights, copylefts, copyups, copydowns, etc.";
pf_info_creationdate;
% ---
vardef soft_rect(expr r,a,b,c,d) =
 clearxy;
 z0=a+r*unitvector(b-a); z1=b-r*unitvector(b-a);
 z2=b+r*unitvector(c-b); z3=c-r*unitvector(c-b);
 z4=c+r*unitvector(d-c); z5=d-r*unitvector(d-c);
 z6=d+r*unitvector(a-d); z7=a-r*unitvector(a-d);
 (z0--z1)..(z2--z3)..(z4--z5)..(z6--z7)..cycle
enddef;
% ---
beginfont
% ---
for ch:=fch upto lch:
 encode ("frame" & decimal(ch)) (ch);
 introduce "frame" & decimal(ch) (utilize) (0) ();
 beginglyph("frame" & decimal(ch))
  path P.a, P.b;
  wd:=min_wd+(ch-fch)*inc_wd;
  P.a=round_node_values(reverse soft_rect(cs-sw,
   (sw,-dp+sw),(wd-sw,-dp+sw),(wd-sw,ht-sw),(sw,ht-sw)));
  P.b=round_node_values(soft_rect(cs,(0,-dp),(wd,-dp),(wd,ht),(0,ht)));
  Fill P.b; unFill P.a; path_labels(P.a,P.b);
  fix_hstem(sw,P.a,P.b); fix_vstem(sw,P.a,P.b);
  fix_hsbw(wd,side_bar,side_bar);
 endglyph;
endfor
%
ch:=lch+1;
encode ("incwd") (ch); introduce "incwd" (utilize) (0) ();
beginglyph("incwd") fix_hsbw(inc_wd,0,0); endglyph;
%
ch:=ch+1;
encode ("penwd") (ch); introduce "penwd" (utilize) (0) ();
beginglyph("penwd") fix_hsbw(sw,0,0); endglyph;
%
ch:=ch+1;
encode ("sideb") (ch); introduce "sideb" (utilize) (0) ();
beginglyph("sideb") fix_hsbw(side_bar,0,0); endglyph;
% ---
endfont.
%% \--------------------------------------------------------------------
%% Construction of a typical frame:
%% \-
%% Konstrukcja typowej ramki:
%% %
%% \PICT{frame100}
%% \--------------------------------------------------------------------
% ---
%%\end


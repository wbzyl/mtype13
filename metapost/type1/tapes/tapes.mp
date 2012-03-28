% -----------------------------------------------------------------------
% A sample font containing several simple geometric glyphs
% -----------------------------------------------------------------------
input type1;
% ---
size:=1000;
band:=100;
depth:=0;
math_axis:=1/2size;
% ---
pf_info_familyname "Tapes";
pf_info_fontname "Tapes-Regular";
pf_info_weight "Normal";
pf_info_version "0.01";
pf_info_capheight size;
pf_info_xheight size;
pf_info_space band;
pf_info_adl size, 0, 0;
pf_info_author "Made by KrakoTeX2000 Group: "
 & "no copyrights, copylefts, copyups, copydowns, etc.";
pf_info_overshoots (1000,10), (0, -10);
pf_info_encoding "abcd";
pf_info_creationdate;
% ---
beginfont

%% \vfill\break
%% \--------------------------------------------------------------------
%% Construction of the character cross:
%% \-
%% Konstrukcja znaku krzy/zyk:
%% %
%% \PICT{a}
%% \--------------------------------------------------------------------
encode ("a") (ASCII "a"); introduce "a" (store+utilize) (0) ();
beginglyph("a");
 save pa, pb, r;
 path pa, pb;
 pa=unitsquare xscaled band yscaled size shifted 1/2(size-band,0);
 pb=unitsquare yscaled band xscaled size shifted 1/2(0,size-band);
 find_outlines(pa,pb) (r);
 Fill r1;
 fix_hstem(band,r1); fix_vstem(band,r1);
 fix_hsbw(size,0,0);
endglyph;

%% \vfill\break
%% \--------------------------------------------------------------------
%% Construction of the character crossed circle:
%% \-
%% Konstrukcja znaku przekre/slone k/o/leczko:
%% %
%% \PICT{b}
%% \--------------------------------------------------------------------
encode ("b") (ASCII "b");
introduce "b" (store+utilize) (0) ();
beginglyph("b");
 save pa, pb, pc, r;
 path pa, pb, pc;
 pa=reverse glyph_stored._a1;
 pb=fullcircle scaled (size-2band) shifted 1/2(size, size);
 pc=fullcircle shifted (1/2, 1/2) scaled size;
 find_outlines(pa,pb) (r);
 Fill pc;
 for i:=1,2,3,4: r[i]:=reverse r[i]; unFill r[i]; endfor
 path_labels(r1,r2,r3,r4);
 fix_hstem(band,pc,pb,r1,r2,r3,r4); fix_vstem(band,pc,pb,r1,r2,r3,r4); 
 fix_hsbw(size,0,0);
endglyph;

%% \vfill\break
%% \--------------------------------------------------------------------
%% Construction of the character partially crossed circle:
%% \-
%% Konstrukcja znaku przekre/slone cz/e/sciowo k/o/leczko:
%% %
%% \PICT{c}
%% \--------------------------------------------------------------------
encode ("c") (ASCII "c");
introduce "c" (utilize) (0) ();
beginglyph("c");
 save pa, pb, pc, r;
 path pa, pb, pc;
 pa=glyph_stored._b2 rotatedaround (1/2(size,size),45);
 pb=glyph_stored._b4 rotatedaround (1/2(size,size),45);
 pc=fullcircle shifted (1/2, 1/2) scaled size;
 Fill pc; unFill pa,pb;
 path_labels(pa,pb,pc);
 fix_hstem(band,pa,pb,pc); fix_vstem(band,pa,pb,pc);
 fix_hsbw(size,0,0);
endglyph;

%% \vfill\break
%% \--------------------------------------------------------------------
%% Construction of the character ``radiation'':
%% \-
%% Konstrukcja znaku ,,promieniowanie'':
%% %
%% \PICT{d}
%% \--------------------------------------------------------------------
encode ("d") (ASCII "d");
introduce "d" (utilize) (0) ();
beginglyph("d");
 save pa, pb, pc, pd, pe;
 path pa[], pb, pc, pd, pe;
 z0=1/2(size,size);
 z1=z0+1/2size*down rotated -30;
 z2=z0+1/2size*down rotated 30;
 pa0=z0--z1--z2--cycle;
 pb=reverse fullcircle scaled band shifted z0;
 pc=reverse fullcircle scaled 3band shifted z0;
 pd=reverse fullcircle scaled (size-2band) shifted z0;
 find_outlines(pa0,pc) (q); find_outlines(reverse q1,pd) (r);
 pa1:=r1;
 pa2:=pa1 rotatedaround (z0,120);
 pa3:=pa2 rotatedaround (z0,120);
 pe=fullcircle scaled size shifted z0;
 Fill pe; unFill pb,pa1,pa2,pa3;
 fix_hstem(band,pa1,pa2,pa3,pb,pe) y<3band;
 fix_vstem(band,pa1,pa2,pa3,pb,pe) abs(x-1/2size)>3band;
 ghost_stem top;
 fix_hsbw(size,0,0);
endglyph;

endfont.
%%\end

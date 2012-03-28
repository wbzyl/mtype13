%%%%
%%%% Adapted to MTYPE13 package.
%%%%
%%%% THIS FILE IS DISTRIBUTED WITH THE METATYPE1 PACKAGE
%%%%
%%%% It contains illustrations for plain_ex.mp
%%%% 19.08.2002. WARNING: still in statu ascendi (to be cleaned some day).

%%%% WB: line
%%%% input plain_ex.mp;
%%%% WB: changed to:
input plain-ex;

vardef xcent(expr p) =
 p shifted (-1/2xpart(urcorner p - llcorner p),0)
enddef;

vardef the_stroke text t =
 forsuffixes e = l,r: path_.e:=t; endfor path_.r -- reverse path_.l -- cycle
enddef;

def turn_fill expr p =
% fill p withcolor if turningnumber p>0: black else: white fi;
enddef;

def turn_draw expr p =
 draw p withcolor if turningnumber p>0: blue else: red fi;
enddef;

beginfig(100);
 xsize:=60mm; ysize:=xsize*(1/2(sqrt(5)-1)); b:=1/6xsize;
 path p[];
 p1=unitsquare xscaled xsize yscaled ysize; draw p1;
 z0=point 1 of p1; z2=point 3 of p1;
 z1=z0+whatever*(z2-z0 leg -b); y1=y2; z1-z2=z0-z3;
 p2=z0--z1--z2--z3--cycle;
 draw p2 withpen pencircle scaled 1bp withcolor blue;
 p3=(-1/2b,0)--(1/2b,0);
 p4=(-1/2xsize,0)--(1/2xsize,0);
 p5=(-1/2ysize,0)--(1/2ysize,0);
 drawdblarrow p3 rotated (90+angle(z1-z0)) shifted 1/2[z0,z2];
 draw xcent(btex $b$ etex) rotated (-90+angle(z1-z0))
   shifted (1/2[z0,z2]+2pt*unitvector(z3-z0));
 drawdblarrow p4 shifted (1/2[x0,x2],1/6[y0,y2]);
 draw xcent(btex $w$ etex) shifted ((1/2[x0,x2],1/6[y0,y2])+2pt*up);
 drawdblarrow p5 rotated 90 shifted (1/6[y0,y2],1/2[y0,y2]);
 draw xcent(btex $h$ etex) rotated 90
   shifted ((1/6[y0,y2],1/2[y0,y2])+2pt*left);
 dotlabel.bot(btex 0 etex, z0);
 dotlabel.top(btex 1 etex, z1);
 dotlabel.top(btex 2 etex, z2);
 dotlabel.bot(btex 3 etex, z3);
endfig;

def show_nodes_and_controls(expr p) = % |p| is cyclic
  draw p;
  for i:=0 upto length(p)-1:
   fill fullcircle scaled 1mm shifted point i of p;
   draw (precontrol i of p)--(point i of p);
   draw (point i of p)--(postcontrol i of p);
   fill fullcircle scaled 1mm shifted precontrol i of p withcolor white;
   draw fullcircle scaled .75mm shifted precontrol i of p;
   fill fullcircle scaled 1mm shifted postcontrol i of p withcolor white;
   draw fullcircle scaled .75mm shifted postcontrol i of p;
  endfor
enddef;

beginfig(101);
  path p,q; save s;
  s=75; s'=s+30;
  p:=fullcircle scaled s;
  show_nodes_and_controls(p);
  for i:=0 upto 7:
   label(decimal i, (point i of p) scaled .8);
  endfor
  currentpicture:=currentpicture shifted (s',.85s');

  q:=delete_nodes(p) ((1,-1), (3,-1), (5,-1), (7,-1));
  show_nodes_and_controls(q);
  currentpicture:=currentpicture shifted (-s',0);

  q:=delete_nodes(p) ((1,0), (3,0), (5,0), (7,0));
  show_nodes_and_controls(q);
  currentpicture:=currentpicture shifted (-s',0);

  q:=delete_nodes(p) ((1,1), (3,1), (5,1), (7,1));
  show_nodes_and_controls(q);
  currentpicture:=currentpicture shifted (-s',0);

endfig;

beginfig(102);
 path a,b,c; numeric diam, size, v, ds, hs, vs;
 diam:=3.25mm; size:=22mm; v:=1/3size; ds:=3/2size; hs:=3.25size; vs:=-5/4size;
 path default_nib; default_nib:=fullcircle scaled diam;
 pickup pencircle scaled 1bp;
 z1=origin; z2=(v,size); z3=(2v,0);
 pen_stroke(cut(rel 90)(0) cut(rel 90)(last))(z1{up}...z2...{down}z3)(a);
 b:=a rotatedaround((2/5size,2/5size),90);
 c:=(.8size,0)--(1.15size,0);

 turn_fill a; turn_fill b;
 turn_draw a; turn_draw b;
 drawarrow c shifted (0, v) dashed evenly;
 find_outlines(a,b)(P);
 for i=1 upto P.num: turn_draw P[i] shifted (ds,0); endfor
 
 a:=reverse a;
 turn_fill b shifted (hs,0); turn_fill a shifted (hs,0);
 turn_draw b shifted (hs,0); turn_draw a shifted (hs,0);
 drawarrow c shifted (hs,v) dashed evenly;
 find_outlines(b,a)(P);
 for i=1 upto P.num: turn_draw P[i] shifted (hs+ds,0); endfor
 
 a:=reverse a; b:=reverse b;
 turn_fill a shifted (0,vs); turn_fill b shifted (0,vs);
 turn_draw a shifted (0,vs); turn_draw b shifted (0,vs);
 drawarrow c shifted (0,v+vs) dashed evenly;
 find_outlines(a,b)(P);
 for i=1 upto P.num: turn_draw P[i] shifted (ds,vs); endfor

 a:=reverse a;
 turn_fill a shifted (hs,vs); turn_fill b shifted (hs,vs);
 turn_draw a shifted (hs,vs); turn_draw b shifted (hs,vs);
 drawarrow c shifted (hs,v+vs) dashed evenly;
 find_outlines(a,b)(P);
 for i=1 upto P.num: turn_draw P[i] shifted (hs+ds,vs); endfor

endfig;

beginfig(103);
 path a,c; numeric diam, size, v, ds, hs;
 diam:=3.25mm; size:=22mm; v:=1/3size; ds:=4/3size; hs:=4size;
 path default_nib; default_nib:=fullcircle scaled diam;
 pickup pencircle scaled 1bp;
 z1=origin;
 z2=(2v,1/2size);
 z3=(v,size);
 z4=(0,1/2size);
 z5=(2v,0);
 pen_stroke(cut(rel 90)(0) cut(rel 90)(last))
   (z1.. tension1.5 ..z2..z3..z4.. tension1.5 .. z5)(a);

  c:=(.8size,0)--(1.15size,0);

  turn_fill a; turn_draw a;
  drawarrow c shifted (0, 2/3v) dashed evenly;
  find_outlines(a)(P);
  for i=1 upto P.num: turn_draw P[i] shifted (ds,0); endfor
 
  a:=reverse a;
  turn_fill a shifted (hs,0); turn_draw a shifted (hs,0);
  drawarrow c shifted (hs,2/3v) dashed evenly;
  find_outlines(a)(P);
  for i=1 upto P.num: turn_draw P[i] shifted (hs+5/6ds,0); endfor
 
%%%% a:=reverse a; b:=reverse b;
%%%% turn_fill a shifted (0,vs); turn_fill b shifted (0,vs);
%%%% turn_draw a shifted (0,vs); turn_draw b shifted (0,vs);
%%%% drawarrow c shifted (0,v+vs) dashed evenly;
%%%% find_outlines(a,b)(P);
%%%% for i=1 upto P.num: turn_draw P[i] shifted (ds,vs); endfor
%%%%
%%%% a:=reverse a;
%%%% turn_fill a shifted (hs,vs); turn_fill b shifted (hs,vs);
%%%% turn_draw a shifted (hs,vs); turn_draw b shifted (hs,vs);
%%%% drawarrow c shifted (hs,v+vs) dashed evenly;
%%%% find_outlines(a,b)(P);
%%%% for i=1 upto P.num: turn_draw P[i] shifted (hs+ds,vs); endfor
%%%%
endfig;

beginfig(104);
 path a, b, c;
 numeric diam, tiny, huge; diam:=3.5bp; tiny:=5mm; huge:=35mm;

 z0=z1+huge*(right rotated 12);
 z1=z2+tiny*(right rotated 30);
 z2=origin;
 z3=z2+tiny*(right rotated -40);
 z4=z3+huge*(right rotated -12);

 a:=z0 .. z1 .. z2 & z2 .. z3 .. z4;
 b:=(z0 .. controls (postcontrol 0 of a) and (precontrol 1 of a) ..
     z2 .. controls (postcontrol 3 of a) and (precontrol 4 of a) .. z4)
     shifted (3/2huge,0);
 c:=(.8huge,0) -- (1.3huge,0);

 pickup pencircle scaled 1bp;
 
 drawarrow c dashed evenly;

 forsuffixes $:=a,b:
  draw $;
  for i:=0 upto length($):
   color oncolor, offcolor; oncolor:=black; offcolor:=black;
   if (str $="a"):
    if i=1: oncolor:=red; offcolor:=red; fi
    if i=2: offcolor:=red; fi
    if i=3: oncolor:=red; fi
   fi
   fill fullcircle scaled diam shifted point i of $ withcolor oncolor;
   if i<length($):
     fill fullcircle scaled diam shifted postcontrol i of $ withcolor white;
     fill fullcircle scaled diam shifted precontrol i+1 of $ withcolor white;
     draw fullcircle scaled diam shifted postcontrol i of $
      withpen pencircle scaled .5bp withcolor offcolor;
     draw fullcircle scaled diam shifted precontrol i+1 of $
      withpen pencircle scaled .5bp withcolor offcolor;
   fi
  endfor
 endfor

endfig;

beginfig(105);
 path a, b, c;
 numeric diam, tiny, huge; diam:=3.5bp; tiny:=5mm; huge:=35mm;

 z0=z1+huge*(right rotated 12);
 z1=origin;
 z2=z1+tiny*(right rotated -40);
 z3=z2+huge*(right rotated -10);

 a:=z0{left}.. z1 & z1 .. z2 .. z3;
 b:=(z0 .. controls (postcontrol 0 of a) and (precontrol 1 of a) ..
  z1 .. controls (postcontrol 2 of a) and (precontrol 3 of a) .. z3)
  shifted (3/2huge,0);
 c:=(.8huge,0) -- (1.3huge,0);

 pickup pencircle scaled 1bp;
 
 drawarrow c dashed evenly;

 forsuffixes $:=a,b:
  draw $;
  for i:=0 upto length($):
   color oncolor, offcolor; oncolor:=black; offcolor:=black;
   if (str $="a"):
    if i=1: offcolor:=red; fi
    if i=2: oncolor:=red; fi
   fi
   fill fullcircle scaled diam shifted point i of $ withcolor oncolor;
   if i<length($):
     fill fullcircle scaled diam shifted postcontrol i of $ withcolor white;
     fill fullcircle scaled diam shifted precontrol i+1 of $ withcolor white;
     draw fullcircle scaled diam shifted postcontrol i of $
      withpen pencircle scaled .5bp withcolor offcolor;
     draw fullcircle scaled diam shifted precontrol i+1 of $
      withpen pencircle scaled .5bp withcolor offcolor;
   fi
  endfor
 endfor

endfig;

% ---
def fill_dir expr t of p =
 fill triangle xyscaled (3.5mm,2.5mm) rotated angle(direction t of p)
  shifted point t of p
enddef;

path p; p=origin{right}..{right+2up}(1,2/5) & (1,2/5)..{right}(2,0);
p:=insert_nodes(p scaled 50mm yscaled 1.05)(1/3,2/3);
% ---
default_nib:=fix_nib(5mm,5mm,0);

beginfig(106);

pickup pencircle scaled 5mm; draw p withcolor .8 white;

pen_stroke()(p)(q);

pickup pencircle scaled 1.5bp;
z.l1=point 5.5 of q.l; z.l2=z.l1+(-5mm,20mm);
draw z.l1--z.l2; label.top(btex ${\it result}_l$ etex, z.l2);
draw q.l withcolor blue; 
fill_dir 0.51 of q.l withcolor blue;
z.r1=point 1.75 of q.r; z.r2=z.r1+(20mm,-10mm);
draw z.r1--z.r2; label.rt(btex ${\it result}_r$ etex, z.r2);
draw q.r withcolor red;
fill_dir 3.5 of q.r withcolor red;
z.b1=point 1 of q.b; z.b2=z.b1+(-5mm,5mm);
draw z.b1--z.b2; label.top(btex ${\it result}_b$ etex, z.b2);
draw q.b withcolor .8green;
z.e1=point 1 of q.e; z.e2=z.e1+(5mm,5mm);
draw z.e1--z.e2; label.top(btex ${\it result}_e$ etex, z.e2);
draw q.e withcolor .8green;

z1=point 1.5 of p; z2=z1+(-5mm,20mm);
draw z1--z2; label.top(btex {\it p} etex, z2);
draw p; fill_dir 3.5 of p;

endfig;

beginfig(107);

default_nib:=fix_nib(5mm,5mm,0);

pen_stroke(nib(default_nib xyscaled (1,2))(infinity))(p)(q);

fill q withcolor .8 white;
pickup pencircle scaled 1.5bp;
draw q;

endfig;

beginfig(108);

default_nib:=fix_nib(5mm,5mm,0);

pen_stroke(
 cut(45)(0) cut(default_nib xyscaled (1,2), rel 90)(infinity)
)(p)(q);

fill q withcolor .8 white;
pickup pencircle scaled 1.5bp;
draw q;

endfig;

beginfig(109);

default_nib:=fix_nib(5mm,5mm,0);

pen_stroke(tip()(3))(p)(q);

fill q withcolor .8 white;
pickup pencircle scaled 1.5bp;
draw p;
for t:=0 upto length(p):
 fill fullcircle scaled 1.25mm shifted point t of p;
endfor
draw p; fill_dir 3.5 of p;
draw q;

endfig;

beginfig(110);

default_nib:=fix_nib(5mm,5mm,0);

pen_stroke(tip(0)(3))(p)(q);

fill q withcolor .8 white;
pickup pencircle scaled 1.5bp;
draw p;
for t:=0 upto length(p):
 fill fullcircle scaled 1.25mm shifted point t of p;
endfor
draw p; fill_dir 3.5 of p;
draw q;

endfig;

end.

%% \end

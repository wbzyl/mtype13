%%%%
%%%% METATYPE 1 PACKAGE        Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%%% addto beginredisglyph endredisglyph Draw Pickup hint_redis_glyph
%%% addto define_key_points
%%% rotatedaround reflectedin
%%% good t
%%% x center

%% \voffset=-.25in
%% \hfuzz=24pt
%% \raggedbottom
%% \font\titlef=plssbx10 at 17pt
%% \font\sectionf=plssbx10 at 13pt
%% \def\title#1#2{\eject
%%   \centerline{\titlef #1}\vskip2\baselineskip}
%% \def\section#1{\bigskip
%%   \centerline{\sectionf #1}\vskip\baselineskip}
%% \font\ninerm=plr9
%% \def\SMC{\ninerm}
%% \def\acro#1{{\SMC #1}\spacefactor1000 }
%% \def\redis{\acro{REDIS}}
%% \def\PICT#1{\LINE{\SETPICT{\jobname}{#1}{\hsize}{75mm}}}
%% \def\PPICT#1#2#3{\LINE{%
%%   \SETPICT{\jobname}{#1}{\hsize}{75mm}\hfil
%%   \SETPICT{\jobname}{#2}{\hsize}{75mm}\hfil
%%   \SETPICT{\jobname}{#3}{\hsize}{75mm}}}
%% \def\ppICT#1#2{\LINE{%
%%   \SETPICT{\jobname}{#1}{\hsize}{75mm}\hfil
%%   \SETPICT{\jobname}{#2}{\hsize}{75mm}}}

%% \title{FONT REDIS-P}

%% W~erze przed komputerowej popularne by³o rysowanie
%% literek piórkiem z~metalow± okr±g³± p³ytk±. Piórko to nazywano
%% {\it redisówk±} -- st±d nazwa tego fontu.

input type1;

pf_info_familyname "Redis-Pen";
pf_info_fontname "Redis-Pen-Regular";
pf_info_weight "Normal";
pf_info_version "1.0";
pf_info_fixedpitch false;

pf_info_capheight 720;
pf_info_xheight 720;
pf_info_space 333;
pf_info_adl 1000, 250, 0;
pf_info_author "Wlodek Bzyl 2002";
pf_info_creationdate;


%% \section{PARAMETRY PODSTAWOWE FONTU}

%% Font {\redis} sk³ada siê z ``liter blokowych''.
%% Cech± charakterystyczn± elementów liter wykonanych tym piórkiem
%% jest ich jednakowa grubo¶æ.
%% Dobór piórka zale¿y od wysoko¶ci litery. Wysoko¶æ liter powinna
%% byæ 7--10 razy wiêksza od szeroko¶ci piórka.

u:=30; % jednostka szeroko¶ci
px:=round(3u); % czyli wysoko¶æ liter jest 8 razy wiêksza od szeroko¶ci piórka

%% Dodatkowe odsadki -- lewa i~prawa.

sidebearing:=2.5u;

%% Wysoko¶æ wielkich liter.

cap_height:=720;


%% \section{USTAWIANIE ZNAKÓW DIAKRYTYCZNYCH}

newinternal acute_slope; acute_slope:=30; % nachylenie do osi $OX$
newinternal acute_shift; acute_shift:=u; % przesuniêcie poziome
newinternal acute_length; acute_length:=5u; 

newinternal ogonek_slope; ogonek_slope:=-125; % nachylenie do osi $OX$
newinternal ogonek_length; ogonek_length:=5.25u;

numeric dotaccent_shift; dotaccent_shift=u; % przesuniêcie poziome


%% \section{BIBLOTECZKA MAKR POMOCNICZYCH}

%% Odbicie wzglêdem punktu $z$.

def reflectedin(expr z) = rotatedaround(z,180) enddef;

%% Definiowanie top, bot, lft, rt (zob. {\tt plain.mp}).

def Pickup primary p = default_nib:=p; pen_pickup_ makepen(p); enddef;

def butt_end(text nodes) = cut(rel 90)(nodes) enddef;

newinternal superness; superness:=.707;
numeric moresuper; moresuper:=.75;

vardef superarc(expr r,t,l,alpha,beta) = 
  save p,b,rt,tl,lb,br,center,superellipse,tm,startangle;
  pair b,rt,tl,lb,br,center; path superellipse,p.a,p.b;
  numeric tm.a,tm.b,tm',tm'',startangle;
  center=1/2[r,l]; 
  b=t reflectedin(center);
  rt=center reflectedin(1/2[r,t]);
  tl=center reflectedin(1/2[t,l]);
  lb=center reflectedin(1/2[l,b]);
  br=center reflectedin(1/2[b,r]);
  superellipse=r{rt-r}...(superness[center,rt]){t-r}
      ...t{tl-t}...(superness[center,tl]){l-t}
      ...l{lb-l}...(superness[center,lb]){b-l}
      ...b{br-b}...(superness[center,br]){r-b}
      ...cycle;
  startangle=angle(r-center);
  p.a=(origin--((infinity*right) rotated (startangle+alpha))) shifted center;
  p.b=(origin--((infinity*right) rotated (startangle+beta))) shifted center;
  if (alpha=0): tm.a=0;      
  else: (tm.a,tm')=superellipse intersectiontimes p.a;
  fi
  if (beta=360): tm.b=8;
  else: (tm.b,tm'')=superellipse intersectiontimes p.b;
  fi
  if (tm.a=0) and (tm.b=8): superellipse
  else: subpath (tm.a,tm.b) of superellipse
  fi
enddef;

numeric slope;

def ellipse_set(suffix $,@,@@,$$) =
  alpha_:=slope*(xpart @-xpart $);
  beta_:=ypart $$-ypart $-slope*(xpart $$-xpart $);
  gamma_:=alpha_/beta_;
  ypart @-ypart $=.5(beta_-alpha_*gamma_);
  xpart @@-xpart $=-2gamma_*(xpart @-xpart $)/(1+gamma_*gamma_);
  ypart @@-ypart $$=slope*(xpart @@-xpart $$)
enddef;

%% Z makra tego korzystam kre¶l±c kreskê sko¶n± w~£.

vardef polar_line(expr z, alpha, l) =
  % draw line of length |l| at angle |alpha| centered at |z|
  save zz,p; pair zz; path p;
  zz=l*right rotated alpha;
  pen_stroke()((origin--zz) shifted z)(p);
  p
enddef;

%% Akcenty d³ugo¶ci $\\{acute\_length}$ rysujê od wysoko¶ci
%% {\it topsidebearing} w~dó³ w~lewo pod k±tem $\\{accent\_slope}$.

newinternal topsidebearing; topsidebearing:=0;

vardef acute_accent =
  save s,p; pair s; path p;
  Pickup redis_acute_pen;
  s=(1/2(w-acute_length*cosd acute_slope),
         h+topsidebearing-acute_length*sind(acute_slope)-pen_top);
  p=origin--acute_length*right rotated acute_slope;
  pen_stroke()(p shifted (s+acute_shift*right))(p);
  p
enddef;

vardef dotaccent =
  save zd; pair zd;
  Pickup redis_dot_pen;
  top ypart zd=h+topsidebearing; xpart zd=w/2;
  redis_dot_pen shifted (zd+dotaccent_shift*right)
enddef;

%% Kropka stawiana na koñcu zdania powinna byæ wiêksza od kropki
%% nad liter± Z.

numeric dot_size; dot_size:=5/4px;


%% \section{NEUTRALIZACJA Z£UDZEÑ OPTYCZNYCH}

%% Wszystkie elementy poziome bêd± kre¶lone nieco wê¿szym
%% piórkiem, poniewa¿ kreska pozioma tej samej grubo¶ci co pionowa
%% wydaje siê grubsza. Dlatego do kre¶lenia liter u¿yjemy piórka
%% eliptycznego, a~nie okr±g³ego.

py:=round(.9px); % wysoko¶æ piórka
path redis_pen; redis_pen:=fix_nib(px,py,0);

%% Podobnie element uko¶ny w~literze £ i akcenty powinny byæ nieco cieñsze
%% od elementu pionowego.

pl:=.8px;
path redis_slash_pen; redis_slash_pen:=fix_nib(pl,pl,0);
pa:=.8px;
path redis_acute_pen; redis_acute_pen:=fix_nib(pa,pa,0);

%%%% Rysuj±c ma³e litery (³ac. {\it miniscules}) powinni¶my pamiêtaæ,
%%%% ¿e z~dwóch kresek pionowych tej samej szeroko¶ci,
%%%% krótsza bêdzie wydawa³a siê grubsza.
%% Trójk±t i~ko³o tej samej wysoko¶ci co prostok±t wydaj±
%% siê nieco ni¿sze. Dlatego litery ostro zakoñczone lub okr±g³e
%% powinny byæ wy¿sze od pozosta³ych.

o:=5; % wielko¶æ ``przestrzelenia'' (ang. {\it overshoot\/})

%% W~koñcu, powinni¶my pamiêtaæ, ¿e punkt umieszczony na geometrycznym
%% ¶rodku wydaje siê, ¿e le¿y poni¿ej ¶rodka.
%% Dlatego poprzeczki w~literach E, F i~H, miejsca po³±czeñ kresek
%% w~B, K i~R oraz przeciêcie siê kresek w~literze X powinni¶my
%% umie¶ciæ wy¿ej, na wysoko¶ci tzw. optycznego ¶rodka.
%% Równie¿ dolny brzuszek litery B~powinien byæ nieco wiêkszy od górnego,
%% w~przeciwnym razie litera ta bêdzie mia³a sk³onno¶ci do przewracania.

oo:=.5u; % ``przestrzelenie'' w górê ¶rodka optycznego

%% Równie¿ poprzeczka w~literze A nie mo¿e byæ umieszczona zbyt nisko.

od:=3u; % ``przestrzelenie'' w dó³ poprzeczki

%% Kropka jest nieco wiêksza od p³ytki piórka.

dd:=px+u/2;
path redis_dot_pen; redis_dot_pen:=fix_nib(dd,dd,0);

%% Litery, w~których wystêpuj± linie uko¶ne, s± trudniejsze
%% do narysowania. Po³±czenia uko¶nych elementów w~literach
%% A, V, M, N, W ³±czymy mo¿liwie szeroko. Robimy to w~tym celu,
%% aby litery te nie wydawa³y siê ciemniejsze od pozosta³ych.
%%%% Z~tego powodu wewnêtrzne kreski takich liter jak M, N i~W
%%%% rysujemy odpowiednio wê¿sze.

%% Makra $\\{openup\_lines}$ u¿ywam do ³±czenia uko¶nych kresek
%% wystêpuj±cych w~literach A, V, W, M, N.

newinternal openup; % zob. neutralizacja z³udzeñ optycznych poni¿ej
newinternal openup_a, openup_b; % `tensions' u¿yte przy ³±czeniu kresek
openup:=1.5u;
openup_a:=1.5; openup_b:=1.5;

vardef openup_lines(text node_list) =
  save n_,i_,z_,t_,edge_,turn_right;
  numeric n_,i_; pair z_[],t_[]; path edge_[]; boolean turn_right[];
  n_:=0;
  for $:=node_list: z_[incr n_]:=$; endfor
  edge_[1]=(z_[1]--z_[2]) shifted (.5openup*left);
  edge_[n_-1]=(z_[n_-1]--z_[n_]) shifted (.5openup*right);
  pen_stroke()(edge_[1])(edge_[1]);
  pen_stroke()(edge_[n_-1])(edge_[n_-1]);
  for i_:=2 upto n_-2: edge_[i_]:=
    z_[i_] shifted (.5openup*right)--z_[i_+1] shifted (.5openup*left);
    pen_stroke()(edge_[i_])(edge_[i_]);
  endfor
  for i_:=2 upto n_-1:
    if angle(z_[i_]-z_[i_-1]) > angle(z_[i_+1]-z_[i_]):
      turn_right[i_]:=true; %%%% message "TURN RIGHT";
    else:
      turn_right[i_]:=false; %%%% message "TURN LEFT";
    fi
  endfor
  for i_:=2 upto n_-1:
    if turn_right[i_]=true:
      t_[i_]:=edge_[i_-1].r intersectiontimes edge_[i_].r;
      edge_[i_-1].r:=subpath (0,xpart t_[i_]) of edge_[i_-1].r;
      edge_[i_].r:=subpath (ypart t_[i_],1) of edge_[i_].r;
    else:
      t_[i_]:=edge_[i_-1].l intersectiontimes edge_[i_].l;
      edge_[i_-1].l:=subpath (xpart t_[i_],1) of edge_[i_-1].l;
      edge_[i_].l:=subpath (0,ypart t_[i_]) of edge_[i_].l;
    fi
  endfor
  edge_[1].r for i_:=2 upto n_-1:
    if turn_right[i_]=true: && else: ..tension openup_a and openup_b.. fi
    edge_[i_].r
  endfor && edge_[n_-1].e && edge_[n_-1].l
  for i_:=n_-1 downto 2:
    if turn_right[i_]=true: ..tension openup_a and openup_b.. else: && fi
    edge_[i_-1].l
  endfor && edge_[1].b & cycle
enddef;


%% \section{PUNKTY KONSTRUKCYJNE}

%% Wiêkszo¶æ liter wykre¶lê w oparciu o~niektóre z~punktów zaznaczonych
%% na rysunku poni¿ej. Wspó³rzêdne punktów s± wyliczane przez makro
%% $\2{define\_key\_points}$. Punkty maj± nazwy postaci:
%% $r_i$, $r_{i\,o}$, $r_{i\,oo}$ lub $r_{i\,od}$.
%% W~celu uproszczenia rysunku prefiks $r$ usun±³em z~nazw punktów.
%% Do kwadratu dorysowa³em dwa prostok±ty szeroko¶ci odsadek
%% oraz kreskê poziom± na wysoko¶ci przestrzelenia $-o$.

def define_key_points = pair r[]; 
  lft bot r0=(0,0); rt bot r1=(w,0); rt top r2=(w,h); lft top r3=(0,h);
  r5=(w/2,h/2);
  bot r6=(w/2,0); rt r7=(w,h/2); top r8=(w/2,h); lft r9=(0,h/2);
  r10=1/2[r0,r6]; r11=1/2[r6,r1]; r13=1/2[r3,r8]; r12=1/2[r8,r2];
  r14=1/2[r9,r5]; r15=1/2[r5,r7];
  pair r[]o; % przestrzelone punkty konstrukcyjne
  for i=0,10,6,11,1: r[i]o=r[i]+o*down; endfor
  for i=3,12,8,13,2: r[i]o=r[i]+o*up; endfor
  pair r[]oo; % przestrzelenie dla ¶rodka optycznego -- góra
  for i=9,5,7,14,15: r[i]oo=r[i]+oo*up; endfor
  pair r[]od; % j.w. -- dó³
  for i=9,5,7,14,15: r[i]od=r[i]+od*down; endfor
enddef;

%% \centerline{\epsffile{eps/redis-000.0}}


%% \section{WSTAWIANIE HINTÓW}

vardef vhint expr p = save vh;
   pen_stroke()(p--(p+up))(vh); vh
enddef;

vardef hhint expr p = save hh;
   pen_stroke()(p--(p+right))(hh); hh
enddef;

def hint_redis_glyph(text vhints_list)(text hhints_list) = Pickup redis_pen;
  for $=vhints_list: fix_vstem(px)(vhint $); endfor
  for $=hhints_list: fix_hstem(py)(hhint $); endfor
enddef;


%% \section{DEFINIOWANIE ZNAKU}

def beginredisglyph(expr name,code,width,height,depth) =
  encode(name)(code); introduce.name(utilize)(1)();
  beginglyph(name); numeric w,h,d;
  glyph_width:=width;
  wd.glyph_name=glyph_width; ht.glyph_name=height; dp.glyph_name=depth;
  w=2round(1/2wd.glyph_name);
  d=round(dp.glyph_name);
  h=round(ht.glyph_name);
  ic.glyph_name=0;
  Pickup redis_pen;
  define_key_points;
  path glyph,bar,bowl,top_bowl,bottom_bowl,left_leg,right_leg,slash,stem;
enddef;

def endredisglyph =
  pickup pencircle scaled 1bp;
  endglyph
enddef;

def Draw suffix s =
  for i:=1 upto s.num:
   if turningnumber s[i] > 0: Fill else: unFill fi \\ s[i];
  endfor
enddef;


%% \section{OBRYSY ZNAKÓW}

beginfont

%% \-----------
%% \PPICT{I}{L}{Lslash}
%% \-----------

beginredisglyph("I",73,3u,cap_height,0);
  pen_stroke()(r6o--r8o)(glyph);
  Fill glyph;
  fix_hsbw(w,sidebearing,sidebearing);
  hint_redis_glyph(r6)();
endredisglyph;

beginredisglyph("L",76,12u,cap_height,0);
  pen_stroke()(r1--r0--r3o)(glyph);
  Fill glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r0)(r0);
endredisglyph;

beginredisglyph("Lslash",138,12u,cap_height,0);
  pen_stroke()(r1--r0--r3o)(l_outline);
  find_outlines(l_outline,polar_line(r9oo+10eps*left,-135,5u))(l_outline);
  find_outlines(
    l_outline1,polar_line(r9oo+10eps*right+.5py*down,45,6u)
  )(glyph);
  Draw glyph;
  fix_hsbw(w,1.5sidebearing,sidebearing);
  hint_redis_glyph(r0)(r0);
endredisglyph;

%% \-----------
%% \PPICT{E}{Eogonek}{F}
%% \-----------

beginredisglyph("E",69,12u,cap_height,0);
  pen_stroke()(r2--r3--r0--r1)(glyph);
  pen_stroke(butt_end(0))(r9oo--3/4[r15oo,r7oo])(bar);
  find_outlines(glyph,bar)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);
  hint_redis_glyph(r0)(r0,r9oo,r3);
endredisglyph;

beginredisglyph("Eogonek",134,12u,cap_height,2py);
  pen_stroke()(
    r2--r3--r0--r1--(r1+ogonek_length*right rotated ogonek_slope)
  )(glyph);
  pen_stroke(butt_end(0))(r9oo--3/4[r15oo,r7oo])(bar);
  find_outlines(glyph,bar)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r0)(r0,r9oo,r3);
endredisglyph;

beginredisglyph("F",70,12u,cap_height,0);
  pen_stroke()(r0o--r3--r2)(glyph);
  pen_stroke(butt_end(0))(r9oo--3/4[r15oo,r7oo])(bar);
  find_outlines(glyph,bar)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r0)(r9oo,r3);
endredisglyph;

%% \-----------
%% \PPICT{T}{H}{Y}
%% \-----------

beginredisglyph("T",84,18u,cap_height,0);
  pen_stroke(butt_end(last))(r6o--r8)(stem);
  pen_stroke()(r3--r2)(bar);
  find_outlines(bar,stem)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r6)(r3);
endredisglyph;

beginredisglyph("H",72,20u,cap_height,0);
  pen_stroke()(r0o--r3o)(left_leg);
  pen_stroke()(r1o--r2o)(right_leg);
  pen_stroke(butt_end(0,last))(r9oo--r7oo)(bar);
  find_outlines(left_leg,bar)(glyph);
  find_outlines(glyph 1,right_leg)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r0,r1)(r9oo);
endredisglyph;

beginredisglyph("Y",89,20u,cap_height,0);
  pen_stroke()(r3--r5oo--r2)(glyph);
  pen_stroke()(r5oo--r6o)(stem);
  find_outlines(glyph, stem)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r6)();
endredisglyph;

%% \-----------
%% \PPICT{N}{Nacute}{K}
%% \-----------

beginredisglyph("N",78,20u,cap_height,0);
  glyph=openup_lines(r0o,r3o,r1o,r2o);
  Fill glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r0+.5openup*left,r1+.5openup*right)();
endredisglyph;

beginredisglyph("Nacute",139,20u,cap_height,0);
  glyph=openup_lines(r0o,r3o,r1o,r2o);
  Fill glyph;
  interim openup_a:=2; interim openup_b:=1.05;
  interim topsidebearing:=2.25py; interim acute_shift:=acute_shift+u;
  Fill acute_accent;
  ht.glyph_name:=h+topsidebearing;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r0+.5openup*left,r1+.5openup*right)();
endredisglyph;

beginredisglyph("K",75,16u,cap_height,0);
  pen_stroke()(r0o--r3o)(glyph);
  r1:=r1+2u*right;
  r9oo:=r9oo+(px-1/20px)*right;
  pen_stroke()(r2o--r9oo--r1o)(right_leg);
  find_outlines(glyph,right_leg)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r0)();
endredisglyph;

%% \-----------
%% \PPICT{Z}{Zdotaccent}{Zacute}
%% \-----------

beginredisglyph("Z",90,20u,cap_height,0);
  r3:=r3+2u*right;
  pen_stroke()(r3--r2--r0--r1)(glyph);
  Fill glyph;
  fix_hsbw(w,sidebearing,sidebearing);
  hint_redis_glyph()(r0,r3);
endredisglyph;

beginredisglyph("Zdotaccent",155,20u,cap_height,0);
  r3:=r3+2u*right;
  pen_stroke()(r3--r2--r0--r1)(glyph);
  Fill glyph;
  interim topsidebearing:=2.25py;
  Fill dotaccent;
  ht.glyph_name:=h+topsidebearing;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph()(r0,r3);
endredisglyph;

beginredisglyph("Zacute",153,20u,cap_height,0);
  r3:=r3+2u*right;
  pen_stroke()(r3--r2--r0--r1)(glyph);
  Fill glyph;
  interim topsidebearing:=2.25py; interim acute_shift:=acute_shift+u;
  Fill acute_accent;
  ht.glyph_name:=h+topsidebearing;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph()(r0,r3);
endredisglyph;

%% \-----------
%% \ppICT{W}{M}
%% \-----------

beginredisglyph("W",87,32u,cap_height,0); interim openup:=2u;
  r10:=r10+1/4openup*right; r11:=r11+1/4openup*left;
  Fill openup_lines(r3o,r10o,r8o,r11o,r2o);
  fix_hsbw(w,sidebearing,sidebearing);  
endredisglyph;

beginredisglyph("M",77,28u,cap_height,0); interim openup:=2u;
  r13o:=r13o+2openup*left; r12o:=r12o+2openup*right;
  Fill openup_lines(r0o,r13o,r6o,r12o,r1o);
  fix_hsbw(w,sidebearing,sidebearing);  
endredisglyph;

%% \vfill\eject
%% \-----------
%% \PPICT{A}{Aogonek}{V}
%% \-----------

beginredisglyph("A",65,20u,cap_height,0);
  glyph=openup_lines(r0o,r8o,r1o);
  r100=whatever[r0,r8]=whatever[r9od,r7od];
  r101=whatever[r8,r1]=whatever[r9od,r7od];
  pen_stroke()(r100--r101)(bar);
  find_outlines(glyph,bar)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph()(r9od);
endredisglyph;

beginredisglyph("Aogonek",129,20u,cap_height,2py);
  glyph=openup_lines(r0o,r8o,r1o);
  r100=whatever[r0o,r8o]=whatever[r9od,r7od];
  r101=whatever[r8o,r1o]=whatever[r9od,r7od];
  pen_stroke()(r100--r101)(bar);
  interim ogonek_length:=4.5u; interim ogonek_slope:=-120;
  pen_stroke()(
    (r1o+.5openup*right)--(r1o+(ogonek_length*right rotated ogonek_slope))
  )(slash);
  find_outlines(glyph,slash)(glyph);
  find_outlines(glyph 1,bar)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph()(r9od);
endredisglyph;

beginredisglyph("V",86,20u,cap_height,0);
  Fill openup_lines(r3o,r6o,r2o);
  fix_hsbw(w,sidebearing,sidebearing);  
endredisglyph;

%% \-----------
%% \PPICT{P}{R}{B}
%% \-----------

beginredisglyph("P",80,12u,cap_height,0); interim superness:=moresuper;
  r100=1/2[r7,r2];
  pen_stroke(butt_end(last))(
    r0o--r3&reverse superarc(r9,r100,r3,0,180)
  )(glyph);
  find_outlines(glyph)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);
  hint_redis_glyph(r0)();
endredisglyph;

beginredisglyph("R",82,12u,cap_height,0); interim superness:=moresuper;
  r100=1/2[r7,r2];
  pen_stroke(butt_end(last))(
    r0o--r3&reverse superarc(r9,r100,r3,0,180)
  )(glyph);
  find_outlines(glyph)(glyph);
  r1o:=r1o shifted (px*right); 
  r9:=r9 shifted (px*right);
  pen_stroke(butt_end(0))(r9--r1o)(right_leg);
  unFill glyph2;
  find_outlines(glyph1,right_leg)(glyph);
  Fill glyph1;
  fix_hsbw(w,sidebearing,sidebearing+px/2);
  hint_redis_glyph(r0)();
endredisglyph;

beginredisglyph("B",66,14u,cap_height,0); interim superness:=moresuper;
  r100=1/2[r15oo,r12]; r101=1/2[r1,r7oo];
  pen_stroke(butt_end(0);butt_end(last))(
    r0--superarc(r10,r101,r14oo,0,180)--r9oo
  )(bottom_bowl);
  pen_stroke()(r0--r3)(stem);
  find_outlines(stem,bottom_bowl)(glyph);  
  unFill glyph1;
  pen_stroke(butt_end(0);butt_end(last))(
    superarc(r9oo-1/15px*up,r100,r3,0,180)
%%%%    superarc(r9oo,r100,r3,0,180)    
  )(top_bowl);
  find_outlines(glyph2,top_bowl)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r0)();
endredisglyph;

%% \-----------
%% \PPICT{O}{Oacute}{Q}
%% \-----------

beginredisglyph("O",79,24u,cap_height,0);
  pen_stroke()(superarc(r7,r8o,r9,0,360))(glyph);
  Fill glyph.r; unFill glyph.l;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r9,r7)(r6o,r8o);
endredisglyph;

beginredisglyph("Oacute",211,24u,cap_height,0);
  pen_stroke()(superarc(r7,r8o,r9,0,360))(glyph);
  Fill glyph.r; unFill glyph.l;
  interim topsidebearing:=2.25py;
  Fill acute_accent;
  ht.glyph_name:=h+topsidebearing;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r9,r7)(r6o,r8o);
endredisglyph;

beginredisglyph("Q",81,24u,cap_height,0);
  pen_stroke()(superarc(r7,r8o,r9,0,360))(glyph);
  pen_stroke()(subpath(0,2/3) of (r1o--r5))(right_leg);
%%%%  Fill glyph.r;
%%%%  unFill glyph.l;
  find_outlines(glyph.r,right_leg)(bowl);
  Fill bowl1;
  find_outlines(reverse glyph.l,reverse right_leg)(glyph);
  unFill reverse glyph1;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r9,r7)(r6o,r8o);
endredisglyph;

%% \-----------
%% \PPICT{J}{C}{Cacute}
%% \-----------

beginredisglyph("J",74,3u,cap_height,0);
  pen_stroke()(
    superarc(right rotated -135,origin,right rotated 135,45,90)
      scaled .2h shifted (1/2px*right+r6-r0)--r8o)(glyph);
  Fill glyph;
  fix_hsbw(w,sidebearing,sidebearing);
  hint_redis_glyph(r8)();
endredisglyph;

beginredisglyph("C",67,24u,cap_height,0);
  pen_stroke()(superarc(r7,r8o,r9,45,315))(glyph);
  Fill glyph;
  fix_hsbw(w,sidebearing,sidebearing-3u);
  hint_redis_glyph(r9)(r8o,r6o);
endredisglyph;

beginredisglyph("Cacute",130,24u,cap_height,0);
  pen_stroke()(superarc(r7,r8o,r9,45,315))(glyph);
  Fill glyph;
  interim topsidebearing:=2.25py;
  Fill acute_accent;
  ht.glyph_name:=h+topsidebearing;
  fix_hsbw(w,sidebearing,sidebearing-3u);
  hint_redis_glyph(r9)(r8o,r6o);
endredisglyph;

%% \-----------
%% \PPICT{G}{U}{D}
%% \-----------

beginredisglyph("G",71,24u,cap_height,0);
  bowl=superarc(r7,r8o,r9,45,315);
  z1=point infinity of bowl;
  x2=xpart z1; top y2=ypart r7;
  x3=xpart z1; y3=ypart r6o;
  pen_stroke(butt_end(infinity))(bowl)(glyph);
  pen_stroke()((z1--z2) shifted (u/20*right))(right_leg);
  find_outlines(glyph,right_leg)(glyph);
  Draw glyph;
%%%%  Fill glyph;
%%%%  Fill right_leg;
  fix_hsbw(w,sidebearing,sidebearing-3u);
  hint_redis_glyph(r9,z1)(r8o,r6o);
endredisglyph;

beginredisglyph("U",85,20u,cap_height,0);
  pen_stroke()(r3o--superarc(r9od,r6o,r7od,0,180)--r2o)(glyph);
  Fill glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r0,r1)(r6o);
endredisglyph;

beginredisglyph("D",68,20u,cap_height,0);
  pen_stroke()(r3--r0--superarc(r6,r7,r8,0,180)--cycle)(glyph);
  Fill glyph.r;
  unFill glyph.l;  
  fix_hsbw(w,sidebearing,sidebearing);
  hint_redis_glyph(r0,r7)(r0,r3);
endredisglyph;

%% \-----------
%% \PPICT{S}{Sacute}{X}
%% \-----------

path s_curve;

beginredisglyph("S",83,16u,cap_height,0); slope:=-1/3;
  pair r',ry',r'',rr',rry',rr'';
  path p[];
  xpart r'=xpart r9+o; ellipse_set(r8o,r',r'',r5oo);
  xpart rr'=xpart r7; ellipse_set(r6o,rr',rr'',r5oo);
  ry'=r' reflectedabout((w/2,0),(w/2,h));
  rry'=rr' reflectedabout((w/2,0),(w/2,h));
  p2=superarc(ry',r8o,r',25,180);
  p3=superarc(rry',r6o,rr',0,180);
  s_curve=p2..r''..r5oo & reverse(p3..rr''..r5oo);
  pen_stroke()(s_curve)(glyph);
  Fill glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r9,r7)(r8o,r6o);
endredisglyph;

beginredisglyph("Sacute",145,16u,cap_height,0);
  pen_stroke()(s_curve)(glyph);
  Fill glyph;
  interim topsidebearing:=2.25py;
  Fill acute_accent;
  ht.glyph_name:=h+topsidebearing;
  fix_hsbw(w,sidebearing,sidebearing);  
  hint_redis_glyph(r9,r7)(r8o,r6o);
endredisglyph;

beginredisglyph("X",88,20u,cap_height,0);
  r2:=r2+u*left; r3:=r3+u*right;
  pen_stroke()(r0--r2)(right_leg);
  pen_stroke()(r1--r3)(left_leg);
  find_outlines(right_leg,left_leg)(glyph);
  Draw glyph;
  fix_hsbw(w,sidebearing,sidebearing);  
endredisglyph;

%% \-----------
%% \PPICT{hyphen}{endash}{emdash}
%% \-----------

def horizontal_rule =
  pen_stroke()(r9--r7)(glyph);
  Fill glyph;
  fix_hsbw(w,px/4,px/4);  
  hint_redis_glyph()(r9)
enddef;

beginredisglyph("hyphen",45,6u,cap_height,0);
  horizontal_rule;
endredisglyph;

beginredisglyph("endash",123,12u,cap_height,0);
  horizontal_rule;
endredisglyph;

beginredisglyph("emdash",124,18u,cap_height,0);
  horizontal_rule;
endredisglyph;

%% \vfil\eject
%% \-----------
%% \PPICT{period}{comma}{one}
%% \-----------

beginredisglyph("period",46,2u,0,0); 
  Fill fix_nib(dot_size,dot_size,0) shifted (1/2dot_size*up+xpart r6*right);
  fix_hsbw(w,sidebearing,sidebearing);  
endredisglyph;

beginredisglyph("comma",44,5u,0,0);
  Fill polar_line(r6,-120,6u);
  fix_hsbw(w,sidebearing,sidebearing);
endredisglyph;

beginredisglyph("one",49,12u,cap_height,0);
  pen_stroke()(r1o--r2o--1/2[r9oo,r3o])(glyph);
  Fill glyph;
  hint_redis_glyph(r1)();
  fix_hsbw(w,sidebearing,sidebearing);
endredisglyph;


%% \section{PODCIÊCIA I LIGATURY}

kern_val_a=round(u);
kern_val_b=2kern_val_a;
kern_val_c=3kern_val_a;
kern_val_d=4kern_val_a;
kern_val_e=5kern_val_a;

%%%%input redis-kl.mp


endfont;


%% \eject
%% \baselineskip 62bp
%% \font\X=redis-p at 56bp
%% \centerline{\X ABCDEFGH}
%% \centerline{\X IJKL£M,NOP}
%% \centerline{\X QRSTUV.WXYZ}
%% \centerline{\X ¡ÊÆ£ÑÓ¦¬¯}
%% \centerline{\X V-O V--O V---O A1}
%% \centerline{\X V-W A--V A---W T1}
%%
%% \def\loop#1\repeat{\def\body{#1}\iterate}
%% \def\iterate{\body \let\next\iterate \else\let\next\relax\fi \next}
%% \let\repeat=\fi % this makes \loop...\if...\repeat skippable
%%
%% \vskip 18bp
%% \baselineskip 23bp
%% \section{TESTOWANIE SZEROKO¦CI LITER}
%% \font\X=redis-p at 18bp \X
%% SZ£¡, KOSZ, ZAJ¡C I KOT. GDYNIA WIDZIANA Z MORZA.
%% MÓÑTY PYHTÓN WID¯IANY. ROLLING STONESSS.
%% SZA£AWI£A, STAIRWAY TO HEAVEN. HAMBURGEFONS H¡MBURGÊFÓÑ¦.
%% \eject
%% \section{TESTOWANIE PODCIÊÆ I LIGATUR}
%% \bigskip \raggedright \pretolerance=5000 \tolerance=5000 \hbadness=5000
%% MODERN PRINTING EQUIPMENT BASED ON RASTER LINES---IN WHICH METAL TYPE
%% HAS BEEN REPLACED BY PURELY COMBINATORIAL PATTERNS OF ZEROES AND ONES
%% THAT SPECIFY THE DESIRED POSITION OF INK IN A DISCRETE WAY---MAKES
%% MATHEMATICS AND COMPUTER SCIENCE INCREASINGLY RELEVANT TO PRINTING.
%% WE NOW HAVE THE ABILITY TO GIVE A COMPLETELY PRECISE DEFINITION OF LETTER
%% SHAPES THAT WILL PRODUCE ESSENTIALLY EQUIVALENT RESULTS ON ALL RASTER\=BASED
%% MACHINES. MOREOVER, THE SHAPES CAN BE DEFINED IN TERMS OF VARIABLE
%% PARAMETERS. COMPUTERS CAN DRAW NEW FONTS OF CHARACTERS
%% IN SECONDS, MAKING IT POSSIBLE FOR DESIGNERS TO PERFORM VALUABLE EXPERIMENTS
%% THAT WERE PREVIOUSLY UNTHINKABLE.
%% \medskip
%% MF IS A SYSTEM FOR THE DESIGN OF ALPHABETS SUITED TO RASTER\=BASED
%% DEVICES THAT PRINT OR DISPLAY TEXT. THE CHARACTERS THAT YOU ARE READING
%% WERE ALL DESIGNED WITH MF, IN A COMPLETELY PRECISE WAY, AND THEY
%% WERE DEVELOPED RATHER HASTILY BY THE AUTHOR OF THE SYSTEM, WHO IS A RANK
%% AMATEUR AT SUCH THINGS. IT SEEMS CLEAR THAT FURTHER WORK WITH MF HAS
%% THE POTENTIAL OF PRODUCING TYPEFACES OF REAL BEAUTY. THIS MANUAL HAS
%% BEEN WRITTEN FOR PEOPLE WHO WOULD LIKE TO HELP ADVANCE THE ART OF
%% MATHEMATICAL TYPE DESIGN.
%%%% \eject
%%%% \input multido
%%%% \newcount\j
%%%% \def\nl{\hfil\break}
%%%% \noindent\X
%%%% \multido{\i=65+1}{26}{\j=\i{\multido{\i=65+1}{26}{\char\j\char\i\ }\nl}}

%%
%%\end

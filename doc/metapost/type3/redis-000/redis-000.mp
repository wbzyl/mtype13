%%%
%%%% TYPE 3 FONTS REPOSITORIUM        Wlodek Bzyl <matwb@univ.gda.pl>
%%%%
%%%% TODO: dodaæ `z³e' przyk³ady.

%% \voffset 24bp

%%% addto paint_grid keylabels define_key_points
%%% addto glyph_begin glyph_end set_kern_steps
%%% addto draw_face draw_eye draw_eyes draw_mouth
%%% good glyph
%%% addto glyph.fix glyph.new glyph.set_encoded
%%% reflectedabout reflectedin
%%% x center

%% \setfontname redis-000 %%%% required by the |\glyph| macro

%% \font\TT plss12
%% \font\titleF=redis-c00 at 36pt
%% \font\stitleF=redis-c00 at 18pt
%% \font\redisbf=redis-c00 at 14pt
%% \font\ninerm=cmr9
%% \def\SMC{\ninerm}
%% \def\acro#1{{\SMC #1}\spacefactor1000 }
%% \def\redis{\acro{REDIS}}
%% \def\mf{\acro{METAFONT}}
%% \def\mp{\acro{METAPOST}}
%% \def\doit{\ifx\next\[\def\next{\hfill}%
%%   \else\ifx\next\ \def\next{}%
%%   \else\def\next{\qquad}\fi\fi\next$\triangleright$\enspace\ignorespaces}
%% \def\glyphd #1 #2 {\centerline{\epsfbox{\mftfontname.#1}\hfil
%%     \epsfbox{\mftfontname.#2}}}
%% \def\glyphs #1 #2 #3 {\centerline{\epsfbox{\mftfontname.#1}\hfil
%%     \epsfbox{\mftfontname.#2}\hfil
%%     \epsfbox{\mftfontname.#3}}}
%% \def\glyphss #1 #2 #3 {\centerline{\epsfbox{\mftfontname.#1}\hfil
%%     \epsfbox{\mftfontname.#2}\hfil
%%     \lower26bp\hbox{\epsfbox{\mftfontname.#3}}}
%%   \vskip-\baselineskip}



%% \title{FONT REDIS}

%% W~erze przedkomputerowej popularne by³o rysowanie
%% literek piórkiem z~metalow± okr±g³± p³ytk±. Piórko to nazywano
%% {\it redisówk±} -- st±d nazwa tego fontu.

%% W programie korzystam ze makr u³atwiaj±cych ustawianie odsadek,
%% oraz definiowanie podciêæ i~ligatur.
%% Makra te oraz $\2{glyph\_begin}$ i $\2{glyph\_end}$ zawarte s±
%% w~pliku {\tt glyph.mp}.

input glyph;


%% \section{PARAMETRY PODSTAWOWE FONTU}

%% Ka¿dy font powinien mieæ nazwê. Nazw± tego fontu jest {\tt Redis-000}.

font_name "Redis-000";

%% Litery bêdê rysowa³ na siatce o~boku $32$.
%% Wybór liczby 32 pozwala, w~wiêkszo¶ci
%% programów dla poszczególnych liter, unikn±æ u³amków. 

u:=1; % jednostka szeroko¶ci
grid_size:=32;

%% Rozmiar siatki okre¶la jednostkê szeroko¶ci o~nazwie `quad'.

font_quad:=grid_size;

%% Przy takim wyborze wysoko¶æ wielkich liter powinna byæ równa
%% oko³o ${3\over4}$ rozmiaru siatki, np. takie proporcje
%% maj± litery z~fontu {\it Computer Modern Roman}.
%% Jednostka szeroko¶ci równa $\\{cap\_height}$ nazywana
%% jest te¿ `kwadratem'.

cap_height:=24; %  ${}={}$kwadrat

%% Warto¶æ nastêpnego parametru okre¶la wysoko¶æ ma³ych liter.
%% Font \acro{REDIS} nie zawiera ma³ych liter, a~poniewa¿ musimy
%% tu podaæ jak±¶ warto¶æ, ustawiam j± na $\\{cap\_height}$.

font_x_height:=cap_height; 
font_coding_scheme:="UPPERCASE ASCII";

%% Litery tego fontu maj± ró¿ne szeroko¶ci, wiêc
%% nastêpnej zmiennej nadajê warto¶æ $\2{false}$.

is_fixed_pitch false;

%% Font {\redis} sk³ada siê z ``liter blokowych'' rysowanych okr±g³ym
%% piórkiem. Dobór rozmiaru piórka zale¿y od wysoko¶ci litery.
%% Zazwyczaj dla odmiany normalnej wysoko¶æ liter powinna byæ 7--10
%% razy wiêksza od szeroko¶ci piórka. Dla odmiany t³ustej zwiêkszamy
%% nieco szeroko¶æ piórka.

px:=3u; % czyli wysoko¶æ liter jest 8 razy wiêksza od szeroko¶ci piórka

%% Ka¿dy font \acro{POSTSCRIPTOWY} jest przechowywany w~pamiêci komputera
%% w~rozmiarze $1\,bp$.
%% Stosowanie takiej konwencji umo¿liwia spójne skalowanie
%% znaków pochodz±cych z~ró¿nych fontów.
%% Skaluj±c font interpretator jêzyka \acro{POSTSCRIPT} korzysta
%% z macierzy $\2{font\_matrix}$.

font_matrix(1/grid_size,0,0,1/grid_size,0,0);

%% Te parametry s± opcjonalne. Tutaj pe³ni± rolê dodatkowego komentarza.

family_name "Redis";
font_version "1.0";
font_identifier:="REDIS 000";

%% Poni¿ej ustalam rozmiar spacji, jej rozci±gliwo¶æ
%% i~kurczliwo¶æ. Dla fontu \acro{CMR10} wielko¶æ spacji
%% (po przeliczeniu na jednostki fontu \acro{REDIS})
%% wynosi³aby $10{2\over3}u$. Norma mówi, ¿e spacja
%% w~tek¶cie z³o¿onymi wielkimi literami powinna zostaæ powiêkszona.
%% Mój wybór to $16u / 8u / 5u$.

font_normal_space:=16u; font_normal_stretch:=8u; font_normal_shrink:=5u;

%% Aby litery nie nachodzi³y na siebie dodajê po obu stronach dodatkowe
%% odstêpy, tzw. {\it odsadki}.

sidebearings:=2u; % odsadki --- lewa i~prawa

%% Znaki fontu Type~3 mo¿emy kolorowaæ. Domy¶lny kolor atramentu
%% u¿ytego do malowania znaków ustawiam na czarny.

color defaultcolor; defaultcolor:=black;

smiley_outline_width:=px/5;


%% \section{USTAWIANIE ZNAKÓW DIAKRYTYCZNYCH}

%% W alfabecie polskim niektóre samog³oski i~spó³g³oski posiadaj±
%% znaki diakrytyczne, tj. kropki i~kreski pochy³e,
%% umieszczane nad lub pod liter±. Najczê¶ciej diakrytyki s±
%% dostosowane do grubo¶ci najcieñszego elementu litery
%% i~umieszczone b±d¼ nieco nad liter±, b±d¼ u~jej podstawy
%% (zob. ``Neutralizacja z³udzeñ\dots'' poni¿ej).

newinternal acute_slope; acute_slope:=30; % nachylenie do osi $OX$
newinternal acute_shift; acute_shift:=u; % przesuniêcie poziome
newinternal acute_length; acute_length:=5u; 

newinternal ogonek_slope; ogonek_slope:=-125; % nachylenie do osi $OX$
newinternal ogonek_length; ogonek_length:=5.25u;

numeric dotaccent_shift; dotaccent_shift=u; % przesuniêcie poziome

%% Akcenty d³ugo¶ci $\\{acute\_length}$ rysujê od wysoko¶ci
%% $\\{topsidebearing}$ w~dó³ w~lewo pod k±tem $\\{accent\_slope}$.

vardef acute_accent =
  save s,aa; pair s; path aa; pickup redis_acute_pen;
  s=(1/2(w-acute_length*cosd acute_slope),
         h+topsidebearing-acute_length*sind(acute_slope)-pen_top);
  aa=origin--acute_length*right rotated acute_slope;
  aa shifted (s+acute_shift*right)
enddef;

%% Kropkê nad Z stawiam na wysoko¶ci $\\{topsidebearing}$ przesuniêt±
%% o~$\\{dotaccent\_shift}$ w~prawo.

vardef dotaccent =
  save zd; pair zd; pickup redis_dot_pen;
  top ypart zd=h+topsidebearing; xpart zd=w/2;
  zd shifted (dotaccent_shift*right)
enddef;

%% Z makra tego korzystam kre¶l±c kreskê sko¶n± w~£.

vardef polar_line(expr z, alpha, l) =
  %\ rysuj kreskê d³ugo¶ci |l| od |z| pod k±tem |alpha|
  save zz; pair zz; zz=l*right rotated alpha;
  (origin--zz) shifted z
%%%%  (origin--zz) shifted (z-1/2[origin,zz])
enddef;

%% Kropka stawiana na koñcu zdania jest nieco wiêksza od p³ytki piórka.

dd:=1.25px;
pickup pencircle scaled dd;
redis_dot_pen:=savepen;


%% \section{BIBLOTECZKA MAKR POMOCNICZYCH}

%% £uki wystêpuj±ce w~literach s±~kawa³kami {\it superelipsy\/}~[3--5].
%% S± to krzywe kszta³tu owalnego.
%% Parametr $\\{superness}$ mówi, o~ile superelipsa ró¿ni siê
%% od elipsy. Wielko¶æ ta powinna byæ wiêksza od $0.5$
%% (dla tej warto¶ci otrzymamy romb) i~mniejsza
%% od $1$ (a~dla tej -- prostok±t). Prawdziw± elipsê otrzymamy,
%% dla $\\{superness}=2^{-0.5}\approx0.707$.
%% \bigskip
%% \centerline{\epsffile{superellipse/se.100}\qquad
%%             \epsffile{superellipse/se.101}\qquad
%%             \epsffile{superellipse/se.102}\qquad
%%             \epsffile{superellipse/se.103}}
%% \bigskip
%% Do rysowania superelipsy wykorzystujê makro $\\{superarc}$:
%% \begindisplay
%%   $\\{superarc}$($\\{r}$,$\,\\{t}$,$\,\\{l}$,%
%%   $\,\\{k±t\_pocz±tkowy}$,$\,\\{k±t\_koñcowy}$)\cr
%% \enddisplay
%% \centerline{\epsffile{superellipse/se.104}}
%% \bigskip

%% Poni¿sza implementacja, w~odró¿nieniu od [3--4, str.~267 i~305],
%% umo¿liwia na rysowanie superellipsy o~dowolnym nachyleniu do osi $OX$.

newinternal superness; superness:=.707;

%% Brzuszki w literach P, R, B rysujê przy zwiêkszonej
%% warto¶ci $\\{superness}$.

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
%%%%  draw p.a withpen pencircle scaled 1;
%%%%  draw p.b withpen pencircle scaled 1;
%%%%  dotlabel.bot("center",center);
%%%%  dotlabel.top("t",t); %dotlabel.top("(rt)",rt);
%%%%  dotlabel.bot("(b)",b); %dotlabel.bot("(lb)",lb);
%%%%  dotlabel.rt("r",r); %dotlabel.rt("(br)",br);
%%%%  dotlabel.lft("l",l); %dotlabel.lft("(tl)",tl);
%%%%  message "startangle: " & decimal startangle
%%%%      & " alpha: " & decimal alpha & " beta: " & decimal beta;  
  if (alpha=0): tm.a=0;      
  else: (tm.a,tm')=superellipse intersectiontimes p.a;
  fi
  if (beta=360): tm.b=8;
  else: (tm.b,tm'')=superellipse intersectiontimes p.b;
  fi
%%%%  message "tm.a: " & decimal tm.a & " tm.b: " & decimal tm.b;
    if (tm.a=0) and (tm.b=8): superellipse
  else: subpath (tm.a,tm.b) of superellipse
  fi
enddef;

%% Litera S, cyfra 8, znak zapytania ?, znaki matematyczne $\infty$,
%% $\sim$, litery greckie $\xi$, $\delta$ i~wiele innych znaków
%% s± zbudowane z~efektownie wij±cych siê krzywych.
%% £±cz±c krzywe Beziera otrzymujemy zazwyczaj nieatrakcyjny `zygzak',
%% a~nie ³adny zawijas.
%% Na rysunku poni¿ej z~lewej widzimy rezultat
%% po³±czenia æwiartki superelipsy (góra) z~punktem (dó³), krzyw± 
%% o~zadanym nachyleniu w~punkcie koñcowym.
%% W~miejscu ³±czenia $z_@$ i~blisko punktu koñcowego na dole krzywizna
%% siê waha. Dlatego tak otrzymana krzywa nie jest ³adna ---
%% brakuje jej ``symetrii''.
%% \medskip
%% Jednym ze sposobów na uzyskanie ³adnie wij±cej siê krzywej
%% jest przesuniêcie nieco w~górê lub w~dó³ punktu $z_@$.
%% Knuth w~[5, str.~271] pisze, ¿e najlepsze rezultaty uzyska³,
%% przesuwaj±c $z_@$ w~pionie o~taki odcinek,
%% aby superelipsa przechodz±ca przez punkty $z_\$$ i~$z_@=(x_@,y_@)$
%% by³a styczna do prostej o~zadanym z~góry nachyleniu w~punkcie
%% $z_{\$\$}$. £±cz±c æwiartkê superelipsy, tym razem przechodz±cej
%% przez przesuniêty nieco w~górê punkt $z_@$, z~punktem $z_{\$\$}$,
%% otrzymujemy `g³adk±' krzyw± narysowan± poni¿ej po prawej.

%% \centerline{\epsffile{superellipse/se.105}}

%% Opisane powy¿ej przesuniêcie jest wyliczane w~makrze $\\{ellipse\_set}$.
%% Dla danych punktów $z_\$$, $z_{\$\$}$, odciêtej $x_@$ punktu $z_@$
%% i~nachylenia $\\{slope}$ makro oblicza rzêdn± $y_@$ punktu $z_@$
%% oraz wspó³rzêdne punktu $z_{@@}$, takiego ¿e prosta styczna
%% $z_{\$\$}\8{--}z_{@@}$ jest nachylona do osi $OX$ pod k±tem $\sigma$,
%% takim ¿e $\tg\sigma={}${\it slope}. Autorem tego makra jest D.~E. Knuth.
%% Historiê jego powstania i~wzory na których jest ono oparte Knuth
%% opisa³ w~[5].

numeric slope;

def ellipse_set(suffix $,@,@@,$$) =
  alpha_:=slope*(xpart @-xpart $);
  beta_:=ypart $$-ypart $-slope*(xpart $$-xpart $);
  gamma_:=alpha_/beta_;
  ypart @-ypart $=.5(beta_-alpha_*gamma_);
  xpart @@-xpart $=-2gamma_*(xpart @-xpart $)/(1+gamma_*gamma_);
  ypart @@-ypart $$=slope*(xpart @@-xpart $$)
enddef;

%% Makro $\\{lines}$ wykorzystujê do ³±czenia uko¶nych kresek wystêpuj±cych
%% w~literach A, V, W, M, N (zob. ``Neutralizacja z³udzeñ\dots'' poni¿ej).

newinternal openup;

def split_point(expr z) = (z+.5openup*left)...(z+.5openup*right) enddef;
  
vardef lines(text knots) = save i, n, z_; numeric i, n; pair z_[];
  n:=0;
  for $=knots: z_[incr n]:=$; endfor
  z_[1]:=z_[1]+.5openup*left;
  z_[n]:=z_[n]+.5openup*right;
  z_[1] for i=2 upto n-1: --split_point(z_[i]) endfor --z_[n]
enddef;


%% \section{ODBITKI PRÓBNE}

%% Znaczenie poni¿szych parametrów jest opisane [6].

proofscale:=5; defaultscale:=3/2;
labeloffset:=.4; dotlabeldiam:=.3;
dotcolor:=.77(1,0,0); rulecolor:=1/2black; 
defaultrulethickness:=.1; defaultscale:=.15;

def extrarule(expr w,z,c) = begingroup interim linecap:=squared;
    drawproof w..z withpen pencircle scaled defaultrulethickness withcolor c
  endgroup
enddef;

color italic_correction_color; italic_correction_color:=(1,0,1);

def makebox(text rule) = % linie poziome
  for y=0,h,-o,cap_height:
    rule((-leftsidebearing,y) t_,(w+rightsidebearing,y) t_);
  endfor
  if topsidebearing<>0:
    rule((-leftsidebearing,h+topsidebearing) t_,
         (w+rightsidebearing,h+topsidebearing) t_);
  fi
  if bottomsidebearing<>0:
    rule((-leftsidebearing,-d-bottomsidebearing) t_,
         (w+rightsidebearing,-d-bottomsidebearing) t_);
  fi
  for x=-leftsidebearing,0,w,w+rightsidebearing: % linie pionowe
    rule((x,0) t_,(x,h) t_);
  endfor
  if charic<>0: % korekta kursywy
    extrarule((w+charic,h) t_,(w+charic,.5h) t_,italic_correction_color);
  fi
enddef;

%% Pod rysunek liter bêdê podk³ada³ siatkê $12\times12$. Oczko siatki
%% jest równe $2/3$ szeroko¶ci piórka.

newinternal drawgrid;

vardef paint_grid =
  save i; numeric i; i:=0;
  if (drawgrid>0) and (proofing>1):
    for i=0 upto 12: draw (i*2u,0)--(i*2u,24u)
      withcolor .5(0,1,1) withpen pencircle scaled 1/8;
    endfor
    for i=0 upto 12: draw (0,i*2u)--(24u,i*2u)
      withcolor .5(0,1,1) withpen pencircle scaled 1/8;
    endfor
  fi
enddef;


%% \section{MAKRA POMOCNICZE DLA U¦MIESZKÓW}

%% Wszyscy ju¿ znamy s³awnego i tak popularnego Smiley'a, ale ma³o kto
%% widzia³ naszego bohatera w innym ubarwieniu. W czcionce u¶mieszki s±
%% w standardowych kolorach, ale gdyby komu¶ przysz³a ochota
%% poeksperymentowæ\dots

%% twarzowy --- ¿ó³ty

color twarzowy; twarzowy=(1,.8,0);

%% obrys kó³ka --- ¿ó³ty

color obrys; obrys=(1.,.8,0);

%% obrysowy --- czarny

color obrysowy; obrysowy=(0,0,0);

%% zakazu --- czerwony

color zakazu; zakazu=(1,0,0);

%% rumiencow --- jasna czerwieñ

color rumiencow; rumiencow=(1,.3,.3);

%% siniaka --- fioletowy

color siniaka; siniaka=(1,0,.7);

%% zadrapan --- czarny

color zadrapan; zadrapan=(0,0,0);

%% wasow --- czarny

color wasow; wasow=(0,0,0);

%% Gdyby nie makra i definicje, narysowanie pojedyñczego u¶mieszku by³o
%% by tak czasoch³onne, ¿e po narysowaniu pierwszego zrezygnowaliby¶my
%% z rysowania nastêpnych.

def draw_face = path p[];
  p1=fullcircle scaled w shifted ((w/2,h/2)+o*down);
  fill p1 withcolor twarzowy;
  draw p1 withpen pencircle scaled smiley_outline_width withcolor obrys
enddef;

def zakaz(expr wy,d,g,r)=
  interim linecap:=butt;
  drawoptions(withcolor zakazu);
  pickup pencircle scaled g;
  path p[];
  p1=fullcircle scaled r shifted (wy/2,h/2);
  p3=fullcircle scaled (r-g+2) shifted (wy/2,h/2);
  p2=subpath(0,9) of p3;
  draw p2 withcolor zakazu;
  draw (g*1.5,d-(g*1.5))--(wy-(g*1.5),g*1.5)
enddef;

def draw_eye(expr x,y,rodz,pro) = path p[];
  pickup pencircle scaled (pro/3);
  if rodz=0:
    p1=(x+.6pro,y)..(x,y+pro)..(x-.6pro,y)..(x,y-pro)..cycle;
    pickup pencircle scaled (pro/5);
    fill p1 withcolor obrysowy;
  elseif rodz=1:
    draw (x-.5pro,y)..(x+.5pro,y);
  elseif rodz=2:
    draw (x,y-.5pro)..(x,y+.5pro);
  elseif rodz=3:
    draw (x-.5pro,y)..(x+.5pro,y);
  elseif rodz=4:
    p1=fullcircle scaled pro shifted (x,y);
    fill p1 withcolor obrysowy;
    draw (x-.8pro,y-.1pro)..(x+.4pro,y+.7pro);
  elseif rodz=5:
    p1=fullcircle scaled pro shifted (x,y);
    fill p1 withcolor obrysowy;
    draw (x+.8pro,y-.1pro)..(x-.4pro,y+.7pro);
  elseif rodz=6:
    p1=(x,y+.2pro)..(x-.5pro,y+.2pro)..{dir -45}(x,y-.4pro){dir 45}..
    (x+.5pro,y+.2pro)..(x,y+.2pro)..cycle;
    pickup pencircle scaled (pro/5);
    fill p1 withcolor zakazu;
  elseif rodz=7:
    p1=(x,y+.6pro)..(x+pro,y)..(x,y-.6pro)..(x-pro,y)..cycle;
    pickup pencircle scaled (pro/5);
    fill p1 withcolor obrysowy;
    draw (x+pro,y){dir 0}..{dir 0}(h/2,y+.2pro);
  elseif rodz=8:
    p1=(x,y+.6pro)..(x+pro,y)..(x,y-.6pro)..(x-pro,y)..cycle;
    pickup pencircle scaled (pro/5);
    fill p1 withcolor obrysowy;
    draw (1000u/2,y+.2pro){dir 0}..{dir 0}(x-pro,y);
  elseif rodz=9:
    p1=(x,y+.5pro)..(x+.5pro,y)..(x,y-.5pro)..(x-.5pro,y)..cycle;
    fill p1 withcolor obrysowy;
    draw (x-.6pro,y+.5pro)..(x+.6pro,y+.5pro);
  elseif rodz=10:
    p1=(x+.5pro,y)..(x,y+.5pro)..(x-.5pro,y)..(x,y-.5pro)..cycle;
    pickup pencircle scaled (pro/5);
    fill p1 withcolor obrysowy;
  elseif rodz=11:
    p1=(x+.6pro,y)..(x-.6pro,y);
    p2=(x,y-.6pro)..(x,y+.6pro);
    draw p1 withcolor obrysowy;
    draw p2 withcolor obrysowy;
  elseif rodz=12:
    p1=(x-.15pro,y-.9pro)..(x-.15pro,y+.9pro);
    p2=(x+.15pro,y-.9pro)..(x+.15pro,y+.9pro);
    p3=(x-.3pro,y-.6pro){dir -35}..{dir 180}(x,y){dir 180}..
       {dir -35}(x+.3pro,y+.6pro);
    pickup pencircle scaled (pro/6);
    draw p1 withcolor obrysowy;
    draw p2 withcolor obrysowy;
    pickup pencircle scaled (pro/4);
    draw p3 withcolor obrysowy;
  fi  
enddef;

def draw_eyes(expr op,xp,yp,pp,od,xd,yd,pd)=
  draw_eye(xp,yp,op,pp);
  draw_eye(xd,yd,od,pd);
enddef;

def draw_mouth(expr ux,uy,wu,ru)=
  pickup pencircle scaled (wu/15);
  z0=(ux-.5wu,uy);
  z1=(ux+.5wu,uy);
  path p[];
  if ru=0:
    z2=(ux,uy-.4wu);
    p1=z0{dir -50}..z2..{dir 50}z1;
  elseif ru=1:
    p1=z0{dir 50}..{dir -50}z1;
  elseif ru=2:
    z2=(ux,uy-.7wu);
    z3=(ux,uy+.7wu);
    p1=z0..z2..z1..z3..cycle;
  elseif ru=3:
    z5=(ux-.4wu,uy);
    z6=(ux+.4wu,uy);
    z2=(ux-.2wu,uy-.1wu);
    z3=(ux+.2wu,uy+.1wu);
    z4=(ux,uy);
    p1=z5..z2..z4..z3..z6;
  elseif ru=4:
    z4=(ux-.2wu,uy-.2wu);
    z5=(ux-.2wu,uy+.2wu);
    z2=(ux+.2wu,uy-.2wu);
    z3=(ux+.2wu,uy+.2wu);
    z6=(ux-.3wu,uy);
    z7=(ux+.3wu,uy);
    p1=z4..z3;
    p2=z5..z2;
    p3=z6..z7;
    draw p2 withcolor obrysowy;
    draw p3 withcolor obrysowy;
  elseif ru=5:
    z6=(ux-.4wu,uy);
    z7=(ux+.4wu,uy);
    z2=(ux-.4wu,uy-.25wu);
    z3=(ux-.3wu,uy-.1wu);
    z4=(ux-.1wu,uy-.13wu);
    z5=(ux-.2wu,uy-.12wu);
    p1=z6{dir -30}..{dir 30}z7;
    p2=z3{dir -90}..z2..{dir 90}z4{dir 180}..z5..{dir 140}z3..cycle;
    draw p2 withcolor zakazu;
    fill p2 withcolor zakazu;
  elseif ru=6:
    z2=(ux-.40wu,uy-.20wu);
    z3=(ux-.30wu,uy+.15wu);
    z4=(ux-.20wu,uy-.11wu);
    z5=(ux-.10wu,uy+.13wu);
    z6=(ux-.00wu,uy-.08wu);
    z7=(ux+.10wu,uy+.10wu);
    z8=(ux+.20wu,uy-.01wu);
    z9=(ux+.30wu,uy+.01wu);
    p1=z0..z2;
    p2=z2..z3;
    p3=z3..z4;
    p4=z4..z5;
    p5=z5..z6;
    p6=z6..z7;
    p7=z7..z8;
    p8=z8..z9;
    p9=z9..z1;
    draw p2 withcolor obrysowy;
    draw p3 withcolor obrysowy;
    draw p4 withcolor obrysowy;
    draw p5 withcolor obrysowy;
    draw p6 withcolor obrysowy;
    draw p7 withcolor obrysowy;
    draw p8 withcolor obrysowy;
    draw p9 withcolor obrysowy;
  elseif ru=7:
    z5=(ux-.5wu,uy-.5wu);
    z6=(ux+.5wu,uy+.5wu);
    z2=(ux-.5wu,uy+.5wu);
    z3=(ux+.5wu,uy-.5wu);
    p1=z5..z6;
    p2=z2..z3;
    draw p2 withcolor obrysowy;
  fi
  draw p1 withcolor obrysowy;
enddef;

def wasy(expr xw,yw,rw,gw)=
  drawoptions(withcolor wasow);
  pickup pencircle scaled (1);
  path p[];
  p1=(xw-.1rw,yw){dir -90}..{dir -90}(xw-.1rw,yw-.1rw){dir -140}..
     (xw-.7rw,yw-.2rw){dir 0}..{dir 30}cycle;
  fill p1 withcolor wasow;
  p2=(xw+.1rw,yw){dir -90}..{dir -90}(xw+.1rw,yw-.1rw){dir -40}..
     (xw+.7rw,yw-.2rw){dir 180}..{dir 150}cycle;
  fill p2 withcolor wasow;
enddef;
 
def rumieniec(expr xw,yw,rw)=
  drawoptions(withcolor rumiencow);
  path p[];
  p1=(xw+.5rw,yw)..(xw,yw+.5rw)..(xw-.5rw,yw)..(xw,yw-.5rw)..cycle;
  fill p1 withcolor rumiencow; 
enddef;

def siniak(expr xw,yw,rw)=
  drawoptions(withcolor siniaka);
  path p[];
  p1=(xw+.6rw,yw)..(xw,yw+rw)..(xw-.6rw,yw)..(xw,yw-rw)..cycle;
  pickup pencircle scaled (rw/5);
  fill p1 withcolor siniaka;
enddef;

def zadrapania(expr xw,yw,rw)=
  drawoptions(withcolor zadrapan);
  path p[];
  p1=(xw+.6rw,yw)..(xw,yw+rw);
  p2=(xw+.25rw,yw-.2rw)..(xw-.4rw,yw+.8rw);
  p3=(xw-.4rw,yw+.1rw)..(xw+.6rw,yw+rw);
  p4=(xw-.25rw,yw-.1rw)..(xw+.8rw,yw+.8rw);
  pickup pencircle scaled (rw/10);
  draw p1 withcolor zadrapan;
  draw p2 withcolor zadrapan;
  draw p3 withcolor zadrapan;
  draw p4 withcolor zadrapan;
enddef;

def lzy(expr xw,yw,rw)=
  drawoptions(withcolor zadrapan);
  path p[];
  p1=fullcircle scaled (rw) shifted (xw,yw);
  fill p1 withcolor obrysowy;
  p2=fullcircle scaled (rw) shifted (xw,yw-1.5rw);
  fill p2 withcolor obrysowy;
enddef;


%% \section{KODOWANIE}

%% Polskie diakrytyki kodujê w~uk³adzie \acro{QX} [7].

"Aogonek"=>129; "Cacute"=>130; "Eogonek"=>134; "Lslash"=>138; "Nacute"=>139;
"Oacute"=>211; "Sacute"=>145; "Zacute"=>153; "Zdotaccent"=>155;

%% Pó³pauzê i pauzê kodujê te¿ w uk³adzie \acro{QX}.

"endash"=>123; "emdash"=>124;

%% U¶mieszkom nadajê ,,ma³e'' kody ASCII.

"smiley_joyful"=>1;
"smiley_sorrowful"=>2;
"smiley_astonished"=>3;
"smiley_in_love"=>4;
"smiley_with_moustache"=>5;
"smiley_bashful"=>6;
"smiley_drubbed"=>7;
"smiley_notdef"=>8;

"love"=>0;


%% \section{DOSTOSOWYWANIE DO W£ASNYCH POTRZEB}

%% Makro $\2{mode\_setup}$ mo¿e zmieniæ warto¶æ ka¿dego z~parametrów
%% podanych powy¿ej. Plik `{\tt redis.mp}' zawiera kilka modyfikacji
%% parametrów. Wyniki mo¿na obejrzeæ na ostatnich dwóch stronach.

glyph_begin_extra:="pickup redis_pen;paint_grid;define_key_points;path p[];";

randomseed:=314;
vardef random_color(expr code) =
  (uniformdeviate 1, uniformdeviate 1, uniformdeviate 1)
enddef;

mode_setup;


%% \section{NEUTRALIZACJA Z£UDZEÑ OPTYCZNYCH}

%% Wszystkie elementy poziome bêd± kre¶lone nieco wê¿szym
%% piórkiem, poniewa¿ kreska pozioma tej samej grubo¶ci co pionowa
%% wydaje siê trochê grubsza. Dlatego do kre¶lenia liter u¿yjê piórka
%% nie ko³owego, lecz eliptycznego.

py:=.9px; % wysoko¶æ piórka
pickup pencircle xscaled px yscaled py;
redis_pen:=savepen;

%% Podobnie element uko¶ny w~literze £ i~akcenty powinny byæ
%% nieco cieñsze od elementu pionowego.

pl:=.8px;
pickup pencircle scaled pl;
redis_slash_pen:=savepen;

pa:=.8px;
pickup pencircle scaled pa;
redis_acute_pen:=savepen;

%%%% Rysuj±c ma³e litery (³ac. {\it miniscules}) powinni¶my pamiêtaæ,
%%%% ¿e z~dwóch kresek pionowych tej samej szeroko¶ci,
%%%% krótsza bêdzie wydawa³a siê grubsza.
%% Trójk±t i~ko³o tej samej wysoko¶ci co prostok±t wydaj±
%% siê nieco ni¿sze. Dlatego litery ostro zakoñczone lub okr±g³e
%% powinny byæ nieco wy¿sze od pozosta³ych.

o:=u/3; % wielko¶æ ``przestrzelenia'' (ang. {\it overshoot\/})

%% W~koñcu powinni¶my pamiêtaæ, ¿e jest z³udzeniem i¿ punkt umieszczony
%% w geometrycznym ¶rodku znajduje siê poni¿ej tego ¶rodka.
%% Dlatego poprzeczki w~literach E, F i~H, miejsca po³±czeñ kresek
%% w~B, K i~R oraz przeciêcie siê kresek w~literze X powinni¶my
%% umie¶ciæ wy¿ej, na wysoko¶ci tzw. optycznego ¶rodka.
%% Tak¿e dolny ,,brzuszek'' litery B powinien byæ nieco wiêkszy od górnego,
%% w~przeciwnym razie litera ta bêdzie mia³a sk³onno¶ci do przewracania siê.

oo:=.5u; % ``przestrzelenie'' w górê ¶rodka optycznego

%% Natomiast poprzeczkê w~literze A nale¿y umie¶ciæ trochê poni¿ej ¶rodka
%% optycznego.

od:=3u; % ``przestrzelenie'' w dó³ poprzeczki

%% Po³±czenia uko¶nych elementów w~literach A, V, M, N, W ³±czymy
%% mo¿liwie szeroko. Robimy to w~tym celu, aby litery te nie wydawa³y
%% siê ciemniejsze od pozosta³ych.

openup:=u; % ``rozsuniêcie'' ³±czonych elementów uko¶nych


%% \section{KOLORY ZNAKÓW}

%% W foncie Typu~3 ka¿dy znak mo¿na pokolorowaæ. Oczywi¶cie kolory
%% znaków powinny wspó³graæ z~innymi kolorami
%% u¿ytymi w~sk³adzie. Dlatego kolorowanie ma sens, gdy wiemy
%% jakie inne kolory zostan± u¿yte.
%% Rzecz jasna tych kolorów teraz nie znam, tote¿ ka¿d± literê
%% pomalujê przypadkowym kolorem wybranym przez \mp.

%% Poniewa¿ kolor wybierany przez \mp\ dla litery O jest bardzo jasny,
%% zatem zamalujê O ``rêcznie'' na szaro.

%%%%glyph.fix(O)("defaultcolor"<<.618white);
glyph.fix(O)("defaultcolor"<<(1,0,1));

%% Heart should be red colored.

glyph.fix(love)("defaultcolor"<<red);

%% Makro $\2{glyph.set\_encoded}\,\\{defaultcolor}$ nadaje kolor
%% zakodowanym znakom. Jedynym argumentem jest procedura
%% jednoargumentowa zwracaj±ca kolor.

glyph.set_encoded.defaultcolor(random_color);


%% \section{KOSMETYKA PARAMETRÓW...}

%% Poniewa¿ kreski uko¶ne odsuwamy od siebie o~$\\{openup}$, wiêc o~tê
%% sam± wielko¶æ muszê zwiêkszyæ odsadki.

glyph.fix(A,V,M,N,W,Nacute)
    ("leftsidebearing"<<openup,"rightsidebearing"<<openup);

glyph.fix(K)("rightsidebearing"<<u);
glyph.fix(R)("rightsidebearing"<<px);

%% Akcenty zwiêkszaj± wysoko¶ci liter --
    
glyph.fix(Cacute,Nacute,Oacute,Sacute,Zacute,Zdotaccent)
    ("topsidebearing"<<2.25py);

%% oraz zwiêkszaj± ich g³êboko¶ci.
    
glyph.fix(Aogonek,Eogonek)("bottomsidebearing"<<1.75py);

%% C, Cacute, G zawieraj± kawa³kiem superelipsy, dlatego litery s± wê¿sze.

glyph.fix(C,Cacute)("rightsidebearing"<<-2u);
glyph.fix(G)("rightsidebearing"<<-1.5u);

glyph.fix(Lslash)("leftsidebearing"<<2u);
glyph.fix(I,J)("leftsidebearing"<<u,"rightsidebearing"<<u);


%% \section{USTALENIE ROZMIARÓW ZNAKÓW}

%% Proporcje liter s± wzorowane na pi¶mie antycznym z~kolumny Trajana~[2].

%% Podajemy kolejno: szeroko¶æ, wysoko¶æ, g³êboko¶æ i~korektê kursywy.
%% Ostatni parametr to lista nazw znaków.
%% Przypominam, ¿e kwadrat to jednostka szeroko¶ci równa $24u$.

glyph.new(24u,cap_height,0,0)(_notdef);

%% Szeroko¶æ I oraz J jest taka sama jak szeroko¶æ piórka.

glyph.new(3u,cap_height,0,0)(I,J);

%% Litery zbudowane w~pó³kwadracie.

glyph.new(12u,cap_height,0,0)(E,F,L,Lslash,Eogonek);

%% Litera S zajmuje $1/2$ kwadratu.

glyph.new(12u,cap_height,0,0)(P,R);
glyph.new(14u,cap_height,0,0)(B);
glyph.new(16u,cap_height,0,0)(S,Sacute);

%% K zajmuje oko³o $2/3$ kwadratu. W~napisie na kolumnie Trajana
%% nie by³a umieszczona.

glyph.new(16u,cap_height,0,0)(K);

%% Litery zajmuj±ce przestrzeñ nieco mniejsz± od kwadratu ($\approx3/4$).

glyph.new(18u,cap_height,0,0)(T);

%% Litery nieco szersze od poprzednich.

glyph.new(20u,cap_height,0,0)(A,H,N,U,V,Y,X,Z,Aogonek,Zacute,Nacute,Zdotaccent);

%% D wype³nia prawie ca³y kwadrat.

glyph.new(20u,cap_height,0,0)(D);

%% Litery O i Q s± oparte na kole wype³niaj±cym kwadrat.

glyph.new(24u,cap_height,0,0)(C,G,O,Q,Cacute,Oacute);

%% M zajmuje mniej ni¿ $1{1\over3}$ kwadratu.

glyph.new(28u,cap_height,0,0)(M);

%% W zajmuje $1{1\over3}$ kwadratu.

glyph.new(32u,cap_height,0,0)(W);

%% Kreska, kropka i przecinek.

glyph.new(6u,cap_height,0,0)(hyphen);
glyph.new(2u,0,0,0)(period);
glyph.new(5u,0,6u,0)(comma);

%% Pó³pauza i pauza.

glyph.new(12u,cap_height,0,0)(endash);
glyph.new(18u,cap_height,0,0)(emdash);

%% Wszystkie u¶mieszki s± takich samych rozmiarów.

glyph.new(24u,24u,0,0)(
  smiley_joyful,smiley_sorrowful,smiley_astonished, smiley_in_love,
  smiley_in_eyeglasses,smiley_with_moustache,smiley_bashful,
  smiley_drubbed,smiley_notdef);

glyph.new(28u,24u,0,0)(love);

%% Znaki do zrobienia!

glyph.new(24u,24u,0,0)(
  colon,semicolon,exclam,greater,parenleft,parenright);


%% \vfil\eject
%% \section{PUNKTY KONSTRUKCYJNE}

%% Wiêkszo¶æ liter wykre¶lê w oparciu o~niektóre z~punktów zaznaczonych
%% na rysunku poni¿ej. Wspó³rzêdne punktów s± wyliczane przez makro
%% $\2{define\_key\_points}$. Punkty maj± nazwy postaci:
%% $r_i$, $r_{i\,o}$, $r_{i\,oo}$ lub $r_{i\,od}$.
%% W~celu uproszczenia rysunku prefiks $r$ usun±³em z~nazw punktów.
%% Do kwadratu dorysowa³em dwa prostok±ty szeroko¶ci odsadek
%% oraz kreskê poziom± na wysoko¶ci przestrzelenia $-o$.

%% \centerline{\epsfxsize=.5\hsize\epsffile{eps/redis-000.0}}

def define_key_points =
  pair r[];  
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
  pair r[]od; % przestrzelenie dla ¶rodka optycznego -- dó³
  for i=9,5,7,14,15: r[i]od=r[i]+od*down; endfor
enddef;

vardef keylabels@#(text t) =
  forsuffixes $=t: makelabel@#(str$,r$); endfor
enddef;

glyph_begin(_notdef); interim drawgrid:=0;
  keylabels.top(0,1,5oo,6,7oo,9oo,10,11,14oo,15oo);
  keylabels.bot(2,3,8,12,13);
  keylabels.top(2o,3o,5o,7o,8o,9o,12o,13o);
  keylabels.bot(0o,1o,6o,10o,11o,9od,5od,7od,14od,15od);
  keylabels.rt(5,7,9,14,15);
glyph_end;


%% \vfil\eject
%% \section{GLIFY}

%% Komentarze dotycz±ce budowy liter pochodz± z~[2].
%% Pod rysunek ka¿dego znaku podk³adam siatkê $12\times12$.

drawgrid:=1;

%% \glyphs 73 84 72

glyph_begin(I);
  draw r6o--r8o;
glyph_end;

glyph_begin(T);
  draw r6o--r8; draw r3--r2;
glyph_end;

glyph_begin(H);
  draw r0o--r3o; draw r1o--r2o; draw r9oo--r7oo;
glyph_end;

%% Element poziomy w~literze H umieszczamy nieco ponad ¶rodkiem
%% wysoko¶ci litery. Umieszczenie elementu poziomego za nisko
%% lub za wysoko czyni j± niezgrabn±.

%% \glyphs 76 70 69

glyph_begin(L);
  draw r1--r0--r3o;
glyph_end;

glyph_begin(F);
  draw r0o--r3--r2; draw r9oo--3/4[r15oo,r7oo];
glyph_end;

glyph_begin(E);
  draw r2--r3--r0--r1; draw r9oo--3/4[r15oo,r7oo];
glyph_end;

%% Litery L, F i~E zbudowane s± w pó³kwadracie.
%% W literach F i~E elementy poziome powinny byæ równej d³ugo¶ci.
%% Skracanie tego elementu stosuje siê jedynie w~pi¶mie z~szeryfami.

%% \glyphss 138 86 134

glyph_begin(Lslash);
  draw r1--r0--r3o; pickup redis_slash_pen;
%%%%  draw polar_line(r9oo+.5u*right,45,10u);
  draw polar_line(r9oo,-135,5u); draw polar_line(r9oo+1/4py*down,45,6u);
glyph_end;

glyph_begin(V);
  draw lines(r3o,r6o,r2o);
glyph_end;

glyph_begin(Eogonek); interim ogonek_length:=5.75u;
  draw r2--r3--r0--r1--(r1+ogonek_length*right rotated ogonek_slope);
  draw r9oo--3/4[r15oo,r7oo];
glyph_end;

%% Litera £ ró¿ni siê od litery L tym, ¿e posiada dodatkow±
%% liniê sko¶n±, przecinaj±c± element pionowy powy¿ej ¶rodka.
%% Linia ta powinna byæ nieco cieñsza od elementu pionowego.
%% Aby inne litery nie `nachodzi³y' na £ zwiêkszamy lew± odsadkê.

%% \glyphs 78 139 88

glyph_begin(N); interim openup:=1.5u;
  draw lines(r0o,r3o,r1o,r2o);
glyph_end;

glyph_begin(Nacute); interim openup:=1.5u;
  interim acute_shift:=acute_shift+u;
  draw lines(r0o,r3o,r1o,r2o); draw acute_accent;
glyph_end;

glyph_begin(X);
  r2o:=r2o+u*left; r3o:=r3o+u*right; draw r0o--r2o; draw r1o--r3o;
glyph_end;

%% Litera N zajmuje prawie ca³y kwadrat. Linii przek±tnej nie nale¿y
%% skracaæ w~celu umieszczenia jej powy¿ej podstawy prawego
%% elementu pionowego, gdy¿ litera ta zatraci swój charakterystyczny
%% kszta³t.

%% \eject
%% \glyphs 90 155 153

glyph_begin(Z);
  r3:=r3+2u*right; draw r3--r2--r0--r1;
glyph_end;

glyph_begin(Zdotaccent);
  r3:=r3+2u*right; draw r3--r2--r0--r1; draw dotaccent;
glyph_end;

glyph_begin(Zacute); interim acute_shift:=acute_shift+u;
  r3:=r3+2u*right; draw r3--r2--r0--r1; draw acute_accent;
glyph_end;

%% Litera Z zajmuje nieco mniej ni¿ pole kwadratu.
%% Górny element poziomy powinien byæ krótszy od dolnego.
%% Je¶li tego nie zrobimy, to litera bêdzie mia³a tendencjê
%% do przewracania siê do ty³u.

%% Diakrytyki nale¿y umieszczaæ tak, aby nie psu³y równo¶ci linii
%% szeregu. Kreski powinny byæ jednolite, tj. jednakowej grubo¶ci
%% i~kszta³tu.

%% \eject
%% \glyphss 87 65 129

glyph_begin(W); interim openup:=1.5u;
  r10o:=r10o+1/4openup*right; r11o:=r11o+1/4openup*left;
  draw lines(r3o,r10o,r8o,r11o,r2o);
glyph_end;

glyph_begin(A);
  p0=r0o--r8o; % lewa nó¿ka
  p1=r8o--r1o; % prawa nó¿ka
  p3=r9od--r7od; draw p3 cutbefore p0 cutafter p1; % poprzeczka
  draw lines(r0o,r8o,r1o);
glyph_end;

glyph_begin(Aogonek);
  p0=r0--r8o; % lewa nó¿ka
  p1=r8o--r1; % prawa nó¿ka
  p3=r9od--r7od; draw p3 cutbefore p0 cutafter p1; % poprzeczka
  draw lines(r0o,r8o,r1o);
  r100=r1o+.5openup*right;
  draw r100--(r100+ogonek_length*right rotated ogonek_slope);
glyph_end;

%% Litera W sk³ada siê jakby z~podwójnego V i~zajmuje $1{1\over3}$
%% kwadratu. Kreski sko¶ne tworz± trzy trójk±ty. z~których pierwszy
%% i~trzeci s± równe, drugi (¶rodkowy) posiada natomiast nieco
%% krótsz± podstawê. Gdyby wszystkie trzy trójk±ty by³y równe,
%% to wówczas trójk±t ¶rodkowy wydawa³by siê szerszy od s±siednich.

%% Poniewa¿ kreski w literze W s± ³±czone pod k±tem mniejszym
%% ni¿ kreski w literze A rozsuwamy je bardziej ni¿ w~A
%% (zob. komentarz przy makrze $\\{lines}$).

%% \eject
%% \glyphs 77 75 89

glyph_begin(M); interim openup:=1.5u;
  r13o:=r13o+2openup*left; r12o:=r12o+2openup*right;
  draw lines(r0o,r13o,r6o,r12o,r1o);
glyph_end;

glyph_begin(K);
  draw r0o--r3o; r1o:=r1o+2u*right; r9oo:=r9oo+px*right; draw r2o--r9oo--r1o;
glyph_end;

glyph_begin(Y);
  draw r3o--r5oo--r2o; draw r5oo--r6o;
glyph_end;


%% Litera M sk³ada siê z~elementów pochy³ych tworz±cych trzy trójk±ty.
%% ¦rodkowy z~nich powinien byæ nieco szerszy od pozosta³ych.
%% Czêsto elementy zewnêtrzne s± rysowane pionowo. Jednak litera taka
%% bêdzie sztywna w~swej formie.

%% W~napisie na kolumnie Trajana litera K nie by³a umieszczona,
%% poniewa¿ alfabet rzymski jej nie zawiera³.
%% Litera ta sk³ada siê z~jednego elementu pionowego i~dwóch
%% sko¶nych, stykaj±cych siê z~sob± w po³owie wysoko¶ci litery
%% z~kresk± pionow±. Elementy sko¶ne kre¶limy tak,
%% aby dolny by³ rozstawiony szerzej anie¿eli górny.

%% Litera Y sk³ada siê z~dwóch linii sko¶nych, stykaj±cych siê
%% poni¿ej ¶rodka kwadratu, z~którego to punktu biegnie ku
%% do³owi linia pionowa. Punktu stycznego dwóch sko¶nych linii
%% z lini± pionow± nie mo¿na umieszczaæ za nisko, gdy¿ litera
%% straci³aby swój wyraz.
%% Niefortunne jest rysowanie litery Y przez przeci±gniêcie prawej
%% linii sko¶nej od wierzcho³ka do podstawy
%% i~uzupe³niaj±cej linii sko¶nej.
%% Litera w~ten sposób wykonana jest niezrównowa¿ona w~swej formie.

%% \eject
%% \glyphs 80 82 66

glyph_begin(P); interim superness:=moresuper;
  draw r0o--r3; r100=1/2[r7,r2]; draw superarc(r9,r100,r3,0,180);
glyph_end;

glyph_begin(R); interim superness:=moresuper;
  draw r0o--r3; r100=1/2[r7,r2];
  draw superarc(r9,r100,r3,0,180);
  r1o:=r1o shifted (px*right); 
  r9:=r9 shifted (px*right);
  draw r9--r1o;
glyph_end;

glyph_begin(B); interim superness:=moresuper;
  draw r0--r3;
  r100=1/2[r15oo,r12]; r101=1/2[r1,r7oo];
  draw superarc(r9oo,r100,r3,0,180);
  draw r0--superarc(r10,r101,r14oo,0,180)--r9oo;
glyph_end;

%% Litera R zajmuje nieco wiêcej ni¿ $1/2$ kwadratu i~ró¿ni siê
%% od litery P jedynie dodanym elementem sko¶nym, wychodz±cym od
%% ¶rodka elementu pionowego ku podstawie litery.
%% Wyprowadzenie linii sko¶nej wprost z~³uku ko³a -- w~do¶æ znacznej
%% odleg³o¶ci od elementu pionowego -- jest czêsto u¿ywane, wymaga
%% jednak wiêkszej staranno¶ci i~wyczucia konstrukcji litery.

%% Dolny ³uk w~literze B powinien byæ wiêkszy od górnego.
%% £±czenie siê ³uków nie mo¿e nast±piæ tu¿ przy elemencie
%% pionowym, lecz w~pewnej odleg³o¶ci od niego, sk±d za pomoc±
%% linii poziomej ³±czy siê z~pionow±.

%% \eject
%% \glyphs 79 211 81

glyph_begin(O);
  draw superarc(r7,r8o,r9,0,360);
glyph_end;

glyph_begin(Oacute);
  draw superarc(r7,r8o,r9,0,360); draw acute_accent;
glyph_end;

glyph_begin(Q);
  draw superarc(r7,r8o,r9,0,360); p0=r1o--r5; draw subpath(0,2/3) of p0;
glyph_end;

%% \glyphss 67 130 74

glyph_begin(C);
  draw superarc(r7,r8o,r9,45,315);
glyph_end;

glyph_begin(Cacute);
  draw superarc(r7,r8o,r9,45,315); draw acute_accent;
glyph_end;

glyph_begin(J);
  draw superarc(right rotated -135,origin,right rotated 135,45,90) scaled .2h
      shifted (1/2px*right+r6-r0)--r8o;
glyph_end;

%% Z~braku miejsca litera C bywa czasami kre¶lona w~postaci po³owy
%% ko³a, lecz wtedy zatraca siê charakterystyczny wyraz tej litery.

%% Litery J, podobnie jak litery K, nie ma w~alfabecie rzymskim.
%% Element pionowy ³agodnie przechodzi u~do³u litery w~³uk.

%% \eject
%% \glyphs 71 85 68

glyph_begin(G);
  p0=superarc(r7,r8o,r9,45,315);
  draw p0;
  z1=point infinity of p0;
  x2=xpart z1; top y2=ypart r7;
  draw z1--z2;
glyph_end;

glyph_begin(U);
  draw r3o--superarc(r9od,r6o,r7od,0,180)--r2o;
glyph_end;

glyph_begin(D);
  draw r3--r0--superarc(r6,r7,r8,0,180)--cycle;
glyph_end;

%% Litera G przypomina literê C. Istnieje kilka innych odmian kre¶lenia
%% tej litery, jak np. zaopatrzenie jej w~dodatkow± liniê poziom±.
%% Do¶æ oryginalna w~swej formie jest litera G sk³adaj±ca siê tylko
%% z~³uku ko³a i~linii poziomej.

%% Litera U zajmuje ${3\over4}$ kwadratu. Czêsto koñczy j±
%% z~prawej strony {\it stópka}, która powinna mieæ zastosowanie
%% jedynie w~ma³ych literach.

%% Litera D sk³ada siê z~elementu pionowego i~³uku ko³a, który
%% wype³nia ca³y kwadrat. £uk ten -- w~pewnej odleg³o¶ci od elementu
%% pionowego -- przechodzi w~linie poziome i~³±czy siê z~nimi
%% u~podstawy i~wierzcho³ka.

%% \eject
%% \glyphd 83 145

path s_curve;

glyph_begin(S); slope:=-1/3;
  pair r',ry',r'',rr',rry',rr'';
  xpart r'=xpart r9+o; ellipse_set(r8o,r',r'',r5oo);
  xpart rr'=xpart r7; ellipse_set(r6o,rr',rr'',r5oo);
  ry'=r' reflectedabout((w/2,0),(w/2,h));
  rry'=rr' reflectedabout((w/2,0),(w/2,h));
%%%%  draw superarc(r' reflectedabout((w/2,0),(w/2,h)),r8o,r',0,360)
%%%%     withpen pencircle scaled 2 withcolor red;
%%%%  draw superarc(rr' reflectedabout((w/2,0),(w/2,h)),r6o,rr',0,360)
%%%%     withpen pencircle scaled 2 withcolor red;
  p2=superarc(ry',r8o,r',25,180);
  p3=superarc(rry',r6o,rr',0,180);
  s_curve=p2..r''..r5oo & reverse(p3..rr''..r5oo);
  draw s_curve;
glyph_end;

glyph_begin(Sacute);
  draw s_curve;
  draw acute_accent;
glyph_end;

%% Litera S jest najtrudniejsz± do wykonania. Zbudowana jest
%% z~piêknie wij±cej siê krzywej. ¯adna czê¶æ tej krzywej nie powinna
%% przechodziæ w~liniê prost±. Niew³a¶ciwe jest kre¶lenie czê¶ci
%% linii ³±cz±cej oba ³uki -- sko¶nie lub poziomo.
%% Krzywe, z~których sk³ada siê litera, s± wycinkami kó³
%% i~zajmuj± ${1\over2}$ kwadratu.
%% Dla równowagi ko³o dolne jest trochê wiêksze od górnego.
%% Koñce ³uków litery winny byæ lekko odgiête na zewn±trz ko³a.

%% \eject
%% \glyphs 45 123 124

glyph_begin(hyphen);
  draw r9--r7;
glyph_end;

glyph_begin(endash);
  draw r9--r7;
glyph_end;

glyph_begin(emdash);
  draw r9--r7;
glyph_end;

%% \glyph 46

glyph_begin(period);
  draw r6 shifted (.1px*up) withpen pencircle scaled 1.15px;
glyph_end;

%% \glyph 44

glyph_begin(comma);
  draw polar_line(r6,-120,6u);
glyph_end;


%% \glyphs 1 2 3

glyph_begin(smiley_joyful);
  draw_face;
  draw_eyes(0,.35w,.7h,w/7.5,0,.65w,.7h,w/7.5);
  draw_mouth(.5w,.45h,.7w,0);
glyph_end;

glyph_begin(smiley_sorrowful);
  draw_face;
  draw_eyes(0,.35w,.7h,(w-1)/7,0,.65w,.7h,(w-1)/7);
  draw_mouth(.5w,.3h,.6w,1);
glyph_end;

glyph_begin(smiley_astonished);
  draw_face;
  draw_eyes(0,.35w,.7h,(w-1)/7,0,.65w,.7h,(w-1)/7);
  draw_mouth(.5w,.3h,.3w,2);
glyph_end;


%% \glyphs 4 5 6

glyph_begin(smiley_in_love);
  draw_face;
  draw_eyes(6,.3w,.65h,(w-1)/4,6,.7w,.65h,(w-1)/4);
  draw_mouth(.5w,.45h,.7w,0);
glyph_end;

glyph_begin(smiley_with_moustache);
  draw_face;
  draw_mouth(.5w,.45h,.7w,0);
  draw_eyes(0,.35w,.7h,(w-1)/7,0,.65w,.7h,(w-1)/7);
  wasy(.5w,.55h,.34w,(w-1)/7);
glyph_end;

glyph_begin(smiley_bashful);
  draw_face;
  draw_eyes(10,.3w,.7h,(w-1)/9,10,.7w,.7h,(w-1)/9);
  rumieniec(.2w,.4h,.2w);
  rumieniec(.8w,.4h,.2w);
  draw_mouth(.5w,.26h,.2w,0);
glyph_end;

%% \glyph 7

glyph_begin(smiley_drubbed);
  draw_face;
  siniak(.33w,.68h,(w-1)/7);
  draw_eyes(0,.35w,.7h,(w-1)/9,0,.65w,.7h,(w-1)/9);
  zadrapania(.75w,.5h,(w-1)/9);
  draw_mouth(.5w,.45h,.7w,0);
glyph_end;

%% \glyph 8

glyph_begin(smiley_notdef);
  draw_face;
  draw_eyes(0,.35w,.7h,(w-1)/7,0,.65w,.7h,(w-1)/7);
  draw_mouth(.5w,.3h,.6w,1);
  zakaz(w,h,w/10,w-1);
glyph_end;

glyph_begin(colon);
glyph_end;

glyph_begin(semicolon);
glyph_end;

glyph_begin(exclam);
glyph_end;

glyph_begin(greater);
glyph_end;

glyph_begin(parenleft);
glyph_end;

glyph_begin(parenright);
glyph_end;

%% \glyph 0

glyph_begin(love);
  r100=.5[r5,r8o]; r101=.5[r7,r2o]; r102=.5[r9,r3o];
  p1=r100..{right}r12o..{down}r101..{r6-r7}r6o
    & r6o{r9-r6o}..{up}r102..{right}r13o..r100..cycle;
  filldraw p1;
glyph_end;


%% \section{PODCIÊCIA I LIGATURY}

%% Lista podciêæ zosta³a sporz±dzona w oparciu o wszystkie pary
%% liter fontu. Dlatego wszystkie skrótowce powinny `dobrze' siê
%% sk³adaæ.

kern_unit:=-u; % `$-$', bo wiêkszo¶æ liter podsuwamy pod poprzedni± literê

set_kern_steps 1, 2, 3, 4, 5, 6; % czyli $i$-te podciêcie${}=i*\\{kern\_unit}$

%tracingligtable:=1;

input redis-lk;

LK(colon)
  LP(parenright,smiley_joyful)
  LP(parenleft,smiley_sorrowful)
  LP(O,smiley_astonished)
  LP(semicolon,smiley_with_moustache)
  LP(greater,smiley_bashful)
  LP(B,smiley_in_love)
  LP(exclam,smiley_drubbed)
KL;


endfont


%% \section{LITERATURA}

%% \newdimen\mftindent \mftindent=2em
%% \def\hang{\hangindent\mftindent}
%% \def\textindent#1{\leavevmode\hskip\mftindent\llap{#1\enspace}\ignorespaces}
%% \def\item{\par\hang\textindent}

%% \item{[1]} Bernaciñski, Stefan. {\it Liternictwo}.
%%    WSiP, Warszawa 1990.
%% \item{[2]} Wojeñski, Jan. {\it Technika Liternictwa}.
%%    Polskie Wydawnictwa Gospodarcze, Warszawa 1957.
%% \item{[3]} Knuth, Donald~E. {\it The METAFONTbook}.
%%    American Mathematical Society \& Addison Weseley, 1986.
%% \item{[4]} Knuth, Donald~E. {\it Computer Modern Typefaces}.
%%    Addison--Weseley, 1992.
%% \item{[5]} Knuth, Donald~E. {\it Digital Typography}.
%%    Center for the Study of Language and Information, 1999.
%% \item{[6]} Hobby, John~D. {\it A Users's Manual for MetaPost\/}.
%%    Dokument dostêpny elektronicznie jako {\tt mpman.ps}.
%% \item{[7]} {\it Uk³ad QX -- kto zacz?\/} Biuletyn \acro{GUST} {\bf9}, 1997.
%% \item{[8]} Bzyl, W³odzimierz. {\it Reintroducing Type~3 Fonts
%%    to the World of {\TeX}}. Biuletyn \acro{GUST} {\bf17}, 2002.

%% \vfil\eject
%% \title{TESTY}
%% \vskip 32bp
%% \font\X=redis-000 at 50bp
%% \baselineskip 60bp
%% \chardef\love=0
%% \centerline{\X :;NAG£ÓWKI:)}
%% \centerline{\X :B¡ÆÊ£ÑÓ¦¬¯:(}
%% \centerline{\X HAMBURGEFONS:O}
%% \centerline{\X KOLOROWY FONT.}
%% \centerline{\X :>THE, ALFABET.}
%% \centerline{\X :!REKLAMA.}
%% \centerline{\X I {\love} TATRAS MTS}
%% \centerline{\X ZA¯Ó£CIÆ, GÊ¦L.}
%%
%% \vfil\eject
%% \baselineskip 25bp \raggedright \hfuzz=100pt \hbadness=10000
%%
%% \section{SAMOG£OSKI}
%% \font\Y=redis-a00 at 18bp \Y

%% GENERATION OF LETTERFORMS BY MATHEMATICAL MEANS WAS FIRST TRIED IN THE
%% FIFTEENTH CENTURY. IT BECAME POPULAR IN THE SIXTEENTH AND SEVENTEENTH
%% CENTURIES. IT WAS ABANDONED, FOR GOOD REASONS, DURING THE
%% EIGHTEENTH CENTURY. PERHAPS THE TWENTIETH CENTURY WILL TURN OUT TO BE
%% THE RIGHT TIME FOR THIS IDEA TO MAKE A COMEBACK, NOW THAT MATHEMATICS
%% HAS ADVANCED AND COMPUTERS ARE ABLE TO DO THE CALCULATIONS.
%%
%% \section{SZALONY REDIS}
%% \font\Z=redis-b00 at 18bp \Z
%%
%% GENERATION OF LETTERFORMS BY MATHEMATICAL MEANS WAS FIRST TRIED IN THE
%% FIFTEENTH CENTURY. IT BECAME POPULAR IN THE SIXTEENTH AND SEVENTEENTH
%% CENTURIES. IT WAS ABANDONED, FOR GOOD REASONS, DURING THE
%% EIGHTEENTH CENTURY. PERHAPS THE TWENTIETH CENTURY WILL TURN OUT TO BE
%% THE RIGHT TIME FOR THIS IDEA TO MAKE A COMEBACK, NOW THAT MATHEMATICS
%% HAS ADVANCED AND COMPUTERS ARE ABLE TO DO THE CALCULATIONS.
%%
%% \vfil\eject
%% \section{ZAKRÊCONY REDIS}
%% \font\V=redis-d00 at 18bp \V
%%
%% GENERATION OF LETTERFORMS BY MATHEMATICAL MEANS WAS FIRST TRIED IN THE
%% FIFTEENTH CENTURY. IT BECAME POPULAR IN THE SIXTEENTH AND SEVENTEENTH
%% CENTURIES. IT WAS ABANDONED, FOR GOOD REASONS, DURING THE
%% EIGHTEENTH CENTURY. PERHAPS THE TWENTIETH CENTURY WILL TURN OUT TO BE
%% THE RIGHT TIME FOR THIS IDEA TO MAKE A COMEBACK, NOW THAT MATHEMATICS
%% HAS ADVANCED AND COMPUTERS ARE ABLE TO DO THE CALCULATIONS.
%%
%% \section{NIEZDECYDOWANY REDIS}
%% \font\W=redis-e00 at 18bp \W
%%
%% GENERATION OF LETTERFORMS BY MATHEMATICAL MEANS WAS FIRST TRIED IN THE
%% FIFTEENTH CENTURY. IT BECAME POPULAR IN THE SIXTEENTH AND SEVENTEENTH
%% CENTURIES. IT WAS ABANDONED, FOR GOOD REASONS, DURING THE
%% EIGHTEENTH CENTURY. PERHAPS THE TWENTIETH CENTURY WILL TURN OUT TO BE
%% THE RIGHT TIME FOR THIS IDEA TO MAKE A COMEBACK, NOW THAT MATHEMATICS
%% HAS ADVANCED AND COMPUTERS ARE ABLE TO DO THE CALCULATIONS.

%%\end

%%%%
%%%%  $Revison:$
%%%%  $Date: 2004/08/23 09:35:44 $
%%%%

%% \input xanthi-format
%% \title{Xanthi Font}

if known included_xanthi: expandafter endinput else: included_xanthi:=1; fi

input xanthi-driver;

%% \section{Elements of the design}

%% The font will be drawn with an elliptical pen.


%% \section{Glyphs}

%% To ease programming and speed up compiling \& testing,
%% programs for similar glyphs are in separate files.
%% Each of the files below could be compiled into font separately.
%% To achieve this I slightly modified metatype1 macros.
%% also on some proofs are shown paths showing the details of the design
%% (see for example the design of the glyph {\it zo\/}).
%% For placing paths on proofs I use new macro {\it just\_paths}.

beginfont

input xanthi-wbzyl;  % the font is incomplete yet, so there is only one file

endfont

%% \end

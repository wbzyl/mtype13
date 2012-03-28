%%%%
%%%%  $Revison:$
%%%%  $Date: 2004/08/24 23:40:18 $
%%%%

%% \input xanthi-format
%% \title{Metric data of Xanthi font}

if known included_xanthi_metric:
  expandafter endinput
else:
  included_xanthi_metric:=1;
fi


%% \section{Metric data: width, height, depth}

set_wht("i")(2u,2u,0);
set_wht("1","2","3","4")(3u,3u,0);

set_wht("s","S")(4u,4u,0);
set_wht("l","L")(0,4u,0);
set_wht("r","R")(4u,4u,0);
set_wht("a","b","A","B")(5u,0,0);

set_wht("v","V")(4u,5u,0);
set_wht("u","U")(4u,4u,0);
set_wht("d","D")(4u,5u,0);

set_wht("T")(4u,4u,0);  % upper right corner


%% \section{Sidebearings}

set_sb("i","1","2","3","4")(u,u);

set_sb("s","S")(u,0);
set_sb("l","L")(0,0);
set_sb("r","R")(u,0);

set_sb("a","b","A","B")(0,0);

set_sb("v","V")(0,0);
set_sb("u","U","d","D")(0,0);

set_sb("T")(0,0);

endinput

%% \end

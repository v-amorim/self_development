\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\@ifl@t@r\fmtversion{2018/04/01}{\UseRawInputEncoding}{}
\ProvidesClass{cv}[2018/07/27 AltaCV v1.1.4, yet another alternative class for a résumé/curriculum vitae.]

\newif\if@academicons
\DeclareOption{academicons}{\@academiconstrue}

\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

\LoadClass{extarticle}

\RequirePackage[margin=2cm]{geometry}
\RequirePackage{fontawesome5}

\if@academicons
	\ExplSyntaxOn
	\msg_redirect_name:nnn { fontspec } { font-not-found } { none }
	\ExplSyntaxOff
	\RequirePackage{academicons}
	\newfontfamily{\AI}{academicons.ttf}
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{heading}{black}
\colorlet{emphasis}{black}
\colorlet{body}{black!80!white}
\newcommand{\itemmarker}{{\small\textbullet}}
\newcommand{\ratingmarker}{\faCircle}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vskip0.25\baselineskip}
\setlist[itemize]{label=\itemmarker}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}

\newenvironment{fullwidth}{%
	\begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
		{\end{adjustwidth}}

\newcommand{\emailsymbol}{\faAt}
\newcommand{\githubsymbol}{\faGithub}
\newcommand{\homepagesymbol}{\faChain}
\newcommand{\linkedinsymbol}{\faLinkedin}
\newcommand{\locationsymbol}{\faMapMarker}
\newcommand{\mailsymbol}{\faEnvelope}
\newcommand{\orcidsymbol}{\aiOrcid}
\newcommand{\phonesymbol}{\faPhone}
\newcommand{\twittersymbol}{\faTwitter}

\newcommand{\printinfo}[2]{\mbox{\textcolor{body}{\normalfont #1}\hspace{0.5em}#2\hspace{2em}}}

\newcommand{\email}[1]{\printinfo{\textcolor{accent}\emailsymbol}{#1}}
\newcommand{\name}[3]{\ifdefstring{#1}{true}{\def\@name{#3}}{\def\@name{#2}}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\github}[2]{\printinfo{\textcolor{accent}\githubsymbol}{\href{#1}{#2}}}
\newcommand{\homepage}[2]{\printinfo{\textcolor{accent}\homepagesymbol}{\href{#1}{#2}}}
\newcommand{\linkedin}[2]{\printinfo{\textcolor{accent}\linkedinsymbol}{\href{#1}{#2}}}
\newcommand{\mailaddress}[2]{\printinfo{\textcolor{accent}\mailsymbol}{\href{#1}{#2}}}
\newcommand{\photo}[2]{\def\@photo{#2}\def\@photodiameter{#1}}
\newcommand{\twitter}[2]{\printinfo{\textcolor{accent}\twittersymbol}{\href{#1}{#2}}}
\newcommand{\location}[3]{\printinfo{\locationsymbol}{\ifdefstring{#1}{true}{#3}{#2}}}
\newcommand{\phone}[3]{\printinfo{\phonesymbol}{\ifdefstring{#1}{true}{#3}{#2}}}


\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}

\newcommand{\makecvheader}{%
	\begingroup
	\ifdef{\@photodiameter}{\begin{minipage}{\dimexpr\linewidth-\@photodiameter-2em}}{}%
			\raggedright\color{emphasis}%
			{\Huge\bfseries\MakeUppercase{\@name}\par}
			\medskip
			{\large\bfseries\color{accent}\@tagline\par}
			\medskip
			{\footnotesize\bfseries\@personalinfo\par}
			\ifdef{\@photodiameter}{%
		\end{minipage}\hfill%
		\begin{minipage}{\@photodiameter}
			\if@normalphoto
				\includegraphics[width=\linewidth]{\@photo}
			\else
				\tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\linewidth];
			\fi%
		\end{minipage}\par}{}%
	\endgroup\medskip
}

\renewenvironment{quote}{\color{accent}\itshape\large}{\par}

\newcommand{\cvtext}[3]{\ifdefstring{#1}{true}{#3}{#2}} % \ifdefstring{#1}{true}{#3}{#2} para ingles/br

\newcommand{\cvsection}[4][]{%
	\bigskip%
	\ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}%
	\ifdefstring{#2}{true}{{\color{heading}\LARGE\bfseries\MakeUppercase{#4}}\\[-1ex]}{{\color{heading}\LARGE\bfseries\MakeUppercase{#3}}\\[-1ex]}
	{\color{headingrule}\rule{\linewidth}{2pt}\par}\medskip
}

\newcommand{\cvsubsection}[3]{%
	\smallskip%
	{\color{emphasis}\large\bfseries{{\ifdefstring{#1}{true}{#3}{#2}}}\par}\medskip
}

\newcommand{\cvevent}[4]{%need to fix english version
	{\large\color{emphasis}\textbf{#1}\par}
	\smallskip\normalsize
	\ifstrequal{#2}{}{}{
		\textbf{\color{accent}#2}\par
		\smallskip}
	\ifstrequal{#3}{}{}{{\small\makebox[0.5\linewidth][l]{\faCalendar\hspace{0.5em}#3}}}%
	\ifstrequal{#4}{}{}{{\small\makebox[0.5\linewidth][l]{\faMapMarker\hspace{0.5em}#4}}}\par
	\medskip
}


\newcommand{\cvachievement}[3]{%
	\begin{tabularx}{\linewidth}{@{}p{2em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
		\multirow{2}{*}{\Large\color{accent}#1} & \bfseries\textcolor{emphasis}{#2} \\
		                                        & #3
	\end{tabularx}%
	\smallskip
}

\newcommand{\cvtag}[3]{%
	\tikz[baseline]\node[anchor=base,draw=body!30,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{\ifdefstring{#1}{true}{#3}{#2}};
}

\newcommand{\cvskill}[4]{%
	\textcolor{emphasis}{\textbf{\ifdefstring{#1}{true}{#3}{#2}}}\hfill
	\foreach \x in {1,...,5}{%
			\space{\ifnumgreater{\x}{#4}{\color{body!30}}{\color{accent}}\ratingmarker}}\par%
}

\newcommand{\cvref}[3]{%
	\smallskip
	\textcolor{emphasis}{\textbf{#1}}\par
	\begin{description}[font=\color{accent},style=multiline,leftmargin=1.25em]
		\item[\normalfont\emailsymbol] #2
		\item[\small\normalfont\mailsymbol] #3
	\end{description}
}

\newenvironment{cvcolumn}[1]{\begin{minipage}[t]{#1}\raggedright}{\end{minipage}}


\RequirePackage{afterpage}
\newcommand{\addsidebar}[2][]{\marginpar{%
		\ifstrequal{#1}{}{}{\vspace*{#1}}%
		\input{#2}}%
}
\newcommand{\addnextpagesidebar}[2][]{\afterpage{\addsidebar[#1]{#2}}}

\AtBeginDocument{%
	\pagestyle{empty}
	\color{body}
	\raggedright
}

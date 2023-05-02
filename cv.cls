\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2023/04/27 Jens Ostertag - CV]

%%%%%%%%%%%%%%%%%%%%%%%%%%
%   LOAD DEFAULT CLASS   %
%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClassWithOptions{article}


%%%%%%%%%%%%%%%%
%   COMMANDS   %
%%%%%%%%%%%%%%%%
\RequirePackage{ifthen}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   DOCUMENT PADDING & INDENTS   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[margin=.9in]{geometry}
\setlength\parindent{0pt}
\setlength\parskip{\baselineskip}


%%%%%%%%%%%%%%%%%%%%%%
%   PAGE NUMBERING   %
%%%%%%%%%%%%%%%%%%%%%%
\pagenumbering{gobble}


%%%%%%%%%%%%%%%%%%%%%%%%%
%   DOCUMENT ENCODING   %
%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[utf8]{inputenc}


%%%%%%%%%%%%%%%%%%%%%%%
%   DOCUMENT COLORS   %
%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{xcolor}

\def\@lightTextColorCode{78716C}
\def\@accentColorCode{EA580C}
\def\@lightAccentColorCode{D6D3D1}

\definecolor{lightTextColor}{HTML}{\@lightTextColorCode}
\definecolor{accentColor}{HTML}{\@accentColorCode}
\definecolor{lightAccentColor}{HTML}{\@lightAccentColorCode}

\newcommand{\setLightTextColor}[1]{
    \def\@lightTextColorCode{#1}
    \definecolor{lightTextColor}{HTML}{\@lightTextColorCode}
}
\newcommand{\setAccentColor}[1]{
    \def\@accentColorCode{#1}
    \definecolor{accentColor}{HTML}{\@accentColorCode}
}
\newcommand{\setLightAccentColor}[1]{
    \def\@lightAccentColorCode{#1}
    \definecolor{lightAccentColor}{HTML}{\@lightAccentColorCode}
}


%%%%%%%%%%%%%%%%%%%%%%
%   DOCUMENT FONTS   %
%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\familydefault}{\sfdefault}


%%%%%%%%%%%%%%%%%%
%   HYPERLINKS   %
%%%%%%%%%%%%%%%%%%
\RequirePackage{hyperref}


%%%%%%%%%%%%%%
%   IMAGES   %
%%%%%%%%%%%%%%
\RequirePackage{graphicx}
\graphicspath{{./img/}}


%%%%%%%%%%%%%
%   ICONS   %
%%%%%%%%%%%%%
\usepackage{fontawesome}


%%%%%%%%%%%%
%   TikZ   %
%%%%%%%%%%%%
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.18}
\usetikzlibrary{calc}
\usetikzlibrary{positioning}
\usetikzlibrary{fit}


%%%%%%%%%%%%%%%%
%   CsQuotes   %
%%%%%%%%%%%%%%%%
\RequirePackage{csquotes}


%%%%%%%%%%%%%
%   TITLE   %
%%%%%%%%%%%%%
\RequirePackage{wrapfig}

\def\@name{}
\def\@address{}
\def\@birthday{}
\def\@email{}
\def\@phone{}
\def\@github{}

\newcommand{\cvName}[1]{
	\def\@name{#1}
}
\newcommand{\cvAddress}[1]{
	\def\@address{#1}
}
\newcommand{\cvBirthday}[1]{
	\def\@birthday{#1}
}
\newcommand{\cvEmail}[1]{
	\def\@email{#1}
}
\newcommand{\cvPhone}[1]{
	\def\@phone{#1}
}
\newcommand{\cvGithub}[1]{
	\def\@github{#1}
}

\renewcommand{\maketitle}{
    \noindent\begin{minipage}{.75\textwidth}
        \LARGE\textbf{Jens Ostertag}\normalsize\\[5mm]
        \begin{tabular}{@{}cl}
            {\color{black}\faMapMarker} & {\color{lightTextColor}\@address}\\
            {\color{black}\faBirthdayCake} & {\color{lightTextColor}\@birthday}\\\\
            {\color{black}\faEnvelope} & {\color{lightTextColor}\href{mailto:\@email}{\@email}}\\
            {\color{black}\faPhone} & {\color{lightTextColor}\@phone}
			\ifthenelse{\equal{\@github}{}}{
			}{
				\\\\
				{\color{black}\faGithub} & {\color{lightTextColor}\href{https://github.com/\@github}{\@github}}
			}
        \end{tabular}
    \end{minipage}
    \hfill
    \begin{minipage}{.2\textwidth}\raggedright
        \includegraphics[width=\textwidth]{avatar}
    \end{minipage}
}


%%%%%%%%%%%%%%%%
%   SECTIONS   %
%%%%%%%%%%%%%%%%
\renewcommand{\section}[2]{
    \noindent\large{\color{accentColor}\textbf{\MakeUppercase{#1}}}\normalsize\\[5mm]
    \input{sections/#2}\ \\[10mm]
}

%%%%%%%%%%%%%%%%%%
%   ITEM TYPES   %
%%%%%%%%%%%%%%%%%%
\newcommand{\itemDescriptionDate}[4]{
    \textbf{#1} {\color{lightTextColor} - \textit{#2}}\\
    {\small\color{lightTextColor}#3\ifthenelse{\equal{#4}{}}{}{ - #4}}
}

\newcommand{\itemDescription}[2]{
    \textbf{#1} {\color{lightTextColor} - \textit{#2}}
}

\newcommand{\itemDate}[3]{
    \textbf{#1}\\
    {\small\color{lightTextColor}#2\ifthenelse{\equal{#3}{}}{}{ - #3}}
}

\newcommand{\itemDetail}[1]{
	\par
%    \hspace{.025\textwidth}
    \begin{minipage}{.05\textwidth}
        \centering
        •
    \end{minipage}
    \begin{minipage}{.95\textwidth}
        #1
    \end{minipage}
    %\hrule
    \vspace{-\baselineskip}
}

%%%%%%%%%%%%%%%%
%   CV ITEMS   %
%%%%%%%%%%%%%%%%
%\RequirePackage[a4paper]{memoir}

\newcounter{cvItemListId}
\setcounter{cvItemListId}{0}

\newcounter{cvItemId}
\setcounter{cvItemId}{0}

\newenvironment{cv-item-list}{
    \addtocounter{cvItemListId}{1}
    \setcounter{cvItemId}{0}
}{
    \setcounter{cvItemId}{0}
}

\newenvironment{cv-item}[1]{
    \begin{minipage}{.05\textwidth}
        \begin{tikzpicture}[remember picture]            
            % Draw Timeline Point
            \node[circle, fill=lightAccentColor, minimum size=3.5mm, inner sep=0] (\thecvItemListId-\thecvItemId) at (1.75mm, 0) {};
        \end{tikzpicture}
    \end{minipage}
    \begin{tikzpicture}[remember picture, overlay]
        % Connect Timeline Points
        \ifthenelse{\thecvItemId = 0}{
            % No connecting Line
            \addtocounter{cvItemId}{1}
        }{
        		\coordinate (newPoint) at (\thecvItemListId-\thecvItemId);
        		\addtocounter{cvItemId}{-1}
        		\coordinate (oldPoint) at (\thecvItemListId-\thecvItemId);
        		\addtocounter{cvItemId}{2}
        		
            % Draw connecting Line from previous Timeline Point
            \draw[-, color=lightAccentColor, line width=.75mm] ($(oldPoint) - (0, 0)$) -- ($(newPoint) - (0, 0)$);
        }
    \end{tikzpicture}
    \begin{minipage}{.95\textwidth}
}{
    \end{minipage}
}
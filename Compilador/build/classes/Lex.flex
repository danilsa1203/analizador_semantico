import compilerTools.Token;

%%
%class Lex
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}
    /* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
ComentarioTradicional = "/*" [^*] ~"*/" | "/*" "*"+ "/"
FinDeLineaComentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
ContenidoComentario = ( [^*] | \*+ [^/*] )*
ComentarioDeDocumentacion = "/**" {ContenidoComentario} "*"+ "/"

/* Comentario */
Comentario = {ComentarioTradicional} | {FinDeLineaComentario} | {ComentarioDeDocumentacion}

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*

/* Número */
Numero = 0 | [1-9][0-9]*
%%

/* Comentarios o espacios en blanco */
{Comentario}|{EspacioEnBlanco} { /*Ignorar*/ }

/* Identificador */
"@" {Identificador} { return token(yytext(), "IDENTIFICADOR", yyline, yycolumn); }

/*Tipos de datos*/
num { return token(yytext(), "TIPO DE DATO", yyline, yycolumn); }

/*Numero*/
{Numero} { return token(yytext(), "NÚMERO", yyline, yycolumn); }

/*Agrupacion*/
"(" { return token(yytext(), "PARÉNTESIS APERTURA", yyline, yycolumn); }
")" { return token(yytext(), "PARÉNTESIS CIERRE", yyline, yycolumn); }
"{" { return token(yytext(), "LLAVE APERTURA", yyline, yycolumn); }
"}" { return token(yytext(), "LLAVE CIERRE", yyline, yycolumn); }
"," { return token(yytext(), "COMA", yyline, yycolumn); }
";" { return token(yytext(), "PUNTO Y COMA", yyline, yycolumn); }

/*Asignacion*/
"->" { return token(yytext(), "ASIGNACIÓN", yyline, yycolumn); }

fun { return token(yytext(), "FUNCIÓN", yyline, yycolumn); }
for { return token(yytext(), "CICLO FOR", yyline, yycolumn); }
while { return token(yytext(), "CICLO WHILE", yyline, yycolumn); }
if | else { return token(yytext(), "CONDICIONAL IF", yyline, yycolumn); }

/* OPERADORES */
"+" { return token(yytext(), "SUMA", yyline, yycolumn); }
"-" { return token(yytext(), "RESTA", yyline, yycolumn); }
"*" { return token(yytext(), "MULTIPLICACIÓN", yyline, yycolumn); }
"/" { return token(yytext(), "DIVISIÓN", yyline, yycolumn); }
"%" { return token(yytext(), "MÓDULO", yyline, yycolumn); }
"=" { return token(yytext(), "IGUAL", yyline, yycolumn); }

/*EXIT*/
"exit" { return token(yytext(), "EXIT", yyline, yycolumn); }

/*Num error*/
0{Numero} { return token(yytext(), "ERROR", yyline, yycolumn); }

/*Identificador error*/
{Identificador} { return token(yytext(), "ERROR", yyline, yycolumn); }

. { return token(yytext(), "ERROR", yyline, yycolumn); }
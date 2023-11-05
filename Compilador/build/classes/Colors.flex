import compilerTools.TextColor;
import java.awt.Color;

%%
%class Colors
%type TextColor
%char
%{
    private TextColor textColor(long start, int size, Color color){
        return new TextColor((int)start, size, color);
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
{Comentario} { return textColor(yychar, yylength(), Color.pink); }
{EspacioEnBlanco} { /*Ignorar*/ }

/* Identificador */
"@" {Identificador} { return textColor(yychar, yylength(), new Color(217, 128, 250)); }

/*Tipos de datos*/
num { return textColor(yychar, yylength(), new Color(18, 203, 196)); }

/*Numero*/
{Numero} { return textColor(yychar, yylength(), new Color(237, 76, 103)); }

/*Agrupacion*/
"(" { return textColor(yychar, yylength(), new Color(131, 52, 113)); }
")" { return textColor(yychar, yylength(), new Color(131, 52, 113)); }
"{" { return textColor(yychar, yylength(), new Color(131, 52, 113)); }
"}" { return textColor(yychar, yylength(), new Color(131, 52, 113)); }
"," { return textColor(yychar, yylength(), new Color(131, 52, 113)); }
";" { return textColor(yychar, yylength(), new Color(131, 52, 113)); }

/*Asignacion*/
"->" { return textColor(yychar, yylength(), new Color(27, 20, 100)); }

fun { return textColor(yychar, yylength(), new Color(255, 195, 18)); }
for { return textColor(yychar, yylength(), new Color(255, 195, 18)); }
while { return textColor(yychar, yylength(), new Color(255, 195, 18)); }
if | else { return textColor(yychar, yylength(), new Color(255, 195, 18)); }


/*Num error*/
0{Numero} { /*Ignorar*/ }

/*Identificador error*/
{Identificador} { /*Ignorar*/ }


. { /* Ignorar */ }
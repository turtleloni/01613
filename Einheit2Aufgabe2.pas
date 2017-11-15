
program merge (input, output);
{ liest ohne Eingabeueberpruefung zwei sortierte Felder mit 
  integer-Zahlen ein; beide Felder werden in einem weiteren Feld
  sortiert zusammengefuegt; das Ergebnis wird ausgegeben; ist 
  die Eingabe unsortiert, so ist das Ergebnisfeld undefiniert }
  const
  FELDLAENGE1 = 5;
  FELDLAENGE2 = 8;
  ERGEBNISFELDLAENGE = 13; { FELDLAENGE1 + FELDLAENGE2 }
        
  type
  tFeld1 = array [1..FELDLAENGE1] of integer;
  tFeld2 = array [1..FELDLAENGE2] of integer;
  tErgebnisFeld = array [1..ERGEBNISFELDLAENGE] of integer;

  var
  Feld1 : tFeld1;
  Feld2 : tFeld2;
  ErgebnisFeld : tErgebnisFeld;
  i : integer;
  j : integer;
  k : integer;
begin
  { sortierte Felder einlesen }
  writeln ('Bitte', FELDLAENGE1:2, ' Werte des ersten Feldes ',
                                         'sortiert eingeben!');
  for i := 1 to FELDLAENGE1 do
    readln (Feld1[i]);
  writeln ('Bitte', FELDLAENGE2:2, ' Werte des zweiten Feldes ',
           'sortiert eingeben!');
  for j := 1 to FELDLAENGE2 do
    readln (Feld2[j]);

  { Verschmelzungsprozess beginnen }
  { Indizes zurücksetzen }
  i := 1;
  j := 1;
  k := 1;
  { Über beide Eingabefelder laufen bis eines "entleert" wurde und 
  jedes mal...}
  while (i <= FELDLAENGE1) and (j <= FELDLAENGE2) do
    { ...den kleineren der beiden Werte in das Ergebnisfeld kopieren }
    if Feld1[i] < Feld2[j] then
    begin
      ErgebnisFeld[k] := Feld1[i];
      i := i + 1;
      k := k + 1
    end
    else
    begin
      ErgebnisFeld[k] := Feld2[j];
      j := j + 1;
      k := k + 1
    end; { while-Schleife }
  { restliche Elemente des noch nicht komplett abgearbeiteten
    Feldes hinter dem Maximum der zuletzt verglichenen
    Werte anhaengen. Wir können beide einfach ausprobieren, 
    auf dem bereits abgearbeiteten Feld gibt es dann 0 Schleifendurchläufe. }
  while j <= FELDLAENGE2 do
  begin
    ErgebnisFeld[k] := Feld2[j];
    k := k + 1;
    j := j + 1
  end;
  while i <= FELDLAENGE1 do
  begin
    ErgebnisFeld[k] := Feld1[i];
    k := k + 1;
    i := i + 1
  end;

  writeln ('Das Ergebnisfeld ist:');
  for k := 1 to ERGEBNISFELDLAENGE do
    write (ErgebnisFeld[k], ' ');
  writeln
end.

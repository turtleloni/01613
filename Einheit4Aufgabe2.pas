program TesteBlattMax (input, output);

type
  tNatZahl = 1..maxint;
  tRefBinBaum = ^tBinBaum;
  tBinBaum = record
               Wert:tNatZahl;
               links:tRefBinBaum;
               rechts:tRefBinBaum
             end;
           
var
  Wurzel : tRefBinBaum;
  blaetterSindMax : Boolean;
  
function BlattMax ( inRefWurzel : tRefBinBaum; inPfadMax : tNatZahl) : Boolean;
  { prüft ob alle Blätter des Baumes die Maxima der Pfade zu ihnen sind }



{ inRefWurzel : zu betrachtender Baum, inPfadMax : aktuelles Maximum des Pfades bis zum Blatt }
  var 
    Max : tNatZahl;
    Knoten : tRefBinBaum;
    Ergebnis : boolean;
  
  begin
    Max := inPfadMax;
    Knoten := inRefWurzel;

    if (Knoten^.links <> nil) or (Knoten^.rechts <> nil) then
    { Blatt nicht erreicht }
    begin	
      if Knoten^.Wert > Max then
      { wenn aktueller wert größer als bisheriges Maximum }
      begin
        Max := Knoten^.Wert
        { aktualisiere Maximum }
      end;
    end
    else
    { Blatt erreicht vergleiche Blatt und Maximum }
    begin
      if Knoten^.Wert < Max then
        Ergebnis := False
      else
        Ergebnis := True;
    end;
    
    if Knoten^.links <> nil then
    { nächster Knoten, linke Seite }
      Ergebnis := BlattMax(Knoten^.links,Max);
        
    if Ergebnis and (Knoten^.rechts <> nil) then
    { wenn linke Seite Bedingung erfüllt dann rechte Seite prüfen }
    { ansonsten Abbruch da gesammt Bedingung nicht erfüllt }
      Ergebnis := BlattMax(Knoten^.rechts,Max);
    
    BlattMax := Ergebnis;

  end; { BlattMax }

procedure BaumAufbauen (var outWurzel : tRefBinBaum) ;
  var 
    index,
    Zahl : integer;
    elter, neuerKnoten : tRefBinBaum;    
     
  function KnotenVonIndex (baum : tRefBinBaum; index : integer) : tRefBinBaum;
    var
      elter : tRefBinBaum;
    begin
      if (index = 1) then
        KnotenVonIndex := baum
      else
      begin
        elter := KnotenVonIndex(baum, index div 2);
        if ( (index mod 2 ) = 0 ) then
          KnotenVonIndex := elter^.links
        else
          KnotenVonIndex := elter^.rechts
      end;
    end;

  begin
    read (index);

    new (outWurzel);
    read (Zahl);
    outWurzel^.Wert := Zahl;

    read (index);
    while (index <> 0) do
    begin            
      elter := KnotenVonIndex(outWurzel, index div 2);
       
      new (neuerKnoten);
      read (Zahl);    
      neuerKnoten^.Wert := Zahl;  

      if ( (index mod 2 ) = 0 ) then
        elter^.links := neuerKnoten
      else
        elter^.rechts := neuerKnoten;
           
      read (index);      
    end;    
  end; { BaumAufbauen }



begin
  writeln('Bitte Baum in level-order eingeben Eingabeformat: Immer erst der Index eines Knotens, dann dessen Wert:');
  BaumAufbauen (Wurzel);
  
  blaetterSindMax := BlattMax(Wurzel, 1);
  
  if blaetterSindMax then
    writeln ('Alle Blaetter sind groesser als alle Knoten auf den jeweiligen Pfaden zu ihnen.')
  else
    writeln ('Mind. ein Blatt ist nicht groesser als alle Knoten auf seinem Pfad.');

end. { TesteBBKnotenzahl }

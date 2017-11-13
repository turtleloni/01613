{$B+}
{$R+}


program TesteSortiereListe(input, output);

  type
  tNatZahl = 0..maxint;
  tRefListe = ^tListe;
  tListe = record
             info : tNatZahl;
             next : tRefListe;
           end;

  var
  RefListe : tRefListe;

  procedure SortiereListe (var ioRefListe : tRefListe);
  { sortiert eine lineare Liste aufsteigend }

		var
		Sortiert, { ende des sortierten teils }
		Zeiger,		{ aktuelles element }
		SortiertDurchlauf, { zählvariable für positionsbestimmung im 
		sortierten teil }
		Vorher : tRefListe; { hilfsvariable zum einsortieren in den 
		sortierten teil }
				
		begin
			Sortiert := ioRefListe;
			SortiertDurchlauf := ioRefListe;
			Zeiger := ioRefListe;
			Vorher := nil;
		
		
		if ioRefListe <> nil then
		begin
			if (ioRefListe <> nil) and (ioRefListe^.next <> nil) then
			{ liste vorhanden, liste größer 1 }
			begin
				while Zeiger^.next <> nil do
				begin
					if Zeiger^.next^.info > Sortiert^.info then
					{ aktuelles element größer als Sortierter Teil }
					begin
						Zeiger := Zeiger^.next;
						Sortiert := Sortiert^.next;
					end
					else
					{ abkoppeln des aktuellen elements }
					begin
						Zeiger := Zeiger^.next;
						Sortiert^.next := Zeiger^.next;
						SortiertDurchlauf := ioRefListe;
						while (Zeiger^.info > SortiertDurchlauf^.info) and
									(SortiertDurchlauf^.next <> nil) and
									(SortiertDurchlauf^.info < Sortiert^.info) do
						{ position im sortierten teil suchen }
						begin
							Vorher := SortiertDurchlauf;
							SortiertDurchlauf := SortiertDurchlauf^.next;
						end; { while position im sortierten teil suchen }
						
						if Vorher <> nil then
						{ wir befinden uns mitten im sortierten teil }
						begin	
							Vorher^.next := Zeiger;
							Zeiger^.next := SortiertDurchlauf;
							Zeiger := Sortiert;
							Vorher := nil; { vorher resetten sonst falsche 
							einordnung }
						end
						else
						{ wir befinden uns am anfang der liste }
						begin	
							Zeiger^.next := ioRefListe;
							ioRefListe := Zeiger;
							Zeiger := Sortiert;
						end;
					end { else abkoppeln und einsortieren }
				end; { while Zeiger^.next nicht nil }
			end; { if liste vorhanden und größer 1 }
		end;
	end; { SortiereListe }



procedure Anhaengen(var ioListe : tRefListe;
                        inZahl : tNatZahl);
{ Haengt inZahl an ioListe an }
  var Zeiger : tRefListe;
begin
  Zeiger := ioListe;
  if Zeiger = nil then
  begin
    new(ioListe);
    ioListe^.info := inZahl;
    ioListe^.next := nil;
  end
  else
  begin
    while Zeiger^.next <> nil do
      Zeiger := Zeiger^.next;
    { Jetzt zeigt Zeiger auf das letzte Element }
    new(Zeiger^.next);
    Zeiger := Zeiger^.next;
    Zeiger^.info := inZahl;
    Zeiger^.next := nil;
  end;
end;

procedure ListeEinlesen(var outListe:tRefListe);
{ liest eine durch Leerzeile abgeschlossene Folge von Integer-
  Zahlen ein und speichert diese in der linearen Liste RefListe. }
  var
  Liste : tRefListe;
  Zeile : string;
  Zahl, Code : integer;
begin
  writeln('Bitte geben Sie die zu sortierenden Zahlen ein.');
  writeln('Beenden Sie Ihre Eingabe mit einer Leerzeile.');
  Liste := nil;
  readln(Zeile);
  val(Zeile, Zahl, Code); { val konvertiert String nach Integer }
  while Code=0 do
  begin
    Anhaengen(Liste, Zahl);
    readln(Zeile);
    val(Zeile, Zahl, Code);
  end; { while }
  outListe := Liste;
end; { ListeEinlesen }

procedure GibListeAus(inListe : tRefListe);
{ Gibt die Elemente von inListe aus }
  var Zeiger : tRefListe;
  begin
  Zeiger := inListe;
  while Zeiger <> nil do
  begin
    writeln(Zeiger^.info);
    Zeiger := Zeiger^.next;
  end; { while }
end; { GibListeAus }

begin
  ListeEinlesen(RefListe);
  SortiereListe(RefListe);
  GibListeAus(RefListe)
end.

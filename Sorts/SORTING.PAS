program privet(input, output);

uses sortdate;

const
  n = 100;
  l = 5;

var
  a: arraydate;

procedure inpdata(var a: arraydate);
  var
    i: integer;
    j: byte;
    s1,s2,s3: string[2];
  begin
    for i := 1 to l do
      begin
        j := random(n);
        str(j, s1);
        if j < 10 then
          s1 := '0' + s1;
        j := random(n);
        str(j, s2);
        if j < 10 then
          s2 := '0' + s2;
        j := random(n);
        str(j, s3);
        if j < 10 then
          s3 := '0' + s3;
        a[i] := s1 + '.'+ s2 + '.' + s3;
      end;
  end;

procedure outpdata(var a: arraydate);
  var
    i: integer;
  begin
    for i := 1 to l do
      write(a[i], ' ');
    writeln('!');
  end;

begin
  lengthar := 5;
  randomize;
  inpdata(a);
  outpdata(a);
  sortbinin(a);
  outpdata(a);
  writeln('-----');
  inpdata(a);
  outpdata(a);
  sortbub(a);
  outpdata(a);
  writeln('-----');
  inpdata(a);
  outpdata(a);
  sortsiev(a);
  outpdata(a);
  writeln('-----');
  inpdata(a);
  outpdata(a);
  sortsimch(a);
  outpdata(a);
  writeln('-----');
  inpdata(a);
  outpdata(a);
  sortsimin(a);
  outpdata(a);
  writeln('-----');
  readln;
end.
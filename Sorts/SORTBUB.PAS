program sortbub(input, output);

const
  n = 15;

type
  array1 = array [1..n] of integer;

var
  a: array1;

procedure inpdata(var a: array1);
  var
    i: integer;
  begin
    randomize;
    for i := 1 to n do
      a[i] := random(n);
  end;

procedure outpdata(var a: array1);
  var
    i: integer;
  begin
    for i := 1 to n do
      write(a[i], ' ');
    writeln;
  end;

procedure replace(var k, l: integer);
  var
    q: integer;
  begin
    q := k;
    k := l;
    l := q;
  end;

procedure sort(var a: array1);
  var
    i, j: integer;
    ok: boolean;
  begin
    i := n;
    ok := false;
    while (i > 1) and not ok do
      begin
        ok := true;
        for j := 1 to i - 1 do
          if a[j] > a[j+1] then
            begin
              replace(a[j], a[j+1]);
              ok := false;
            end;
        i := i - 1;
      end;
  end;

begin
  inpdata(a);
  outpdata(a);
  sort(a);
  outpdata(a);
  readln;
end.
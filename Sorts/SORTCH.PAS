program sortch(input, output);

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
    i, j, min, k: integer;
  begin
    for i := 1 to  n - 1 do
      begin
        min := a[i];
        k := i;
        for j := i + 1 to n do
          if a[j] < min then
            begin
              min := a[j];
              k := j;
            end;
        replace(a[i], a[k]);
      end;
  end;

begin
  inpdata(a);
  outpdata(a);
  sort(a);
  outpdata(a);
  readln;
end.
program sortscr(input, output);         

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
    for i := 1 to  n - 1 do
      begin
        if a[i] > a[i+1] then
          begin
            j := i + 1;
            repeat
              replace(a[j], a[j-1]);
              j := j - 1;
              if j = 1 then
                break;
            until a[j] >= a[j-1];
          end;
      end
  end;

begin
  inpdata(a);
  outpdata(a);
  sort(a);
  outpdata(a);
  readln;
end.
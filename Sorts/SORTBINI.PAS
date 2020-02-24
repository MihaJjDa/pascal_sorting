program sortbinin(input, output);

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

function lookforin(var a: array1; i: integer): integer;
  var
    j, k: integer;
  begin
    j := i div 2;
    k := i div 2;
    if j > 1 then
      repeat
        if k > 1 then
          k := k div 2;
        if a[i] < a[j-1] then
          j := j - k
        else
          j := j + k;
        if (j = 1) then
          break;
      until (a[j-1] <= a[i]) and (a[i] < a[j]);
    lookforin := j;
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
  begin
    for i := 2 to n do
      if a[i] < a[i-1] then
        begin
          j := lookforin(a, i);
          if j = 1 then
            if a[i] > a[1] then
              for j := i downto 3 do
                replace(a[j], a[j-1])
            else
              for j := i downto 2 do
                replace(a[j], a[j-1])
          else
            for j := i downto j + 1 do
              replace(a[j], a[j-1]);
        end;
  end;

begin
  inpdata(a);
  outpdata(a);
  sort(a);
  outpdata(a);
  readln;
end.
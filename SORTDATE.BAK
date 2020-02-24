unit sortdate;

interface

  type
    date = string[8];
    arraydate = array [1..255] of date;   {ИЗМЕНИТЬ 1 НА 0 !!!}

  var
    lengthar: byte;

  procedure SortBinIn(var a: arraydate);
    {Sorting by binary inserts}

  procedure SortBub(var a: arraydate);
    {Bubble sorting}

  procedure SortSimCh(var a: arraydate);
    {Sorting by Simple Choice}

  procedure SortSiev(var a: arraydate);
    {Sorting by Sieving}

  procedure SortSimIn(var a: arraydate);
    {Sorting by Simple Inserts}

implementation

  function dateinstr(var s: date): date;
    {Date into string}
    {Функция переводит строку S из формата dd.mm.yy в формат yy.mm.dd
     для удобного сравнения}
    begin
      dateinstr := copy(s, 7, 2) + '.' + copy(s, 4, 2) + '.' + copy(s, 1, 2);
    end;

  procedure ardateins(var a: arraydate);
    {Array of Dates into String}
    var
      i: integer;
    begin
      for i := 1 to lengthar do
        a[i] := dateinstr(a[i]);
    end;

  procedure ReplDate(var k, l: date);
    {Replace Dates}
    var
      q: date;
    begin
      q := k;
      k := l;
      l := q;
    end;

  procedure SortBinIn(var a: arraydate);
  {Sorting by Bynary Inserts}
    var
      i, j: integer;
    function lookforin: integer;
      var
        k: integer;
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
            if j = 1 then
              break;
          until (a[j-1] <= a[i]) and (a[i] < a[j]);
        lookforin := j;
      end;
    begin
      ardateins(a);
      for i := 2 to lengthar do
        if a[i] < a[i-1] then
          begin
            j := lookforin;
            if j = 1 then
              if a[1] < a[i] then
                for j := i downto 3 do
                  repldate(a[j], a[j-1])
              else
                for j := i downto 2 do
                  repldate(a[j], a[j-1])
            else
              for j := i downto j + 1 do
                repldate(a[j], a[j-1]);
          end;
      ardateins(a);
    end;

  procedure SortBub(var a: arraydate);
  {Bubble Sorting}
    var
      i, j: integer;
      ok: boolean;
    begin
      ardateins(a);
      i := lengthar;
      ok := false;
      while (i > 1) and not ok do
        begin
          ok := true;
          for j := 1 to i - 1 do
            if a[j+1] < a[j] then
              begin
                repldate(a[j], a[j+1]);
                ok := false;
              end;
          inc(i);
        end;
      ardateins(a);
    end;

  procedure SortSimCh(var a: arraydate);
  {Sorting by Simple Choice}
    var
      i, j, k: integer;
      min: date;
    begin
      ardateins(a);
      for i := 1 to lengthar - 1 do
        begin
          min := a[i];
          k := i;
          for j := i + 1 to lengthar do
            if a[j] < min then
              begin
                min := a[j];
                k := j;
              end;
          repldate(a[i], a[k]);
        end;
      ardateins(a);
    end;

  procedure SortSiev(var a: arraydate);
  {Sorting by Sieving}
    var
      i, j: integer;
      ok: boolean;
    begin
      ardateins(a);
      for i := 1 to lengthar - 1 do
        begin
          if a[i+1] < a[i] then
            begin
              j := i + 1;
              repeat
                repldate(a[j], a[j-1]);
                dec(j);
                if j = 1 then
                  break;
              until a[j-1] <= a[j];
            end;
        end;
      ardateins(a);
    end;

  procedure SortSimIn(var a: arraydate);
  {Sorting by Simple Inserts}
    var
      i, j: integer;
    function lookforin: integer;
      begin
        j := i;
        repeat
          dec(j);
          if j = 1 then
            break;
        until (a[j-1] <= a[i]) and (a[i] < a[j]);
        lookforin := j;
      end;
    begin
      ardateins(a);
      for i := 2 to lengthar do
        if a[i] < a[i-1] then
          begin
            j := lookforin;
            if j = 1 then
              if a[1] < a[i] then
                for j := i downto 3 do
                  repldate(a[j], a[j-1])
              else
                for j := i downto 2 do
                  repldate(a[j], a[j-1])
            else
              for j := i downto j + 1 do
                repldate(a[j], a[j-1]);
          end;
      ardateins(a);
    end;

end.
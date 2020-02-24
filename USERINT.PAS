unit userint;

interface

  uses crt, crt1;

  const
    up =        #72;
    down =      #80;
    left =      #75;
    right =     #77;
    enter =     #13;
    del =       #83;
    backspace = #8;
    ins =       #82;
    esc =       #27;
    keyend =    #79;
    home =      #71;
    f1 =        #59;

  type
    setofkeys = set of char;

  procedure putfield(x, y, n: byte; s: string);

  procedure getfield(x, y, n: byte; var s: string);

  procedure paintfield(x, y, n, a: byte);

  procedure readfield(x, y, n: byte; stopkeys: setofkeys; var s: string; var key: char);

  procedure makeframe(x1, y1, x2, y2: byte);

implementation

  procedure putfield(x, y, n: byte; s: string);
    var
      i: byte;
    begin
      for i := 1 to length(s) do
        putch(x + i - 1, y, s[i]);
      for i := length(s) + 1 to n do
        putch(x + i - 1, y, ' ');
    end;

  procedure getfield(x, y, n: byte; var s: string);
    var
      i: byte;
    begin
      s[0] := chr(n);
      for i := 1 to n do
        s[i] := getch(x + i - 1, y);
    end;

  procedure paintfield(x, y, n, a: byte);
    var
      i: byte;
    begin
      for i := 1 to n do
        putattr(x + i - 1, y, a);
    end;

  procedure crson1(a: byte); assembler;
    asm
      mov ch, a
      mov cl, 0Fh
      mov ah, 1
      int 10H
    end;

  procedure readfield(x, y, n: byte; stopkeys: setofkeys; var s: string; var key: char);
    var
      a, i: byte;
      insmode, spec: boolean;
    begin
      a := x;
      gotoxy(a, y);
      crson1(0);
      insmode := false;
      repeat
        inkey(key, spec);
        if spec then
          begin
            if key in stopkeys then
              begin
                getfield(x, y, n, s);
                crsoff;
                exit;
              end;
            case key of
              left:      if a > x then
                           dec(a);
              right:     if a < x + n - 1 then
                           inc(a);
              del:       begin
                           for i := a + 1 to x + n - 1 do
                             putch(i - 1, y, getch(i, y));
                           putch(x + n - 1, y, ' ');
                         end;
              backspace: if a > x then
                           begin
                             for i := a to x + n - 1 do
                               putch(i - 1, y, getch(i, y));
                             putch(x + n - 1, y, ' ');
                             dec(a);
                           end;
              ins:       begin
                           insmode := not insmode;
                           crsoff;
                           if insmode then
                             crson1(14)
                           else
                             crson1(0);
                         end;
              keyend:    a := x + n - 1;
              home:      a := x;
            end;
          end
        else
          if insmode then
            begin
              for i := x + n - 2 downto a do
                putch(i + 1, y, getch(i, y));
              putch(a, y, key);
              if a < x + n - 1 then
                inc(a);
            end
          else
            begin
              putch(a, y, key);
              if a < x + n - 1 then
                inc(a);
            end;
        gotoxy(a, y);
      until false;
  end;

  procedure makeframe(x1, y1, x2, y2: byte);
    var
      a, b, c, d, i: byte;
    begin
      windcoord(a, b, c, d);
      window(x1, y1, x2, y2);
      clrscr;
      putch(1, 1, #201);
      putch(1, y2 - y1 + 1, #200);
      putch(x2 - x1 + 1, 1, #187);
      putch(x2 - x1 + 1, y2 - y1 + 1, #188);
      for i := 2 to x2 - x1 do
        begin
          putch(i, 1, #205);
          putch(i, y2 - y1 + 1, #205);
        end;
      for i := 2 to y2 - y1 do
        begin
          putch(1, i, #186);
          putch(x2 - x1 + 1, i, #186);
        end;
      window(a, b, c, d);
    end;

end.

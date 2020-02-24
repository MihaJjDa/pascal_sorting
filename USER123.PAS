program user123;

uses crt, crt1, userint, sortdate;

const
  tbg = black;
  tc = white;
  meth: byte = 0;
  mode: byte = 0;
  len: byte = 0;
  menux1 = 1;
  menux2 = 28;
  menux3 = 55;
  menuy = 1;
  menuf = 27;
  set1x = 1;
  set2x = 38;
  set3x = 56;
  sety = 24;
  set1f = 32;
  set2f = 14;
  set3f = 16;
  methx1 = 8;
  methy1 = 6;
  methx2 = 39;
  methy2 = 17;
  methf = 32;
  lenx1 = 47;
  leny1 = 6;
  lenx2 = 72;
  leny2 = 6;
  lenf = 26;
  modex1 = 47;
  modey1 = 11;
  modex2 = 59;
  modey2 = 14;
  modef = 13;
  stopkeys: setofkeys = [enter, esc];

  procedure initmenu;
    var
      i: integer;
    begin
      crsoff;
      window(1, 1, 80, 25);
      textbackground(tbg);
      textcolor(tc);
      clrscr;
      putfield(menux1, menuy, menuf, '           Метод');
      putfield(menux2, menuy, menuf, '           Работа');
      putfield(menux3, menuy, menuf - 1, '          Выход');
      for i := 1 to 80 do
        begin
          putch(i, menuy + 1, #205);
          putch(i, sety - 2, #205);
        end;
      putfield(set1x, sety - 1, set1f, 'Метод сортировки:');
      putfield(set1x, sety, set1f, 'Не выбран');
      putfield(set2x, sety - 1, set2f, 'Режим работы:');
      putfield(set2x, sety, set2f, 'Не выбран');
      putfield(set3x, sety - 1, set3f, 'Длина массива:');
      putfield(set3x, sety, set3f, 'Не выбрана');
      paintfield(1, 1, 27, tbg + 16 * tc);
      paintfield(1, 25, 80, black + 16 * lightgray);
    end;

  procedure movemenu(var x: byte; y: byte; var n: byte; key: char);
    begin
      paintfield(x, y, n, tc + 16 * tbg);
      case key of
        left:  if x = menux1 then
                 x := menux3
               else
                  x := x - menuf;
        right: if x = menux3 then
                 x := menux1
               else
                 x := x + menuf;
      end;
      if x = menux3 then
        n := menuf - 1
      else
        n := menuf;
      paintfield(x, y, n, tbg + 16 * tc);
    end;

  procedure initmeth(meth: byte);
    var
      i: integer;
    begin
      makeframe(methx1 - 1, methy1 - 1, methx2 + 1, methy2 + 1);
      window(methx1, methy1, methx2, methy2);
      putfield(1, 1, methf, 'Методы сортировки');
      for i := 1 to methf do
        putch(i, 2, #205);
      putfield(1, 3, methf, 'Сортировка простыми вставками');
      putfield(1, 4, methf, 'Сортировка бинарными вставками');
      putfield(1, 5, methf, 'Метод пузырька');
      putfield(1, 6, methf, 'Челночная сортировка');
      putfield(1, 7, methf, 'Сортировка простым выбором');
      putfield(1, 8, methf, 'Метод Шелла');
      putfield(1, 9, methf, 'Быстрая сортировка (рек.)');
      putfield(1, 10, methf, 'Быстрая сортировка (нерек.)');
      putfield(1, 11, methf, 'Сортировка простым слиянием');
      putfield(1, 12, methf, 'Сортировка естественным слиянием');
      if meth > 0 then
        paintfield(1, meth + 2, methf, tbg + 16 * lightgray);
    end;

  procedure initlen(len, mode: byte);
    var
      i, maxlen: byte;
      sl, sml: string;
    begin
      makeframe(lenx1 - 1, leny1 - 1, lenx2 + 1, leny2 + 1);
      window(lenx1, leny1, lenx2, leny2);
      case mode of
        0: maxlen := 255;
        1: maxlen := 15;
        2: maxlen := 100;
      end;
      str(len, sl);
      str(maxlen, sml);
      putfield(1, 1, lenf, 'Длина массива (<=' + sml + '): ' + sl);
    end;

  procedure initmode(mode: byte);
    var
      i: byte;
    begin
      makeframe(modex1 - 1, modey1 - 1, modex2 + 1, modey2 + 1);
      window(modex1, modey1, modex2, modey2);
      putfield(1, 1, modef, 'Режимы работы');
      for i := 1 to modef do
        putch(i, 2, #205);
      putfield(1, 3, modef, 'Отладка');
      putfield(1, 4, modef, 'Счет');
      if mode > 0 then
        paintfield(1, mode + 2, modef, tbg + 16 * lightgray);
    end;

  procedure initset(meth, mode, len: byte);
    var
      i: byte;
    begin
      initmeth(meth);
      initlen(len, mode);
      initmode(mode);
    end;

  procedure initwork(mode, len: byte);
    var
      i: integer;
    begin
      clrscr;
    end;

  procedure initwin(item, meth, mode, len: byte);
    begin
      window(1, 3, 80, 21);
      clrscr;
      case item of
        1: initset(meth, mode, len);
        2: initwork(mode, len);
        3: clrscr;
      end;
      window(1, 1, 80, 25);
    end;

  procedure helpstr(item: byte);
    var
      a, b, c, d: byte;
      s: string;
    begin
      windcoord(a, b, c, d);
      window(1, 25, 80, 25);
      paintfield(1, 1, 80, tbg + 16 * lightgray);
      case item of
        0: putfield(1, 1, 80, 'Выберите раздел: Left, Right - сдвиг; Enter - выбор; Esc - выход');
        1: putfield(1, 1, 80, 'Выберите раздел: Left, Right, Up, Down - сдвиг; Enter - выбор; Esc - назад');
        2: putfield(1, 1, 80, 'Выберите метод сортировки: Up, Down - сдвиг; Enter - выбор; Esc - назад');
        3: putfield(1, 1, 80, 'Выберите режим работы: Up, Down - сдвиг; Enter - выбор; Esc - назад');
        4: putfield(1, 1, 80, 'Введите длину массива: Enter - принять; Esc - назад');
        5: begin
             paintfield(1, 1, 80, tbg + 16 * red);
             putfield(1, 1, 80, 'Ошибка ввода! Enter - продолжить');
           end;
      end;
      window(a, b, c, d);
    end;

  procedure moveset(var x, y, n, item: byte; key: char);
    begin
      paintfield(x, y, n, tc + 16 * tbg);
      case key of
        up, down:     if x = 47 then
                        begin
                          if y = 6 then
                             begin
                              y := 11;
                              item := 3;
                            end
                          else
                            begin
                              y := 6;
                              item := 2;
                            end;
                        end
                      else
                        begin
                          x := 47;
                          y := 11;
                          n := 13;
                          item := 3;
                        end;
        left, right:  if y = 6 then
                        begin
                          if x = 47 then
                            begin
                              x := 8;
                              n := 32;
                              item := 1;
                            end
                          else
                            begin
                              x := 47;
                              n := 13;
                              item := 2;
                            end;
                        end
                      else
                        begin
                          x := 8;
                          y := 6;
                          n := 32;
                          item := 1;
                        end;
      end;
      paintfield(x, y, n, tbg + 16 * tc);
    end;

  procedure movemeth(x: byte; var y: byte; n, item: byte; key: char);
    begin
      if y <> item then
        paintfield(x, y, n, tc + 16 * tbg)
      else
        paintfield(x, y, n, tbg + 16 * tc);
      case key of
        up:   if y = 1 then
                y := 10
              else
                dec(y);
        down: if y = 10 then
                y := 1
              else
                inc(y);
      end;
      paintfield(x, y, n, tbg + 16 * tc);
    end;

  procedure chmeth(var meth: byte);
    var
      key: char;
      spec: boolean;
      a, b, c, d, e, f, n, item: byte;
    begin
      helpstr(2);
      window(8, 8, 39, 17);
      a := 1;
      n := 32;
      item := meth;
      if item > 0 then
        begin
          b := item;
          paintfield(a, item, n, tbg + 16 * tc);
        end
      else
        begin
          b := 1;
          paintfield(a, b, n, tbg + 16 * tc);
        end;
      repeat
        inkey(key, spec);
        if spec then
          case key of
            up, down: begin
                        movemeth(a, b, n, item, key);
                      end;
            enter:    begin
                        if item = b then
                          item := 0
                        else
                          begin
                            if item > 0 then
                              paintfield(a, item, n, tc + 16 * tbg);
                            item := b;
                          end;
                        windcoord(c, d, e, f);
                        window(1, 1, 80, 25);
                        case item of
                          0:  putfield(set1x, sety, set1f, 'Не выбран');
                          1:  putfield(set1x, sety, set1f, 'Сортировка простыми вставками');
                          2:  putfield(set1x, sety, set1f, 'Сортировка бинарными вставками');
                          3:  putfield(set1x, sety, set1f, 'Метод пузырька');
                          4:  putfield(set1x, sety, set1f, 'Челночная сортировка');
                          5:  putfield(set1x, sety, set1f, 'Сортировка простым выбором');
                          6:  putfield(set1x, sety, set1f, 'Метод Шелла');
                          7:  putfield(set1x, sety, set1f, 'Быстрая сортировка (рек.)');
                          8:  putfield(set1x, sety, set1f, 'Быстрая сортировка (нерек.)');
                          9:  putfield(set1x, sety, set1f, 'Сортировка простым слиянием');
                          10: putfield(set1x, sety, set1f, 'Сортировка естественным слиянием');
                        end;
                        window(c, d, e, f);
                      end;
            esc:      begin
                        paintfield(a, b, n, tc + 16 * tbg);
                        if item > 0 then
                          paintfield(a, item, n, tbg + 16 * lightgray);
                        window(1, 1, 80, 21);
                        meth := item;
                        exit;
                      end;
          end;
          if (item > 0) and (item <> b) then
            paintfield(a, item, n, tbg + 16 * lightgray);
      until false;
    end;

  procedure movemode(x: byte; var y: byte; n, item: byte; key: char);
    begin
      if y <> item then
        paintfield(x, y, n, tc + 16 * tbg)
      else
        paintfield(x, y, n, tbg + 16 * tc);
      case key of
        up:   if y = 1 then
                y := 2
              else
                dec(y);
        down: if y = 2 then
                y := 1
              else
                inc(y);
      end;
      paintfield(x, y, n, tbg + 16 * tc);
    end;

  procedure chmode(var mode: byte);
    const
      a: byte = 1;
      b: byte = 1;
      n: byte = modef;
    var
      c, d, e, f, item: byte;
      key: char;
      spec: boolean;
    begin
      helpstr(3);
      window(modex1, modey1 + 2, modex2, modey2);
      item := mode;
      if item > 0 then
        paintfield(a, item, n, tbg + 16 * tc)
      else
        paintfield(a, b, n, tbg + 16 * tc);
      repeat
        inkey(key, spec);
        if spec then
          case key of
            up, down: begin
                        movemode(a, b, n, item, key);
                      end;
            enter:    begin
                        if item = b then
                          item := 0
                        else
                          begin
                            if item > 0 then
                              paintfield(a, item, n, tc + 16 * tbg);
                            item := b;
                          end;
                        windcoord(c, d, e, f);
                        window(1, 1, 80, 25);
                        case item of
                          0:  putfield(set2x, sety, set2f, 'Не выбран');
                          1:  putfield(set2x, sety, set2f, 'Отладка');
                          2:  putfield(set2x, sety, set2f, 'Счет');
                        end;
                        window(c, d, e, f);
                      end;
            esc:      begin
                        paintfield(a, b, n, tc + 16 * tbg);
                        if item > 0 then
                          paintfield(a, item, n, tbg + 16 * lightgray);
                        mode := item;
                        window(lenx1+14, leny1, lenx2-3, leny1);
                        case mode of
                          0: putfield(1, 1, 7, '(<=255)');
                          1: putfield(1, 1, 7, '(<=15)');
                          2: putfield(1, 1, 7, '(<=100)');
                        end;
                        window(1, 1, 80, 21);
                        exit;
                      end;
          end;
          if (item > 0) and (item <> b) then
            paintfield(a, item, n, tbg + 16 * lightgray);
      until false;
    end;

  procedure chlen(var len: byte; mode: byte); {Change length}
    var
      x, code: integer;
      s, s1: string;
      key: char;
      spec, ok: boolean;
      xr: byte;
    begin
      helpstr(4);
      getfield(lenx2 - 2, leny1, 3, s1);
      case mode of
        0: xr := 255;
        1: xr := 15;
        2: xr := 100;
      end;
      repeat
        readfield(lenx2 - 2, leny1, 3, stopkeys, s, key);
        if key = enter then
          begin
            if s[3] = ' ' then
              begin
                delete(s, 3, 1);
                if s[2] = ' ' then
                  delete(s, 2, 1);
              end;
            val(s, x, code);
            ok := (code = 0) and (x >= 1) and (x <= xr);
            if not ok then
              begin
                helpstr(5);
                repeat
                  inkey(key, spec);
                until (spec = true) and (key = enter);
                helpstr(4);
              end
            else
              begin
                len := x;
                if s[1] = '0' then
                  begin
                    s := copy(s, 2, 2);
                    if s[1] = '0' then
                      s := copy(s, 2, 1);
                  end;
                window(1, 1, 80, 25);
                putfield(set3x, sety, set3f, s);
                window(1, 1, 80, 21);
              end;
          end
        else
          begin
            ok := true;
            putfield(lenx2 - 2, leny1, 3, s1);
          end;
      until ok;
    end;

  procedure chset(var meth, mode, len: byte);
    var
      a, b, n, item: byte;
      key: char;
      spec: boolean;
    begin
      a := methx1;
      b := methy1;
      n := methf;
      item := 1;
      paintfield(8, 6, 32, tbg + 16 * tc);
      repeat
        helpstr(1);
        inkey(key, spec);
        if spec then
          case key of
            f1:                    {help};
            left, right, up, down: moveset(a, b, n, item, key);
            enter:                 begin
                                     paintfield(a, b, n, tbg + 16 * lightgray);
                                     case item of
                                       1: chmeth(meth);
                                       2: chlen(len, mode);
                                       3: chmode(mode);
                                     end;
                                     paintfield(a, b, n, tbg + 16 * tc);
                                   end;
            esc:                   begin
                                     paintfield(a, b, n, tc + 16 * tbg);
                                     paintfield(methx1, methy1, methf, tc + 16 * tbg);
                                     exit;
                                   end;
          end;
      until false;
    end;

const
  a: byte = menux1;
  b: byte = menuy;
  n: byte = menuf;
  item: byte = 1;

var
  key: char;
  spec: boolean;
begin
  initmenu;
  initwin(item, meth, mode, len);
  repeat
    helpstr(0);
    inkey(key, spec);
    if spec then
      case key of
        f1:          {help};
        left, right: begin
                       movemenu(a, b, n, key);
                       item := a div 27 + 1;
                       initwin(item, meth, mode, len);
                     end;
        enter:       begin
		       paintfield(a, b, n, tbg + 16 * lightgray);
                       helpstr(item);
                       case item of
                         1: chset(meth, mode, len);
                         2: ;
                         3: exit;
                       end;
                       paintfield(a, b, n, tbg + 16 * tc);
                     end;
        esc:         exit;
      end;
  until false;
  window(1, 1, 80, 15);
  textbackground(black);
  textcolor(black + 16 * white);
  clrscr;
  crson;
end.
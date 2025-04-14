library common_lib;
context common_lib.common_context;

use std.textio.line;
use std.textio.write;

package linked_list is
  generic (
    type ElementT;
    function ToStringF(item: ElementT) return string
  );

  type LList is protected 
    impure function Count return integer;
    procedure AddFirst(item: ElementT);
    impure function GetAt(index: integer) return ElementT;
    procedure RemoveAt(index: integer);
    impure function Dump return string;
  end protected LList;
end package;

package body linked_list is
  type Entry;
  type Link is access Entry;
  type Entry is record
    element: ElementT;
    link: Link;
  end record;

  type LList is protected body
    variable head: Link := null;

    impure function Count return integer is
      variable element: Link := head;
      variable count: integer := 0;
    begin
      while element /= null loop
        count := count + 1;
        element := element.link;    
      end loop;
      return count;
    end function Count;

    procedure AddFirst(item: ElementT) is
      variable e: Link := new Entry;
    begin
      e.element := item;
      e.link := head;
      head := e;
    end procedure;

    impure function Find(index: integer) return Link is
      variable el: Link := head;
      variable counter: integer := 0;
    begin
      while counter < index and el /= null loop
        counter := counter + 1;
        el := el.link;
      end loop;
      return el;
    end function;
  
    impure function GetAt(index: integer) return ElementT is
      variable el: Link := head;
      variable default_ret: ElementT;
    begin
      el := Find(index);

      if el /= null then
        return el.element;
      else
        Alert("GetAt: index out of range");
        return default_ret;
      end if;
    end function;

    procedure RemoveAt(index: integer) is
      variable prev: Link := Find(index - 1);
      variable current: Link := Find(index);
    begin
      if prev /= null then
        prev.link := Find(index + 1);
      end if;
      if current /= null then
        deallocate(current);
      end if;
    end procedure;

    impure function Dump return string is
      variable el: Link := head;
      variable ret: line;
    begin
      write(ret, string'("LList: ["));
      while el /= null loop
        write(ret, ToStringF(el.element) & ", ");
        el := el.link;
      end loop;
      write(ret, string'("]"));
      return ret.all;
    end function;

  end protected body;
end package body;

library common_lib;
context common_lib.common_context;

entity ex4 is
end entity;

architecture behav of ex4 is

  type PrimeRecT is record
    Number: integer;
    IsPrime: boolean;
  end record;

  function ToString(item: PrimeRecT) return string is
  begin
    return "Prime {number: " & to_string(item.Number) & ", is_prime: " & to_string(item.IsPrime) & "}";
  end function;

  function prime(n: integer; p: boolean) return PrimeRecT is
    variable ret: PrimeRecT;
  begin
    ret.Number := n;
    ret.IsPrime := p;
    return ret;
  end function;
  
  package PrimeLL is new work.linked_list generic map(PrimeRecT, ToString);
  
begin

  stimuli_p: process is
    variable list: PrimeLL.LList;
  begin
    wait for 0 ns;
    AffirmIfEqual(list.Count, 0);

    list.AddFirst(prime(1, true));
    list.AddFirst(prime(5, true));
    list.AddFirst(prime(8, false));
    AffirmIfEqual(list.Count, 3);

    AffirmIfEqual(list.GetAt(0).Number, 8);
    AffirmIfEqual(list.GetAt(1).Number, 5);
    AffirmIfEqual(list.GetAt(2).Number, 1);
    AffirmIfEqual(list.GetAt(2).IsPrime, true);

    list.RemoveAt(1);
    AffirmIfEqual(list.Count, 2);
    AffirmIfEqual(list.GetAt(1).number, 1);

    -- Gain coverage for out of range errors (can I assert this fails somehow?)
    AffirmIfEqual(list.GetAt(20).number, integer'left);
    list.RemoveAt(5);

    Log(list.Dump);
    Log("**********************************");
    ReportAlerts;
    std.env.stop;
    wait ; 
  end process;

end architecture;
  

library common_lib;
context common_lib.common_context;

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
    variable head: Link;

    impure function Count return integer is
      variable element: Link := head;
      variable count: integer := 0;
    begin
      while element.link /= null loop
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

    impure function GetAt(index: integer) return ElementT is
      variable count: integer := 0;
      variable el: Link := head;
      variable default_ret: ElementT;
    begin
      while count < index and el.link /= null loop
        count := count + 1;
        el := el.link;
      end loop;
      if count = index then
        return el.element;
      else
        return default_ret;
      end if;
    end function;

    procedure RemoveAt(index: integer) is
    begin
    end procedure;

    impure function Dump return string is
    begin
      return "";
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
    return "Prime { number: " & to_string(item.Number) & ", is_prime: " & to_string(item.IsPrime) & " }";
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

    Log("**********************************");
    ReportAlerts;
    std.env.stop;
    wait ; 
  end process;

end architecture;

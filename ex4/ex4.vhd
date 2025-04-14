library common_lib;
context common_lib.common_context;

package linked_list is
  generic (
    type ElementT;
    function ToStringF(item: ElementT) return string
  );

  type LList is protected 
    function Count return integer;
    procedure AddFirst(item: ElementT);
    function GetAt(index: integer) return ElementT;
    procedure RemoveAt(index: integer);
    function Dump return string;
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

    function Count return integer is
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

    function GetAt(index: integer) return ElementT is
      variable count: integer := 0;
      variable el: Link := head;
    begin
      while count < index and el.link /= null loop
        count := count + 1;
        el := el.link;
      end loop;

    end function;
  end protected body;
end package body;

entity ex4 is
end entity;

architecture behav of ex4 is

  type PrimeRecT is record
    Number: integer;
    IsPrime: boolean;
  end record;

  -- implement the ToString function here
  function ToString(item: PrimeRecT) return string is
  begin
  -- Enter your code here
  end function;

  -- Instantiate the linked_list package here, use PrimeRecT as generic type
  -- Enter your code here
  
begin

  stimuli_p: process is
  begin
    -- Implement your main testbench code here
    -- Enter your code here
    Log("**********************************");
    std.env.stop;
    wait ; 
  end process;

end architecture;

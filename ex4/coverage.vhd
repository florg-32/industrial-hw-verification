Coverage Report by file with details

=================================================================================
=== File: ex4.vhd
=================================================================================
Branch Coverage:
    Enabled Coverage              Bins      Hits    Misses  Coverage
    ----------------              ----      ----    ------  --------
    Branches                         6         6         0   100.00%

================================Branch Details================================

Branch Coverage for file ex4.vhd --

------------------------------------IF Branch------------------------------------
    69                                        12     Count coming in to IF
    69              1                         10           if el /= null then
    71              1                          2           else
Branch totals: 2 hits of 2 branches = 100.00%

------------------------------------IF Branch------------------------------------
    81                                         4     Count coming in to IF
    81              1                          2           if prev /= null then
                                               2     All False Count
Branch totals: 2 hits of 2 branches = 100.00%

------------------------------------IF Branch------------------------------------
    84                                         4     Count coming in to IF
    84              1                          2           if current /= null then
                                               2     All False Count
Branch totals: 2 hits of 2 branches = 100.00%


Condition Coverage:
    Enabled Coverage              Bins   Covered    Misses  Coverage
    ----------------              ----      ----    ------  --------
    Conditions                       2         2         0   100.00%

================================Condition Details================================

Condition Coverage for file ex4.vhd --

----------------Focused Condition View-------------------
Line       56 Item    1  ((counter < index) and (el /= ))
Condition totals: 2 of 2 input terms covered = 100.00%


Statement Coverage:
    Enabled Coverage              Bins      Hits    Misses  Coverage
    ----------------              ----      ----    ------  --------
    Statements                      52        51         1    98.07%

================================Statement Details================================

Statement Coverage for file ex4.vhd --

    1                                                library common_lib;
    2                                                context common_lib.common_context;
    3                                                
    4                                                use std.textio.line;
    5                                                use std.textio.write;
    6                                                
    7                                                package linked_list is
    8                                                  generic (
    9                                                    type ElementT;
    10                                                   function ToStringF(item: ElementT) return string
    11                                                 );
    12                                               
    13                                                 type LList is protected 
    14                                                   impure function Count return integer;
    15                                                   procedure AddFirst(item: ElementT);
    16                                                   impure function GetAt(index: integer) return ElementT;
    17                                                   procedure RemoveAt(index: integer);
    18                                                   impure function Dump return string;
    19                                                 end protected LList;
    20                                               end package;
    21                                               
    22                                               package body linked_list is
    23                                                 type Entry;
    24                                                 type Link is access Entry;
    25                                                 type Entry is record
    26                                                   element: ElementT;
    27                                                   link: Link;
    28                                                 end record;
    29                                               
    30                                                 type LList is protected body
    31              1                          2         variable head: Link := null;
    32                                               
    33                                                   impure function Count return integer is
    34                                                     variable element: Link := head;
    35                                                     variable count: integer := 0;
    36                                                   begin
    37              1                         16           while element /= null loop
    38              1                         10             count := count + 1;
    39              1                         10             element := element.link;    
    40              1                         10           end loop;
    41              1                          6           return count;
    42                                                   end function Count;
    43                                               
    44                                                   procedure AddFirst(item: ElementT) is
    45                                                     variable e: Link := new Entry;
    46                                                   begin
    47              1                          6           e.element := item;
    48              1                          6           e.link := head;
    49              1                          6           head := e;
    50                                                   end procedure;
    51                                               
    52                                                   impure function Find(index: integer) return Link is
    53                                                     variable el: Link := head;
    54                                                     variable counter: integer := 0;
    55                                                   begin
    56              1                         52           while counter < index and el /= null loop
    57              1                         30             counter := counter + 1;
    58              1                         30             el := el.link;
    59              1                         30           end loop;
    60              1                         22           return el;
    61                                                   end function;
    62                                                 
    63                                                   impure function GetAt(index: integer) return ElementT is
    64                                                     variable el: Link := head;
    65                                                     variable default_ret: ElementT;
    66                                                   begin
    67              1                         12           el := Find(index);
    68                                               
    69                                                     if el /= null then
    70              1                         10             return el.element;
    71                                                     else
    72              1                          2             Alert("GetAt: index out of range");
    73              1                          2             return default_ret;
    74                                                     end if;
    75                                                   end function;
    76                                               
    77                                                   procedure RemoveAt(index: integer) is
    78                                                     variable prev: Link := Find(index - 1);
    79                                                     variable current: Link := Find(index);
    80                                                   begin
    81                                                     if prev /= null then
    82              1                          2             prev.link := Find(index + 1);
    83                                                     end if;
    84                                                     if current /= null then
    85              1                          2             deallocate(current);
    86                                                     end if;
    87                                                   end procedure;
    88                                               
    89                                                   impure function Dump return string is
    90                                                     variable el: Link := head;
    91                                                     variable ret: line;
    92                                                   begin
    93              1                          2           write(ret, string'("LList: ["));
    94              1                          6           while el /= null loop
    95              1                          4             write(ret, ToStringF(el.element) & ", ");
    96              1                          4             el := el.link;
    97              1                          4           end loop;
    98              1                          2           write(ret, string'("]"));
    99              1                          2           return ret.all;
    100                                                  end function;
    101                                              
    102                                                end protected body;
    103                                              end package body;
    104                                              
    105                                              library common_lib;
    106                                              context common_lib.common_context;
    107                                              
    108                                              entity ex4 is
    109                                              end entity;
    110                                              
    111                                              architecture behav of ex4 is
    112                                              
    113                                                type PrimeRecT is record
    114                                                  Number: integer;
    115                                                  IsPrime: boolean;
    116                                                end record;
    117                                              
    118                                                function ToString(item: PrimeRecT) return string is
    119                                                begin
    120             1                          2         return "Prime {number: " & to_string(item.Number) & ", is_prime: " & to_string(item.IsPrime) & "}";
    121                                                end function;
    122                                              
    123                                                function prime(n: integer; p: boolean) return PrimeRecT is
    124                                                  variable ret: PrimeRecT;
    125                                                begin
    126             1                          3         ret.Number := n;
    127             1                          3         ret.IsPrime := p;
    128             1                          3         return ret;
    129                                                end function;
    130                                                
    131                                                package PrimeLL is new work.linked_list generic map(PrimeRecT, ToString);
    132                                                
    133                                              begin
    134                                              
    135             1                          1       stimuli_p: process is
    136                                                  variable list: PrimeLL.LList;
    137                                                begin
    138             1                          1         wait for 0 ns;
    139             1                          1         AffirmIfEqual(list.Count, 0);
    140                                              
    141             1                          1         list.AddFirst(prime(1, true));
    142             1                          1         list.AddFirst(prime(5, true));
    143             1                          1         list.AddFirst(prime(8, false));
    144             1                          1         AffirmIfEqual(list.Count, 3);
    145                                              
    146             1                          1         AffirmIfEqual(list.GetAt(0).Number, 8);
    147             1                          1         AffirmIfEqual(list.GetAt(1).Number, 5);
    148             1                          1         AffirmIfEqual(list.GetAt(2).Number, 1);
    149             1                          1         AffirmIfEqual(list.GetAt(2).IsPrime, true);
    150                                              
    151             1                          1         list.RemoveAt(1);
    152             1                          1         AffirmIfEqual(list.Count, 2);
    153             1                          1         AffirmIfEqual(list.GetAt(1).number, 1);
    154                                              
    155                                                  -- Gain coverage for out of range errors (can I assert this fails somehow?)
    156             1                          1         AffirmIfEqual(list.GetAt(20).number, integer'left);
    157             1                          1         list.RemoveAt(5);
    158                                              
    159             1                          1         Log(list.Dump);
    160             1                          1         Log("**********************************");
    161             1                          1         ReportAlerts;
    162             1                          1         std.env.stop;
    163             1                    ***0***         wait ; 
    164                                                end process;
    165                                              
    166                                              end architecture;
    167                                                



Total Coverage By File (code coverage only, filtered view): 99.35%


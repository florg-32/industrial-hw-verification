library common_lib;
context common_lib.common_context;
  
entity ex1 is
end entity;

architecture behav of ex1 is

  type ColorT is (Red, Green, Blue, Yellow);

  pure function ColorToString(pos: integer) return string is
  begin
    if (pos < 0) or (pos > ColorT'pos(ColorT'right)) then
      Alert("color index out of range");
      return "OutOfRange";
    end if;
    return to_string(ColorT'val(pos));
  end function;

  pure function ColorsToList return string is
    type string_ptr is access string;
    variable ret : string_ptr := new string'(ColorToString(0));
  begin
    for i in 1 to ColorT'pos(ColorT'right) loop
      ret := new string'(ret.all & ", " & ColorToString(i));
    end loop;
    return ret.all;
  end function;

begin

  stimuli_p: process is
  begin
    -- During initialization, the process is evaluated until the first wait statement
    wait for 0 ns;
    report ColorToString(1) severity note;
    report "AllEnums: " & ColorsToList severity note;
    Log("**********************************");
    ReportAlerts;
    std.env.stop;
    wait ; 
  end process;

end architecture;

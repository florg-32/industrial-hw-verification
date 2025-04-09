library common_lib;
context common_lib.common_context;
  
entity ex2 is
end entity;

architecture behav of ex2 is

  type StateT is (Idle, Invert, NotAffected, Keep);
  signal state: StateT := Idle;
  signal clock, clock_n, output: std_logic := '0';
  signal eventCounter: integer := -1;
  signal transCounter: integer := -1;
  -- Enter your code here
  
begin

  CreateClock(clock, 10 ns);
  clock_n <= not clock;

  state_p: process (clock) is
  begin
    if rising_edge(clock) then
      case state is
        when Idle =>
          output <= '0';
        when Invert =>
          output <= not output;
        when NotAffected =>
          output <= unaffected;
        when Keep =>
          output <= output;
      end case;
    end if;
  end process;

  event_count_p: process (all) is
  begin
    if output'event then
      eventCounter <= eventCounter + 1;
    end if;
  end process;

  trans_count_p: process (all) is
  begin
    if output'transaction'event then
      transCounter <= transCounter + 1;
    end if;
  end process;

  stimuli_p: process is
  begin
    -- During initialization, the process is evaluated until the first wait statement
    wait for 0 ns;
    state <= Idle;
    WaitForClock(clock_n, 20);
    AffirmIfEqual(eventCounter, 0);
    AffirmIfEqual(transCounter, 20);

    state <= Invert;
    WaitForClock(clock_n, 20);
    AffirmIfEqual(eventCounter, 20);
    AffirmIfEqual(transCounter, 40);
    
    state <= NotAffected;
    WaitForClock(clock_n, 20);
    AffirmIfEqual(eventCounter, 20);
    AffirmIfEqual(transCounter, 40);

    state <= Keep;
    WaitForClock(clock_n, 20);
    AffirmIfEqual(eventCounter, 20);
    AffirmIfEqual(transCounter, 60);

    Log("Events: " & to_string(eventCounter) & " Transactions: " & to_string(transCounter));
    -- While events happen on every actual change of a value, transaction events occur on every assignment
    Log("**********************************");
    ReportAlerts;
    std.env.stop;
    wait ; 
  end process;

end architecture;

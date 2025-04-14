library common_lib;
context common_lib.common_context;

entity ex3 is
end entity;

architecture behav of ex3 is

  -- Define additional signals or constants here as required
  -- Enter your code here
  signal clock: std_logic;
  signal tx_electrical, rx_electrical: std_logic;
  signal tx_optical, rx_optical: std_logic;

  constant ELECTRICAL_DELAY: time := 23 ns;
  constant PULL_DOWN_TIME_CONSTANT: time := 50 * 50.0e-9 sec;
  constant PULL_UP_TIME_CONSTANT: time := (1e3 + 50) * 50.0e-9 sec;

  constant OPTICAL_DELAY: time := 32.0 ns + 120.0 sec / 200000e3;
  signal optical_glitch_free_tx: std_logic;
begin

  CreateClock(clock, 600 us);
  tx_electrical <= clock;
  tx_optical <= clock;

  stimuli_p: process is
  begin
    wait for 10 ms;
    Log("**********************************");
    std.env.stop;
    wait ; 
  end process;

  -- Implement the transmission line, ie. assign a correctly delayed version of 'tx' onto 'rx'
  -- for both the electrical and the optical transmission lines
  electrical_delay_p: process (all) is
  begin
    if tx_electrical = '1' then
      rx_electrical <= transport '1' after ELECTRICAL_DELAY + PULL_UP_TIME_CONSTANT;
    else
      rx_electrical <= transport '0' after ELECTRICAL_DELAY + PULL_DOWN_TIME_CONSTANT;
    end if;  
  end process;

  optical_glitch_free_tx <= reject 20 ns inertial tx_optical after 32 ns;
  rx_optical <= transport optical_glitch_free_tx after OPTICAL_DELAY;

end architecture;

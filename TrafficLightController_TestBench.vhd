--    Project  : Traffic Light Controller, test bench
--    File     : TrafficLightController_TestBench.vhd
--    Authors  : Ismail Walsh
--    Company  : University of Leicester
--    Date     : 2019
-------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tlcontroller_tb IS
end    tlcontroller_tb;

architecture behaviour of tlcontroller_tb is 

	Component tlcontroller
	port (
	       SW    : in STD_LOGIC_VECTOR(0 downto 0);
			 CLOCK : in STD_LOGIC;
			 BUTTON: in STD_LOGIC_VECTOR(2 downto 0);
			 LEDG  :out std_LOGIC_VECTOR(9 downto 0)
			 );

	end Component;

component fsm
    port (road1sensor    : in STD_LOGIC;
          road2sensor    : in STD_LOGIC;
          clock          : in STD_LOGIC; --50MHz
          reset          : in STD_LOGIC;
			 enable         : in std_LOGIC;
			 clk_div        : in STD_LOGIC; --1Hz
			 count28        : in std_LOGIC_VECTOR (4 downto 0);
			 r1_rag         : out std_LOGIC_VECTOR(2 downto 0);
			 r2_rag         : out std_LOGIC_VECTOR(2 downto 0)
			 );
		
end component;

component mod28 is

    port(clk_div         : in STD_LOGIC;
         reset           : in STD_LOGIC;
         en              : in STD_LOGIC;
         count28         : out STD_LOGIC_VECTOR (4 downto 0)
        );		  
end component;


		
-- Initialise input signals 

signal  road1sensor      :  STD_LOGIC;
signal  road2sensor      :  STD_LOGIC;
signal  clock            :  STD_LOGIC; --50MHz
signal  reset            :  STD_LOGIC;
signal  enable           :  std_LOGIC;
signal  fivebitinput     :  std_LOGIC_VECTOR(4 downto 0);
signal  en               :  std_LOGIC;
 

--Outputs

signal  r1_rag           :  std_LOGIC_VECTOR(2 downto 0);
signal  r2_rag           :  std_LOGIC_VECTOR(2 downto 0);
signal  LEDG             :  std_LOGIC_VECTOR(9 downto 0);
	
begin

-- instatiation of U1

	U1: tlcontroller port map( BUTTON(0)        =>   reset,
	                           BUTTON(1)        =>   road1sensor,
                              BUTTON(2)        =>   road2sensor,
                              CLOCK            =>   clock,
			                     SW(0)            =>   enable,
			                     LEDG             =>   LEDG
										);

r1_rag <= LEDG(2 downto 0); 
r2_rag <= LEDG(9 downto 7);

                              --road1sensor  =>   road1sensor,
                              --road2sensor  =>   road2sensor,
                              --clock        =>   clock,
                              --reset        =>   reset,
			                     --enable       =>   enable,
			                     --r1_rag       =>   r1_rag,
			                     --r2_rag       =>   r2_rag

   U2: fsm          port map( road1sensor  =>   road1sensor,
                              road2sensor  =>   road2sensor,
                              clock        =>   clock,
                              reset        =>   reset,
			                     enable       =>   enable,
										clk_div      =>   clock,
			                     r1_rag       =>   LEDG(2 downto 0),
			                     r2_rag       =>   LEDG(9 downto 7),
										count28      =>   fivebitinput
										);
										

  U3: mod28         port map  (clk_div     => clock,
                               reset       => reset,
                               en          => en,
                               count28     => fivebitinput
									    );
	                          									  
--Clock 50MHz									  
process 
	begin
	 clock <= '1'; 
	 wait for 50 ns;
	 clock <= '0';
	 wait for 50 ns;
end process;


	-- Stimulus Process
stim_proc: process
begin

   reset <= '1';
	
wait for 10 ns;





--Road1sensor
  reset       <= '0';
  enable      <= '0';
  en          <= '0';
  road1sensor <= '1';
  road2sensor <= '0';
  
  wait for 800 ns;
  
--Both cars
  
  
  en          <= '0';
  road1sensor <= '1';
  road2sensor <= '1';
  
  wait for 800 ns;


--Road2sensor

  en          <= '0';
  road1sensor <= '0';
  road2sensor <= '1';
  
  wait for 800 ns;


--No sensors

  en          <= '0';
  road1sensor <= '0';
  road2sensor <= '0';
  

end process;
end behaviour;

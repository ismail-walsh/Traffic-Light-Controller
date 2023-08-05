--    Project  : Traffic Light Controller
--    File     : TrafficLightController.vhd
--    Authors  : Ismail Walsh
--    Company  : University of Leicester
--    Date     : 2019
-------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tlcontroller is

    port (
	       SW    : in STD_LOGIC_VECTOR(0 downto 0);
			 CLOCK : in STD_LOGIC;
			 BUTTON: in STD_LOGIC_VECTOR(2 downto 0);
			 LEDG  :out std_LOGIC_VECTOR(9 downto 0)
			 );
end tlcontroller;
			
          --road1sensor    : in STD_LOGIC; 
          --road2sensor    : in STD_LOGIC; 
          --clock          : in STD_LOGIC; --50MHz
          --reset          : in STD_LOGIC;
			 --enable         : in std_LOGIC; 
			 --r1_rag         : out std_LOGIC_VECTOR(2 downto 0);
			 --r2_rag         : out std_LOGIC_VECTOR(2 downto 0)

architecture structural of tlcontroller is
component Clock_Divider is

    port(Clock	          : in	STD_LOGIC;
			Reset	          : in	STD_LOGIC;
			Clk_Div         : out STD_LOGIC 
         );  
end component;

component mod28 is

    port(clk_div         : in STD_LOGIC;
         reset           : in STD_LOGIC;
         en              : in STD_LOGIC; 
         count28         : out STD_LOGIC_VECTOR (4 downto 0)
        );		  
end component;

component fsm is

    port( road1sensor    : in STD_LOGIC; 
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

signal fivebitinput      : std_LOGIC_VECTOR (4 downto 0);
signal signalclk_div     : std_LOGIC;
signal signalen          : std_LOGIC;

begin

---Instatiation of mod28
U1: mod28                   port map  (clk_div      => CLOCK,
                                       reset        => BUTTON(0),
                                       en           => signalen,
                                       count28      => fivebitinput
									            ); 
									  
---Instatiation of a Clock Divider
U2: Clock_Divider           port map  (Clk_div      => signalclk_div,
                                       Clock	       => CLOCK,
			                              Reset        => SW(0)
									            );	
									  
---Instatiation of fsm									  
U3: fsm                     port map  (road1sensor  =>   BUTTON(1),
                                       road2sensor  =>   BUTTON(2),
                                       clock        =>   CLOCK,
                                       reset        =>   BUTTON(0),
			                              enable       =>   SW(0),
			                              clk_div      =>   CLOCK,
			                              count28      =>   fivebitinput,
			                              r1_rag       =>   LEDG(2 downto 0),
			                              r2_rag       =>   LEDG(9 downto 7)
									            ); 

signalclk_div <= CLOCK;
end structural;



--    Project  : Traffic Light Controller, Modulo Counter
--    File     : ModuloCounter28
--    Authors  : Ismail Walsh
--    Company  : University of Leicester
--    Date     : 2019
-------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mod28 is

   PORT(clk_div   : IN STD_LOGIC;
        reset     : IN STD_LOGIC;
        en        : IN STD_LOGIC; 
        count28   : OUT STD_LOGIC_VECTOR (4 downto 0)
		  );
		  
end mod28;

architecture Behavioral of mod28 is
signal signalcount28 : std_LOGIC_VECTOR (4 downto 0);
begin

process(clk_div, reset, signalcount28, en) --Counter
begin

  if reset = '1' then
     signalcount28 <= "00000";
  
  elsif rising_edge(clk_div) then
     if en ='1' then
      signalcount28 <= signalcount28;
			
	      elsif signalcount28 >= "11011" then 
	            signalcount28 <= "00000";
					
					else signalcount28 <= signalcount28 + "00001";
			  
	   end if;	
	end if;
				
count28 <= signalcount28;

end process;  

end Behavioral; 



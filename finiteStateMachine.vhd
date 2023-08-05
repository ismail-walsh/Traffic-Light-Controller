--    Project  : Traffic Light Controller 
--    File     : finiteStateMachine.vhd
--    Author  : Ismail Walsh
--    Company  : University of Leicester
--    Date     : 2019
-------------------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fsm is

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
end fsm;

architecture structural of fsm is

signal signalen          : std_LOGIC;
signal r1rag             : std_LOGIC_VECTOR (2 downto 0);
signal r2rag             : std_LOGIC_VECTOR (2 downto 0);
signal signalcount28     : std_LOGIC_VECTOR (4 downto 0);
type fsm_type is (s0, s1, s2, s3, s4, s5);
signal Current_State, Next_state : fsm_type;


component mod28 is

    port(clk_div         : in STD_LOGIC;
         reset           : in STD_LOGIC;
         en              : in STD_LOGIC; 
         count28         : out STD_LOGIC_VECTOR (4 downto 0)
        );		  
end component;

begin

---Instatiation of mod28
U1: mod28                   port map  (clk_div      => clk_div,
                                       reset        => reset,
                                       en           => signalen,
                                       count28      => signalcount28
									            );
													
													
signalcount28 <= count28;													
													
													

end structural;

architecture my_fsm of fsm is

type fsm_type is (s0, s1, s2, s3, s4, s5);
signal Current_State, Next_state : fsm_type;
signal signalcount28     : std_LOGIC_VECTOR (4 downto 0);

begin

process (clk_div , reset, enable, Current_State) begin
 if reset = '1' then
	 
       Current_State <= S0;
		
             elsif rising_edge (clock) then
				 
               Current_State <= Next_state;
					else 
					Current_State <= Current_State;
              end if;
				  
				  

end process;


 
process(Current_State, road1sensor, road2sensor, signalcount28, Next_state)
begin
case Current_State is


		when s0 =>     
		              if signalcount28 <= "00000" then    -- 0 sec 
						  
		                 if    road1sensor = '0' and road2sensor = '1' then Next_state <= s1;  
		                 elsif road1sensor = '1' and road2sensor = '0' then Next_state <= s1;  
		                 elsif road1sensor = '1' and road2sensor = '1' then Next_state <= s1; 
					  
					           else  Next_state <= s1; 
					     end if; 
						  end if; 
					  
					  
		when s1 =>     
		                if signalcount28 <= "00010" then  -- 2 sec
						  
		                if    road1sensor = '0' and road2sensor = '1' then Next_state <= s2;   
		                elsif road1sensor = '1' and road2sensor = '0' then Next_state <= s1;   
		                elsif road1sensor = '1' and road2sensor = '1' then Next_state <= s2;  
					     
						       else Next_state <= s1; 
						  
						  end if; 
					     end if; 
					  
					  
		when s2 =>    
		              if signalcount28 <= "01100" then -- 12 sec
						  
							 if road1sensor = '0' and road2sensor = '1' then Next_state <= s3;   
							 elsif road1sensor = '1' and road2sensor = '0' then Next_state <= s3;
							 elsif road1sensor = '1' and road2sensor = '1' then Next_state <= s3; 
						  
						      else Next_state <= s3; 
								
						  end if; 
						  end if;
					  
					  
		when s3 =>    
		              if signalcount28 <= "01110" then    -- 14 sec
		           
							 if road1sensor = '0' and road2sensor = '1' then Next_state <= s4; 
							 elsif road1sensor = '1' and road2sensor = '0' then Next_state <= s4; 
							 elsif road1sensor = '1' and road2sensor = '1' then Next_state <= s4; 
					 
								 else Next_state <= s4; 
					 
					     end if;
						  end if; 
					  
					  
		when s4 =>    
		              if signalcount28 <= "10000" then --16
		           
							 if road1sensor = '0' and road2sensor = '1' then Next_state <= s4; 
							 elsif road1sensor = '1' and road2sensor = '0' then Next_state <= s5; 
							 elsif road1sensor = '1' and road2sensor = '1' then Next_state <= s5; 
					    
						       else Next_state <= s4; 
					
				        end if;
					     end if;
					   
						
		when s5 =>    
		              if signalcount28 <= "11010" then --26
		           
							 if road1sensor = '0' and road2sensor = '1' then Next_state <= s0; 
							 elsif road1sensor = '1' and road2sensor = '0' then Next_state <= s0; 
							 elsif road1sensor = '1' and road2sensor = '1' then Next_state <= s0; 
						  
						       else Next_state <= s0;
						  
						  end if;
						  end if;
	
	   when others => 
		           
end case;

signalcount28 <= count28;

end process;	





process(Current_State, Next_state)
begin
case Current_State is


		when s0 =>  if signalcount28 <= "00000" then
		r1_rag <= "110"; r2_rag <= "100"; -- s0   
		end if;
		              
					  
					  
		when s1 =>   if signalcount28 <= "00010" then
		r1_rag <= "001"; r2_rag <= "100"; --S1   
		 end if;             
					  
					  
		when s2 =>  if signalcount28 <= "01100" then
		r1_rag <= "010"; r2_rag <= "100";  --S2
		 end if;             
					  
					  
		when s3 =>  if signalcount28 <= "01110" then
		r1_rag <= "100"; r2_rag <= "110"; --s3 
		 end if;        
		          
					  
		when s4 =>  if signalcount28 <= "10000" then
		r1_rag <= "100"; r2_rag <= "001"; --s4
		 end if;             
					   
						
		when s5 =>  if signalcount28 <= "11010" then
		r1_rag <= "100"; r2_rag <= "010"; --s5
		  end if;            
						  
		when others => r1_rag <= "000"; r2_rag <= "000";
						 
		           
end case;

end process;	

end my_fsm;


 


--Binary Number List (for your translating pleasure)

--0	0
--1	1
--2	10
--3	11
--4	100
--5	101
--6	110
--7	111
--8	1000
--9	1001
--10	1010
--11	1011
--12	1100
--13	1101
--14	1110
--15	1111
--16	10000
--17	10001
--18	10010
--19	10011
--20	10100
--21	10101
--22	10110
--23	10111
--24	11000
--25	11001
--26	11010
--27	11011
--28	11100















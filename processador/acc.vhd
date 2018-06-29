library IEEE;
use IEEE.std_logic_1164.all;
-- Registrador acumulador
-- Register Accumulator

entity acc is
  port ( rst   : in STD_LOGIC;
         clk   : in STD_LOGIC;
         input : in STD_LOGIC_VECTOR (3 downto 0);
         enb   : in STD_LOGIC;
         output: out STD_LOGIC_VECTOR (3 downto 0)
       );
end acc;

architecture bhv of acc is
signal temp : STD_LOGIC_VECTOR(3 downto 0);
begin
	process (rst, input, enb, clk)
	begin
		if (rst = '1') then
			output <= "0000";
		elsif (clk'event and clk = '1') then
				if (enb = '1') then 
					output <= input;
					temp <= input;
				else
					output <= temp;
				end if;
		end if;
	end process;
end bhv;
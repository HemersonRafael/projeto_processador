library IEEE;
use IEEE.std_logic_1164.all;

-- Banco de registradores (BR)
-- Register File (rf)

entity rf is
	port ( 
		rst    : in STD_LOGIC;
		clk    : in STD_LOGIC;
		input  : in std_logic_vector(3 downto 0); -- O que será escrito no registrador
		sel    : in std_logic_vector(1 downto 0); -- em qual registrador será escrito 
		enb    : in std_logic;
		output : out std_logic_vector(3 downto 0)
   );		
end rf;

architecture bhv of rf is
	-- Teremos 4 registradores de 4 bits
	signal out0, out1, out2, out3 : std_logic_vector(3 downto 0);

	begin
		process (rst, clk)
		begin	  
		  
			if(rst = '1') then
				out0 <= "0000"; 
				out1 <= "0000";
				out2 <= "0000";
				out3 <= "0000";
				output <= "0000";	
			  
			elsif(clk'event and clk = '1')then
		  -- Quando enable for '0', estaremos tratando os acontecimentos nos signals
		  -- para que quando enable for '1', passemos a saída.
				if (enb = '0') then
					case (sel) is 
					  when "00" => 
						out0 <= input;
					  when "01" => 
						out1 <= input;
					  when "10" => 
						out2 <= input;
					  when "11" =>
						out3 <= input;
					  when others =>
						output <= "0000";
					end case;
				else
					case (sel) is
					  when "00" =>
						output <= out0;
					  when "01" =>
						output <= out1;
					  when "10" =>
						output <= out2;
					  when "11" =>
						output <= out3;
					  when others =>
						output <= "0000";
					end case;
				end if;
		   end if;
		end process;	
	-- end begin
end bhv;
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- unidade logica aritmetrica (ULA)
-- Arithmetic Logic Unit (ALU)

entity alu is
	port( 
		rst   		: in  STD_LOGIC;
		clk   		: in  STD_LOGIC;
		inputA		: in  STD_LOGIC_VECTOR (3 downto 0);
		inputB 		: in  STD_LOGIC_VECTOR (3 downto 0); 
		alu_st		: in  std_logic_vector (3 downto 0);			
		output		: out STD_LOGIC_VECTOR (3 downto 0)			
	);
end alu;

architecture bhv of alu is
	begin
		process (rst, clk, alu_st, inputA, inputB)
			begin
				if(rst = '1') then
					output <= "0000";
				else
					case alu_st is
						-- Accumulator = Register [dd]
						when "0000" => output <= inputB;
						-- Register [dd] = Accumulator
						when "0001" => output <= inputA;
						-- Accumulator = Immediate
						when "0010" => output <= inputB;
						-- Accumulator = Accumulator + Register[dd]
						when "0011" => output <= inputA + inputB;
						-- Accumulator = Accumulator - Register[dd]
						when "0100" => output <= inputA - inputB;
						-- Accumulator = Accumulator AND Register[dd]
						when "0101" => output <= inputA and inputB;
						-- Accumulator = Accumulator OR Register[dd]
						when "0110" => output <= inputA or inputB;
						-- Accumulator = NOT Accumulator
						when "1000" => output <= not inputA;
						when others =>
					end case; 	
				end if;
			-- end begin	
		end process;
		
	-- end begin 

end bhv;
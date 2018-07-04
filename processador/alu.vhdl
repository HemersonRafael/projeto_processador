library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
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
		process (rst, clk, alu_st)
			variable A,B, RESLT : integer := 0;
			
			begin
				
				if(rst = '1') then
					output <= "0000";
					A := 0;
					B := 0;
				else
					A := conv_integer(unsigned(inputA));
					B := conv_integer(unsigned(inputB));
					case alu_st is
						-- Accumulator = Register [dd]
						when "0000" => output <= inputB;
						-- Register [dd] = Accumulator
						when "0001" => output <= inputA;
						-- Accumulator = Immediate
						when "0010" => output <= inputB;
						-- Accumulator = Accumulator + Register[dd]
						when "0011" => output <= conv_std_logic_vector((A + B),4);
						-- Accumulator = Accumulator - Register[dd]
						when "0100" => output <= conv_std_logic_vector((A - B),4);
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
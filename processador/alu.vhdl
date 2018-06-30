library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
use ieee.STD_LOGIC_UNSIGNED.all;
-- unidade logica aritmetrica (ULA)
-- Arithmetic Logic Unit (ALU)

entity alu is
	port ( 
		rst   		: in  STD_LOGIC;
		clk   		: in  STD_LOGIC;
		inputAcc 	: in  STD_LOGIC_VECTOR (3 downto 0); -- input vem do Accumulator
		inputReg 	: in  STD_LOGIC_VECTOR (3 downto 0); -- input vem do Registrador
		imm   		: in  std_logic_vector (3 downto 0);
		alu_st		: in  std_logic_vector (3 downto 0); -- modo de seleção da alu
		output		: out STD_LOGIC_VECTOR (3 downto 0)			
	);
end alu;

architecture bhv of alu is
	begin
		process (rst, clk, alu_st)
			begin
				if(rst = '1') then
					output <= "0000";
				elsif(clk'event and clk = '1')then
					case alu_st is
						-- Accumulator = Register [dd]
						when "0000" => output <= inputReg;
						-- Register [dd] = Accumulator
						when "0001" => output <= inputAcc;
						-- Accumulator = Immediate
						when "0010" => output <= imm;
						-- Accumulator = Accumulator + Register[dd]
						when "0011" => output <= inputAcc + inputReg;
						-- Accumulator = Accumulator - Register[dd]
						when "0100" => output <= inputAcc - inputReg;
						-- Accumulator = Accumulator AND Register[dd]
						when "0101" => output <= inputAcc and inputReg;
						-- Accumulator = Accumulator OR Register[dd]
						when "0110" => output <= inputAcc or inputReg;
						-- PC = Address[aaaa]
						when "0111" => output <= inputAcc;
						-- Accumulator = NOT Accumulator
						when "1000" => output <= not inputAcc;
						-- Stop execution
						when "1001" => output <= "1111";
					end case; 	
				end if;
		end process;
	-- end begin 

end bhv;
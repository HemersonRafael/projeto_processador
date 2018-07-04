library  ieee;
use ieee.std_logic_1164.all;

entity conversor_comandos is
	port(
	  instrucao 	: in  std_logic_vector (3 downto 0);  -- vetor de entrada com 4 bits
	  hex3 : out std_logic_vector (6 downto 0);
	  hex2 : out std_logic_vector (6 downto 0);
	  hex1 : out std_logic_vector (6 downto 0);
	  hex0 : out std_logic_vector (6 downto 0)
	);
end conversor_comandos;

architecture hardware of conversor_comandos is
	begin
		process (instrucao)
			begin
			case instrucao is
				when "0000" =>					-- MOVA
					hex3 <= "1101010";   -- M
					hex2 <= "1000000";   -- O
					hex1 <= "1010101";   -- V
					hex0 <= "0001000";   -- A
					
				when "0001" =>					-- MOVR
					hex3 <= "1101010";   -- M
					hex2 <= "1000000";   -- O
					hex1 <= "1010101";   -- V
					hex0 <= "0101111";   -- R
				
				when "0010" =>					-- LOAD
					hex3 <= "1000111";	-- L
					hex2 <= "1000000";	-- O
					hex1 <= "0001000";	-- A
					hex0 <= "0100001";	-- D
				
				when "0011" =>					-- ADD
					hex3 <= "1111111";   -- _
					hex2 <= "0001000";   -- A
					hex1 <= "0100001";   -- D
					hex0 <= "0100001";   -- D
				
				when "0100" =>					-- SUB
					hex3 <= "1111111";   -- _
					hex2 <= "0010010";   -- S
					hex1 <= "1000001";   -- U
					hex0 <= "0000011";   -- B
				
				when "0101" =>					-- ANDR
					hex3 <= "0001000";   -- A
					hex2 <= "0101011";   -- N
					hex1 <= "0100001";   -- D
					hex0 <= "0101111";   -- R
					
				when "0110" =>					-- ORR
					hex3 <= "1111111";   -- _
					hex2 <= "1000000";   -- O
					hex1 <= "0101111";   -- R
					hex0 <= "0101111";   -- R
					
				when "0111" =>					-- JMP
					hex3 <= "1111111";   -- _
					hex2 <= "1100001";   -- J
					hex1 <= "1101010";   -- M
					hex0 <= "0001100";   -- P
				
				when "1000" =>					-- INV
					hex3 <= "1111111";   -- _
					hex2 <= "1001111";   -- I
					hex1 <= "0101011";   -- N
					hex0 <= "1010101";   -- V
				
				when "1001" =>					-- HALT
					hex3 <= "1111111";   -- H
					hex2 <= "0001000";   -- A
					hex1 <= "0111000";   -- L
					hex0 <= "1111000";   -- T

				when others =>					-- OUTROS
					hex3 <= "1111111";   -- _
					hex2 <= "1111111";   -- _
					hex1 <= "1111111";   -- _
					hex0 <= "1111111";   -- _

				end case;
		end process;
end hardware;
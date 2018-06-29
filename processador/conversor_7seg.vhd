library  ieee;
use ieee.std_logic_1164.all;

entity conversor_7seg is
	port(
	  entrada 	: in  std_logic_vector (3 downto 0);  -- vetor de entrada com 4 bits
	  segmentos : out std_logic_vector (6 downto 0)-- vetor de saida que vai receber o valor de entrada representando em 7 bits
	);
end conversor_7seg;

architecture hardware of conversor_7seg is
	begin
	  with entrada select -- seleciona, dependendo do valor de "entrada", converte o equivalente em 7 bits para "segmentos"
			segmentos <=	"1000000" when "0000", -- 0
								"1111001" when "0001", -- 1
								"0100100" when "0010", -- 2
								"0110000" when "0011", -- 3
								"0011001" when "0100", -- 4
								"0010010" when "0101", -- 5
								"0000010" when "0110", -- 6
								"1111000" when "0111", -- 7
								"0000000" when "1000", -- 8
								"0010000" when "1001", -- 9
								"1111111" when "1111", -- apagado
								"0111111" when others; -- -
end hardware;
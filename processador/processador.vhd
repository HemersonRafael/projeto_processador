library ieee;

use ieee.std_logic_1164.all;

entity processador is
		port(
			key0 : in  std_logic;
			hex0 : out std_logic_vector (6 downto 0);
			hex1 : out std_logic_vector (6 downto 0);
			hex2 : out std_logic_vector (6 downto 0);
			hex3 : out std_logic_vector (6 downto 0);
			hex4 : out std_logic_vector (6 downto 0);
			hex5 : out std_logic_vector (6 downto 0)
		);
end processador;

architecture hardware of processador is
	begin

end hardware;
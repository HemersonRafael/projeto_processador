library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

-- Unidade Central de Processamento (UCP)
-- Central Processing Unit(CPU)
-- cpu (top level entity)

entity cpu is
   port ( 
		rst     : in  STD_LOGIC;
		start   : in  STD_LOGIC;
		clk     : in  STD_LOGIC;
		output  : out STD_LOGIC_VECTOR(3 downto 0);
		HEX0    : out STD_LOGIC_VECTOR(6 downto 0);
		HEX1 	  : out STD_LOGIC_VECTOR(6 downto 0);
		HEX2 	  : out STD_LOGIC_VECTOR(6 downto 0);
		HEX3 	  : out STD_LOGIC_VECTOR(6 downto 0);
		HEX4 	  : out STD_LOGIC_VECTOR(6 downto 0);
		HEX5 	  : out STD_LOGIC_VECTOR(6 downto 0)
   );
end cpu;

architecture struc of cpu is

	component conversor_7seg
		port(
		  entrada 	: in  std_logic_vector (3 downto 0);  -- vetor de entrada com 4 bits
		  segmentos : out std_logic_vector (6 downto 0)-- vetor de saida que vai receber o valor de entrada representando em 7 bits
		);
	end component;
	
	component ctrl 
		port ( 
			rst   : in STD_LOGIC;
			start : in STD_LOGIC;
			clk   : in STD_LOGIC;
			imm   : out std_logic_vector(3 downto 0)
		);
	end component;

	component dp
		port (
			rst     : in STD_LOGIC;
			clk     : in STD_LOGIC;
			imm     : in std_logic_vector(3 downto 0);
			output_4: out STD_LOGIC_VECTOR (3 downto 0)    
		);
	end component;


	signal immediate : std_logic_vector(3 downto 0);
	signal cpu_out : std_logic_vector(3 downto 0);

	begin
	  
	  controller: ctrl port map(rst, start, clk,immediate);
	  datapath: dp port map(rst, clk, immediate, cpu_out);
	  C7S: conversor_7seg port map(cpu_out,HEX0);
	  
	  process(rst, clk, cpu_out)
	  begin
		  if(clk'event and clk='1') then
			output <= cpu_out;
		  end if;
	  end process;
	  
	-- end begin

end struc;




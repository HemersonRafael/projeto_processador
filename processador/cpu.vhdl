library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Unidade Central de Processamento (UCP)
-- Central Processing Unit(CPU)
-- cpu (top level entity)

entity cpu is
   port( 
		rst     : in  STD_LOGIC;
		start   : in  STD_LOGIC;
		clk     : in  STD_LOGIC;
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
		  entrada 	: in  std_logic_vector (3 downto 0);
		  segmentos	: out std_logic_vector (6 downto 0)
		);
	end component;
	
	component conversor_comandos is
		port(
		  instrucao 	: in  std_logic_vector (3 downto 0);
		  hex3 : out std_logic_vector (6 downto 0);
		  hex2 : out std_logic_vector (6 downto 0);
		  hex1 : out std_logic_vector (6 downto 0);
		  hex0 : out std_logic_vector (6 downto 0)
		);
	end component;
	
	component ctrl 
		port( 
			rst_ctrl   		: in STD_LOGIC;
			start_ctrl 		: in STD_LOGIC;
			clk_ctrl   		: in STD_LOGIC;       
			output_ctrl 	: out std_logic_vector(3 downto 0);	
			alu_st_ctrl		: out std_logic_vector(3 downto 0);
			rf_sel_ctrl		: out std_logic_vector(1 downto 0);  
			rf_enb_ctrl		: out std_logic;						  
			acc_enb_ctrl	: out std_logic
		);
	end component;

	component dp
		port( 
			rst_dp     	: in  STD_LOGIC;
			clk_dp     	: in  STD_LOGIC;
			input_dp		: in  std_logic_vector(3 downto 0);
			alu_st_dp	: in std_logic_vector(3 downto 0);
			rf_sel_dp	: in std_logic_vector(1 downto 0);  
			rf_enb_dp	: in std_logic;						  
			acc_enb_dp	: in std_logic;
			output_dp	: out STD_LOGIC_VECTOR(3 downto 0)    
		);
	end component;

	signal aux 						:  std_logic_vector(3 downto 0);
	signal immediate 				:  std_logic_vector(3 downto 0);
	signal cpu_out 				:  std_logic_vector(3 downto 0);
	signal output_ctrl_out 		:  std_logic_vector(3 downto 0);	
	signal alu_st_ctrl_out 		:  std_logic_vector(3 downto 0); 
	signal rf_sel_ctrl_out 		:  std_logic_vector(1 downto 0);   
	signal rf_enb_ctrl_out 		:  std_logic;						  
	signal acc_enb_ctrl_out 	:  std_logic;
	signal unidade_CPU			:  std_logic_vector(3 downto 0);
	signal dezena_CPU 			:  std_logic_vector(3 downto 0);
	
	begin
	   
		DATAPATH		: dp 		port map(rst, clk, immediate, alu_st_ctrl_out, rf_sel_ctrl_out, rf_enb_ctrl_out, acc_enb_ctrl_out, cpu_out);
		CONTROLLER	: ctrl 	port map(rst,start, clk, immediate, alu_st_ctrl_out, rf_sel_ctrl_out, rf_enb_ctrl_out, acc_enb_ctrl_out);
		

		C7S1: conversor_7seg port map(dezena_CPU,HEX5);
	   C7S2: conversor_7seg port map(unidade_CPU,HEX4);
		C7COM: conversor_comandos port map(alu_st_ctrl_out, HEX3, HEX2, HEX1, HEX0);
		
		process(rst, clk, cpu_out)
		variable quociente_CPU, resto_CPU : integer range 0 to 9;
		begin
			if(rst = '1') then
				aux <="0000";
			elsif(clk'event and clk='1') then
				
				aux <= cpu_out;
				
				quociente_CPU := conv_integer(unsigned(aux))/10;
				resto_CPU	  := conv_integer(unsigned(aux)) rem 10;
				
				-- Processo abaixo e utilizado para converte inteiros para vetores de 4 bits
				unidade_CPU	<= conv_std_logic_vector(resto_CPU , 4); -- conv_std_logic_vector realiza a conversao de inteiro para um vetor de bits
				dezena_CPU 	<= conv_std_logic_vector(quociente_CPU , 4);
			end if;
		end process;
	  
	-- end begin
end struc;




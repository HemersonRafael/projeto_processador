library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

-- Unidade Central de Processamento (UCP)
-- Central Processing Unit(CPU)
-- cpu (top level entity)

entity cpu is
   port( 
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
		  entrada 	: in  std_logic_vector (3 downto 0);
		  segmentos	: out std_logic_vector (6 downto 0)
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
		port (
			rst     : in STD_LOGIC;
			clk     : in STD_LOGIC;
			imm     : in std_logic_vector(3 downto 0);
			output_dp: out STD_LOGIC_VECTOR (3 downto 0)    
		);
	end component;


	signal immediate 				:  std_logic_vector(3 downto 0);
	signal cpu_out 				:  std_logic_vector(3 downto 0);
	signal output_ctrl_out 		:  std_logic_vector(3 downto 0);	
	signal alu_st_ctrl_out 		:  std_logic_vector(3 downto 0); 
	signal rf_sel_ctrl_out 		:  std_logic_vector(1 downto 0);   
	signal rf_enb_ctrl_out 		:  std_logic;						  
	signal acc_enb_ctrl_out 	:  std_logic;
	
	begin
	   
		--datapath: dp port map();
		controller: ctrl port map(rst,start, clk, immediate, cpu_out, alu_st_ctrl_out, rf_sel_ctrl_out, rf_enb_ctrl_out, acc_enb_ctrl_out);
		

		C7S: conversor_7seg port map(cpu_out,HEX0);
	  
		process(rst, clk, cpu_out)
		begin
			if(rst = '1') then
				output <="0000";
			elsif(clk'event and clk='1') then
				output <= cpu_out;
			end if;
		end process;
	  
	-- end begin
end struc;




library IEEE;
use IEEE.std_logic_1164.all;
-- Bloco operacional (Datapath)
entity dp is
	port( 
		rst_dp     		: in  STD_LOGIC;
		clk_dp     		: in  STD_LOGIC;
		input_dp		: in  std_logic_vector(3 downto 0);
		alu_st_dp	: out std_logic_vector(3 downto 0);
		rf_sel_dp	: out std_logic_vector(1 downto 0);  
		rf_enb_dp	: out std_logic;						  
		acc_enb_dp	: out std_logic
		output_dp	: out STD_LOGIC_VECTOR(3 downto 0)   
   );
end dp;

architecture rtl2 of dp is
component alu is
	port( 
		rst   		: in  STD_LOGIC;
		clk   		: in  STD_LOGIC;
		inputA		: in  STD_LOGIC_VECTOR (3 downto 0);
		inputB 		: in  STD_LOGIC_VECTOR (3 downto 0); 
		alu_st		: in  std_logic_vector (3 downto 0);			
		output		: out STD_LOGIC_VECTOR (3 downto 0)			
	);
end component;
component acc is
	port( 
		rst   	: in  STD_LOGIC;
		clk   	: in  STD_LOGIC;
		input 	: in  STD_LOGIC_VECTOR (3 downto 0);
		enb   	: in  STD_LOGIC;
		output	: out STD_LOGIC_VECTOR (3 downto 0)
   );
end component;

component rf is
	port (
		rst    : in  STD_LOGIC;
		clk    : in  STD_LOGIC;
		input  : in  std_logic_vector(3 downto 0); -- O que será escrito no registrador
		sel    : in  std_logic_vector(1 downto 0); -- em qual registrador será escrito 
		enb    : in  std_logic;
		output : out std_logic_vector(3 downto 0)
   );	
end component;

signal alu_inA	: std_logic_vector(3 downto 0);
signal alu_inB	: std_logic_vector(3 downto 0);
signal rf_in	: std_logic_vector(3 downto 0);
signal acc_in	: std_logic_vector(3 downto 0);
signal alu_out	: std_logic_vector(3 downto 0);
signal rf_out	: std_logic_vector(3 downto 0);
signal acc_out	: std_logic_vector(3 downto 0);

begin

	ALU1: alu port map(rst_dp, clk_dp, alu_inA , alu_inB, alu_st_dp, alu_out);
	RF1 :	rf  port map(rst_dp, clk_dp, rf_in, rf_sel_dp, rf_enb_dp, rf_out);
	ACC1: acc port map(rst_dp, clk_dp, acc_in, acc_enb_dp, acc_out);
	
	process (rst_dp, clk_dp, alu_out)
		begin
			when 
			output_dp <= alu_out;
   end process;
end rtl2;
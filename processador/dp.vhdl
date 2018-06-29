library IEEE;
use IEEE.std_logic_1164.all;
-- Bloco operacional (Datapath)
entity dp is
  port ( rst     	: in STD_LOGIC;
         clk     	: in STD_LOGIC;
         imm     	: in std_logic_vector(3 downto 0);
			sel_rf_dp: in std_logic_vector(1 downto 0);
			alu_st_dp: out std_logic_vector(3 downto 0);
         output_4	: out STD_LOGIC_VECTOR (3 downto 0)
         
       );
end dp;

architecture rtl2 of dp is

component acc is
  port ( rst   : in STD_LOGIC;
         clk   : in STD_LOGIC;
         input : in STD_LOGIC_VECTOR (3 downto 0);
         enb   : in STD_LOGIC;
         output: out STD_LOGIC_VECTOR (3 downto 0)
       );
end component;

component rf is
  port ( rst    : in STD_LOGIC;
         clk    : in STD_LOGIC;
         input  : in std_logic_vector(3 downto 0); -- O que será escrito no registrador
         sel    : in std_logic_vector(1 downto 0); -- em qual registrador será escrito 
         enb    : in std_logic;
         output : out std_logic_vector(3 downto 0)
       );
		
end component;

component alu is
	port ( 
		rst   		: in  STD_LOGIC;
		clk   		: in  STD_LOGIC;
		inputAcc 	: in  STD_LOGIC_VECTOR (3 downto 0);
		inputReg 	: in  STD_LOGIC_VECTOR (3 downto 0);
		imm   		: in  std_logic_vector (3 downto 0); 
		alu_st		: in  std_logic_vector (3 downto 0);			
		output		: out STD_LOGIC_VECTOR (3 downto 0)			
	);
end component;

signal alu_out: std_logic_vector(3 downto 0);
signal rf_out: std_logic_vector(3 downto 0);

begin
	--alu1: alu port map (rst,clk,imm, alu_out);
	--rf1:	rf port map(rst, clk, alu_out,  )
	-- maybe this is were we add the port maps for the other components.....

	process (rst, clk)
		begin

			-- this you should change so the output actually
			-- comes from the accumulator so it follows the
			-- instruction set. since the accumulator is always 
			-- involved we want to be able to see the
			-- results/data changes on the acc.

			-- take care of reset state
		  
			output_4 <= alu_out;
		
   end process;
end rtl2;
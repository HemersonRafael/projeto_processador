library IEEE;
use IEEE.std_logic_1164.all;
-- Bloco operacional (Datapath)
entity dp is
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
			input  : in  std_logic_vector(3 downto 0); 
			sel    : in  std_logic_vector(1 downto 0); 
			enb    : in  std_logic;
			output : out std_logic_vector(3 downto 0)
		);	
	end component;

	signal alu_inA	: std_logic_vector(3 downto 0) := "0000";
	signal alu_inB	: std_logic_vector(3 downto 0) := "0000";
	signal rf_in	: std_logic_vector(3 downto 0) := "0000";
	signal acc_in	: std_logic_vector(3 downto 0) := "0000";
	signal alu_out	: std_logic_vector(3 downto 0) := "0000";
	signal rf_out	: std_logic_vector(3 downto 0) := "0000";
	signal acc_out	: std_logic_vector(3 downto 0) := "0000";

	constant mova  : std_logic_vector(3 downto 0) := "0000";
	constant movr  : std_logic_vector(3 downto 0) := "0001";
	constant load  : std_logic_vector(3 downto 0) := "0010";
	constant add	: std_logic_vector(3 downto 0) := "0011";
	constant sub	: std_logic_vector(3 downto 0) := "0100";
	constant andr  : std_logic_vector(3 downto 0) := "0101";
	constant orr   : std_logic_vector(3 downto 0) := "0110";
	constant inv   : std_logic_vector(3 downto 0) := "1000";
	constant halt  : std_logic_vector(3 downto 0) := "1001";
	

	begin
		
		ALU1: alu port map(rst_dp, clk_dp, alu_inA , alu_inB, alu_st_dp, alu_out);
		RF1 :	rf  port map(rst_dp, clk_dp, rf_in, rf_sel_dp, rf_enb_dp, rf_out);
		ACC1: acc port map(rst_dp, clk_dp, acc_in, acc_enb_dp, acc_out);
		
		process (rst_dp, alu_inA , alu_inB, alu_st_dp, alu_out, rf_in, rf_sel_dp, rf_enb_dp, rf_out, acc_in, acc_enb_dp, acc_out)
			begin
				if(rst_dp = '1') then
					output_dp <= "0000";
				elsif (clk_dp'event and clk_dp = '0') then
					case alu_st_dp is	
						when mova =>
							alu_inB <= rf_out;
							acc_in  <= alu_out;
							--output_dp <= alu_out;
						when movr =>
							alu_inA <= acc_out;
							rf_in <= alu_out;
							--output_dp <= alu_out;						
						when load =>
							alu_inB <= input_dp;
							acc_in  <= alu_out;
							--output_dp <= alu_out;
						when add =>
							alu_inA <= acc_out;
							alu_inB <= rf_out;
							acc_in  <= alu_out;
							--output_dp <= alu_out;
						when sub =>
							alu_inA <= acc_out;
							alu_inB <= rf_out;
							acc_in  <= alu_out;
							--output_dp <= alu_out;
						when andr =>
							alu_inA <= acc_out;
							alu_inB <= rf_out;
							acc_in  <= alu_out;
							--output_dp <= alu_out;
						when orr =>
							alu_inA <= acc_out;
							alu_inB <= rf_out;
							acc_in  <= alu_out;
							--output_dp <= alu_out;
						when inv =>
							alu_inA   <= acc_out;
							acc_in    <= alu_out;
							
						when others =>
							output_dp <= acc_out;
						
					end case;
					output_dp <= alu_out;
				end if;
		end process;
end rtl2;
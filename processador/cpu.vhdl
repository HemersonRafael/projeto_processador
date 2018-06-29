library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

-- Unidade Central de Processamento (UCP)
-- Central Processing Unit(CPU)
-- cpu (top level entity)

entity cpu is
   port ( 
			rst           : in  STD_LOGIC;
			start         : in  STD_LOGIC;
         clk           : in  STD_LOGIC;
			output        : out STD_LOGIC_VECTOR(3 downto 0);
       	a,b,c,d,e,f,g : out std_logic
          
        );
end cpu;

architecture struc of cpu is

component ctrl 
   port ( rst   : in STD_LOGIC;
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


  process(rst, clk, cpu_out)
  begin


    if(clk'event and clk='1') then
    output <= cpu_out;
    
       case cpu_out is
         when "0000" =>
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '0'; 
			  g <= '1';
         when "0001" =>
           a <= '1'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
           e <= '1'; 
			  f <= '1'; 
			  g <= '1';
         when "0010" =>
			  a <= '0'; 
			  b <= '0'; 
			  c <= '1'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '1'; 
			  g <= '0';
         when "0011" =>
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '1'; 
			  f <= '1'; 
			  g <= '0';
         when "0100" =>
           a <= '1'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
           e <= '1'; 
			  f <= '0'; 
			  g <= '0';
         when "0101" =>
           a <= '0'; 
			  b <= '1'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '1'; 
			  f <= '0'; 
			  g <= '0';
         when "0110" =>
           a <= '0'; 
			  b <= '1'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '0'; 
			  g <= '0';
         when "0111" =>
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '1'; 
           e <= '1'; 
			  f <= '1'; 
			  g <= '1';
         when "1000" =>
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '0'; 
			  g <= '0';
         when "1001" =>
           a <= '0'; 
			  b <= '0'; 
			  c <= '0'; 
			  d <= '0'; 
           e <= '0'; 
			  f <= '1'; 
			  g <= '0';
         when others =>
       end case;
    end if;
  end process;							

end struc;




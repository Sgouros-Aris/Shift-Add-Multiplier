library ieee;
use ieee.std_logic_1164.all;

entity barrel_shifter20 is
port ( input: in std_logic_vector(19 downto 0);
	output: out std_logic_vector(19 downto 0);
	shift: in std_logic);

end barrel_shifter20;

architecture beh_barrel of barrel_shifter20 is

component Mux2to1
port( 	Input_A: 	in std_logic;
        Input_B: 	in std_logic;
	Input_Select:	in std_logic;
	Output_Mux: 	out std_logic);
end component;


begin
barrel_mux_0: Mux2to1 port map(	Input_A=>input(0), 
				Input_B=>'0', 
				Input_Select=> shift, 
				Output_Mux=> output(0));
mux_generate:
for i in 1 to 19 generate
barrel_mux_i: Mux2to1 port map(	Input_A=>input(i), 
				Input_B=> input(i-1), 
				Input_Select=> shift, 
				Output_Mux=>output(i));
end generate;


end beh_barrel;


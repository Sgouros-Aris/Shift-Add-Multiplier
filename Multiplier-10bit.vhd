library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all; 

 

entity Multiplier10bit is
	port (InputA : in std_logic_vector(9 downto 0);
 	      InputB : in std_logic_vector(9 downto 0);
	      Output : out std_logic_vector(19 downto 0)
	);
end Multiplier10bit;

architecture Multiplier10bit_arch of Multiplier10bit is

 	component And10b is
		port (Input1b 		: in std_logic;
 		      Input10b 		: in std_logic_vector(9 downto 0 );
		      and_out10b 	: out std_logic_vector(9 downto 0)
			);
	end component And10b;


	component barrel_shifter20 is
 	 	port ( 	input: in std_logic_vector(19 downto 0);
			output: out std_logic_vector(19 downto 0);
			shift: in std_logic);

	end component barrel_shifter20;


	component carry_lookahead_adder is
		port (	i_add1  	: in std_logic_vector(19 downto 0);
    			i_add2  	: in std_logic_vector(19 downto 0);
    			o_result   	: out std_logic_vector(19 downto 0)
    			);
	end component carry_lookahead_adder;

	type MATA is array ( 9 downto 0 ) of std_logic_vector( 19 downto 0);
	type MATB is array ( 9 downto 0 ) of std_logic_vector( 9 downto 0);
	type MATC is array ( 0 to 9,0 to 9 ) of std_logic_vector( 19 downto 0);
	
	signal E:MATA;
	signal outand:MATB;
	signal shift:MATC;
	signal a:MATA;


	

begin
	And0:	And10b port map(InputA(0),InputB,outand(0));
	a(0)<= "0000000000"&outand(0);

	And1:	And10b port map(InputA(1),InputB,outand(1));
	a(1)<= "0000000000"&outand(1);

	Shift1:	barrel_shifter20 port map(a(1),shift(1,0),'1');

	Add1:	carry_lookahead_adder port map(a(0),shift(1,0),E(1));

	Multiplication:for i in 2 to 9 generate
		And_i: And10b port map(InputA(i),InputB,outand(i));
		a(i) <= "0000000000"&outand(i);
		Shift_i: barrel_shifter20 port map(a(i),shift(i,0),'1');
		Shift_j:for j in 0 to i-1 generate
			Shift_ij: barrel_shifter20 port map(shift(i,j),shift(i,j+1),'1');
		end generate;
		Add_i:	carry_lookahead_adder port map(E(i-1),shift(i,i-1),E(i));
	end generate;

	Output<= E(9);

end Multiplier10bit_arch;
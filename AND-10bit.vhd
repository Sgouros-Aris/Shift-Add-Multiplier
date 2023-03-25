library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity And10b is
	port (	Input1b		: in std_logic;
 	      	Input10b 	: in std_logic_vector(9 downto 0 );
		and_out10b	: out std_logic_vector(9 downto 0)
	);
end And10b;
 
architecture And10b_arch of And10b is
 

begin 
	GEN_AND: for i in 0 to 9 generate
		and_out10b(i) <= Input10b(i) and Input1b;
	end generate GEN_AND;
	
end And10b_arch;


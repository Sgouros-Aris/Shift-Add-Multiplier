library ieee;
use ieee.std_logic_1164.all;

---------------------------Entity Declaration------------------------------------------

entity Mux2to1 is 
	port( 	Input_A: 		in std_logic;
              	Input_B: 		in std_logic;
		Input_Select:		in std_logic;
	      	Output_Mux: 		out std_logic
	);
end Mux2to1;

--------------------------Architectures Declaration-------------------------------------

architecture Mux2to1_Arch of Mux2to1 is

--------------------------Architecture Internal Signals Declaration--------------------

--------------------------Body of Architecture------------------------------------------

begin
	with Input_Select select
		Output_MUX <= 	Input_A when '0',
				Input_B when OTHERS;
		
end Mux2to1_Arch;


library ieee;
use ieee.std_logic_1164.all;

---------------------------Entity Declaration------------------------------------------

entity FullAdder is 

	port( 	Input_A: 		in std_logic;
              	Input_B: 		in std_logic;
		Input_Cin:		in std_logic;
		Output_Sum:		out std_logic;
	      	Output_Cout: 		out std_logic
	);

end FullAdder;

--------------------------Architectures Declaration-------------------------------------

architecture FullAdder_Arch of FullAdder is

--------------------------Architecture Internal Signals Declaration--------------------

signal A_XOR_B:		std_logic;	
signal A_AND_B:		std_logic;
signal Sig1_AND_Cin:	std_logic;

--------------------------Body of Architecture------------------------------------------

begin

	A_XOR_B <= Input_A XOR Input_B;
	A_AND_B <= Input_A AND Input_B;
	Sig1_AND_Cin <= A_XOR_B AND Input_Cin;
	Output_Sum <= A_XOR_B XOR Input_Cin;
	Output_Cout <= A_AND_B OR Sig1_AND_Cin;

end FullAdder_Arch;


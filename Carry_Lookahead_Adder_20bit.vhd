library ieee;
use ieee.std_logic_1164.all;
 
entity carry_lookahead_adder is
  generic (
    g_WIDTH : integer :=20 
    );
  port (
    i_add1  : in std_logic_vector(g_WIDTH-1 downto 0);
    i_add2  : in std_logic_vector(g_WIDTH-1 downto 0);
    o_result   : out std_logic_vector(g_WIDTH-1 downto 0)
    );
end carry_lookahead_adder;
 
 
architecture rtl of carry_lookahead_adder is
 
  component FullAdder is
    port (
      Input_A  : in  std_logic;
      Input_B  : in  std_logic;
      Input_Cin : in  std_logic;
      Output_Sum   : out std_logic;
      Output_Cout : out std_logic);
  end component FullAdder;
 
  signal w_G : std_logic_vector(g_WIDTH-1 downto 0); -- Generate
  signal w_P : std_logic_vector(g_WIDTH-1 downto 0); -- Propagate
  signal w_C : std_logic_vector(g_WIDTH downto 0);   -- Carry
 
  signal w_SUM  : std_logic_vector(g_WIDTH-1 downto 0);
 
begin
 
  -- Create the Full Adders
  GEN_FULL_ADDERS : for ii in 0 to g_WIDTH-1 generate
    FULL_ADDER_INST : FullAdder
      port map (
        Input_A  => i_add1(ii),
        Input_B  => i_add2(ii),
        Input_Cin => w_C(ii),        
        Output_Sum   => w_SUM(ii),
        Output_Cout => open
        );
  end generate GEN_FULL_ADDERS;
 
  -- Create the Generate (G) Terms:  Gi=Ai*Bi
  -- Create the Propagate Terms: Pi=Ai+Bi
  -- Create the Carry Terms:  
  GEN_CLA : for jj in 0 to g_WIDTH-1 generate
    w_G(jj)   <= i_add1(jj) and i_add2(jj);
    w_P(jj)   <= i_add1(jj) or i_add2(jj);
    w_C(jj+1) <= w_G(jj) or (w_P(jj) and w_C(jj));
  end generate GEN_CLA;
     
  w_C(0) <= '0'; -- no carry input
 
  o_result <= w_SUM;  
   
end rtl;

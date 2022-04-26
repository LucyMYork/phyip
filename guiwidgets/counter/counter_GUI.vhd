

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_GUI is
Port ( btn_input: in STD_LOGIC;
       counter_output: out STD_LOGIC_VECTOR(15 downto 0);
       clk_input: in STD_LOGIC);
end counter_GUI;

architecture Behavioral of counter_GUI is

signal counter_d,counter_q : UNSIGNED (15 downto 0);

begin

process(clk_input, counter_d) begin
    if (clk_input'event and clk_input='1')then
        counter_q<=counter_d;  
    end if;
end process;

counter_d<=counter_q+1 when btn_input='1' else
           counter_q;
           
counter_output<=STD_LOGIC_VECTOR(counter_q);

end Behavioral;

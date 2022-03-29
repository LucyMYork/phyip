library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity dbholder is
Port ( CLK100MHZ : in STD_LOGIC;
       btnC: in STD_LOGIC;
       LED: out STD_LOGIC_VECTOR(15 downto 0));
end dbholder;

architecture Behavioral of dbholder is
signal count_d,count_q: UNSIGNED(15 downto 0) :=to_unsigned(0,16);
signal mygate : STD_LOGIC;
begin

process (CLK100MHZ , count_q) begin
    if (CLK100MHZ 'event and CLK100MHZ ='1')  then 
        count_q<=count_d;
    end if;
end process;

--portmap in the button debouncer
mydebouncer_instance_1 : entity work.debouncer(Behavioral) port map(

--COMMA between rows
-- the inputs/ outs of the code beign port mapped in go FIRST

clk_input => CLK100MHZ ,
button_input=>btnC,
gate_output=>mygate
);

count_d<=count_q +1 when mygate='1' else count_q;

led<= STD_LOGIC_VECTOR(count_q);

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LED_Display is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           --led : out STD_LOGIC_VECTOR (15 downto 0);
           CLK100MHZ: in STD_LOGIC;
           seg: out STD_LOGIC_VECTOR(6 downto 0);
           dp: out STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0));
end LED_Display;

architecture Behavioral of LED_Display is

--signal digit : STD_LOGIC_VECTOR (3 downto 0);
signal counter_d,counter_q: UNSIGNED (31 downto 0);
-- 4 bits will hold what the four swithces of interest have a values
signal counter_logic: STD_LOGIC_VECTOR(31 downto 0);
signal switches : UNSIGNED (3 downto 0);
signal sw_unsigned: UNSIGNED (15 downto 0);

-- remember the registers need to be the same witdth as the ports used to define them.

begin

process(CLK100MHZ, counter_d) begin
    if (CLK100MHZ'event and CLK100MHZ='1')then
        counter_q<=counter_d;  
    end if;
end process;
 
--counter bits 29 and 30 should have a period of 1 second
-- 2 bit counter

--for a rate of a quatrter of a milisecond, use bits 17 and 18

counter_d<= counter_q +1;
counter_logic <= std_logic_vector(counter_q);

an<="1110" when (counter_logic(18 downto 17)="00") else
    "1101" when (counter_logic(18 downto 17)="01") else
    "1011" when (counter_logic(18 downto 17)="10") else
    "0111" when (counter_logic(18 downto 17)="11") else
    "1111";

--an<=sw(3 downto 0);  --swithces determine what anode to write to 
--an<= "0000";  --writes to all 4 digits at the sane time

--will display food:
--seg<="0100001" when (counter_logic(18 downto 17)="00")  else
--     "1000000" when (counter_logic(18 downto 17)="01") else
--     "1000000" when (counter_logic(18 downto 17)="10")  else
--     "0001110" when (counter_logic(18 downto 17)="11") else
--     "1111111";

-- 4 swithces assigned to each anode, switch configuration determines the number/hex displayed on the an

-- set sw to unsigned integers

sw_unsigned<= UNSIGNED(sw);
   
-- defines the 4 setss of switches used for each anode
switches <=sw_unsigned(3 downto 0) when (counter_logic(18 downto 17)="00") else
           sw_unsigned(7 downto 4) when (counter_logic(18 downto 17)="01") else
           sw_unsigned(11 downto 8) when (counter_logic(18 downto 17)="10") else
           sw_unsigned(15 downto 12) when (counter_logic(18 downto 17)="11") else
           sw_unsigned(3 downto 0);
                 
                 
seg<= "1000000" when (switches="0000") else --zero 0
      "1111001" when (switches="0001") else --one 1
      "0100100" when (switches="0010") else -- two 2
      "0110000" when (switches="0011") else --three 3
      "0011001" when (switches="0100") else --four 4
      "0010010" when (switches="0101") else --  five 
      "0000011" when (switches="0110") else --six 
      "1111000" when (switches="0111") else -- seven 
      "0000000" when (switches="1000") else --- eight 
      "0011000" when (switches="1001") else -- nine 
      "0001000" when (switches="1010") else -- A 
      "0000011" when (switches="1011") else --b 
      "1000110" when (switches="1100") else --C 
      "0100001" when (switches="1101") else --d 
      "0000110" when (switches="1110") else --E 
      "0001110" when (switches="1111") else --F 
      "1111111";






--dp <= sw(15);





end Behavioral;

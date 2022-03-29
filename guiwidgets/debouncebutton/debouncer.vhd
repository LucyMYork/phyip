library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity debouncer is
Port ( clk_input :in STD_LOGIC;
       button_input : in STD_LOGIC;
       gate_output: out STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is
    signal counter_d,counter_q : UNSIGNED (15 downto 0); ---chnaged to 16 bits for task C9
    --signal counter_in_logic: STD_LOGIC_VECTOR (31 downto 0);   
    signal bstore_d,bstore_q : STD_LOGIC;
    signal bcount_d,bcount_q: UNSIGNED (1 downto 0);
begin

process(clk_input , counter_d, bstore_d) begin
    if (clk_input 'event and clk_input ='1')then
        counter_q<=counter_d;
        bstore_q<=bstore_d;
        --stores weather the button has been pressed
        bcount_q<=bcount_d;
        --bcount should increment with number of button presses in a short ammount of time, reducing bounce
    end if;
    
end process;
            
              

bstore_d<='1' when (button_input ='1' and bstore_q='0') else
          '0' when (button_input ='0' and bstore_q='1') else
          bstore_d;

--b count increment when pressed or unpressed 
bcount_d<=bcount_q +1 when ((button_input ='1' and bstore_q='0') or (button_input ='0' and bstore_q='1')) else
          bcount_q +1 when bcount_q > 0 else
          bcount_q;
          
          
gate_output<='1' when (button_input ='1' and bstore_q='0' and bcount_q=0) else
             '0';
--ate_output<=STD_LOGIC(bcount_q);

--cast the resulting register state to the output gate 

end Behavioral;

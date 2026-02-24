library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Indispensable pour l'arithmÃ©tique

type vect is array of std_logic_vector(31 downto 0);

entity perceptron is
    Generic (
        SIZE_INPUT : integer := 16 ;
    );
    Port ( 
        CK, RST, EN : in std_logic;
        VALID : out std_logic;
        IN_VALUE : in std_logic_vector(31 downto 0);
        OUT_VALUE : out std_logic_vector(31 downto 0);
    );
end perceptron;

architecture Behavioral of perceptron is
    signal sum : signed(15 downto 0) := (others => '0'); -- valeur de sortie 
    signal mul : signed(31 downto 0) := (others => '0');
    signal weight : vect(15 downto 0) := (others=>'0');
    signal index = integer range 0 to SIZE_INPUT := 0;
begin
    process(CK,EN)

    begin
        wait until CK'event and CK='1'
            if RST='0' then 
                sum<=(others => '0');
                index <= 0;
            elsif EN='1' then
                if index < SIZE_INPUT then
                    mul <= IN_VALUE*weight(index);
                    --choisir comment on passe de 32 à 16 bits ici
                    sum <= sum + mul
                    index <= index + 1 ;
                    if index = SIZE_INPUT then
                        index <= 0;
                        VALID <= 1;
                        sum<=0
                        if sum < 0 then -- on commence avec ReLU(x)
                            OUT_VALUE<=0;
                        else 
                            OUT_VALUE<=sum; 
                        end if ;
                    end if ;
            --    else 
            --       index = 0;
            --       VALID = 1;
            --      if sum < 0 then -- on commence avec ReLU(x)
            --            OUT_VALUE<=0;
            --        else 
            --            OUT_VALUE<=sum; 
            --        end if ;
                end if;
            end if;
    end process;
end Behavioral;
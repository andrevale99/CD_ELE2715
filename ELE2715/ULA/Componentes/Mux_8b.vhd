--========================================================================
-- 	MUX DE 2 BITS
--========================================================================

entity MUX8B is
    port(i : in bit_vector(7 downto 0);
         s : in bit_vector(2 downto 0);
         q : out bit);
end MUX8B;

architecture ckt of MUX8B is

begin

    q <= (i(0) and not s(2) and not s(1) and not s(0))
         or 
         (i(1) and not s(2) and not s(1) and s(0))
         or 
         (i(2) and not s(2) and s(1) and not s(0))
         or 
         (i(3) and not s(2) and s(1) and s(0))
         or 
         (i(4) and s(2) and not s(1) and not s(0))
         or 
         (i(5) and s(2) and not s(1) and s(0))
         or 
         (i(6) and s(2) and s(1) and not s(0))
         or 
         (i(7) and s(2) and s(1) and s(0));

end ckt;
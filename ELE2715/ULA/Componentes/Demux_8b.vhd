--========================================================================
-- 	DEMUX DE 8 BITS
--========================================================================
entity DEMUX8B is
    port(i : in bit;
         s : in bit_vector(2 downto 0);
         q : out bit_vector(7 downto 0));
end DEMUX8B;

architecture ckt of DEMUX8B is

begin

    q(0) <= (i and not s(2) and not s(1) and not s(0));
    q(1) <= (i and not s(2) and not s(1) and s(0));
    q(2) <= (i and not s(2) and s(1) and not s(0));
    q(3) <= (i and not s(2) and s(1) and s(0));
    q(4) <= (i and s(2) and not s(1) and not s(0));
    q(5) <= (i and s(2) and not s(1) and s(0));
    q(6) <= (i and s(2) and s(1) and not s(0));
    q(7) <= (i and s(2) and s(1) and s(0));

end ckt;
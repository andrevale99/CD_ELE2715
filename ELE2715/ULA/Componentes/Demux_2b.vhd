--========================================================================
-- 	DEMUX DE 2 BITS
--========================================================================

entity DEMUX2B is
    port (i : in bit;
          q0, q1 : out bit;
          s : in bit);
end DEMUX2B;

architecture ckt of DEMUX2B is

begin

    q0 <= (i and not s);
    q1 <= (i and s);

end ckt;
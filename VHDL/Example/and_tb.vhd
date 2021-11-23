entity ckt_tb is
end ckt_tb;

architecture bench of ckt_tb is
  component t is
    port(A,B: in bit;
        X: out bit);
    end component;

    signal A:bit;
    signal B:bit;
    signal X:bit;

    for lab: t use entity work.ckt;

    begin
      lab: t
      port map ( A => A, B => B, X => X);

    process
    begin
      A <= '1';
      B <= '1';
      wait for 100 ms;

      A <= '0';
      B <= '1';
      wait for 100 ms;
      wait;
    end process;

end bench;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity final is

	port(	reloj: in std_logic;
			boton1, boton2: in std_logic;
			switchesB: in std_logic_vector(3 downto 0);
			switchesP: in std_logic_vector(2 downto 0);
			display1, display2, display3, display4, display5, display6: inout std_logic_vector(6 downto 0);
			leds: out std_logic_vector(3 downto 0));

end final;


architecture Behavioral of final is

	type estados is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);
	signal epresente: estados := s0;
	signal esiguiente: estados;

	signal segundo: std_logic;
	signal Q: std_logic_vector(5 downto 0);
	signal limiteMensaje: std_logic_vector(5 downto 0):= "011000";
	signal reinicio: std_logic := '0';
	
	
	begin
	
		divisor: process(reloj)
			variable cuenta: std_logic_vector(27 downto 0) := X"0000000";
			begin if rising_edge(reloj) then
				if cuenta = X"48009E0" then
					cuenta := X"0000000";
				else
					cuenta := cuenta+1;
				end if;
			end if;
			segundo <= cuenta(23);
		end process;
		
		
		MdE1: process(segundo) -- transición
			variable cuenta: std_logic_vector(5 downto 0) := "000000";
			begin if rising_edge(segundo) then
				if esiguiente = epresente then
					epresente <= esiguiente;
				else
					if esiguiente = s0 then
						limiteMensaje <= "011000";
					elsif esiguiente = s1 then
						limiteMensaje <= "110101";
					elsif esiguiente = s2 then
						limiteMensaje <= "011010";
					elsif esiguiente = s3 then
						limiteMensaje <= "011001";
					elsif esiguiente = s4 then
						limiteMensaje <= "011000";
					elsif esiguiente = s5 then
						limiteMensaje <= "010000";
					elsif esiguiente = s6 then
						limiteMensaje <= "010000";
					elsif esiguiente = s7 then
						limiteMensaje <= "010000";
					elsif esiguiente = s8 then
						limiteMensaje <= "010000";
					else -- s9
						limiteMensaje <= "001101";
					end if;
					reinicio <= '1';
					epresente <= esiguiente;
				end if;
				if cuenta = limiteMensaje or reinicio = '1' then
					cuenta := "000000";
					reinicio <= '0';
				else
					cuenta := cuenta+1;
				end if;
				Q <= cuenta;
			end if;
		end process;
		
		
		
		MdE2: process(epresente, boton1, boton2, Q, switchesP, switchesB)
		
			begin case epresente is
					
				when s0 => -- inicio cine
					if Q = "000000" then
						leds <= "0000";
						display1 <= "1110111";
					elsif Q = "000001" then
						display1 <= "1000110";
					elsif Q = "000010" then
						display1 <= "1111001";
					elsif Q = "000011" then
						display1 <= "0101011";
					elsif Q = "000100" then
						display1 <= "0000110";
					elsif Q = "000110" then
						display1 <= "0001110";
					elsif Q = "000111" then
						display1 <= "1111001";
					elsif Q = "001000" then
						display1 <= "1110111";
					elsif Q = "001011" then
						display1 <= "0001100";
					elsif Q = "001100" then
						display1 <= "1111001";
					elsif Q = "001101" then
						display1 <= "1000110";
					elsif Q = "001110" then
						display1 <= "0001000";
					elsif Q = "010001" then
						display1 <= "0000011";
					elsif Q = "010010" then
						display1 <= "0100011";
					elsif Q = "010011" then
						display1 <= "1001110";
					elsif Q = "010100" then
						display1 <= "0100011";
					elsif Q = "010101" then
						display1 <= "0101011";
					else
						display1 <= "1111111";
					end if;
					
					if boton1 = '0' then
						esiguiente <= s1;
					else
						esiguiente <= s0;
					end if;
					
					
				when s1 => -- eleccion pelicula
					if Q = "000000" then
						display1 <= "0001001";
					elsif Q = "000001" then
						display1 <= "1000000";
					elsif Q = "000010" then
						display1 <= "1000111";
					elsif Q = "000011" then
						display1 <= "0001000";
					elsif Q = "000100" then
						display1 <= "1110111";
					elsif Q = "000110" then
						display1 <= "0100101";
					elsif Q = "000111" then
						display1 <= "0011000";
					elsif Q = "001000" then
						display1 <= "1000001";
					elsif Q = "001001" then
						display1 <= "0000110";
					elsif Q = "001011" then
						display1 <= "0001100";
					elsif Q = "001100" then
						display1 <= "0000110";
					elsif Q = "001101" then
						display1 <= "1000111";
					elsif Q = "001110" then
						display1 <= "1111001";
					elsif Q = "001111" then
						display1 <= "1000110";
					elsif Q = "010000" then
						display1 <= "1000001";
					elsif Q = "010001" then
						display1 <= "1000111";
					elsif Q = "010010" then
						display1 <= "0001000";
					elsif Q = "010100" then
						display1 <= "0011000";
					elsif Q = "010101" then
						display1 <= "1000001";
					elsif Q = "010110" then
						display1 <= "1111001";
					elsif Q = "010111" then
						display1 <= "0000110";
					elsif Q = "011000" then
						display1 <= "0101111";
					elsif Q = "011001" then
						display1 <= "0000110";
					elsif Q = "011010" then
						display1 <= "0010010";
					elsif Q = "011011" then
						display1 <= "0101100";
					elsif Q = "011101" then
						display1 <= "0110111";
					elsif Q = "011111" then
						display1 <= "1111001";
					elsif Q = "100000" then
						display1 <= "1110111";
					elsif Q = "100001" then
						display1 <= "1000110";
					elsif Q = "100010" then
						display1 <= "0001000";
					elsif Q = "100011" then
						display1 <= "0101111";
					elsif Q = "100100" then
						display1 <= "0010010";
					elsif Q = "100111" then
						display1 <= "0100100";
					elsif Q = "101000" then
						display1 <= "1110111";
					elsif Q = "101001" then
						display1 <= "0000110";
					elsif Q = "101010" then
						display1 <= "0010010";
					elsif Q = "101011" then
						display1 <= "1000000";
					elsif Q = "101110" then
						display1 <= "0110000";
					elsif Q = "101111" then
						display1 <= "1110111";
					elsif Q = "110000" then
						display1 <= "1000001";
					elsif Q = "110001" then
						display1 <= "0001100";
					else
						display1 <= "1111111";
					end if;
					
					if boton1 = '0' then
						if switchesP = "001" then
							esiguiente <= s2;
						elsif switchesP = "010" then
							esiguiente <= s3;
						elsif switchesP = "011" then
							esiguiente <= s3;
						elsif switchesP = "100" then
							esiguiente <= s4;
						elsif switchesP = "101" then
							esiguiente <= s4;
						elsif switchesP = "110" then
							esiguiente <= s4;
						elsif switchesP = "111" then
							esiguiente <= s4;
						else
							esiguiente <= s1;
						end if;
					else
						esiguiente <= s1;
					end if;
					
					
					
				when s2 => -- 1_Cars boletos
					if Q = "000000" then
						display1 <= "1111001";
					elsif Q = "000001" then
						display1 <= "1110111";
					elsif Q = "000010" then
						display1 <= "1000110";
					elsif Q = "000011" then
						display1 <= "0001000";
					elsif Q = "000100" then
						display1 <= "0101111";
					elsif Q = "000101" then
						display1 <= "0010010";
					elsif Q = "000111" then
						display1 <= "0100101";
					elsif Q = "001000" then
						display1 <= "1000110";
					elsif Q = "001001" then
						display1 <= "1000001";
					elsif Q = "001010" then
						display1 <= "0001000";
					elsif Q = "001011" then
						display1 <= "0101011";
					elsif Q = "001100" then
						display1 <= "1001110";
					elsif Q = "001101" then
						display1 <= "0100011";
					elsif Q = "001110" then
						display1 <= "0010010";
					elsif Q = "010000" then
						display1 <= "0000011";
					elsif Q = "010001" then
						display1 <= "0100011";
					elsif Q = "010010" then
						display1 <= "1000111";
					elsif Q = "010011" then
						display1 <= "0000110";
					elsif Q = "010100" then
						display1 <= "1001110";
					elsif Q = "010101" then
						display1 <= "0100011";
					elsif Q = "010110" then
						display1 <= "0010010";
					elsif Q = "010111" then
						display1 <= "0101100";
					else
						display1 <= "1111111";
					end if;
					
					if boton1 = '0' then
						if switchesB = "0000" then
							esiguiente <= s2;
						else
							if switchesB = "0001" then
								esiguiente <= s8;
							elsif switchesB = "0010" then
								esiguiente <= s7;
							elsif switchesB = "0011" then
								esiguiente <= s7;
							elsif switchesB = "0100" then
								esiguiente <= s6;
							elsif switchesB = "0101" then
								esiguiente <= s6;
							elsif switchesB = "0110" then
								esiguiente <= s6;
							elsif switchesB = "0111" then
								esiguiente <= s6;
							else
								esiguiente <= s5;
							end if;
						end if;
					else
						esiguiente <= s2;
					end if;
					
					
					
				when s3 => -- 2_Eso boletos
					if Q = "000000" then
						display1 <= "0100100";
					elsif Q = "000001" then
						display1 <= "1110111";
					elsif Q = "000010" then
						display1 <= "0000110";
					elsif Q = "000011" then
						display1 <= "0010010";
					elsif Q = "000100" then
						display1 <= "1000000";
					elsif Q = "000110" then
						display1 <= "0100101";
					elsif Q = "000111" then
						display1 <= "1000110";
					elsif Q = "001000" then
						display1 <= "1000001";
					elsif Q = "001001" then
						display1 <= "0001000";
					elsif Q = "001010" then
						display1 <= "0101011";
					elsif Q = "001011" then
						display1 <= "1001110";
					elsif Q = "001100" then
						display1 <= "0100011";
					elsif Q = "001101" then
						display1 <= "0010010";
					elsif Q = "001111" then
						display1 <= "0000011";
					elsif Q = "010000" then
						display1 <= "0100011";
					elsif Q = "010001" then
						display1 <= "1000111";
					elsif Q = "010010" then
						display1 <= "0000110";
					elsif Q = "010011" then
						display1 <= "1001110";
					elsif Q = "010100" then
						display1 <= "0100011";
					elsif Q = "010101" then
						display1 <= "0010010";
					elsif Q = "010110" then
						display1 <= "0101100";
					else
						display1 <= "1111111";
					end if;
					
					if boton1 = '0' then
						if switchesB = "0000" then
							esiguiente <= s3;
						else
							if switchesB = "0001" then
								esiguiente <= s8;
							elsif switchesB = "0010" then
								esiguiente <= s7;
							elsif switchesB = "0011" then
								esiguiente <= s7;
							elsif switchesB = "0100" then
								esiguiente <= s6;
							elsif switchesB = "0101" then
								esiguiente <= s6;
							elsif switchesB = "0110" then
								esiguiente <= s6;
							elsif switchesB = "0111" then
								esiguiente <= s6;
							else
								esiguiente <= s5;
							end if;
							
						end if;
					else
						esiguiente <= s3;
					end if;
					
					
					
					
				when s4 => -- 3_UP boletos
					if Q = "000000" then
						display1 <= "0110000";
					elsif Q = "000001" then
						display1 <= "1110111";
					elsif Q = "000010" then
						display1 <= "1000001";
					elsif Q = "000011" then
						display1 <= "0001100";
					elsif Q = "000101" then
						display1 <= "0100101";
					elsif Q = "000110" then
						display1 <= "1000110";
					elsif Q = "000111" then
						display1 <= "1000001";
					elsif Q = "001000" then
						display1 <= "0001000";
					elsif Q = "001001" then
						display1 <= "0101011";
					elsif Q = "001010" then
						display1 <= "1001110";
					elsif Q = "001011" then
						display1 <= "0100011";
					elsif Q = "001100" then
						display1 <= "0010010";
					elsif Q = "001110" then
						display1 <= "0000011";
					elsif Q = "001111" then
						display1 <= "0100011";
					elsif Q = "010000" then
						display1 <= "1000111";
					elsif Q = "010001" then
						display1 <= "0000110";
					elsif Q = "010010" then
						display1 <= "1001110";
					elsif Q = "010011" then
						display1 <= "0100011";
					elsif Q = "010100" then
						display1 <= "0010010";
					elsif Q = "010101" then
						display1 <= "0101100";
					else
						display1 <= "1111111";
					end if;
					
					if boton1 = '0' then
						if switchesB = "0000" then
							esiguiente <= s4;
						else
							if switchesB = "0001" then
								esiguiente <= s8;
							elsif switchesB = "0010" then
								esiguiente <= s7;
							elsif switchesB = "0011" then
								esiguiente <= s7;
							elsif switchesB = "0100" then
								esiguiente <= s6;
							elsif switchesB = "0101" then
								esiguiente <= s6;
							elsif switchesB = "0110" then
								esiguiente <= s6;
							elsif switchesB = "0111" then
								esiguiente <= s6;
							else
								esiguiente <= s5;
							end if;
							
						end if;
					else
						esiguiente <= s4;
					end if;
					
					
				when s5 => -- Pagar 4
				
					leds <= "1111";
				
					if Q = "000000" then
						display1 <= "0001100";
					elsif Q = "000001" then
						display1 <= "0001000";
					elsif Q = "000010" then
						display1 <= "1000010";
					elsif Q = "000011" then
						display1 <= "0001000";
					elsif Q = "000100" then
						display1 <= "0101111";
					elsif Q = "000110" then
						display1 <= "0011001"; -- Número 4
					elsif Q = "001000" then
						display1 <= "0001100";
					elsif Q = "001001" then
						display1 <= "0000110";
					elsif Q = "001010" then
						display1 <= "0010010";
					elsif Q = "001011" then
						display1 <= "1000000";
					elsif Q = "001100" then
						display1 <= "0010010";
					else
						display1 <= "1111111";
					end if;
					
					if boton2 = '0' then
						esiguiente <= s6;
					else
						esiguiente <= s5;
					end if;
					

				when s6 => -- Pagar 3
				
					leds <= "0111";
				
					if Q = "000000" then
						display1 <= "0001100";
					elsif Q = "000001" then
						display1 <= "0001000";
					elsif Q = "000010" then
						display1 <= "1000010";
					elsif Q = "000011" then
						display1 <= "0001000";
					elsif Q = "000100" then
						display1 <= "0101111";
					elsif Q = "000110" then
						display1 <= "0110000"; -- Número 3
					elsif Q = "001000" then
						display1 <= "0001100";
					elsif Q = "001001" then
						display1 <= "0000110";
					elsif Q = "001010" then
						display1 <= "0010010";
					elsif Q = "001011" then
						display1 <= "1000000";
					elsif Q = "001100" then
						display1 <= "0010010";
					else
						display1 <= "1111111";
					end if;
					
					if boton2 = '0' then
						esiguiente <= s7;
					else
						esiguiente <= s6;
					end if;
					
					
				when s7 => -- Pagar 2
				
					leds <= "0011";
				
					if Q = "000000" then
						display1 <= "0001100";
					elsif Q = "000001" then
						display1 <= "0001000";
					elsif Q = "000010" then
						display1 <= "1000010";
					elsif Q = "000011" then
						display1 <= "0001000";
					elsif Q = "000100" then
						display1 <= "0101111";
					elsif Q = "000110" then
						display1 <= "0100100"; -- Número 2
					elsif Q = "001000" then
						display1 <= "0001100";
					elsif Q = "001001" then
						display1 <= "0000110";
					elsif Q = "001010" then
						display1 <= "0010010";
					elsif Q = "001011" then
						display1 <= "1000000";
					elsif Q = "001100" then
						display1 <= "0010010";
					else
						display1 <= "1111111";
					end if;
					
					if boton2 = '0' then
						esiguiente <= s8;
					else
						esiguiente <= s7;
					end if;

					
				when s8 => -- Pagar 1
				
					leds <= "0001";
				
					if Q = "000000" then
						display1 <= "0001100";
					elsif Q = "000001" then
						display1 <= "0001000";
					elsif Q = "000010" then
						display1 <= "1000010";
					elsif Q = "000011" then
						display1 <= "0001000";
					elsif Q = "000100" then
						display1 <= "0101111";
					elsif Q = "000110" then
						display1 <= "1111001"; -- Número 1
					elsif Q = "001000" then
						display1 <= "0001100";
					elsif Q = "001001" then
						display1 <= "0000110";
					elsif Q = "001010" then
						display1 <= "0010010";
					elsif Q = "001011" then
						display1 <= "1000000";
					else
						display1 <= "1111111";
					end if;
					
					if boton2 = '0' then
						esiguiente <= s9;
					else
						esiguiente <= s8;
					end if;
					
					
				when s9 => -- Gracias
				
					leds <= "0000";
				
					if Q = "000000" then
						display1 <= "1000010";
					elsif Q = "000001" then
						display1 <= "0101111";
					elsif Q = "000010" then
						display1 <= "0001000";
					elsif Q = "000011" then
						display1 <= "1000110";
					elsif Q = "000100" then
						display1 <= "1111001";
					elsif Q = "000101" then
						display1 <= "0001000";
					elsif Q = "000110" then
						display1 <= "0010010";
					elsif Q = "001000" then
						display1 <= "1110111";
					elsif Q = "001001" then
						display1 <= "1110111";
					elsif Q = "001010" then
						display1 <= "1110111";
					else
						display1 <= "1111111";
					end if;
					
					if boton1 = '0' then
						esiguiente <= s0;
					else
						esiguiente <= s9;
					end if;
					
			end case;
		end process;
	

	-- Cambio de corrimiento de registros.
	FF1: process(segundo)
	begin
		if rising_edge(segundo) then
			display2 <= display1;
		end if;
	end process;
	
	FF2: process(segundo)
	begin
		if rising_edge(segundo) then
			display3 <= display2;
		end if;
	end process;
	
	FF3: process(segundo)
	begin
		if rising_edge(segundo) then
			display4 <= display3;
		end if;
	end process;
	
	FF4: process(segundo)
	begin
		if rising_edge(segundo) then
			display5 <= display4;
		end if;
	end process;
	
	FF5: process(segundo)
	begin
		if rising_edge(segundo) then
			display6 <= display5;
		end if;
	end process;


end Behavioral;
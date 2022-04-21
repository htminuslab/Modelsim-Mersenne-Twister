---------------------------------------------------------------------------------------------------
-- Simple FLI demo generating 64bits random numbers using the Mersenne Twister
--
-- https://github.com/htminuslab            
--                                       
---------------------------------------------------------------------------------------------------
--  See license note in mt.c                                                  
---------------------------------------------------------------------------------------------------
--
--  Testbench
-- 
--  Revision History:                                                        
--                                                                           
--  Date:          Revision     Author         
--  23 May   2014  0.1          Hans Tiggeler 
--  21 April 2022  0.1a         Hans Tiggeler Cleaned up/checked Modelsim 2022.1
---------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pkg is
    -- Initialise Mersenne Twister
    procedure init_genrand64(seed:in unsigned(63 downto 0));
    attribute FOREIGN of init_genrand64 : procedure is "init_genrand64 ./fli_mt.dll";
    -- Get 64bits random number
    procedure get_rand64(msw:inout integer; lsw:inout integer);
    attribute FOREIGN of get_rand64 : procedure is "get_rand64 ./fli_mt.dll";   
end;

package body pkg is
    procedure init_genrand64(seed:in unsigned(63 downto 0)) is begin end;
    procedure get_rand64(msw:inout integer; lsw:inout integer) is begin end;
end;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

use work.pkg.all;

architecture example of tb is

begin

  initproc: process
     variable seed : unsigned(63 downto 0):=(others=>'0'); 
  begin
    init_genrand64(seed);                           -- Generate Seed
    wait;
  end process;


  genproc: process
     variable x : unsigned(63 downto 0);
     variable msw :integer ;
     variable lsw :integer ;
     
  begin
    wait for 10 ns;
    get_rand64(msw,lsw);                            -- Get 64bits random number
    x(63 downto 32):=unsigned(to_signed(msw,32));   -- Convert two 32bits to single 64 bits unsigned
    x(31 downto 0):=unsigned(to_signed(lsw,32));
    
    report "MT=" & "0x" & to_hstring(x);            -- Display in transcript
    
  end process;

end;


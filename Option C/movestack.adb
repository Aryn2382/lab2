package body movestack is
   Delt: Float;
   procedure movestack(N: in Integer; Base: in out arrayTypes.intArray; Top: in out arrayTypes.intArray; StackSpace: in out arrayTypes.stringArray; NewBase: in arrayTypes.intArray) is
   begin
      for J in 2..N loop
         if NewBase(J) < Base(J) then
            Delt := Float(Base(J) - NewBase(J));
            for L in (Base(J) + 1)..Top(J) loop
               StackSpace(L - Integer(Delt)) := StackSpace(L);
            end loop;
            Base(J) := NewBase(J);
            Top(J) := Top(J) - Integer(Delt);
         end if;
      end loop;
      for J in N..2 loop
         if NewBase(J) > Base(J) then
            Delt := Float(NewBase(J) - Base(J));
            for L in Top(J)..(Base(J) + 1) loop
               StackSpace(L + Integer(Delt)) := StackSpace(L);
            end loop;
            Base(J) := NewBase(J);
            Top(J) := Top(J) + Integer(Delt);
         end if;
      end loop;
   end;
end movestack;

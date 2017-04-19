with Ada.Text_IO; use Ada.Text_IO;

package body movestack is
   Delt: Float;
   procedure movestack(N: in Integer; Base: in out arrayTypes.intArray; Top: in out arrayTypes.intArray; StackSpace: in out arrayTypes.stringArray; NewBase: in arrayTypes.intArray) is
      package Int_IO is new Ada.Text_IO.Integer_IO(Integer); use Int_IO;
   begin
      for J in 2..N loop
         if NewBase(J) < Base(J) then
            Delt := Float(Base(J) - NewBase(J));
            for L in (Base(J) + 1)..Top(J) loop
               Put("StackSpace("); Put((L - Integer(Delt)), 1); Put(") := "); Put("StackSpace("); Put(L, 1); Put(")"); New_Line;
               StackSpace(L - Integer(Delt)) := StackSpace(L);
            end loop;
            Base(J) := NewBase(J);
            Top(J) := Top(J) - Integer(Delt);
         end if;
      end loop;
      for J in reverse 2..N loop
         if NewBase(J) > Base(J) then
            Delt := Float(NewBase(J) - Base(J));
            for L in reverse (Base(J) + 1)..Top(J) loop
               Put("StackSpace("); Put((L + Integer(Delt)), 1); Put(") := "); Put("StackSpace("); Put(L, 1); Put(")"); New_Line;
               StackSpace(L + Integer(Delt)) := StackSpace(L);
            end loop;
            Base(J) := NewBase(J);
            Top(J) := Top(J) + Integer(Delt);
         end if;
      end loop;
   end;
end movestack;

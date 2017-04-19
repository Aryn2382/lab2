with Ada.Text_IO; use Ada.Text_IO;
with movestack; use movestack;

package body reallocate is
   Avail, TotalInc, J, MinSpace : Integer;
   GrowthAllocate, Alpha, Beta, Sigma, Tau : Float;

   procedure reallocate(max : in Integer; init : in Integer; stack: in Integer; stacks : in Integer; base : in out arrayTypes.intArray; top : in out arrayTypes.intArray; EqualAllocate : in Float; StackSpace: in out arrayTypes.stringArray; text: in arrayTypes.charArray) is
      package Int_IO is new Ada.Text_IO.Integer_IO(Integer); use Int_IO;
      package Float_IO is new Ada.Text_IO.Float_IO(Float); use Float_IO;
   begin
      declare
         OldTop, Growth, NewBase : arrayTypes.intArray(1..stacks);
      begin
         for i in 1..stacks loop
            OldTop(i) := Integer(Float'Floor(((Float(i) - 1.0) / 4.0 * Float(max - init)) + Float(init))) + 1;
         end loop;

         Put("Base(J): ( ");
         for i in 1..(stacks + 1) loop
            Put(Base(i), 1); Put(" ");
         end loop;
         Put(")"); New_Line;
         Put("Top(J): ( ");
         for i in 1..stacks loop
            if i = stack then
               Put(top(i) - 1, 1);
            else
               Put(top(i), 1);
            end if;
            Put(" ");
         end loop;
         Put(")"); New_Line;
         Put("OldTop(J): ( ");
         for i in 1..stacks loop
            Put(OldTop(i), 1); Put(" ");
         end loop;
         Put(")"); New_Line; New_Line;

         Avail := max - init;
         TotalInc := 0;
         J := stacks;
         MinSpace := Integer(Float'Floor(Float(max) * 0.05));
         while J > 0 loop
            Avail := Avail - (top(J) - base(J));
            if top(J) > OldTop(J) then
               Growth(J) := top(J) - OldTop(J);
               TotalInc := TotalInc + Growth(J);
            else
               Growth(J) := 0;
            end if;
            J := J - 1;
         end loop;

         if Avail < MinSpace - 1 then
            Put_Line("MEMORY OVERLOAD");
            top(stack) := top(stack) - 1;
         else
            GrowthAllocate := 1.0 - EqualAllocate;
            Alpha := EqualAllocate * Float(Avail) / Float(stacks);
            Beta := GrowthAllocate * Float(Avail) / Float(TotalInc);
            NewBase(1) := Base(1);
            Sigma := 0.0;
            for i in 2..stacks loop
               Tau := Sigma + Alpha + (Float(Growth(i - 1)) * Beta);
               NewBase(i) := NewBase(i - 1) + (top(i - 1) - base(i - 1)) + Integer(Float'Floor(Tau)) - Integer(Float'Floor(Sigma));
               Sigma := Tau;
            end loop;
            top(stack) := top(stack) - 1;
            movestack.movestack(4, base, top, StackSpace, NewBase);
            top(stack) := top(stack) + 1;
            StackSpace(top(stack)) := text;
            for i in 1..stacks loop
               OldTop(i) := top(i);
            end loop;

            Put("After repacking:");
            New_Line;
            for i in (init + 1)..max loop
               Put(i); Put(": ");
               if (i > base(1) and i <= top(1)) or (i > base(2) and i <= top(2)) or (i > base(3) and i <= top(3)) or (i > base(4) and i <= top(4)) then
                  for j in 1..StackSpace(i)'Length loop
                     Put(StackSpace(i)(j));
                  end loop;
                  New_Line;
               else
                  New_Line;
               end if;
            end loop;
            New_Line;
            Put("Base(J): ( ");
            for i in 1..(stacks + 1) loop
               Put(Base(i), 1); Put(" ");
            end loop;
            Put(")"); New_Line;
            Put("Top(J): ( ");
            for i in 1..stacks loop
               Put(top(i), 1); Put(" ");
            end loop;
            Put(")"); New_Line; New_Line;

         end if;

      end;
   end;
end reallocate;

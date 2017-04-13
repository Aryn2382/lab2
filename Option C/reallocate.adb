with Ada.Text_IO; use Ada.Text_IO;
with movestack; use movestack;

package body reallocate is
   Avail, TotalInc, J, MinSpace : Integer;
   GrowthAllocate, Alpha, Beta, Sigma, Tau : Float;

   procedure reallocate(max : in Integer; init : in Integer; stack: in Integer; stacks : in Integer; base : in out arrayTypes.intArray; top : in out arrayTypes.intArray; EqualAllocate : in Float; StackSpace: in out arrayTypes.stringArray) is
      package Int_IO is new Ada.Text_IO.Integer_IO(Integer); use Int_IO;
      package Float_IO is new Ada.Text_IO.Float_IO(Float); use Float_IO;
   begin
      declare
         OldTop, Growth, NewBase : arrayTypes.intArray(1..stacks);
      begin
         for i in 1..stacks loop
            OldTop(i) := Integer(Float'Floor(((Float(i) - 1.0) / 4.0 * Float(max - init)) + Float(init))) + 1;
         end loop;
         Avail := max - init;
         TotalInc := 0;
         J := stacks;
         MinSpace := Integer(Float'Floor(Float(max) * 0.1));
         while J > 0 loop
            --Put("J "); Put(J);
            --Put(top(J)); Put(" "); Put(base(J)); New_Line;
            Avail := Avail - (top(J) - base(J));
            if top(J) > OldTop(J) then
               Growth(J) := top(J) - OldTop(J);
               TotalInc := TotalInc + Growth(J);
               --Put("TotalInc "); Put(TotalInc);
            else
               Growth(J) := 0;
            end if;
            J := J - 1;
         end loop;
         if TotalInc = 0 then
            TotalInc := 1;
         end if;

         if Avail < MinSpace - 1 then
               Put_Line("MEMORY OVERLOAD");
         else
            GrowthAllocate := 1.0 - EqualAllocate;
            Alpha := EqualAllocate * Float(Avail) / Float(stacks);
            --Put(TotalInc);
            Beta := GrowthAllocate * Float(Avail) / Float(TotalInc);
            NewBase(1) := Base(1);
            Sigma := 0.0;
            for i in 2..stacks loop
               --Put(i); New_Line;
               --Put(Beta); New_Line;
               Tau := Sigma + Alpha + Float(Growth(i - 1)) * Beta;
               --Put(Integer(Float'Floor(Tau))); New_Line;
               NewBase(i) := NewBase(i - 1) + (top(i - 1) - base(i - 1)) + Integer(Float'Floor(Tau)) - Integer(Float'Floor(Sigma));
               Sigma := Tau;
            end loop;
            top(stack) := top(stack) - 1;
            movestack.movestack(4, base, top, StackSpace, NewBase);
            top(stack) := top(stack) + 1;
            --insert item?????
            for i in 1..stacks loop
               OldTop(i) := top(i);
            end loop;
         end if;

      end;
   end;
end reallocate;

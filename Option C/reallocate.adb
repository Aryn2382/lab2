package body reallocate is
   Avail, TotalInc, J, MinSpace : Integer;
   GrowthAllocate, Alpha, Beta, Sigma, Tau : Float;

   procedure reallocate(max : in Integer; init : in Integer; stack: in Integer; stacks : in Integer; base : in out arrayTypes.intArray; top : in out arrayTypes.intArray; EqualAllocate : in Float)
   begin
      declare
         OldTop, Growth, NewBase : arrayTypes.intArray(1..stacks);
      begin
         for i in 1..(stacks + 1) loop
            OldTop(i) := Top(i);
         end loop;
         Avail := max - init;
         TotalInc := 0;
         J := stacks;
         MinSpace := max * .1;
         while J > 0 loop
            Avail := Avail - (top(J) - base(J));
            if top(J) > OldTop(J) then
               Growth(J) := Top(J) - OldTop(J);
               TotalInc := TotalInc + Growth(J);
            else
               Growth(J) := 0;
            end if;
            J := J - 1;
         end loop;
         if Avail < MinSpace - 1 then
               Put("MEMORY OVERLOAD");
            else
               GrowthAllocate := 1 - EqualAllocate;
               Alpha := EqualAllocate * Avail / stacks;
               Beta := GrowthAllocate * Avail / TotalInc;
               NewBase(1) := Base(1);
               Sigma := 0.0;
               for i in 2..stacks loop
                  Tau := Sigma + Alpha + Growth(i - 1) * Beta;
                  NewBase(i) := NewBase(i - 1) + (top(i - 1) - base(i - 1)) + Float'Floor(Tau) - Float'Floor(Sigma);
                  Simga := Tau
               end loop;
               top(stack) := top(stack) - 1;
               movestack.movestack();
               top(stack) := top(stack) + 1;
               --insert item?????
               for i in 1..stacks loop
                  OldTop(i) := top(i);
               end loop;



         end if;

      end;
   end;
end reallocate;

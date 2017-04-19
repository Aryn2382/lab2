with Ada.Text_IO; use Ada.Text_IO;
with arrayTypes; use arrayTypes;
with reallocate; use reallocate;

procedure lab2c is
   package Int_IO is new Ada.Text_IO.Integer_IO(Integer); use Int_IO;
   lower, upper, init, max : Integer;

   procedure Push(space : in out arrayTypes.stringArray; base : in out intArray; top : in out intArray; stack : in Integer; text : in charArray) is
   begin
      top(stack) := top(stack) + 1;
      if top(stack) > base(stack + 1) then
         Put_Line("PUSH OVERFLOW "); New_Line;
         top(stack) := top(stack) - 1;
         for i in (init + 1)..max loop
            Put(i); Put(": ");
            if (i > base(1) and i <= top(1)) or (i > base(2) and i <= top(2)) or (i > base(3) and i <= top(3)) or (i > base(4) and i <= top(4)) then
               for j in 1..space(i)'Length loop
                  Put(space(i)(j));
               end loop;
               New_Line;
            else
               New_Line;
            end if;
         end loop;
         top(stack) := top(stack) + 1;
         reallocate.reallocate(max, init, stack, 4, base, top, 0.15, space, text);
      else
         space(top(stack)) := text;
      end if;
   end Push;

   procedure Pop(space : in out arrayTypes.stringArray; base : in out intArray; top : in out intArray; stack : in Integer; text : out charArray) is
   begin
      if top(stack) = base(stack) then
         Put_Line("POP OVERFLOW");
      else
         text := space(top(stack));
         top(stack) := top(stack) - 1;
      end if;
   end Pop;
begin
   Put("Enter a lower bound: "); Get(lower);
   Put("Enter an upper bound: "); Get(upper);
   Put("Enter an initial location: "); Get(init);
   Put("Enter the max: "); Get(max);

   declare
      space : arrayTypes.stringArray(lower..upper);
      top : arrayTypes.intArray(1..4);
      base : arrayTypes.intArray(1..5);
      text : String(1..13);
      temp : arrayTypes.charArray(1..10);
   begin
      for j in 1..5 loop
         base(j) := Integer(Float'Floor(((Float(j) - 1.0) / 4.0 * Float(max - init)) + Float(init)));
         if j < 5 then
            top(j) := base(j);
         end if;
      end loop;
      New_Line;
      Put("Enter text: "); Get(text);
      while text /= "end          " loop
         for i in 4..13 loop
            temp(i - 3) := text(i);
         end loop;
         Put_Line(text);
         if text(1) = 'I' then
            Push(space, base, top, Integer'Value(text(2..2)), temp);
         elsif text(1) = 'D' then
            Pop(space, base, top, Integer'Value(text(2..2)), temp);
            New_Line;
            for i in 1..10 loop
               Put(temp(i));
            end loop;
            New_Line;
         end if;
         Put("Enter text: "); Get(text);
      end loop;
   end;
end lab2c;

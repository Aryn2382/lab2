with arrayTypes; use arrayTypes;

package movestack is
   procedure movestack(N: in Integer; Base: in out arrayTypes.intArray; Top: in out arrayTypes.intArray; StackSpace: in out arrayTypes.stringArray; NewBase: in arrayTypes.intArray);
end movestack;

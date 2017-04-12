with arrayTypes; use arrayTypes;

package reallocate is
   procedure reallocate(max : in Integer; init : in Integer; stack: in Integer; stacks : in Integer; base : in out arrayTypes.intArray; top : in out arrayTypes.intArray; EqualAllocate : in Float; StackSpace: in out arrayTypes.stringArray);
end reallocate;

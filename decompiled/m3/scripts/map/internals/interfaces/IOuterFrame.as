package map.internals.interfaces
{
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   
   public interface IOuterFrame extends Disposeable
   {
      
      function get frameId() : uint;
      
      function show(param1:Object) : void;
      
      function close() : void;
      
      function get attackBtn() : BaseButton;
   }
}


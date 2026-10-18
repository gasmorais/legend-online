package battle.view.ui
{
   import flash.display.DisplayObject;
   
   public interface IHpStrip
   {
      
      function set maxValue(param1:Number) : void;
      
      function set currentValue(param1:Number) : void;
      
      function get maxValue() : Number;
      
      function get currentValue() : Number;
      
      function initCurrentValue(param1:Number) : void;
      
      function getView() : DisplayObject;
      
      function dispose() : void;
   }
}


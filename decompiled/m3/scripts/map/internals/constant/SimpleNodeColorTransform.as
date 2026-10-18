package map.internals.constant
{
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   
   public class SimpleNodeColorTransform
   {
      
      private static const mouseOverColor:ColorTransform = new ColorTransform(1,1,1,1,50,50,50,0);
      
      private static const mouseOutColor:ColorTransform = new ColorTransform();
      
      public function SimpleNodeColorTransform()
      {
         super();
      }
      
      public function NodeMouseOverColor(param1:DisplayObject) : void
      {
         param1.transform.colorTransform = mouseOverColor;
      }
      
      public function NodeMouseOutColor(param1:DisplayObject) : void
      {
         param1.transform.colorTransform = mouseOutColor;
      }
   }
}


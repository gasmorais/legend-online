package map.internals.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class PathPoint extends Bitmap
   {
      
      public function PathPoint(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false)
      {
         param1 = ComponentFactory.Instance.creatBitmapData("asset.common.SpaceMapFrame.PathPoint");
         super(param1,param2,param3);
      }
   }
}


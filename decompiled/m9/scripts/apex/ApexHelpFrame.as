package apex
{
   import com.pickgliss.instance.IManualSize;
   import flash.geom.Rectangle;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ApexHelpFrame extends SimpleHelpFrame implements IManualSize
   {
      
      public function ApexHelpFrame()
      {
         super();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,686,492);
      }
   }
}


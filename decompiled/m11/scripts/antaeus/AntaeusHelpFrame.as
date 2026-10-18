package antaeus
{
   import com.pickgliss.instance.IManualSize;
   import flash.geom.Rectangle;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class AntaeusHelpFrame extends SimpleHelpFrame implements IManualSize
   {
      
      public function AntaeusHelpFrame()
      {
         super();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,686,492);
      }
   }
}


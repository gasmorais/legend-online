package sevenyear.view.help
{
   import com.pickgliss.instance.IManualSize;
   import flash.geom.Rectangle;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SevenYearStarAreaHelpFrame extends SimpleHelpFrame implements IManualSize
   {
      
      public function SevenYearStarAreaHelpFrame()
      {
         super();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,563,288);
      }
   }
}


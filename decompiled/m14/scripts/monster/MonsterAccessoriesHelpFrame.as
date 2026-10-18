package monster
{
   import com.pickgliss.instance.IManualSize;
   import flash.geom.Rectangle;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class MonsterAccessoriesHelpFrame extends SimpleHelpFrame implements IManualSize
   {
      
      public function MonsterAccessoriesHelpFrame()
      {
         super();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,686,492);
      }
   }
}


package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.module.star.StarTroughInfo;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class StarController extends FrameController
   {
      
      public static const HOROSCOPE:int = 1;
      
      public static const ENHANCEDATTRIBUTE:int = 2;
      
      public static const AUTOSTAR:int = 3;
      
      public static const SUB_FRAME:int = 5;
      
      public var _info:StarTroughInfo;
      
      public function StarController()
      {
         super();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         switch(_data.openType)
         {
            case 1:
               return "star.HoroscopeFrame";
            case 2:
               return "star.EnhancedAttributeFrame";
            case 3:
               return "star.AutoStarSetFrame";
            case 5:
               return "star.SubStarFrame";
            default:
               return "star.StarFrame";
         }
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_info);
      }
      
      public function get hasStarFrmae() : Boolean
      {
         return _frame != null && _frame.parent != null && _frame.toString() == "[object StarFrame]";
      }
      
      public function openStarHelpFrame() : void
      {
         var _loc1_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("star.StarHelpFrame");
         _loc1_.show();
      }
   }
}


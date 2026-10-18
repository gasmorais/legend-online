package mvc.controler
{
   import mvc.FrameController;
   
   public class YearActiveController extends FrameController
   {
      
      public static const Enter:String = "Enter";
      
      public static const Day:String = "Day";
      
      public static const Look:String = "Look";
      
      public static const Egg:String = "Egg";
      
      public static const Shop:String = "Shop";
      
      public static const Egg_Drop:String = "Egg_Drop";
      
      private var _lockPreName:String;
      
      public function YearActiveController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_frame["show"].length > 0)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "";
         switch(_data.openType)
         {
            case "Enter":
               _loc1_ = "year2023.frame.YearActiveEnterFrame";
               break;
            case "Day":
               _loc1_ = "year2023.frame.YearActiveDayFrame";
               break;
            case "Look":
               _loc1_ = "year2023.frame.YearActiveLookFrame";
               break;
            case "Egg":
               _loc1_ = "year2023.frame.YearActiveEggFrame";
               break;
            case "Shop":
               _loc1_ = "year2023.frame.YeraActiveShopFrame";
               break;
            case "Egg_Drop":
               _loc1_ = "year2023.frame.YearactiveEggDropFrame";
         }
         return _loc1_;
      }
      
      public function setLockPreFrame(param1:String, param2:String = null, param3:Object = null, param4:String = null) : void
      {
         _preModule = param1;
         _preOpenType = param2;
         _preData = param3;
         _lockPreName = param4;
      }
      
      override protected function exitFrame() : void
      {
         _frame = null;
         if(!_lockPreName)
         {
            if(_preModule)
            {
               openPreFrame();
            }
            _preModule = null;
            _preOpenType = null;
            _preData = null;
            _exitFrameName = null;
         }
         else if(_exitFrameName == _lockPreName)
         {
            if(_preModule)
            {
               openPreFrame();
            }
            _lockPreName = null;
            _preModule = null;
            _preOpenType = null;
            _preData = null;
            _exitFrameName = null;
         }
      }
   }
}


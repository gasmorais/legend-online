package mvc.controler
{
   import mvc.FrameController;
   
   public class CommonController extends FrameController
   {
      
      private var _lockPreName:String;
      
      public function CommonController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.frameData)
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
         return "ui." + _data.moduleUIName + "." + _data.openType;
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


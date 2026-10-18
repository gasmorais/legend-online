package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   
   public class ConsortiaChessController extends FrameController
   {
      
      public static const BATTLE:int = 1;
      
      public static const ROLE:int = 2;
      
      public static const RESULT:int = 3;
      
      public static const RANK:int = 4;
      
      public static const RECORD:int = 5;
      
      public static const REWORD:int = 6;
      
      private var _lockPreName:String;
      
      public function ConsortiaChessController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "consortiachess.ChesspvpBattleFrame";
         }
         if(_data.openType == 3)
         {
            return "consortiachess.ChessPvpResultFrame";
         }
         if(_data.openType == 2)
         {
            return "consortiachess.ChesspvpUpRoleFrame";
         }
         if(_data.openType == 4)
         {
            return "consortiachess.ChesspvpRankFrame";
         }
         if(_data.openType == 5)
         {
            return "consortiachess.ChesspvpRecordFrame";
         }
         if(_data.openType == 6)
         {
            return "consortiachess.ChesspvpRewardFrame";
         }
         return "consortiachess.ChesspvpInFrame";
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
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}


package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class MarryController extends FrameController
   {
      
      public function MarryController()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(param1)
         {
            param1.currentLoaded = 0;
         }
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function get hasHeartFrame() : Boolean
      {
         return _frame && _data && _data.openType == "HEART";
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "marry.propose.MarryQuestFrame";
         if(_data && _data.openType == "QUEST")
         {
            _loc1_ = "marry.propose.MarryQuestFrame";
         }
         else if(_data && _data.openType == "RECEIVE")
         {
            _loc1_ = "marry.propose.MarryAnswerFrame";
         }
         else if(_data && _data.openType == "SUCCEED")
         {
            _loc1_ = "marry.propose.MarryRewardFrame2";
         }
         else if(_data && _data.openType == "QUALITY_SELECT")
         {
            _loc1_ = "marry.quality.MarryQualityFrame";
         }
         else if(_data && _data.openType == "QUALITY_CONFIRM")
         {
            _loc1_ = "marry.quality.MarryConfirmFrame";
         }
         else if(_data && _data.openType == "ROOM_LIST")
         {
            _loc1_ = "marry.room.MarryRoomListFrame";
         }
         else if(_data && _data.openType == "WEDDING_SET")
         {
            _loc1_ = "marry.room.WeddingRoomSetFrame";
         }
         else if(_data && _data.openType == "WEDDING_INVATE")
         {
            _loc1_ = "marry.room.WeddingInviteframe";
         }
         else if(_data && _data.openType == "RING_UPGRADE")
         {
            _loc1_ = "marry.income.MarryRingUpgradeFrame";
         }
         else if(_data && _data.openType == "TREE_FOSTER")
         {
            _loc1_ = "marry.income.MarryTreeFosterFrame";
         }
         else if(_data && _data.openType == "TASK_MAP")
         {
            _loc1_ = "marry.income.MarryTaskMapFrame";
         }
         else if(_data && _data.openType == "HEART")
         {
            _loc1_ = "marry.income.MarryHeartFrame";
         }
         else if(_data && _data.openType == "MARRY_TRAIN")
         {
            _loc1_ = "marry.income.MarryTrainFrame";
         }
         else if(_data && _data.openType == "SEARCH_MATE")
         {
            _loc1_ = "marry.income.MateRecommendFrame";
         }
         return _loc1_;
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}


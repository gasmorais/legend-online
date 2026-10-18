package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import manager.LanguageMgr;
   import managers.OfferRewardManager;
   import managers.TaskSocketManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import ui.events.UIBarEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TaskManage;
   import yishi.view.tips.MessageTipManager;
   
   public class TaskControler extends FrameController
   {
      
      public function TaskControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         var _loc2_:String = null;
         if(!checkExitstTask() && OfferRewardManager.instance.model.baseRewardDic.getList().length <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("task.TaskControler.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         NotificationManager.instance.dispatchEvent(new UIBarEvent("taskFrameOpened",_frame));
         if(_data.frameData != null)
         {
            _data.frameData();
         }
      }
      
      override public function get frameClassName() : String
      {
         return "task.TaskFrameII";
      }
      
      public function sendGetTaskReward(param1:int, param2:int, param3:Boolean = false) : void
      {
         TaskSocketManager.sendGetTaskReward(param1,param2,param3);
      }
      
      public function checkExitstTask() : Boolean
      {
         var _loc1_:Boolean = TaskManage.instance.cate.acceptedList.length != 0;
         if(!_loc1_ && frame)
         {
            frame.dispose();
         }
         return _loc1_;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}


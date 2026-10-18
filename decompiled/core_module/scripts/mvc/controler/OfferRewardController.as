package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import manager.LanguageMgr;
   import managers.OfferRewardManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.offerreward.BaseOfferReward;
   import ui.events.UIBarEvent;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class OfferRewardController extends FrameController
   {
      
      private var _baseReward:BaseOfferReward;
      
      public function OfferRewardController()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "offerReward.OfferRewardFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function closeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
         }
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         var _loc2_:String = "";
         if(thane.grades < 14)
         {
            _loc2_ = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTaskItem.command03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(rewardManager.model.remainRewardCount <= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("buildings.offerreward.view.OfferTaskItem.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         super.start(param1);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get rewardManager() : OfferRewardManager
      {
         return OfferRewardManager.instance;
      }
      
      public function openRewardHelpFrame() : void
      {
         var _loc1_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("offerReward.RewardHelpFrame");
         _loc1_.show();
      }
      
      public function openTaskFrameByBaseReward(param1:BaseOfferReward) : void
      {
         _baseReward = param1;
         var _loc2_:Frame = FrameControllerManager.instance.taskControler.frame;
         if(!_loc2_)
         {
            FrameControllerManager.instance.openControllerByInfo("task");
            _loc2_ = FrameControllerManager.instance.taskControler.frame;
         }
         if(!_loc2_)
         {
            NotificationManager.instance.addEventListener("taskFrameOpened",__taskFrameOpenHandler);
         }
         else
         {
            _loc2_["selectedByInfo"] = _baseReward;
            _baseReward = null;
         }
      }
      
      private function __taskFrameOpenHandler(param1:UIBarEvent) : void
      {
         NotificationManager.instance.removeEventListener("taskFrameOpened",__taskFrameOpenHandler);
         var _loc2_:Frame = FrameControllerManager.instance.taskControler.frame;
         if(_loc2_)
         {
            _loc2_["selectedByInfo"] = _baseReward;
         }
         _baseReward = null;
      }
   }
}


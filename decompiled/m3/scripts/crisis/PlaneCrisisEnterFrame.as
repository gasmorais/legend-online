package crisis
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import crisis.ui.PlaneCrisisRewardTipView;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PlaneCrisisEnterFrame extends Frame
   {
      
      private var _enterBtn1:TextButton;
      
      private var _enterBtn2:TextButton;
      
      private var _rewardBtn:TextButton;
      
      private var _tipView:PlaneCrisisRewardTipView;
      
      private var _difficulty:int = 1;
      
      private var _maxTime:int;
      
      public function PlaneCrisisEnterFrame()
      {
         super();
         _maxTime = TempleteManager.instance.getConfigValue("crisis_available_times");
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _enterBtn1 = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.normalEnterBtn");
         _enterBtn2 = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.advanceEnterBtn");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.rewardEnterTipBtn");
         addToContent(_enterBtn1);
         addToContent(_enterBtn2);
         addToContent(_rewardBtn);
         titleText = LanguageMgr.GetTranslation("planeCrisis.enterTitle");
         _enterBtn1.text = LanguageMgr.GetTranslation("planeCrisis.normalBtn");
         _enterBtn2.text = LanguageMgr.GetTranslation("planeCrisis.advanceBtn");
         _rewardBtn.text = LanguageMgr.GetTranslation("planeCrisis.lookTip");
      }
      
      private function initEvent() : void
      {
         _enterBtn1.addEventListener("click",clickHandler);
         _enterBtn2.addEventListener("click",clickHandler);
         _rewardBtn.addEventListener("click",lookRewardHandler);
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         _enterBtn1.removeEventListener("click",clickHandler);
         _enterBtn2.removeEventListener("click",clickHandler);
         _rewardBtn.removeEventListener("click",lookRewardHandler);
         removeEventListener("response",__frameResponse);
      }
      
      private function lookRewardHandler(param1:MouseEvent) : void
      {
         if(_tipView && !_tipView.isDie)
         {
            ObjectUtils.disposeObject(_tipView);
            _tipView = null;
            return;
         }
         _tipView = new PlaneCrisisRewardTipView();
         var _loc2_:Point = new Point();
         _loc2_ = _rewardBtn.localToGlobal(_loc2_);
         _tipView.x = _loc2_.x - _tipView.displayWidth + 410;
         _tipView.y = _loc2_.y - 234;
         if(_tipView.y < 0)
         {
            _tipView.y = 20;
         }
         _tipView.show();
         param1.stopPropagation();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(ArmyManager.instance.thane.grades < 80)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",80));
            return;
         }
         if(!FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("planeCrisis.noTeam"));
            return;
         }
         if(!FreedomTeamManager.instance.isCaptain)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("planeCrisis.isCapiter"));
            return;
         }
         var _loc3_:String = "";
         if(param1.currentTarget == _enterBtn1)
         {
            _difficulty = 1;
            _loc3_ = LanguageMgr.GetTranslation("planeCrisis.DiffName1");
         }
         else if(param1.currentTarget == _enterBtn2)
         {
            _difficulty = 2;
            _loc3_ = LanguageMgr.GetTranslation("planeCrisis.DiffName2");
         }
         var _loc4_:int = _maxTime - PlayerManager.instance.currentPlayerModel.playerInfo.usePlaneCrisis;
         var _loc6_:TodayNotAlertFrame = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.enterConfirmFrame");
         var _loc5_:String = LanguageMgr.GetTranslation("planeCriris.doEnterContent",_loc3_,_loc4_,_maxTime);
         var _loc2_:String = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.alertConent");
         _loc6_.checkBtm.selected = true;
         if(_loc4_ == 0)
         {
            _loc6_.checkBtm.selected = false;
            _loc6_.checkBtm.enable = false;
         }
         _loc6_.show(_loc5_,_loc2_,confirmEnterFun);
         dispose();
      }
      
      private function confirmEnterFun(param1:Boolean) : void
      {
         var _loc2_:int = param1 ? 1 : 0;
         PlaneCrisisManager.Instance.gameOp(1,_loc2_,_difficulty);
      }
      
      public function show(param1:Object = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_enterBtn1);
         _enterBtn1 = null;
         ObjectUtils.disposeObject(_enterBtn2);
         _enterBtn2 = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         super.dispose();
      }
   }
}


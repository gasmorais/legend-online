package map.campaign.view.physics
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class FarmBonView extends CampaignNpcPhysics
   {
      
      private var _statusBtn:BaseButton;
      
      private var _txt:FilterFrameText;
      
      private var _leftTime:int;
      
      private var _uint:uint;
      
      public function FarmBonView()
      {
         super();
         initEvent();
      }
      
      private function initEvent() : void
      {
         FarmManager.instance.model.addEventListener("FARM_BIGBONFIRE_STATUS",farmStatusChange);
         FarmManager.instance.model.addEventListener("FARM_SELECTED_CHANGE",farmStatusChange);
         model.addEventListener("FARM_BONFIRE_BEGIN_TIME",farmStatusChange);
      }
      
      private function removeEvent() : void
      {
         FarmManager.instance.model.removeEventListener("FARM_BIGBONFIRE_STATUS",farmStatusChange);
         FarmManager.instance.model.removeEventListener("FARM_SELECTED_CHANGE",farmStatusChange);
         model.removeEventListener("FARM_BONFIRE_BEGIN_TIME",farmStatusChange);
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      private function farmStatusChange(param1:Event = null) : void
      {
         initView();
      }
      
      override protected function initView() : void
      {
         var _loc1_:Date = null;
         super.initView();
         if(FarmManager.instance.model.masterId != thane.userId)
         {
            return;
         }
         _statusBtn = ComponentFactory.Instance.creatComponentByStylename("farm.bigbon.statusBtn");
         _txt = ComponentFactory.Instance.creatComponentByStylename("farm.bigbon.statusTxt");
         addChild(_statusBtn);
         addChild(_txt);
         _txt.text = "";
         _statusBtn.enable = true;
         if(FarmManager.instance.model.isBigBonfire || FarmManager.instance.model.beginLeftTime > 0)
         {
            _statusBtn.enable = false;
            _loc1_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
            _loc1_.setDate(_loc1_.date + 1);
            _loc1_.setHours(0);
            _loc1_.setMinutes(0);
            _loc1_.setSeconds(0);
            _leftTime = _loc1_.valueOf() / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
            _txt.text = DateFormatter.getConsortiaCountDate(_leftTime);
            _uint = setInterval(updateTime,1000);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function updateTime() : void
      {
         _leftTime = _leftTime - 1;
         if(_leftTime <= 0)
         {
            clearInterval(_uint);
            _txt.text = "";
            _statusBtn.enable = true;
            return;
         }
         if(_statusBtn != null)
         {
            _statusBtn.enable = false;
         }
         if(_txt != null)
         {
            _txt.text = DateFormatter.getConsortiaCountDate(_leftTime);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_statusBtn);
         _statusBtn = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         clearInterval(_uint);
         super.dispose();
      }
   }
}


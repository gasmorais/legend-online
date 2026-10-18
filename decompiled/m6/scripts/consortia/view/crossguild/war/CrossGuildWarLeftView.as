package consortia.view.crossguild.war
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildModel;
   import utils.LogicUtils;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.ProgressCommon;
   import yishi.view.tips.MessageTipManager;
   
   public class CrossGuildWarLeftView extends Component
   {
      
      private var _spiritBar:ProgressCommon;
      
      private var _addSpiritBtn:BaseButton;
      
      private var _attackBtn:IconButton;
      
      private var _defendPolicyBtn:IconButton;
      
      public function CrossGuildWarLeftView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _spiritBar = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarLeftView.spiritBar");
         _addSpiritBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarLeftView.addSpiritBtn");
         _attackBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarLeftView.attackBtn");
         _defendPolicyBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildWarLeftView.defendPolicyBtn");
         addChild(_spiritBar);
         addChild(_addSpiritBtn);
         addChild(_attackBtn);
         addChild(_defendPolicyBtn);
      }
      
      private function addEvent() : void
      {
         _defendPolicyBtn.addEventListener("click",_defendPolicyBtnClickHandler);
         _attackBtn.addEventListener("click",_attackBtnClickHandler);
         _addSpiritBtn.addEventListener("click",_addSpiritBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_defendPolicyBtn)
         {
            _defendPolicyBtn.removeEventListener("click",_defendPolicyBtnClickHandler);
         }
         if(_attackBtn)
         {
            _attackBtn.removeEventListener("click",_attackBtnClickHandler);
         }
         if(_addSpiritBtn)
         {
            _addSpiritBtn.removeEventListener("click",_addSpiritBtnClickHandler);
         }
      }
      
      private function _defendPolicyBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("crossguild",2);
      }
      
      private function _attackBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:CrossGuildWarAttackRecordFrame = ComponentFactory.Instance.creatComponentByStylename("crossguild.CrossGuildWarAttackRecordFrame");
         _loc2_.show();
      }
      
      private function _addSpiritBtnClickHandler(param1:MouseEvent) : void
      {
         if(model.curSpirit >= model.maxSpirit)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("CrossGuildWarLeftView.buyActionPoint.alert"));
            return;
         }
         if(model.buySpiritCount >= model.maxBuySpiritCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.GoodsItem10.hasBuyEnough"));
            return;
         }
         var _loc6_:int = model.maxBuySpiritCount - model.buySpiritCount;
         var _loc5_:String = LanguageMgr.GetTranslation("CrossGuildWarLeftView.buySpirit.content",model.buySpiritCost,_loc6_);
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [confirmBuyHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,true,2);
      }
      
      private function confirmBuyHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(model.buySpiritCost,false))
         {
            return;
         }
         CrossGuildManager.instance.sendBuySpirit();
      }
      
      public function refreshView() : void
      {
         _spiritBar.value = model.curSpirit / model.maxSpirit;
         _spiritBar.text = LanguageMgr.GetTranslation("CrossGuildWarLeftView.actionPointBar.text",model.curSpirit,model.maxSpirit);
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_addSpiritBtn);
         _addSpiritBtn = null;
         ObjectUtils.disposeObject(_attackBtn);
         _attackBtn = null;
         ObjectUtils.disposeObject(_defendPolicyBtn);
         _defendPolicyBtn = null;
         ObjectUtils.disposeObject(_spiritBar);
         _spiritBar = null;
         super.dispose();
      }
   }
}


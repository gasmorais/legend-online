package planeswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.planeswar.PlanesWarModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PlanesTopView extends Component
   {
      
      private var energyStrip:StripView;
      
      private var energyBar:MovieClip;
      
      private var addEnergyBtn:BaseButton;
      
      private var energyText:FilterFrameText;
      
      private var energyLimitInfo:ConfigInfosTempInfo;
      
      private var energyCostInfo:ConfigInfosTempInfo;
      
      private var energyMaxInfo:ConfigInfosTempInfo;
      
      private var findCostInfo:ConfigInfosTempInfo;
      
      private var recoverInfo:ConfigInfosTempInfo;
      
      private var recoverArr:Array;
      
      private var findArr:Array;
      
      private var energyCostArr:Array;
      
      public function PlanesTopView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         energyStrip = ComponentFactory.Instance.creatComponentByStylename("PlanesTopView.energyStrip");
         energyBar = ComponentFactory.Instance.creatCustomObject("PlanesTopView.energyBar");
         addEnergyBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesTopView.addEnergyBtn");
         energyText = ComponentFactory.Instance.creatComponentByStylename("PlanesTopView.energyText");
         addChild(energyStrip);
         energyStrip.addChild(energyBar);
         addChild(addEnergyBtn);
         addChild(energyText);
         energyLimitInfo = TempleteManager.instance.getConfigInfoByConfigName("planes_buy_energy_limit");
         energyCostInfo = TempleteManager.instance.getConfigInfoByConfigName("planes_buy_energy");
         energyMaxInfo = TempleteManager.instance.getConfigInfoByConfigName("planes_max_recover_energy");
         findCostInfo = TempleteManager.instance.getConfigInfoByConfigName("planes_scan");
         recoverInfo = TempleteManager.instance.getConfigInfoByConfigName("planes_recover_energy");
         if(recoverInfo)
         {
            recoverArr = recoverInfo.ConfigValue.split(",");
         }
         if(findCostInfo)
         {
            findArr = findCostInfo.ConfigValue.split(",");
         }
         if(energyCostInfo)
         {
            energyCostArr = energyCostInfo.ConfigValue.split(",");
         }
         refreshView();
      }
      
      private function addEvent() : void
      {
         addEnergyBtn.addEventListener("click",__addEnergyClickHandler);
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(energyLimitInfo && recoverInfo)
         {
            _loc2_ = int(energyLimitInfo.ConfigValue) - model.hasBuyEnergyCount;
            addEnergyBtn.tipData = LanguageMgr.GetTranslation("planeswar.planesListView.addEnergyBtnTiptext",_loc2_);
            energyStrip.tipData = LanguageMgr.GetTranslation("planeswar.planesListView.addEnergyBtnTiptext2",recoverArr[0],recoverArr[1]);
         }
         if(energyMaxInfo)
         {
            energyText.text = model.energyLeft + "/" + energyMaxInfo.ConfigValue;
            _loc1_ = model.energyLeft * 100 / parseInt(energyMaxInfo.ConfigValue);
            energyBar.gotoAndStop(_loc1_);
         }
      }
      
      private function __addEnergyClickHandler(param1:MouseEvent) : void
      {
         if(model.hasBuyEnergyCount > int(energyLimitInfo.ConfigValue))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("planes.buyEnergy.hasEnough"));
            return;
         }
         var _loc3_:Array = energyCostInfo.ConfigValue.split(",");
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < _loc3_[0])
         {
            RechargeAlertMannager.show();
            return;
         }
         if(model.selfArmy.isMoving)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_:String = LanguageMgr.GetTranslation("planesWar.planesListView.AddEnergyTips",_loc3_[0],_loc3_[1]);
         SharedManagerHelper.ins.needAlert("planeswar.view.PlanesTopView.addEnergy",addEnergyHandlerResult,_loc2_,_loc4_,"");
      }
      
      private function addEnergyHandlerResult(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1 == true ? 2 : 1;
         PlanesWarManager.instance.sendPlanesOpMsg(8,[_loc2_]);
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      private function removeEvent() : void
      {
         if(addEnergyBtn)
         {
            addEnergyBtn.removeEventListener("click",__addEnergyClickHandler);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(energyBar)
         {
            ObjectUtils.disposeViolentMc(energyBar);
         }
         energyBar = null;
         if(energyStrip)
         {
            ObjectUtils.disposeObject(energyStrip);
         }
         energyStrip = null;
         if(addEnergyBtn)
         {
            ObjectUtils.disposeObject(addEnergyBtn);
         }
         addEnergyBtn = null;
         if(energyText)
         {
            ObjectUtils.disposeObject(energyText);
         }
         energyText = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}


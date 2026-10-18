package buildings.seminary.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.BuildOrderEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import mainBar.StripView;
   import mainBar.view.VipCoolDownFrame;
   import manager.LanguageMgr;
   import mvc.module.buildings.BuildInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.ResourceEvent;
   import yishi.manager.BuildingManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class SeminaryFrameBottomView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _ownCrystalNumText:FilterFrameText;
      
      private var _resourcesTip:StripView;
      
      private var _quickFrame:VipCoolDownFrame;
      
      public function SeminaryFrameBottomView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("seminary.bg2Img");
         _ownCrystalNumText = ComponentFactory.Instance.creatComponentByStylename("seminary.ownCrystalNumText");
         onCrystalUpdate(null);
         _resourcesTip = ComponentFactory.Instance.creatCustomObject("seminary.ResourcesTip");
         _resourcesTip.setHitArea(0,0,190,47);
         _resourcesTip.tipData = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.resourcesTip");
         addChild(_bg);
         addChild(_ownCrystalNumText);
         addChild(_resourcesTip);
      }
      
      private function initEvent() : void
      {
         BuildingManager.instance.addEventListener("COLL_ONE_ORDER",__coolSuccessHandler);
         BuildingManager.instance.addEventListener("USE_ONE_ORDER",__useOneOrderHandler);
         ResourceManager.instance.waterCrystal.addEventListener(ResourceEvent.RESOURCE_UPDATE,onCrystalUpdate);
         NotificationManager.instance.addEventListener("TEC_UPGRADE_CLICK",__tecUpgradeHandler);
      }
      
      private function onCrystalUpdate(param1:Event) : void
      {
         if(_ownCrystalNumText)
         {
            _ownCrystalNumText.text = ResourceManager.instance.waterCrystal.count + "";
         }
      }
      
      public function changeRed() : void
      {
         _ownCrystalNumText.setFrame(2);
      }
      
      public function revertColor() : void
      {
         _ownCrystalNumText.setFrame(1);
      }
      
      private function removeEvent() : void
      {
         BuildingManager.instance.removeEventListener("COLL_ONE_ORDER",__coolSuccessHandler);
         BuildingManager.instance.removeEventListener("USE_ONE_ORDER",__useOneOrderHandler);
         ResourceManager.instance.waterCrystal.removeEventListener(ResourceEvent.RESOURCE_UPDATE,onCrystalUpdate);
         NotificationManager.instance.removeEventListener("TEC_UPGRADE_CLICK",__tecUpgradeHandler);
      }
      
      private function __tecUpgradeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc4_:String = null;
         var _loc3_:BuildInfo = param1.data as BuildInfo;
         if(_loc3_)
         {
            _loc2_ = false;
            if(_loc3_.buildingId != 0)
            {
               _loc2_ = Boolean(BuildingManager.instance.model.isMaxLevel(_loc3_.buildingId));
               if(_loc2_)
               {
                  _loc4_ = LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.isMaxLevelTip");
                  MessageTipManager.instance().show(_loc4_);
                  return;
               }
               if(BuildingManager.instance.isUpgradeAvaliable(_loc3_))
               {
                  BuildingManager.instance.upgradeBuildingByBuildingInfo(_loc3_);
               }
            }
            else
            {
               BuildingManager.instance.creatBuilding(getTemp(_loc3_).SonType);
            }
         }
      }
      
      private function getTemp(param1:BuildInfo) : BuildingTempInfo
      {
         var _loc2_:BuildingTempInfo = null;
         if(param1.templateId != 0)
         {
            _loc2_ = param1.templeteInfo;
         }
         else
         {
            _loc2_ = TempleteManager.instance.buildTemplateCate.getMinGradeBuildingTemplete(param1.sonType);
         }
         return _loc2_;
      }
      
      public function allCoolBack(param1:Boolean, param2:int = 0, param3:int = 0, param4:Boolean = true) : void
      {
         BuildingManager.instance.allCoolBack(param1,param2,param3,param4);
         _quickFrame = null;
      }
      
      private function __coolSuccessHandler(param1:BuildOrderEvent) : void
      {
      }
      
      private function __useOneOrderHandler(param1:BuildOrderEvent) : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_ownCrystalNumText);
         _ownCrystalNumText = null;
         ObjectUtils.disposeObject(_resourcesTip);
         _resourcesTip = null;
         ObjectUtils.disposeObject(_quickFrame);
         _quickFrame = null;
         if(_resourcesTip)
         {
            _resourcesTip.dispose();
         }
         _resourcesTip = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


package map.campaign.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.internals.data.CampaignNode;
   import yishi.events.NotificationEvent;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.NotificationManager;
   
   public class GodsEveningMapNodeItem extends Component
   {
      
      private var _nodeName:GradientText;
      
      private var _gotoBtn:TextButton;
      
      private var _data:CampaignNode;
      
      public function GodsEveningMapNodeItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nodeName = ComponentFactory.Instance.creatComponentByStylename("map.campaign.view.frame.GodsEveningMapNodeItem.nodeName");
         _gotoBtn = ComponentFactory.Instance.creatComponentByStylename("map.campaign.view.frame.GodsEveningMapNodeItem.gotoBtn");
         addChild(_nodeName);
         addChild(_gotoBtn);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_nodeName);
         _nodeName = null;
         ObjectUtils.disposeObject(_gotoBtn);
         _gotoBtn = null;
      }
      
      private function addEvent() : void
      {
         _gotoBtn.addEventListener("click",__gotoBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _gotoBtn.removeEventListener("click",__gotoBtnClickHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      private function __gotoBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:CampaignArmy = null;
         SoundManager.instance.play("022");
         if(_data.param2 == 3)
         {
            for each(var _loc2_:CampaignArmy in CampaignManager.instance.mapModel.allUserArmy)
            {
               if(getCampaignNodeByGodDessId(_loc2_.goddessId) && _data.param1 == getCampaignNodeByGodDessId(_loc2_.goddessId).param1)
               {
                  _loc3_ = _loc2_;
               }
            }
         }
         if(_loc3_)
         {
            if(!(_loc3_.userId == CampaignManager.instance.mapModel.selfMemberData.userId && _loc3_.baseHero.serviceName == CampaignManager.instance.mapModel.selfMemberData.baseHero.serviceName))
            {
               GodsEveningManager.instance.model.selfFowllowingArmy = _loc3_;
               NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",_loc3_));
            }
         }
         else
         {
            GodsEveningManager.instance.model.selfFowllowingArmy = null;
            NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",null));
            CampaignManager.instance.mapModel.selectNode = _data;
            CampaignManager.instance.controller.moveArmyByPos(_data.curPosX * 20,_data.curPosY * 20,true);
         }
      }
      
      private function getCampaignNodeByGodDessId(param1:int) : CampaignNode
      {
         for each(var _loc2_:CampaignNode in CampaignManager.instance.mapModel.mapNodesData)
         {
            if(_loc2_.nodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get data() : CampaignNode
      {
         return _data;
      }
      
      public function set data(param1:CampaignNode) : void
      {
         _data = param1;
         _nodeName.text = LanguageMgr.GetTranslation("godsEvening.GodsEveningMapNodeItem.nodeName",param1.info.names);
         _gotoBtn.text = LanguageMgr.GetTranslation("godsEvening.GodsEveningMapNodeItem.goto");
         _gotoBtn.x = _nodeName.x + _nodeName.textWidth + 10;
      }
   }
}


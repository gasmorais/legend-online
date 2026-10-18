package consortia.view.myConsortia.newui
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.myConsortia.item.ConsortiaActivityItem;
   import events.ConsortiaEvent;
   import flash.events.Event;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaViewHelper;
   import yishi.manager.ConsortiaManager;
   import yishi.utils.MsgMan;
   import yishi.view.frame.ConsortiaEmeDreamRewardFrame;
   
   public class ConsortiaActivityView extends Component
   {
      
      private var _activeBg:Image;
      
      private var _itemList:SimpleTileList;
      
      private var _tabSpanel:ScrollPanel;
      
      private var rewaradFrame:ConsortiaEmeDreamRewardFrame;
      
      public function ConsortiaActivityView()
      {
         super();
         initView();
         addEvent();
         ConsortiaViewHelper.instance.initActivityData();
         refreshView();
      }
      
      private function initView() : void
      {
         _activeBg = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaActivityView.activeBg");
         _itemList = ComponentFactory.Instance.creatComponentByStylename("ConsortiaActivityView.itemList",[3]);
         _tabSpanel = ComponentFactory.Instance.creatComponentByStylename("ConsortiaActivityView.tabSpanel");
         addChild(_tabSpanel);
         _tabSpanel.setView(_itemList);
      }
      
      private function addEvent() : void
      {
         model.secretInfo.addEventListener("TREE_STATE_UPDATE",__updateSecretHandler);
         model.addEventListener("UPDA_CONSORTIA_INFO",__infoUpdateHandler);
         MsgMan.addObserver("CampaignEvent.CONSORTIA_BOSS_SWITCH",this,__consortiaSwitchHandler);
         MsgMan.addObserver("OPEN_EMEDREAM_REWARD_FRAME",this,__openEmedreamRewardHandler);
         MsgMan.addObserver("CROSS_GUILD_MAIN_CHANGE",this,__consortiaSwitchHandler);
      }
      
      private function removeEvent() : void
      {
         model.secretInfo.removeEventListener("TREE_STATE_UPDATE",__updateSecretHandler);
         model.removeEventListener("UPDA_CONSORTIA_INFO",__infoUpdateHandler);
         MsgMan.removeObserver("OPEN_EMEDREAM_REWARD_FRAME",this,__openEmedreamRewardHandler);
         MsgMan.removeObserver("CampaignEvent.CONSORTIA_BOSS_SWITCH",this,__consortiaSwitchHandler);
         MsgMan.removeObserver("CROSS_GUILD_MAIN_CHANGE",this,__consortiaSwitchHandler);
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ConsortiaActivityItem = null;
         _itemList.removeAllChild();
         _tabSpanel.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < activityInfoList.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("Consortia.ConsortiaActivityView.activeItem");
            _itemList.addChild(_loc1_);
            _loc1_.data = activityInfoList[_loc2_];
            _loc2_++;
         }
         _tabSpanel.commitChanges();
         _tabSpanel.invalidateViewport();
      }
      
      private function __updateSecretHandler(param1:ConsortiaEvent) : void
      {
         ConsortiaViewHelper.instance.initActivityData();
         refreshView();
      }
      
      private function __consortiaSwitchHandler(param1:String, param2:Object) : void
      {
         ConsortiaViewHelper.instance.initActivityData();
         refreshView();
      }
      
      private function __infoUpdateHandler(param1:ConsortiaEvent) : void
      {
         ConsortiaViewHelper.instance.initActivityData();
         refreshView();
      }
      
      private function __openEmedreamRewardHandler(param1:String, param2:Object) : void
      {
         rewaradFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaEmeDream.ConsortiaEmeDreamRewardFrame");
         rewaradFrame.addEventListener("dispose",__onRewardFrameDispose);
         rewaradFrame.show();
      }
      
      private function __onRewardFrameDispose(param1:Event) : void
      {
         rewaradFrame.removeEventListener("dispose",__onRewardFrameDispose);
         rewaradFrame = null;
         StageReferance.stage.focus = this;
      }
      
      private function get activityInfoList() : Array
      {
         return ConsortiaViewHelper.instance.activeList;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_activeBg);
         _activeBg = null;
         ObjectUtils.disposeObject(_itemList);
         _itemList = null;
         ConsortiaViewHelper.instance.cleanActivityData();
         super.dispose();
      }
   }
}


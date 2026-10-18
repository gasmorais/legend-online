package worldboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.WorldBossManager;
   import mvc.module.worldboss.WorldBossStuntmanInfo;
   import worldboss.view.WorldBossItem;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class WorldBossFrame extends Frame implements IManualSize
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _help:BaseButton = ComponentFactory.Instance.creatComponentByStylename("worldboss.FriendList.help");
      
      private var _vBox:VBox;
      
      private var _items:Array = [];
      
      public function WorldBossFrame()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,480,320);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("worldboss.FrameBack");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("worldboss.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("worldboss.Vbox");
         addToContent(_back);
         addToContent(_scrollPanel);
         _scrollPanel.setView(_vBox);
         _help.tipData = LanguageMgr.GetTranslation("worldboss.WorldBossFrame.helpTips01");
         _help.x = 392;
         _help.y = 22;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_help);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _help.addEventListener("click",__helpClick);
         playerInfo.addEventListener("WORLDBOSSSTATE",__updateStateListHandler);
         NotificationManager.instance.addEventListener("UPDATE_WARFIGHT_STATE_LIST",__updateStateListHandler);
         stuntman.addEventListener("change",__updateStateListHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _help.removeEventListener("click",__helpClick);
         playerInfo.removeEventListener("WORLDBOSSSTATE",__updateStateListHandler);
         NotificationManager.instance.removeEventListener("UPDATE_WARFIGHT_STATE_LIST",__updateStateListHandler);
         stuntman.removeEventListener("change",__updateStateListHandler);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("worldboss.worldbossHelperFrame");
         _loc2_["show"]();
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
      
      private function __updateStateListHandler(param1:Event) : void
      {
         for each(var _loc2_:EnterBaseItemView in _items)
         {
            _loc2_.updateState();
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         sornItems();
      }
      
      private function refreshList() : void
      {
         var _loc1_:WorldBossItem = null;
         var _loc2_:Dictionary = TempleteManager.instance.worldBossTemplateDict;
         for each(var _loc3_:CampaignTemplate in _loc2_)
         {
            if(_loc3_.Types == 1)
            {
               _loc1_ = new WorldBossItem();
               _loc1_.worldBossTemplate = _loc3_;
               _items.push(_loc1_);
            }
         }
         sornItems();
      }
      
      private function sornItems() : void
      {
         var _loc2_:int = 0;
         var _loc1_:EnterBaseItemView = null;
         _items.sortOn("state",16);
         _loc2_ = 0;
         while(_loc2_ < _items.length)
         {
            _loc1_ = _items[_loc2_] as EnterBaseItemView;
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function get stuntman() : WorldBossStuntmanInfo
      {
         return WorldBossManager.instance.stuntman;
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
      
      public function show(param1:int = 0) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OPEN_CAMPAIGN_FRAME",null));
         titleText = LanguageMgr.GetTranslation("worldboss.WorldBossFrame.title01");
         refreshList();
         initEvent();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


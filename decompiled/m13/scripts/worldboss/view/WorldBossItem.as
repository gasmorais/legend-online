package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.WorldBossManager;
   import managers.WorldBossSocketOutManager;
   import mvc.controler.WorldBossControler;
   import mvc.module.worldboss.WorldBossStuntmanInfo;
   import worldboss.EnterBaseItemView;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class WorldBossItem extends EnterBaseItemView
   {
      
      private var _back:Bitmap;
      
      private var _iconBack:ScaleBitmapImage;
      
      private var _icon:BaseIconView;
      
      private var _name:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _time:FilterFrameText;
      
      private var _desc:FilterFrameText;
      
      private var _state:FilterFrameText;
      
      private var _btnEff:MovieImage;
      
      private var _worldBossTemplate:CampaignTemplate;
      
      private var _enterButton:IconButton;
      
      private var _buyAvatarButton:SelectedTextButton;
      
      private var _useState:FilterFrameText;
      
      public function WorldBossItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.worldboss.ItemBack");
         _iconBack = ComponentFactory.Instance.creatComponentByStylename("worldboss.ItemIconBack");
         _icon = ComponentFactory.Instance.creatCustomObject("worldboss.ItemIcon");
         _name = ComponentFactory.Instance.creatComponentByStylename("worldboss.ItemName");
         _level = ComponentFactory.Instance.creatComponentByStylename("worldboss.ItemLevel");
         _time = ComponentFactory.Instance.creatComponentByStylename("worldboss.ItemTime");
         _desc = ComponentFactory.Instance.creatComponentByStylename("worldboss.ItemDesc");
         _state = ComponentFactory.Instance.creatComponentByStylename("worldboss.ItemState");
         _useState = ComponentFactory.Instance.creatComponentByStylename("worldboss.UseState");
         _enterButton = ComponentFactory.Instance.creatComponentByStylename("worldboss.EnterButton");
         _buyAvatarButton = ComponentFactory.Instance.creatComponentByStylename("worldboss.buyAvatarTextButton");
         _btnEff = ComponentFactory.Instance.creatComponentByStylename("worldboss.ItemButtonMc");
         _buyAvatarButton.text = LanguageMgr.GetTranslation("WorldBossItem.shiyongtishen");
         _buyAvatarButton.tipData = 30;
         addChild(_back);
         addChild(_iconBack);
         addChild(_icon);
         addChild(_name);
         addChild(_level);
         addChild(_time);
         addChild(_desc);
         addChild(_state);
         addChild(_useState);
         addChild(_enterButton);
         addChild(_buyAvatarButton);
         _enterButton.addChild(_btnEff);
         _btnEff.mouseChildren = _btnEff.mouseChildren = false;
         _enterButton.buttonMode = true;
         _buyAvatarButton.buttonMode = true;
         _buyAvatarButton.delayClickTime = 800;
         _name.text = LanguageMgr.GetTranslation("worldboss.view.WorldBossItem.name");
         _level.text = LanguageMgr.GetTranslation("worldboss.view.WorldBossItem.level");
         _time.text = LanguageMgr.GetTranslation("worldboss.view.WorldBossItem.timetxt");
         _desc.text = LanguageMgr.GetTranslation("worldboss.view.WorldBossItem.desc");
         _state.text = LanguageMgr.GetTranslation("worldboss.view.WorldBossItem.state");
      }
      
      public function get worldBossTemplate() : CampaignTemplate
      {
         return _worldBossTemplate;
      }
      
      public function set worldBossTemplate(param1:CampaignTemplate) : void
      {
         _worldBossTemplate = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         _name.text = _worldBossTemplate.CampaignName;
         _level.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_worldBossTemplate.MinLevel);
         _time.text = LanguageMgr.GetTranslation("worldboss.view.WorldBossItem.time",_worldBossTemplate.OpenTime,_worldBossTemplate.StopTime);
         _desc.text = _worldBossTemplate.Description ? _worldBossTemplate.Description : "";
         _icon.icon = IconFactory.getBossIcon(_worldBossTemplate.CampaignId);
         updateState();
      }
      
      override public function updateState() : void
      {
         state = _worldBossTemplate.state;
         _state.text = _worldBossTemplate.stateValue;
         _buyAvatarButton.visible = false;
         _enterButton.visible = false;
         _useState.visible = false;
         _state.visible = false;
         _enterButton.y = 10;
         if(state == 2)
         {
            _state.visible = true;
         }
         else if(state == 1)
         {
            _state.visible = true;
            updateBuyState();
         }
         else if(state == 0)
         {
            _enterButton.visible = true;
            _enterButton.y = 10;
         }
      }
      
      private function updateBuyState() : void
      {
         if(stuntman.hasBuyFor(_worldBossTemplate.CampaignId))
         {
            _buyAvatarButton.selected = true;
         }
         else
         {
            _buyAvatarButton.selected = false;
         }
      }
      
      private function get stuntman() : WorldBossStuntmanInfo
      {
         return WorldBossManager.instance.stuntman;
      }
      
      private function initEvent() : void
      {
         _enterButton.addEventListener("click",__enterHander);
         _buyAvatarButton.addEventListener("click",__onBuyAvatarHandler);
      }
      
      private function removeEvent() : void
      {
         _enterButton.removeEventListener("click",__enterHander);
         _buyAvatarButton.removeEventListener("click",__onBuyAvatarHandler);
      }
      
      private function __enterHander(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_worldBossTemplate.MinLevel > ArmyManager.instance.thane.grades)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command02");
            MessageTipManager.instance().show(_loc2_);
         }
         else if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            MessageTipManager.instance().show(WorldBossHelper.getCampaignTips());
         }
         else if(stuntman.hasBuyFor(this.worldBossTemplate.CampaignId))
         {
            alertWarning();
         }
         else
         {
            control.sendEnterBattle(_worldBossTemplate);
         }
      }
      
      private function alertWarning() : void
      {
         SimpleAlertHelper.instance.data = [enter];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("worldboss.BuyAvatarFrame.command04");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true);
      }
      
      private function enter(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            control.sendEnterBattle(_worldBossTemplate);
            control.sendCancelStunmanFor(this.worldBossTemplate.CampaignId);
            this.stuntman.cancelBuyFor(this.worldBossTemplate.CampaignId);
         }
      }
      
      private function __onBuyAvatarHandler(param1:Event) : void
      {
         if(WorldBossManager.instance.stuntman.hasBuyFor(this._worldBossTemplate.CampaignId))
         {
            WorldBossSocketOutManager.sendCancelStunmanFor(this._worldBossTemplate.CampaignId);
            WorldBossManager.instance.stuntman.cancelBuyFor(this._worldBossTemplate.CampaignId);
         }
         else
         {
            WorldBossSocketOutManager.sendBuyStunmanFor(this._worldBossTemplate.CampaignId);
            WorldBossManager.instance.stuntman.buyFor(this._worldBossTemplate.CampaignId);
         }
      }
      
      private function get control() : WorldBossControler
      {
         return FrameControllerManager.instance.worldBossControler;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _back = null;
         _btnEff = null;
         _buyAvatarButton = null;
         _desc = null;
         _enterButton = null;
         _icon = null;
         _iconBack = null;
         _level = null;
         _name = null;
         _state = null;
         _time = null;
         _worldBossTemplate = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


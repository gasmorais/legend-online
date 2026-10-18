package worldboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import managers.WorldBossManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import ui.toptoolbar.TopBtnType;
   import ui.toptoolbar.view.TimeActiveBoxOpenTime;
   import worldboss.pvp.WarFightItem;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.frame.NewVipOpenView;
   import yishi.view.frame.PvpHeroFrame;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class PvpSelectFrame extends Frame implements IManualSize
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _help:BaseButton;
      
      private var _vBox:VBox;
      
      private var _txt:FilterFrameText;
      
      private var _items:Array = [];
      
      private var _openType:int;
      
      private var _heroesBtn:IconButton;
      
      private var _vipOpenView:NewVipOpenView;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      private var _openStepTimes:String;
      
      public function PvpSelectFrame()
      {
         super();
         initView();
         initBufferView();
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
         _back = ComponentFactory.Instance.creatComponentByStylename("PvpSelectFrame.FrameBack");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("PvpSelectFrame.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("worldboss.Vbox");
         _txt = ComponentFactory.Instance.creatComponentByStylename("PvpSelectFrame.Txt");
         _heroesBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.pvp.warfight.HeroesButton");
         _help = ComponentFactory.Instance.creatComponentByStylename("worldboss.FriendList.help");
         _vipOpenView = new NewVipOpenView(15);
         addToContent(_back);
         _back.y = 22;
         addToContent(_scrollPanel);
         addToContent(_txt);
         _txt.y = 36;
         addToContent(_vipOpenView);
         _vipOpenView.x = 13;
         _vipOpenView.y = 202;
         addToContent(_help);
         addToContent(_heroesBtn);
         _scrollPanel.setView(_vBox);
         _help.tipData = LanguageMgr.GetTranslation("worldboss.WorldBossFrame.helpTips02");
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("WarField_MaxCount");
         var _loc1_:int = int(_loc4_ ? int(_loc4_.ConfigValue) : 2);
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.warFieldCount);
         var _loc3_:int = Math.max(_loc2_,0);
         _txt.htmlText = LanguageMgr.GetTranslation("PvpSelectFrame.countTxt") + toArialBold(_loc3_ + " / " + _loc1_);
         _heroesBtn.visible = false;
      }
      
      private function initBufferView() : void
      {
         var _loc1_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(8);
         if(_loc1_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc1_);
            _bufferView.setDescText(_loc1_.tempInfo.Desc);
            _bufferView.x = 235;
            _bufferView.y = 205;
            addToContent(_bufferView);
            _back.height = 247;
            this.height = 355;
         }
         else
         {
            _back.height = 227;
            this.height = 335;
         }
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      private function initEvent() : void
      {
         if(_heroesBtn)
         {
            _heroesBtn.addEventListener("click",__openHerosFrame);
         }
         addEventListener("response",__frameResponse);
         if(_help)
         {
            _help.addEventListener("click",__helpClick);
         }
         playerInfo.addEventListener("WORLDBOSSSTATE",__updateStateListHandler);
         NotificationManager.instance.addEventListener("UPDATE_WARFIGHT_STATE_LIST",__updateStateListHandler);
      }
      
      private function removeEvent() : void
      {
         if(_heroesBtn)
         {
            _heroesBtn.removeEventListener("click",__openHerosFrame);
         }
         removeEventListener("response",__frameResponse);
         if(_help)
         {
            _help.removeEventListener("click",__helpClick);
         }
         playerInfo.removeEventListener("WORLDBOSSSTATE",__updateStateListHandler);
         NotificationManager.instance.removeEventListener("UPDATE_WARFIGHT_STATE_LIST",__updateStateListHandler);
      }
      
      private function __openHerosFrame(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         CheckUIModuleUtil.instance.tryCall("sort",function():void
         {
            var _loc1_:PvpHeroFrame = ComponentFactory.Instance.createComponentGroupByStylename("worldboss.PvpHeroFrame");
            _loc1_.preFrame = "worldboss";
            _loc1_.show();
         });
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("worldboss.pvpHelperFrame");
         _loc2_.titleText = "worldboss.view.BaseHelpFrame.helpTitleText";
         _loc2_.helpHtmlStr = LanguageMgr.GetTranslation("worldboss.view.BaseHelpFrame.BattleHelpContent" + warType,_openStepTimes);
         _loc2_.commitChanges();
         _loc2_.show();
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
      
      private function __updateStateListHandler(param1:Event) : void
      {
         refreshList();
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
         _openType = param1;
         LayerManager.Instance.addToLayer(this,3,true,true);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("OPEN_CAMPAIGN_FRAME",null));
         titleText = LanguageMgr.GetTranslation("worldboss.WorldBossFrame.title02");
         refreshList();
         initEvent();
      }
      
      private function refreshList() : void
      {
         var _loc11_:String = null;
         var _loc17_:String = null;
         var _loc1_:int = 0;
         var _loc20_:Array = null;
         var _loc7_:int = 0;
         var _loc2_:WarFightItem = null;
         var _loc15_:CampaignTemplate = null;
         var _loc3_:WarFightItem = null;
         var _loc5_:int = 0;
         var _loc16_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         if(_loc16_.minutes >= 0 && _loc16_.minutes < 25)
         {
            _loc5_ = _loc16_.hours;
         }
         else
         {
            _loc5_ = _loc16_.hours + 1;
         }
         var _loc6_:int = int(TopBtnType.TIME_ACTIVE_BTNS.indexOf("rvr1"));
         var _loc12_:Array = TimeActiveBoxOpenTime.instance.getOpenTimeByIndex(_loc6_);
         var _loc14_:int = int(_loc12_.length);
         var _loc18_:int = 1;
         _openStepTimes = "";
         var _loc13_:Boolean = Boolean(WorldBossManager.instance.pvpWarIsOpen);
         _vBox.disposeAllChildren();
         _items = [];
         var _loc9_:WarFightItem = null;
         var _loc8_:WarFightItem = null;
         var _loc10_:WarFightItem = null;
         var _loc4_:WarFightItem = null;
         var _loc21_:int = 24;
         _loc7_ = 0;
         while(_loc7_ < _loc14_)
         {
            _loc20_ = _loc12_[_loc7_].split(",");
            if(_loc7_ == 0)
            {
               _openStepTimes += _loc12_[_loc7_].replace(",","-");
            }
            else
            {
               _openStepTimes += "," + _loc12_[_loc7_].replace(",","-");
            }
            _loc2_ = new WarFightItem();
            _loc11_ = _loc20_[0];
            _loc17_ = _loc20_[1];
            _loc1_ = int(_loc11_.split(":")[0]);
            _loc18_ = 1;
            if(_loc13_ && _loc5_ == _loc1_)
            {
               _loc18_ = 0;
            }
            if(warType == 1)
            {
               _loc2_.setDataTemp(warTemp.CampaignId,warTemp.CampaignName,_loc18_,_loc11_,_loc17_,warTemp.Description);
               _items.push(_loc2_);
               if(_loc18_ == 0)
               {
                  _loc9_ = _loc2_;
               }
               else if(_loc1_ >= _loc5_ && _loc1_ < _loc21_)
               {
                  _loc10_ = _loc2_;
                  _loc21_ = _loc1_;
               }
            }
            else
            {
               _loc15_ = TempleteManager.instance.pvpWarFightDic[4901];
               _loc2_.setDataTemp(_loc15_.CampaignId,_loc15_.CampaignName,_loc18_,_loc11_,_loc17_,_loc15_.Description);
               _items.push(_loc2_);
               if(_loc18_ == 0)
               {
                  _loc9_ = _loc2_;
               }
               else if(_loc1_ >= _loc5_ && _loc1_ < _loc21_)
               {
                  _loc10_ = _loc2_;
                  _loc21_ = _loc1_;
               }
               _loc3_ = new WarFightItem();
               _loc15_ = TempleteManager.instance.pvpWarFightDic[4101];
               _loc3_.setDataTemp(_loc15_.CampaignId,_loc15_.CampaignName,_loc18_,_loc11_,_loc17_,_loc15_.Description);
               _items.push(_loc3_);
               if(_loc18_ == 0)
               {
                  _loc8_ = _loc3_;
               }
               else if(_loc10_ && _loc21_ == _loc1_)
               {
                  _loc4_ = _loc3_;
               }
            }
            _loc7_++;
         }
         if(_loc9_)
         {
            _vBox.addChild(_loc9_);
            if(_loc8_)
            {
               _vBox.addChild(_loc8_);
            }
         }
         if(_loc10_)
         {
            _vBox.addChild(_loc10_);
            if(_loc4_)
            {
               _vBox.addChild(_loc4_);
            }
         }
         for each(var _loc19_:WarFightItem in _items)
         {
            if(_loc19_ != _loc9_ && _loc19_ != _loc8_ && _loc19_ != _loc10_ && _loc19_ != _loc4_)
            {
               _vBox.addChild(_loc19_);
            }
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function get warType() : int
      {
         if(thane.isAvenger)
         {
            return 3;
         }
         if(thane.isChangeJob)
         {
            return 2;
         }
         return 1;
      }
      
      private function get warTemp() : CampaignTemplate
      {
         if(thane.isAvenger)
         {
            return TempleteManager.instance.pvpWarFightDic[4901];
         }
         if(thane.isChangeJob)
         {
            return TempleteManager.instance.pvpWarFightDic[4101];
         }
         return TempleteManager.instance.pvpWarFightDic[4701];
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_heroesBtn);
         _heroesBtn = null;
         ObjectUtils.disposeObject(_vipOpenView);
         _vipOpenView = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         super.dispose();
      }
   }
}


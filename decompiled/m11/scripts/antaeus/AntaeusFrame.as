package antaeus
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.AntaeusEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.antaeus.AntaeusAssistantData;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.AntaeusManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class AntaeusFrame extends Frame
   {
      
      private var _btnSign:IconButton;
      
      private var _btnRight:BaseButton;
      
      private var _btnLeft:BaseButton;
      
      private var _btnShop:BaseButton;
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _bit2:Bitmap;
      
      private var _bit3:Bitmap;
      
      private var _bit4:Bitmap;
      
      private var _bit5:Bitmap;
      
      private var _bit6:Bitmap;
      
      private var _txtName:FilterFrameText;
      
      private var _txtSite:FilterFrameText;
      
      private var _txtCount:FilterFrameText;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _txt3:FilterFrameText;
      
      private var _txt4:FilterFrameText;
      
      private var _txt5:FilterFrameText;
      
      private var _txt6:FilterFrameText;
      
      private var _bit7:Bitmap;
      
      private var _bit8:Bitmap;
      
      private var _bit9:Bitmap;
      
      private var PLAYER_COUNT:int = 10;
      
      private var playerBox:VBox;
      
      private var contentBox:HBox;
      
      private var numBitmap:BitmapData;
      
      private var numSP:Sprite;
      
      private var _avatar:ShowAvatar;
      
      private var _selectedData:AntaeusAssistantData;
      
      private var _avatarData:ThaneInfo;
      
      private var _icon1:BaseIconView;
      
      private var _icon2:BaseIconView;
      
      private var _icon3:BaseIconView;
      
      private var _icon4:BaseIconView;
      
      private var _icon5:BaseIconView;
      
      private var _icon6:BaseIconView;
      
      private var _tipContainer:Component;
      
      private var _helpBtn:BaseButton;
      
      private var funCount:int = 4;
      
      private var pageCount:int = 3;
      
      private var curPage:int;
      
      public function AntaeusFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _btnSign = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.btnSign");
         _btnRight = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.btnRight");
         _btnLeft = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.btnLeft");
         _btnShop = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.btnShop");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.antaeus.strFP");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.antaeus.str2");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.antaeus.str3");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.antaeus.str4");
         _bit4 = ComponentFactory.Instance.creatBitmap("asset.antaeus.str7");
         _bit5 = ComponentFactory.Instance.creatBitmap("asset.antaeus.str1");
         _bit6 = ComponentFactory.Instance.creatBitmap("asset.antaeus.str8");
         _txtName = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txtName");
         _txtSite = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txtSite");
         _txtCount = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txtCount");
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txt1");
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txt2");
         _txt3 = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txt3");
         _txt4 = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txt4");
         _txt5 = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txt5");
         _txt6 = ComponentFactory.Instance.creatComponentByStylename("ui.antaeus.txt6");
         _bit7 = ComponentFactory.Instance.creatBitmap("asset.antaeus.bg");
         _bit8 = ComponentFactory.Instance.creatBitmap("asset.antaeus.border");
         _bit9 = ComponentFactory.Instance.creatBitmap("asset.antaeus.title");
         addToContent(_bit7);
         addToContent(_btnSign);
         addToContent(_btnRight);
         addToContent(_btnLeft);
         addToContent(_btnShop);
         addToContent(_bit0);
         addToContent(_bit1);
         addToContent(_bit2);
         addToContent(_bit3);
         addToContent(_bit4);
         addToContent(_bit5);
         addToContent(_bit6);
         addToContent(_txtName);
         addToContent(_txtSite);
         addToContent(_txtCount);
         addToContent(_txt1);
         addToContent(_txt2);
         addToContent(_txt3);
         addToContent(_txt4);
         addToContent(_txt5);
         addToContent(_txt6);
         addToContent(_bit8);
         addToContent(_bit9);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("antaeus.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("antaeus.help.title");
         addToContent(_helpBtn);
         playerBox = ComponentFactory.Instance.creatComponentByStylename("antaeus.vbox");
         addToContent(playerBox);
         contentBox = ComponentFactory.Instance.creatComponentByStylename("antaeus.hbox");
         addToContent(contentBox);
         numBitmap = ComponentFactory.Instance.creatBitmapData("asset.antaeus.num1");
         numSP = new Sprite();
         addToContent(numSP);
         numSP.x = _bit0.x + _bit0.width + 3;
         numSP.y = _bit0.y - 2;
         _avatar = new ShowAvatar(false,__onCompleteHandler);
         _avatar.scaleX = _avatar.scaleY = 0.85;
         _avatar.mouseEnabled = _avatar.mouseChildren = false;
         addToContent(_avatar);
         _avatar.x = 310;
         _avatar.y = 221;
         _icon1 = ComponentFactory.Instance.creatComponentByStylename("antaeus.propertyIcon1");
         addToContent(_icon1);
         _icon2 = ComponentFactory.Instance.creatComponentByStylename("antaeus.propertyIcon2");
         addToContent(_icon2);
         _icon3 = ComponentFactory.Instance.creatComponentByStylename("antaeus.propertyIcon3");
         addToContent(_icon3);
         _icon4 = ComponentFactory.Instance.creatComponentByStylename("antaeus.propertyIcon4");
         addToContent(_icon4);
         _icon5 = ComponentFactory.Instance.creatComponentByStylename("antaeus.propertyIcon5");
         addToContent(_icon5);
         _icon6 = ComponentFactory.Instance.creatComponentByStylename("antaeus.propertyIcon6");
         addToContent(_icon6);
         initContent();
         m.sendOpenView();
         _tipContainer = new Component();
         addToContent(_tipContainer);
         _btnLeft.enable = _btnRight.enable = false;
      }
      
      private function __onCompleteHandler() : void
      {
         var _loc1_:Boolean = false;
         if(_avatarData)
         {
            _avatar.data = _avatarData;
            _loc1_ = Boolean(PlayerManager.instance.getIsDragonTalkerState(_avatarData));
            _avatar.y = _loc1_ ? 211 : 221;
         }
      }
      
      private function refreshPlayerView() : void
      {
         if(!_selectedData)
         {
            NumberViewUtils.refreshValue(0,numSP,numBitmap,22,27,14,22,"0123456789");
            _txtName.text = "";
            _txtSite.text = "";
         }
         else
         {
            NumberViewUtils.refreshValue(_selectedData.power,numSP,numBitmap,22,27,14,22,"0123456789");
            _txtName.text = _selectedData.showData.player.nickName;
            _txtSite.text = "[" + _selectedData.showData.player.serverName + "]";
            _txtCount.text = LanguageMgr.GetTranslation("antaeus.assistCount",_selectedData.assists);
            _avatarData = new ThaneInfo();
            _avatarData.armsEquipAvata = _selectedData.showData.player.arm;
            _avatarData.bodyEquipAvata = _selectedData.showData.player.cloth;
            _avatarData.wingAvata = _selectedData.showData.player.wing;
            _avatarData.hairFashionAvata = _selectedData.showData.player.hat;
            _avatarData.hairEquipAvata = _selectedData.showData.player.hat;
            _avatarData.hideFashion = _selectedData.showData.player.hideFashion;
            _avatarData.armsFashionAvata = _selectedData.showData.player.fashionArm;
            _avatarData.bodyFashionAvata = _selectedData.showData.player.fashionCloth;
            _avatarData.isOpenDragonTalker = _selectedData.showData.player.isDragonTalker;
            _avatarData.job = _selectedData.showData.player.job;
            _avatarData.templateId = _selectedData.showData.player.heroTempId;
            _avatar.data = _avatarData;
            _icon1.icon = _selectedData.showData.getPetIcon();
            _icon2.icon = _selectedData.showData.getChildIcon();
            _icon3.icon = _selectedData.showData.getSlaveChildIcon();
            _icon4.icon = _selectedData.showData.getGoddessIcon();
            _icon5.icon = _selectedData.showData.getArtifactIcon();
            _icon6.icon = _selectedData.showData.getTitanIcon();
            if(_tipContainer)
            {
               _tipContainer.dispose();
               _tipContainer = null;
            }
            makeTip(_txt1,1);
            makeTip(_txt2,2);
            makeTip(_txt3,3);
            makeTip(_txt4,4);
            makeTip(_txt5,5);
            makeTip(_txt6,6);
         }
         _txt1.text = LanguageMgr.GetTranslation("antaeus.str1");
         _txt2.text = LanguageMgr.GetTranslation("antaeus.str2");
         _txt3.text = LanguageMgr.GetTranslation("antaeus.str3");
         _txt4.text = LanguageMgr.GetTranslation("antaeus.str4");
         _txt5.text = LanguageMgr.GetTranslation("antaeus.str5");
         _txt6.text = LanguageMgr.GetTranslation("antaeus.str6");
      }
      
      private function makeTip(param1:FilterFrameText, param2:int) : void
      {
         _tipContainer = new Component();
         addToContent(_tipContainer);
         var _loc4_:Component = new Component();
         _loc4_.x = param1.x;
         _loc4_.y = param1.y;
         _loc4_.graphics.beginFill(0,0);
         _loc4_.graphics.drawRect(0,0,param1.width,param1.height);
         _loc4_.graphics.endFill();
         _tipContainer.addChild(_loc4_);
         _loc4_.tipStyle = "antaeus.AntaeusTip";
         _loc4_.tipDirctions = "4,1,6,5,2,7,0,3";
         _loc4_.isFollowMouse = false;
         _loc4_.tipGapH = 0;
         _loc4_.tipGapV = 0;
         _loc4_.buttonMode = true;
         var _loc3_:Object = {};
         _loc3_.data = _selectedData.showData;
         _loc3_.index = param2;
         _loc4_.tipData = _loc3_;
      }
      
      private function initContent() : void
      {
         var _loc2_:AntaeusItem = null;
         var _loc1_:int = 0;
         while(contentBox.numChildren > 0)
         {
            _loc2_ = contentBox.removeChildAt(0) as AntaeusItem;
            _loc2_.dispose();
         }
         curPage = 1;
         _loc1_ = 1;
         while(_loc1_ <= pageCount)
         {
            _loc2_ = new AntaeusItem();
            _loc2_.index = _loc1_;
            contentBox.addChild(_loc2_);
            _loc1_++;
         }
      }
      
      private function initPlayerList() : void
      {
         var _loc2_:AntaeusListItem = null;
         var _loc1_:int = 0;
         while(playerBox.numChildren > 0)
         {
            _loc2_ = playerBox.removeChildAt(0) as AntaeusListItem;
            _loc2_.dispose();
         }
         _loc1_ = 0;
         while(_loc1_ < PLAYER_COUNT)
         {
            _loc2_ = new AntaeusListItem(m.model.antaeusData.getDataByRank(_loc1_ + 1));
            _loc2_.clickback = clickPlayerBack;
            playerBox.addChild(_loc2_);
            _loc1_++;
         }
         if(!_selectedData)
         {
            _loc2_ = playerBox.getChildAt(0) as AntaeusListItem;
            _loc2_.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function clickPlayerBack(param1:AntaeusAssistantData) : void
      {
         var _loc3_:AntaeusListItem = null;
         var _loc2_:int = 0;
         _selectedData = param1;
         _loc2_ = 0;
         while(_loc2_ < PLAYER_COUNT)
         {
            _loc3_ = playerBox.getChildAt(_loc2_) as AntaeusListItem;
            _loc3_.selected = false;
            _loc2_++;
         }
         refreshPlayerView();
         refreshContentView();
      }
      
      private function refreshContentView() : void
      {
         var _loc1_:AntaeusItem = null;
         var _loc2_:int = 0;
         _btnLeft.enable = curPage > 1;
         _btnRight.enable = curPage + pageCount - 1 < funCount;
         _loc2_ = 0;
         while(_loc2_ < pageCount)
         {
            _loc1_ = contentBox.getChildAt(_loc2_) as AntaeusItem;
            _loc1_.index = curPage + _loc2_;
            _loc1_.data = _selectedData;
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btnShop.addEventListener("click",onClickShop);
         _btnSign.addEventListener("click",onClickSign);
         m.addEventListener("UPDATE_INFO",updateInfo);
         _helpBtn.addEventListener("click",__helpClick);
         _btnLeft.addEventListener("click",__preBtnClickHandler);
         _btnRight.addEventListener("click",__nextBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btnShop.removeEventListener("click",onClickShop);
         _btnSign.removeEventListener("click",onClickSign);
         m.removeEventListener("UPDATE_INFO",updateInfo);
         _helpBtn.removeEventListener("click",__helpClick);
         _btnLeft.addEventListener("click",__preBtnClickHandler);
         _btnRight.addEventListener("click",__nextBtnClickHandler);
      }
      
      private function __nextBtnClickHandler(param1:MouseEvent) : void
      {
         curPage = curPage + 1;
         refreshContentView();
      }
      
      private function __preBtnClickHandler(param1:MouseEvent) : void
      {
         curPage = curPage - 1;
         refreshContentView();
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         var _loc2_:AntaeusHelpFrame = ComponentFactory.Instance.creatComponentByStylename("antaeus.AntaeusHelpFrame");
         _loc2_.show();
      }
      
      protected function updateInfo(param1:AntaeusEvent) : void
      {
         initPlayerList();
         refreshPlayerView();
         refreshContentView();
      }
      
      protected function onClickShop(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",1017);
      }
      
      protected function onClickSign(param1:MouseEvent) : void
      {
         var _loc5_:Number = int(TempleteManager.instance.getConfigInfoByConfigName("antaeus_sign_power").ConfigValue);
         var _loc3_:Number = Number(ArmyManager.instance.thane.fightingCapacity);
         if(_loc3_ < _loc5_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("antaeus.powerNotEnough",_loc5_));
            return;
         }
         if(!m.model.canSign)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("antaeus.powerLowerThanLast"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("antaeus.campaign.sign");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc6_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [confirm];
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc2_,_loc4_,_loc6_,false,true,true,1);
      }
      
      private function confirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            m.sendSign();
         }
      }
      
      private function get m() : AntaeusManager
      {
         return AntaeusManager.instance;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         m.clear();
         removeEvent();
         ObjectUtils.disposeObject(_btnSign);
         _btnSign = null;
         ObjectUtils.disposeObject(_btnRight);
         _btnRight = null;
         ObjectUtils.disposeObject(_btnLeft);
         _btnLeft = null;
         ObjectUtils.disposeObject(_btnShop);
         _btnShop = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(_bit4);
         _bit4 = null;
         ObjectUtils.disposeObject(_bit5);
         _bit5 = null;
         ObjectUtils.disposeObject(_bit6);
         _bit6 = null;
         ObjectUtils.disposeObject(_txtName);
         _txtName = null;
         ObjectUtils.disposeObject(_txtSite);
         _txtSite = null;
         ObjectUtils.disposeObject(_txtCount);
         _txtCount = null;
         ObjectUtils.disposeObject(_txt1);
         _txt1 = null;
         ObjectUtils.disposeObject(_txt2);
         _txt2 = null;
         ObjectUtils.disposeObject(_txt3);
         _txt3 = null;
         ObjectUtils.disposeObject(_txt4);
         _txt4 = null;
         ObjectUtils.disposeObject(_txt5);
         _txt5 = null;
         ObjectUtils.disposeObject(_txt6);
         _txt6 = null;
         ObjectUtils.disposeObject(_bit7);
         _bit7 = null;
         ObjectUtils.disposeObject(_bit8);
         _bit8 = null;
         ObjectUtils.disposeObject(_bit9);
         _bit9 = null;
         ObjectUtils.disposeObject(playerBox);
         playerBox = null;
         ObjectUtils.disposeObject(contentBox);
         contentBox = null;
         ObjectUtils.disposeObject(numBitmap);
         numBitmap = null;
         ObjectUtils.disposeObject(numSP);
         numSP = null;
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         ObjectUtils.disposeObject(_icon1);
         _icon1 = null;
         ObjectUtils.disposeObject(_icon2);
         _icon2 = null;
         ObjectUtils.disposeObject(_icon3);
         _icon3 = null;
         ObjectUtils.disposeObject(_icon4);
         _icon4 = null;
         ObjectUtils.disposeObject(_icon5);
         _icon5 = null;
         ObjectUtils.disposeObject(_icon6);
         _icon6 = null;
         ObjectUtils.disposeObject(_tipContainer);
         _tipContainer = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}


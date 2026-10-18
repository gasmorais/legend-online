package armyII.viewII.equip
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class MedalFrame extends Frame
   {
      
      private var _bg:Image;
      
      private var _newItemBg:Image;
      
      private var _maxTips:Image;
      
      private var _attributeView1:MedalAttributeView;
      
      private var _attributeView2:MedalAttributeView;
      
      private var _currentGradesItem:BaseIconView;
      
      private var _nextGradesItem:BaseIconView;
      
      private var _expProgress:MovieClip;
      
      private var _inputBg:Image;
      
      private var _leftCountTips1:Image;
      
      private var _leftCountTips2:Image;
      
      private var _currentGradesTxt:FilterFrameText;
      
      private var _nextGradesTxt:FilterFrameText;
      
      private var _expTxt:FilterFrameText;
      
      private var _honerTxt:FilterFrameText;
      
      private var _costTxt:FilterFrameText;
      
      private var _costInputTxt:FilterFrameText;
      
      private var _ownCountTxt:FilterFrameText;
      
      private var _upgradeTipTxt:FilterFrameText;
      
      private var _validDateTxt:FilterFrameText;
      
      private var _feedBtn:IconButton;
      
      private var _upgradeBtn:IconButton;
      
      private var _renewalBtn:IconButton;
      
      private var _renewalAdvBtn:IconButton;
      
      private var _renewalIcon:Bitmap;
      
      private var _helpBtn:BaseButton;
      
      private var _renewalCost:int;
      
      private var _renewalAdvCost:int;
      
      private var _thane:ThaneInfo = ArmyManager.instance.thane;
      
      private var _playerModel:PlayerModel = PlayerManager.instance.currentPlayerModel;
      
      private var _currencyInfo:PlayerCurrencyInfo = PlayerCurrencyManager.instance.currencyInfo;
      
      private const OP_FEED:int = 1;
      
      private const OP_FEED_ADV:int = 2;
      
      private const OP_UPGRADE:int = 3;
      
      private const OP_RENEWAL:int = 4;
      
      private const OP_RENEWAL_ADV:int = 5;
      
      private const TEMPLATE_ID:int = 208041;
      
      public function MedalFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("armyII.viewII.equip.MedalFrame.TitleTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.ContentBg");
         _newItemBg = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.NewItemBg");
         _maxTips = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.MaxTips");
         _attributeView1 = ComponentFactory.Instance.creatCustomObject("army.MedalFrame.AttributeView1");
         _attributeView2 = ComponentFactory.Instance.creatCustomObject("army.MedalFrame.AttributeView2");
         _currentGradesItem = ComponentFactory.Instance.creatCustomObject("army.MedalFrame.CurrentGradesItem");
         _nextGradesItem = ComponentFactory.Instance.creatCustomObject("army.MedalFrame.NextGradesItem");
         _expProgress = ComponentFactory.Instance.creatCustomObject("army.MedalFrame.ExpProgress");
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.InputBg");
         _leftCountTips1 = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.LeftCountTips1");
         _leftCountTips2 = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.LeftCountTips2");
         _currentGradesTxt = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.CurrentGradesTxt");
         _nextGradesTxt = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.NextGradesTxt");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.ExpTxt");
         _honerTxt = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.HonerTxt");
         _costTxt = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.CostTxt");
         _costInputTxt = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.CostInputTxt");
         _ownCountTxt = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.OwnCountTxt");
         _upgradeTipTxt = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.UpgradeTipTxt");
         _validDateTxt = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.ValidDateTxt");
         _feedBtn = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.FeedBtn");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.UpgradeBtn");
         _renewalBtn = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.RenewalBtn");
         _renewalAdvBtn = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.RenewalAdvBtn");
         _renewalIcon = ComponentFactory.Instance.creatBitmap("asset.medal.RenewalIcon");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         _costInputTxt.text = "1";
         addToContent(_bg);
         addToContent(_newItemBg);
         addToContent(_maxTips);
         addToContent(_attributeView1);
         addToContent(_attributeView2);
         addToContent(_currentGradesItem);
         addToContent(_nextGradesItem);
         addToContent(_expProgress);
         addToContent(_inputBg);
         addToContent(_leftCountTips1);
         addToContent(_leftCountTips2);
         addToContent(_currentGradesTxt);
         addToContent(_nextGradesTxt);
         addToContent(_expTxt);
         addToContent(_honerTxt);
         addToContent(_costTxt);
         addToContent(_costInputTxt);
         addToContent(_ownCountTxt);
         addToContent(_upgradeTipTxt);
         addToContent(_validDateTxt);
         addToContent(_feedBtn);
         addToContent(_upgradeBtn);
         addToContent(_renewalBtn);
         addToContent(_renewalAdvBtn);
         addToContent(_renewalIcon);
         addToContent(_helpBtn);
         _expProgress.gotoAndStop(1);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_newItemBg);
         _newItemBg = null;
         ObjectUtils.disposeObject(_maxTips);
         _maxTips = null;
         ObjectUtils.disposeObject(_attributeView1);
         _attributeView1 = null;
         ObjectUtils.disposeObject(_attributeView2);
         _attributeView2 = null;
         ObjectUtils.disposeObject(_currentGradesItem);
         _currentGradesItem = null;
         ObjectUtils.disposeObject(_nextGradesItem);
         _nextGradesItem = null;
         ObjectUtils.disposeObject(_expProgress);
         _expProgress = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_leftCountTips1);
         _leftCountTips1 = null;
         ObjectUtils.disposeObject(_leftCountTips2);
         _leftCountTips2 = null;
         ObjectUtils.disposeObject(_currentGradesTxt);
         _currentGradesTxt = null;
         ObjectUtils.disposeObject(_nextGradesTxt);
         _nextGradesTxt = null;
         ObjectUtils.disposeObject(_expTxt);
         _expTxt = null;
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         ObjectUtils.disposeObject(_costTxt);
         _costTxt = null;
         ObjectUtils.disposeObject(_costInputTxt);
         _costInputTxt = null;
         ObjectUtils.disposeObject(_ownCountTxt);
         _ownCountTxt = null;
         ObjectUtils.disposeObject(_upgradeTipTxt);
         _upgradeTipTxt = null;
         ObjectUtils.disposeObject(_validDateTxt);
         _validDateTxt = null;
         ObjectUtils.disposeObject(_feedBtn);
         _feedBtn = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_renewalBtn);
         _renewalBtn = null;
         ObjectUtils.disposeObject(_renewalAdvBtn);
         _renewalAdvBtn = null;
         ObjectUtils.disposeObject(_renewalIcon);
         _renewalIcon = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _feedBtn.addEventListener("click",__feedBtnClickHandler);
         _upgradeBtn.addEventListener("click",__upgradeBtnClickHandler);
         _renewalBtn.addEventListener("click",__renewalBtnClickHandler);
         _renewalAdvBtn.addEventListener("click",__renewalAdvBtnClickHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         _costInputTxt.addEventListener("change",__costInputChangeHandler);
         _thane.addEventListener("MEDALGRADE_UPDATE",__updateHandler);
         _thane.addEventListener("MEDALGP_UPDATE",__updateHandler);
         _thane.addEventListener("MEDALINVALIDTIME_UPDATE",__updateHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _feedBtn.removeEventListener("click",__feedBtnClickHandler);
         _upgradeBtn.removeEventListener("click",__upgradeBtnClickHandler);
         _renewalBtn.removeEventListener("click",__renewalBtnClickHandler);
         _renewalAdvBtn.removeEventListener("click",__renewalAdvBtnClickHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         _costInputTxt.removeEventListener("change",__costInputChangeHandler);
         _thane.removeEventListener("MEDALGRADE_UPDATE",__updateHandler);
         _thane.removeEventListener("MEDALGP_UPDATE",__updateHandler);
         _thane.removeEventListener("MEDALINVALIDTIME_UPDATE",__updateHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemUpdateHandler);
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.templateInfo.SonType == 321 || _loc2_.templateId == 208041)
         {
            refreshView();
         }
      }
      
      private function __updateHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("army.MedalFrame.HelpFrame");
         _loc2_.show();
      }
      
      private function __costInputChangeHandler(param1:Event) : void
      {
         var _loc3_:int = int(_costInputTxt.text);
         var _loc2_:int = int(_currencyInfo.arenaMedal.amount);
         if(_loc3_ > _loc2_)
         {
            _loc3_ = _loc2_;
            _costInputTxt.text = _loc3_.toString();
         }
         else if(_loc3_ < 1)
         {
            _costInputTxt.text = "1";
         }
         else
         {
            _costInputTxt.text = _loc3_.toString();
         }
      }
      
      private function __renewalAdvBtnClickHandler(param1:MouseEvent) : void
      {
         SocketSendManager.instance.sendMedalOp(5);
      }
      
      private function __renewalBtnClickHandler(param1:MouseEvent) : void
      {
         SocketSendManager.instance.sendMedalOp(4);
      }
      
      private function __upgradeBtnClickHandler(param1:MouseEvent) : void
      {
         SocketSendManager.instance.sendMedalOp(3);
      }
      
      private function __feedBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = int(_costInputTxt.text);
         if(_loc3_ == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.equip.MedalFrame.TipsTxt01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         SocketSendManager.instance.sendMedalOp(1,_loc3_);
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
      
      private function refreshView() : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = int(_thane.medalGrades);
         var _loc7_:int = _loc2_ + 1;
         var _loc6_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc2_,43);
         var _loc8_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc7_,43);
         var _loc9_:GoodsInfo = new GoodsInfo();
         var _loc1_:GoodsInfo = new GoodsInfo();
         var _loc4_:int = int(_currencyInfo.arenaMedal.amount);
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(208041));
         _newItemBg.visible = false;
         _maxTips.visible = false;
         _feedBtn.enable = false;
         _feedBtn.visible = false;
         _upgradeBtn.enable = false;
         _upgradeBtn.visible = false;
         _leftCountTips1.visible = false;
         _leftCountTips2.visible = false;
         _costTxt.visible = false;
         _costInputTxt.visible = false;
         _inputBg.visible = false;
         _honerTxt.text = "";
         _costTxt.text = "";
         _ownCountTxt.text = "";
         _upgradeTipTxt.text = "";
         _expTxt.text = "";
         _loc5_ = 100;
         if(_loc6_)
         {
            _loc9_.templateId = _loc6_.TemplateId;
            _attributeView1.updateContent(_loc9_,_loc9_,1);
            _currentGradesItem.icon = IconFactory.getGoodsIconByTID(_loc6_.TemplateId);
            _currentGradesTxt.text = LanguageMgr.GetTranslation("public.level2",_loc6_.Grades);
            _renewalCost = _loc9_.templateInfo.Property1;
            _renewalAdvCost = _loc9_.templateInfo.Property2;
            _renewalBtn.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.MedalFrame.TipsTxt02",_renewalCost,1);
            _renewalAdvBtn.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.MedalFrame.TipsTxt02",_renewalAdvCost,15);
            if(_loc8_)
            {
               _loc1_.templateId = _loc8_.TemplateId;
               _attributeView2.updateContent(_loc9_,_loc1_,2);
               _newItemBg.visible = true;
               _nextGradesItem.icon = IconFactory.getGoodsIconByTID(_loc8_.TemplateId);
               _nextGradesTxt.text = LanguageMgr.GetTranslation("public.level2",_loc8_.Grades);
               _honerTxt.text = _loc8_.ActiveObject.toString();
               _costTxt.text = _loc8_.TemplateName;
               _upgradeTipTxt.text = LanguageMgr.GetTranslation("armyII.viewII.equip.MedalFrame.TipsTxt03",_loc8_.TemplateName);
               _expTxt.text = _thane.medalGp + " / " + _loc8_.Data;
               _loc5_ = _thane.medalGp * 100 / _loc8_.Data;
               if(_thane.honer < _loc8_.ActiveObject)
               {
                  _honerTxt.setFrame(1);
               }
               else
               {
                  _honerTxt.setFrame(2);
               }
               if(_thane.medalGp < _loc8_.Data)
               {
                  _ownCountTxt.text = _loc4_.toString();
                  _ownCountTxt.x = 322;
                  _feedBtn.enable = true;
                  _feedBtn.visible = true;
                  _leftCountTips1.visible = true;
                  _costInputTxt.visible = true;
                  _inputBg.visible = true;
               }
               else
               {
                  _ownCountTxt.text = _loc3_.toString();
                  _ownCountTxt.x = 350;
                  _upgradeBtn.enable = true;
                  _upgradeBtn.visible = true;
                  _leftCountTips2.visible = true;
                  _costTxt.visible = true;
               }
            }
            else
            {
               _maxTips.visible = true;
               _honerTxt.setFrame(2);
               _honerTxt.text = "--";
               _costTxt.visible = true;
               _costTxt.text = "--";
               _attributeView2.visible = false;
               _nextGradesItem.icon = IconFactory.getGoodsIconByTID(_loc6_.TemplateId);
               _nextGradesTxt.text = LanguageMgr.GetTranslation("public.level2",_loc6_.Grades);
               _ownCountTxt.text = "";
            }
            _expProgress.gotoAndStop(_loc5_);
            if(_thane.medalInvalidTime > 0)
            {
               _validDateTxt.text = DateFormatter.getFullDateString(_thane.medalInvalidTime - _playerModel.sysCurTimeBySecond);
            }
            else
            {
               _validDateTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
            }
         }
         __costInputChangeHandler(null);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}


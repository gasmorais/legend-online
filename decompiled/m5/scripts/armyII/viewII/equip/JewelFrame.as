package armyII.viewII.equip
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.item.ItemUseStoreReqMsg;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BulePowerItem;
   
   public class JewelFrame extends Frame
   {
      
      private var _back:MutipleImage;
      
      private var _jewelIcon:ScaleFrameImage;
      
      private var _lvIcon:Image;
      
      private var _costBack:Image;
      
      private var _exp:BulePowerItem;
      
      private var _level:FilterFrameText;
      
      private var _currentEff:FilterFrameText;
      
      private var _currentEffValue:FilterFrameText;
      
      private var _nextEff:FilterFrameText;
      
      private var _nextEffeValue:FilterFrameText;
      
      private var _icon:BaseIconView;
      
      private var _current:FilterFrameText;
      
      private var _currentValue:FilterFrameText;
      
      private var _cost:FilterFrameText;
      
      private var _costValue:FilterFrameText;
      
      private var _alert:FilterFrameText;
      
      private var _maxGrame:FilterFrameText;
      
      private var _confitmBtn:IconButton;
      
      private var _strip:StripView;
      
      private var isHighLevel:Boolean = false;
      
      private var _max:int;
      
      private var _isMaxLevel:Boolean = false;
      
      public function JewelFrame()
      {
         super();
         initView();
         initEvent();
         _max = GoodsManager.instance.getCountBySontypeAndBagType(293,1);
         if(isHighLevel)
         {
            _max = GoodsManager.instance.getCountBySontypeAndBagType(318,1);
         }
         refreshView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("army.JewelBackAsset.MutipleImage");
         _jewelIcon = ComponentFactory.Instance.creatComponentByStylename("army.JeweIconImage");
         _lvIcon = ComponentFactory.Instance.creatComponentByStylename("army.LevelIcon");
         _costBack = ComponentFactory.Instance.creatComponentByStylename("army.JewelInputBack");
         _level = ComponentFactory.Instance.creatComponentByStylename("army.JewelLevel");
         _currentEff = ComponentFactory.Instance.creatComponentByStylename("army.JewelCurEff");
         _currentEffValue = ComponentFactory.Instance.creatComponentByStylename("army.JewelCurEffValue");
         _nextEff = ComponentFactory.Instance.creatComponentByStylename("army.JewelNextEff");
         _nextEffeValue = ComponentFactory.Instance.creatComponentByStylename("army.JewelNextEffValue");
         _current = ComponentFactory.Instance.creatComponentByStylename("army.JewelCurrent");
         _currentValue = ComponentFactory.Instance.creatComponentByStylename("army.JewelCurrentValue");
         _cost = ComponentFactory.Instance.creatComponentByStylename("army.JewelCost");
         _costValue = ComponentFactory.Instance.creatComponentByStylename("army.JewelCostValue");
         _alert = ComponentFactory.Instance.creatComponentByStylename("army.JewelAlert");
         _maxGrame = ComponentFactory.Instance.creatComponentByStylename("army.JewelMaxGrade");
         _confitmBtn = ComponentFactory.Instance.creatComponentByStylename("army.JewelConfirmBtn");
         _exp = ComponentFactory.Instance.creatCustomObject("army.JewelExp",[true]);
         _icon = ComponentFactory.Instance.creatCustomObject("army.JewelIcon");
         _strip = ComponentFactory.Instance.creatComponentByStylename("army.JewelConfirmBtnTip");
         _strip.addChild(_confitmBtn);
         addToContent(_back);
         addToContent(_jewelIcon);
         addToContent(_lvIcon);
         addToContent(_costBack);
         addToContent(_level);
         addToContent(_currentEff);
         addToContent(_currentEffValue);
         addToContent(_nextEff);
         addToContent(_nextEffeValue);
         addToContent(_current);
         addToContent(_currentValue);
         addToContent(_cost);
         addToContent(_costValue);
         addToContent(_alert);
         addToContent(_strip);
         addToContent(_exp);
         addToContent(_icon);
         var _loc2_:String = LanguageMgr.GetTranslation("auction.view.buy.HotSearchItem.goodsName2");
         var _loc1_:String = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelTitleTxt");
         _jewelIcon.setFrame(1);
         _icon.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelIconTipContent");
         if(thane.jewelGrades >= 80 && playerInfo.vocationGrades > 0)
         {
            isHighLevel = true;
         }
         if(isHighLevel)
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelAlertTxt.param");
            _loc1_ = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelTitleTxt02");
            _jewelIcon.setFrame(2);
            _confitmBtn.iconStyle = "asset.army.JewelHigtLevelTxtAsset";
            _confitmBtn.iconInnerRectString = "16,121,10,32,13";
            _icon.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelIconTipContent02");
         }
         _alert.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelAlertTxt",_loc2_,_loc1_);
         _cost.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelCostTxt");
         _current.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelCurrentValueTxt",_loc2_);
         _currentEff.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelCurrentEffTxt");
         _nextEff.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelNextEffTxt");
         titleText = _loc1_;
         _maxGrame.text = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command03");
         _costValue.restrict = "0-9";
         _currentValue.x = _current.x + _current.textWidth + 5;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confitmBtn.addEventListener("click",__confirmHandler);
         _costValue.addEventListener("change",__textChangeHandler);
         thane.addEventListener("JEWELGP_UPDATE",__updateHandler);
         thane.addEventListener("JEWELGRADES_UPDATE",__updateHandler);
         thane.addEventListener("SENIORSTOREGRADE_UPDATE",__updateHandler);
         thane.addEventListener("SENIORSTOREGP_UPDATE",__updateHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confitmBtn.removeEventListener("click",__confirmHandler);
         _costValue.removeEventListener("change",__textChangeHandler);
         thane.removeEventListener("JEWELGP_UPDATE",__updateHandler);
         thane.removeEventListener("JEWELGRADES_UPDATE",__updateHandler);
         thane.removeEventListener("SENIORSTOREGRADE_UPDATE",__updateHandler);
         thane.removeEventListener("SENIORSTOREGP_UPDATE",__updateHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemUpdateHandler);
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc3_:PackageOut = new PackageOut(8484);
         var _loc2_:ItemUseStoreReqMsg = new ItemUseStoreReqMsg();
         _loc2_.count = int(_costValue.text);
         _loc2_.templateId = 208014;
         if(isHighLevel)
         {
            _loc2_.templateId = 208031;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
         _confitmBtn.enable = false;
      }
      
      private function __textChangeHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_costValue.text);
         if(!_loc2_)
         {
            _loc2_ = 0;
         }
         if(_loc2_ > _max)
         {
            _costValue.text = _max.toString();
         }
         else
         {
            _costValue.text = _loc2_.toString();
         }
         if(_isMaxLevel)
         {
            if(!_confitmBtn.enable)
            {
               return;
            }
            _confitmBtn.enable = false;
         }
         else
         {
            _confitmBtn.enable = _max > 0 && _loc2_;
         }
      }
      
      private function __updateHandler(param1:PlayerEvent) : void
      {
         if(thane.jewelGrades >= 80 && playerInfo.vocationGrades > 0)
         {
            if(!isHighLevel)
            {
               isHighLevel = true;
               refreshTxt();
            }
         }
         refreshView();
      }
      
      private function refreshTxt() : void
      {
         _alert.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelAlertTxt",LanguageMgr.GetTranslation("auction.view.buy.HotSearchItem.goodsName2"),LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelTitleTxt02"));
         _jewelIcon.setFrame(2);
         titleText = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelTitleTxt02");
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.templateInfo.SonType == 293)
         {
            refreshView();
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(thane.jewelGrades + 1,15);
         _max = GoodsManager.instance.getCountBySontypeAndBagType(293,1);
         _level.text = thane.jewelGrades.toString();
         _icon.icon = IconFactory.getGoodsByTID(208014).iconPath;
         var _loc3_:String = LanguageMgr.GetTranslation("auction.view.buy.HotSearchItem.goodsName2");
         var _loc1_:String = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelTitleTxt");
         _currentEffValue.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",GoodsHelp.getJewelEffecyByGrade(thane.jewelGrades));
         _icon.tipData = IconFactory.getGoodsByTID(208014).Description;
         if(isHighLevel)
         {
            _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(thane.seniorStoreGrade + 1,104);
            _level.text = thane.seniorStoreGrade.toString();
            _max = GoodsManager.instance.getCountBySontypeAndBagType(318,1);
            _currentEffValue.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",GoodsHelp.getSeniorJewelEffecyByGrade(thane.seniorStoreGrade));
            _icon.icon = IconFactory.getGoodsByTID(208031).iconPath;
            _loc3_ = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelAlertTxt.param");
            _loc1_ = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelTitleTxt02");
            _jewelIcon.setFrame(2);
            _confitmBtn.iconStyle = "asset.army.JewelHigtLevelTxtAsset";
            _confitmBtn.iconInnerRectString = "35,85,10,32,13";
            _icon.tipData = _icon.tipData = IconFactory.getGoodsByTID(208031).Description;
         }
         _alert.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelAlertTxt",_loc3_,_loc1_);
         _cost.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelCostTxt");
         _current.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelCurrentValueTxt",_loc3_);
         _currentEff.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelCurrentEffTxt");
         _nextEff.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelNextEffTxt");
         titleText = _loc1_;
         _maxGrame.text = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command03");
         _costValue.restrict = "0-9";
         _currentValue.x = _current.x + _current.textWidth + 5;
         _currentValue.text = _max.toString();
         _costValue.text = _max.toString();
         if(_loc2_)
         {
            _exp.max = _loc2_.Data;
            _exp.current = thane.jewelGp;
            _nextEffeValue.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",GoodsHelp.getJewelEffecyByGrade(thane.jewelGrades + 1));
            if(isHighLevel)
            {
               _exp.current = thane.seniorStoreGp;
               _nextEffeValue.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelEffValueTxt",GoodsHelp.getSeniorJewelEffecyByGrade(thane.seniorStoreGrade + 1));
               _confitmBtn.enable = _max > 0 && int(_costValue.text) && thane.seniorStoreGrade < playerInfo.vocationLevel * 10;
            }
            else
            {
               _confitmBtn.enable = _max > 0 && int(_costValue.text);
            }
         }
         else
         {
            _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(thane.jewelGrades,15);
            if(isHighLevel)
            {
               _loc2_ = TempleteManager.instance.getTemplateByLevelAndType(thane.seniorStoreGrade,104);
            }
            _exp.max = _loc2_.Data;
            _exp.current = _loc2_.Data;
            _nextEff.text = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command03");
            _nextEffeValue.text = "";
            _confitmBtn.enable = false;
            _isMaxLevel = true;
            _strip.tipData = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command03");
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
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
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}


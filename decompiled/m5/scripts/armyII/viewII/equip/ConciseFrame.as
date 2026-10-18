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
   
   public class ConciseFrame extends Frame
   {
      
      private var _back:MutipleImage;
      
      private var _conciseIcon:Image;
      
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
      
      private var _max:int;
      
      private var _isMaxLevel:Boolean = false;
      
      public function ConciseFrame()
      {
         super();
         initView();
         initEvent();
         _max = GoodsManager.instance.getCountBySontypeAndBagType(276,1);
         refreshView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.MutipleImage");
         _conciseIcon = ComponentFactory.Instance.creatComponentByStylename("army.conciseIcon");
         _lvIcon = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.LevelIcon");
         _costBack = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.InputBack");
         _level = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.Level");
         _currentEff = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.CurEff");
         _currentEffValue = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.CurEffValue");
         _nextEff = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.NextEff");
         _nextEffeValue = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.NextEffValue");
         _current = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.Current");
         _currentValue = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.CurrentValue");
         _cost = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.Cost");
         _costValue = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.CostValue");
         _alert = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.Alert");
         _maxGrame = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.MaxGrade");
         _confitmBtn = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.ConfirmBtn");
         _exp = ComponentFactory.Instance.creatCustomObject("army.ConciseFrame.ConciseExp",[true]);
         _icon = ComponentFactory.Instance.creatCustomObject("army.ConciseFrame.ConciseIcon");
         _strip = ComponentFactory.Instance.creatComponentByStylename("army.ConciseFrame.ConfirmBtnTip");
         _strip.addChild(_confitmBtn);
         addToContent(_back);
         addToContent(_conciseIcon);
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
         var _loc1_:String = LanguageMgr.GetTranslation("armyII.viewII.equip.ConciseFrame.TitleTxt");
         _alert.text = LanguageMgr.GetTranslation("armyII.viewII.equip.ConciseFrame.AlertTxt");
         _cost.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelCostTxt");
         _current.text = LanguageMgr.GetTranslation("armyII.viewII.equip.ConciseFrame.CurrentValueTxt");
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
         thane.addEventListener("CONCISE_GP_CHANGE",__updateHandler);
         thane.addEventListener("CONCISE_GRADES_CHANGE",__updateHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confitmBtn.removeEventListener("click",__confirmHandler);
         _costValue.removeEventListener("change",__textChangeHandler);
         thane.removeEventListener("CONCISE_GP_CHANGE",__updateHandler);
         thane.removeEventListener("CONCISE_GRADES_CHANGE",__updateHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemUpdateHandler);
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc3_:PackageOut = new PackageOut(9592);
         var _loc2_:ItemUseStoreReqMsg = new ItemUseStoreReqMsg();
         _loc2_.count = int(_costValue.text);
         _loc2_.templateId = 208055;
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
         refreshView();
      }
      
      private function refreshTxt() : void
      {
         _alert.text = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelAlertTxt",LanguageMgr.GetTranslation("auction.view.buy.HotSearchItem.goodsName2"),LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelTitleTxt02"));
         titleText = LanguageMgr.GetTranslation("armyII.viewII.equip.JewelFrame.JewelTitleTxt02");
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.templateInfo.SonType == 276)
         {
            refreshView();
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(thane.conciseGrades + 1,117);
         _max = GoodsManager.instance.getCountBySontypeAndBagType(276,1);
         _level.text = thane.conciseGrades.toString();
         _icon.icon = IconFactory.getGoodsByTID(208055).iconPath;
         _currentEffValue.text = LanguageMgr.GetTranslation("armyII.viewII.equip.ConciseFrame.EffValueTxt",GoodsHelp.getConciseEffecyByGrade(thane.conciseGrades));
         _icon.tipData = IconFactory.getGoodsByTID(208055).Description;
         _maxGrame.text = LanguageMgr.GetTranslation("buildings.casern.view.PawnLevelUpFrame.command03");
         _costValue.restrict = "0-9";
         _currentValue.x = _current.x + _current.textWidth + 5;
         _currentValue.text = _max.toString();
         _costValue.text = _max.toString();
         if(_loc1_)
         {
            _exp.max = _loc1_.Data;
            _exp.current = thane.conciseGp;
            _nextEffeValue.text = LanguageMgr.GetTranslation("armyII.viewII.equip.ConciseFrame.EffValueTxt",GoodsHelp.getConciseEffecyByGrade(thane.conciseGrades + 1));
            _confitmBtn.enable = _max > 0 && int(_costValue.text);
         }
         else
         {
            _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(thane.conciseGrades,117);
            _exp.max = _loc1_.Data;
            _exp.current = _loc1_.Data;
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


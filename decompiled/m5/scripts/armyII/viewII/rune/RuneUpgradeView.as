package armyII.viewII.rune
{
   import bag.events.BagEvent;
   import cell.view.runebag.RuneIntensifyCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.RuneInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.BulePowerItem;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class RuneUpgradeView extends Frame implements IManualSize
   {
      
      private const LOW_RUNE_TEMPID:int = 3020010;
      
      private var _back:ScaleBitmapImage;
      
      private var _back3:MovieClip;
      
      private var _bottomBg:ScaleLeftRightImage;
      
      private var _middlebg:Bitmap;
      
      private var _nameBack:Bitmap;
      
      private var _iconBack:Bitmap;
      
      private var _baseIcon:BaseIconView;
      
      private var _data:RuneInfo;
      
      private var _runeBag:RuneBag;
      
      private var _itemDic:SimpleDictionary;
      
      private var _runeList:Array;
      
      private var _runeListView:Sprite;
      
      private var _upgradeBtn:IconButton;
      
      private var _quickBuyBtn:IconButton;
      
      private var _nameTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _expGetTipTxt:FilterFrameText;
      
      private var _expGetTxt:FilterFrameText;
      
      private var _autoPut:FilterFrameText;
      
      private var _expGet:int;
      
      private var _exp:BulePowerItem;
      
      private var _maxIcon:BaseIconView;
      
      private var _maxIconLevelTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _runeCarryTwoLevel:int = 40;
      
      private var _runeOpenLevel:int = 35;
      
      public function RuneUpgradeView()
      {
         super();
         _runeCarryTwoLevel = int(TempleteManager.instance.getConfigInfoByConfigName("CarryTwoRune").ConfigValue);
         _runeOpenLevel = int(TempleteManager.instance.getConfigInfoByConfigName("OpenRuneGrade").ConfigValue);
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,575,395);
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:RuneIntensifyCell = null;
         titleText = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.TitleTxt");
         _itemDic = new SimpleDictionary(true);
         _runeList = [];
         _runeListView = new Sprite();
         _runeListView.x = 38;
         _runeListView.y = 100;
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("army.rune.IntensifyRuneItem");
            _loc2_.x = (int(_loc1_ % 4) - 1) * 58 + 35;
            _loc2_.y = int(_loc1_ / 4) * 58 - int(_loc1_ / 4) * 4;
            _runeListView.addChild(_loc2_);
            _runeList.push(_loc2_);
            _loc2_.pos = _loc1_;
            _itemDic.add(_loc1_ + "_0_" + 0,_loc2_);
            _loc1_++;
         }
         _back = ComponentFactory.Instance.creatComponentByStylename("army.rune.RuneUpgradeViewBackGround");
         _back3 = ComponentFactory.Instance.creatCustomObject("army.rune.Back3");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("army.rune.UpgradeRightBottomBg");
         _middlebg = ComponentFactory.Instance.creatBitmap("asset.army.rune.MiddleBg");
         _nameBack = ComponentFactory.Instance.creatBitmap("asset.army.rune.TextBack1");
         _iconBack = ComponentFactory.Instance.creatBitmap("asset.army.rune.IconBack");
         _baseIcon = ComponentFactory.Instance.creatCustomObject("army.rune.EquipedIcon");
         _runeBag = ComponentFactory.Instance.creatCustomObject("army.rune.RuneBag",[5,5]);
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("army.rune.SwallowBtn");
         _quickBuyBtn = ComponentFactory.Instance.creatComponentByStylename("army.rune.QuickByBtn");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("army.rune.UpgradeNameTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("army.rune.UpgradeLevelTxt");
         _expGetTipTxt = ComponentFactory.Instance.creatComponentByStylename("army.rune.UpgradeExpGetTipsTxt");
         _expGetTxt = ComponentFactory.Instance.creatComponentByStylename("army.rune.UpgradeExpGetTxt");
         _autoPut = ComponentFactory.Instance.creatComponentByStylename("army.rune.UpgradeAutoPutTxt");
         _exp = ComponentFactory.Instance.creatCustomObject("army.rune.RuneExp",[true]);
         _maxIcon = ComponentFactory.Instance.creatCustomObject("army.rune.MaxEquipedIcon");
         _maxIconLevelTxt = ComponentFactory.Instance.creatComponentByStylename("army.rune.UpgradeMaxLevelTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("army.rune.RuneUpgradeHelpBtn");
         _expGetTipTxt.text = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.ExpGetTipTxt");
         _expGetTxt.text = "0";
         _maxIconLevelTxt.text = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.RuneMaxTxt");
         _helpBtn.tipData = LanguageMgr.GetTranslation("armyII.SkillFrame.HelpBtn.RuneTipdata");
         _autoPut.htmlText = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.AutoPutTxt");
         _autoPut.mouseEnabled = true;
         _nameBack.x = 80;
         _nameBack.y = 15;
         _iconBack.x = 5;
         _iconBack.y = 15;
         _baseIcon.x = 6;
         _baseIcon.y = 16;
         addToContent(_back);
         addToContent(_back3);
         addToContent(_bottomBg);
         addToContent(_middlebg);
         addToContent(_runeBag);
         addToContent(_runeListView);
         addToContent(_nameBack);
         addToContent(_iconBack);
         addToContent(_baseIcon);
         addToContent(_upgradeBtn);
         addToContent(_quickBuyBtn);
         addToContent(_nameTxt);
         addToContent(_expGetTipTxt);
         addToContent(_expGetTxt);
         addToContent(_autoPut);
         addToContent(_exp);
         addToContent(_maxIcon);
         addToContent(_maxIconLevelTxt);
         addToContent(_helpBtn);
      }
      
      private function unitView() : void
      {
         cleanList();
         if(_back)
         {
            _back.dispose();
         }
         _back = null;
         if(_bottomBg)
         {
            _bottomBg.dispose();
         }
         _bottomBg = null;
         ObjectUtils.disposeViolentMc(_back3);
         _back3 = null;
         ObjectUtils.disposeObject(_middlebg);
         _middlebg = null;
         ObjectUtils.disposeObject(_nameBack);
         _nameBack = null;
         ObjectUtils.disposeObject(_iconBack);
         _iconBack = null;
         ObjectUtils.disposeAllChildren(_runeListView);
         _runeListView = null;
         if(_baseIcon)
         {
            _baseIcon.dispose();
         }
         _baseIcon = null;
         if(_runeBag)
         {
            _runeBag.dispose();
         }
         _runeBag = null;
         if(_upgradeBtn)
         {
            _upgradeBtn.dispose();
         }
         _upgradeBtn = null;
         if(_quickBuyBtn)
         {
            _quickBuyBtn.dispose();
         }
         _quickBuyBtn = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_levelTxt)
         {
            _levelTxt.dispose();
         }
         _levelTxt = null;
         if(_expGetTipTxt)
         {
            _expGetTipTxt.dispose();
         }
         _expGetTipTxt = null;
         if(_expGetTxt)
         {
            _expGetTxt.dispose();
         }
         _expGetTxt = null;
         if(_autoPut)
         {
            _autoPut.dispose();
         }
         _autoPut = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_exp)
         {
            _exp.dispose();
         }
         _exp = null;
         if(_maxIcon)
         {
            _maxIcon.dispose();
         }
         _maxIcon = null;
         if(_maxIconLevelTxt)
         {
            _maxIconLevelTxt.dispose();
         }
         _maxIconLevelTxt = null;
         if(_helpBtn)
         {
            _helpBtn.dispose();
         }
         _helpBtn = null;
         _data = null;
      }
      
      private function cleanList() : void
      {
         if(_runeList)
         {
            while(_runeList.length > 0)
            {
               _runeList.pop().dispose();
            }
            _runeList = null;
         }
         if(_itemDic)
         {
            for each(var _loc1_:BaseItemView in _itemDic)
            {
               _loc1_.dispose();
            }
            _itemDic = null;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         _upgradeBtn.addEventListener("click",__upgradeBtnClickHandler);
         _quickBuyBtn.addEventListener("click",__quickBuyBtnClickHandler);
         NotificationManager.instance.addEventListener("RUNE_UPGRADE",__runeRefreshHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
         _autoPut.addEventListener("click",__onLinkHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         _upgradeBtn.removeEventListener("click",__upgradeBtnClickHandler);
         _quickBuyBtn.removeEventListener("click",__quickBuyBtnClickHandler);
         NotificationManager.instance.removeEventListener("RUNE_UPGRADE",__runeRefreshHandler);
         _helpBtn.removeEventListener("click",__helpClickHandler);
         _autoPut.removeEventListener("click",__onLinkHandler);
      }
      
      private function __onLinkHandler(param1:MouseEvent) : void
      {
         var _loc7_:GoodsInfo = null;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         SoundManager.instance.play("022");
         _runeBag.refreshData();
         var _loc3_:int = int(_runeBag.data.length);
         var _loc10_:Array = GoodsManager.instance.getGoodsByBagType(0);
         var _loc8_:Array = hidePosList;
         var _loc9_:int = int(_loc8_.length);
         var _loc4_:int = 0;
         var _loc6_:Boolean = true;
         if(_loc9_ == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc9_)
         {
            if(_loc5_ < _loc3_)
            {
               _loc7_ = _runeBag.data[_loc5_] as GoodsInfo;
               _loc4_ = int(_loc8_[_loc5_]);
               if(!canAutoPut(_loc7_,_loc4_,_loc10_,_loc6_))
               {
                  break;
               }
               _loc10_.push(_loc7_);
               _loc6_ = false;
            }
            _loc5_++;
         }
      }
      
      private function canAutoPut(param1:GoodsInfo, param2:int, param3:Array, param4:Boolean = false) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:String = null;
         for each(var _loc7_:GoodsInfo in param3)
         {
            _loc6_ += _loc7_.count;
         }
         if(thane.runeInfo.grade >= 10)
         {
            _loc5_ = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.UpgradeTipTxt3");
            if(param4)
            {
               MessageTipManager.instance().show(_loc5_);
            }
         }
         else if(param3.length < 8)
         {
            PlayerManager.instance.moveBagToBag(param1.bagType,param1.objectId,param1.pos,0,0,param2,1);
            return true;
         }
         return false;
      }
      
      private function get hidePosList() : Array
      {
         var _loc1_:int = 0;
         var _loc3_:GoodsInfo = null;
         var _loc2_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc3_ = GoodsManager.instance.getHideBagItemByPos(_loc1_);
            if(_loc3_ == null)
            {
               _loc2_.push(_loc1_);
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("core.RuneHelpFrame");
         _loc2_.show();
      }
      
      private function __runeRefreshHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = 0;
         var _loc5_:RuneInfo = null;
         var _loc4_:Array = thane.runeCate.allRuneList.getList();
         for(var _loc3_:String in _loc4_)
         {
            _loc2_ = int(_loc3_);
            _loc5_ = _loc4_[_loc2_];
            if(_loc5_ && _loc5_.templateInfo.RuneType == _data.templateInfo.RuneType)
            {
               data = _loc5_;
               break;
            }
         }
      }
      
      private function __quickBuyBtnClickHandler(param1:MouseEvent) : void
      {
         CheckUIModuleUtil.instance.tryCall("quickbuy",showBuyFrameCall);
      }
      
      private function showBuyFrameCall() : void
      {
         var _loc2_:ShopGoodsInfo = null;
         if(!thane.runeInfo)
         {
            return;
         }
         if(!thane.runeInfo.templateInfo)
         {
            return;
         }
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         if(thane.runeInfo.templateInfo.Level == 0)
         {
            _loc2_ = TempleteManager.instance.getShopTempInfoByItemId(3020010);
         }
         else
         {
            _loc2_ = TempleteManager.instance.getShopTempInfoByItemId(3021001);
         }
         if(_loc2_)
         {
            _loc1_.data(_loc2_);
            _loc1_.show();
         }
         else
         {
            _loc1_.dispose();
         }
      }
      
      private function __upgradeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_data.nextTemplateInfo && _data.grade < 10)
         {
            if(thane.grades < _data.nextTemplateInfo.NeedGrade && _data.runeCurGp == _data.nextTemplateInfo.NeedGp)
            {
               _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.UpgradeTipTxt2");
               MessageTipManager.instance().show(_loc2_);
            }
            else
            {
               controler.sendUpgradeRune(_data.runeId);
            }
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.UpgradeTipTxt3");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      protected function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && visible)
         {
            _loc2_.data = _loc3_;
            updateView();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
            updateView();
         }
      }
      
      private function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc6_:GoodsInfo = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         _expGet = 0;
         var _loc1_:int = int(_runeList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if(_runeList[_loc3_].data)
            {
               _loc6_ = _runeList[_loc3_].data as GoodsInfo;
               _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_.templateId);
               _loc7_ = int(_loc4_.Property1);
               _loc5_ = int(_loc4_.Property2);
               _loc2_ = int(_loc6_.count);
               if(_data.templateInfo.RuneType == _loc7_ || _loc7_ == 0 || _loc7_ == 100)
               {
                  if(_loc7_ == 100)
                  {
                     if(thane.runeInfo.templateInfo.Level == 0)
                     {
                        _loc5_ = 50;
                     }
                     else
                     {
                        _loc5_ = 10;
                     }
                  }
                  _expGet += _loc5_ * _loc2_;
               }
               else
               {
                  _expGet += _loc5_ / 10 * _loc2_;
               }
            }
            _loc3_++;
         }
         _expGetTxt.text = _expGet.toString();
         updateBtnView();
      }
      
      private function updateBtnView() : void
      {
         if(_expGet > 0)
         {
            _upgradeBtn.enable = true;
         }
         else
         {
            _upgradeBtn.enable = false;
         }
      }
      
      public function set data(param1:RuneInfo) : void
      {
         _data = param1;
         _nameTxt.text = _data.templateInfo.TemplateName + " " + LanguageMgr.GetTranslation("public.level2",_data.grade);
         _levelTxt.text = "Lv." + _data.grade;
         _levelTxt.x = _nameTxt.x + _nameTxt.textWidth + 6;
         if(_data.nextTemplateInfo)
         {
            _exp.max = _data.nextTemplateInfo.NeedGp;
            _exp.current = _data.runeCurGp;
         }
         else
         {
            _exp.max = _data.templateInfo.NeedGp;
            _exp.current = _data.templateInfo.NeedGp;
         }
         _expGetTxt.text = "0";
         _baseIcon.icon = IconFactory.getTecIconByIcon(_data.templateInfo.Icon);
         _baseIcon.tipData = _data;
         _maxIcon.icon = IconFactory.getTecIconByIcon(_data.templateInfo.Icon);
         _maxIcon.tipData = TempleteManager.instance.getMaxRuneTemplateInfoByRuneType(_data.templateInfo.RuneType,_data.templateInfo.Level);
         thane.runeInfo = _data;
         updateView();
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
      
      private function get controler() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function moveGoodsBack() : void
      {
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc2_:GoodsInfo in _loc1_)
         {
            PlayerManager.instance.moveBagToBag(_loc2_.bagType,_loc2_.objectId,_loc2_.pos,1,0,0,1);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         moveGoodsBack();
         KeyBoardRegister.instance.keyEnable = true;
         DragManager.getInstance().stopDrag();
         removeEvent();
         unitView();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}


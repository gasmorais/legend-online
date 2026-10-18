package mounts
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MountsEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import map.space.SpaceManager;
   import map.space.manager.SpaceSocketOutManager;
   import mvc.controler.MountsController;
   import mvc.module.mounts.MountAreaType;
   import mvc.module.mounts.MountInfo;
   import mvc.module.mounts.MountKingInfo;
   import mvc.module.mounts.WildSoulCollection;
   import mvc.module.mounts.WildSoulInfo;
   import yishi.SwitchPageHelp;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class WildSoulFrame extends Frame
   {
      
      private var items:Array = [];
      
      private var _border:Scale9CornerImage;
      
      private var _bg:Image;
      
      private var _tipTxt:Bitmap;
      
      private var _pageTxt:FilterFrameText;
      
      private var _prePageBtn:IconButton;
      
      private var _nextPageBtn:IconButton;
      
      private var _changeBtn:IconButton;
      
      private var _changeBtnStripView:StripView;
      
      private var _helpBtn:BaseButton;
      
      private var _itemContainer:Sprite;
      
      private var _normalBtn:SelectedIconButton;
      
      private var _magicBtn:SelectedIconButton;
      
      private var _livestockBtn:SelectedIconButton;
      
      private var _beastBtn:SelectedIconButton;
      
      private var _technologyBtn:SelectedIconButton;
      
      private var _buttonMc1:MovieClip;
      
      private var _buttonMc2:MovieClip;
      
      private var _buttonMc3:MovieClip;
      
      private var _buttonMc4:MovieClip;
      
      private var _mcArray:Array;
      
      private var _groupBtn:SelectedButtonGroup;
      
      private var _txtback:Bitmap;
      
      private var _displayShow:Bitmap;
      
      private var _creditsLabel:Bitmap;
      
      private var _creditsValue:FilterFrameText;
      
      private var _currentSelectedItem:WildSoulItem;
      
      private var _commontTxt:CustomBitmap;
      
      private var _currentHelpFrame:String;
      
      private var _currentPromotionTemplateId:int;
      
      private var _kingTrainView:MountKingTrainView;
      
      private var _mountsPromotionView:MountsPromotionView;
      
      public var showMountFrame:Boolean = true;
      
      public function WildSoulFrame()
      {
         MountsManager.instance.requestWildSoulList();
         super();
         initView();
         addEvent();
         avatarList.reset();
         vipMountCheck();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:WildSoulItem = null;
         _groupBtn = new SelectedButtonGroup();
         _border = ComponentFactory.Instance.creatComponentByStylename("wildsoul.BgBorder");
         _bg = ComponentFactory.Instance.creatComponentByStylename("wildsoul.BigBg");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("wildsoul.prePageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("wildsoul.nextPageBtn");
         _txtback = ComponentFactory.Instance.creatBitmap("asset.wildsoul.PageNumBack");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("wildsoul.PageText");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("wildsoul.changeBtn");
         _changeBtnStripView = ComponentFactory.Instance.creatCustomObject("MountKingTrainView.changeBtnStripView");
         _normalBtn = ComponentFactory.Instance.creatComponentByStylename("wildsoul.normalBtn");
         _magicBtn = ComponentFactory.Instance.creatComponentByStylename("wildsoul.magicBtn");
         _livestockBtn = ComponentFactory.Instance.creatComponentByStylename("wildsoul.livestockBtn");
         _beastBtn = ComponentFactory.Instance.creatComponentByStylename("wildsoul.beastBtn");
         _technologyBtn = ComponentFactory.Instance.creatComponentByStylename("wildsoul.technologyBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("mounts.helpBtn2");
         _buttonMc1 = ComponentFactory.Instance.creatCustomObject("mounts.specialBtnMc");
         _buttonMc2 = ComponentFactory.Instance.creatCustomObject("mounts.specialBtnMc");
         _buttonMc3 = ComponentFactory.Instance.creatCustomObject("mounts.specialBtnMc");
         _buttonMc4 = ComponentFactory.Instance.creatCustomObject("mounts.specialBtnMc");
         _tipTxt = ComponentFactory.Instance.creatBitmap("asset.wildsoul.TipTxt");
         _itemContainer = new Sprite();
         _buttonMc1.gotoAndStop(1);
         _buttonMc1["pos"].addChild(_magicBtn);
         _buttonMc2.gotoAndStop(1);
         _buttonMc2["pos"].addChild(_livestockBtn);
         _buttonMc3.gotoAndStop(1);
         _buttonMc3["pos"].addChild(_beastBtn);
         _buttonMc4.gotoAndStop(1);
         _buttonMc4["pos"].addChild(_technologyBtn);
         _mcArray = [_buttonMc1,_buttonMc2,_buttonMc3,_buttonMc4];
         addToContent(_border);
         addToContent(_bg);
         addToContent(_itemContainer);
         _bg.x = 3;
         _bg.y = 23;
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("mounts.WildSoulItem");
            _loc4_ = _loc3_ / 4;
            _loc2_ = _loc3_ % 4;
            _loc1_.x = _loc2_ * (_loc1_.rect.width + 4) + 10;
            _loc1_.y = _loc4_ * (_loc1_.rect.height + 7) + 33;
            _itemContainer.addChild(_loc1_);
            items.push(_loc1_);
            _loc3_++;
         }
         addToContent(_tipTxt);
         addToContent(_txtback);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_pageTxt);
         addToContent(_changeBtnStripView);
         addToContent(_normalBtn);
         addToContent(_helpBtn);
         _groupBtn.addSelectItem(_normalBtn);
         _groupBtn.addSelectItem(_magicBtn);
         _groupBtn.addSelectItem(_livestockBtn);
         _groupBtn.addSelectItem(_beastBtn);
         _groupBtn.addSelectItem(_technologyBtn);
         this.titleText = LanguageMgr.GetTranslation("mounts.command08");
         _currentHelpFrame = "mounts.MountHelperFrame";
         _helpBtn.tipData = LanguageMgr.GetTranslation("mounts.tips05");
         _changeBtn.enable = false;
         _changeBtnStripView.tipData = [LanguageMgr.GetTranslation("mounts.WildSoulFrame.changeBtnStripView")];
         var _loc5_:Component = ComponentFactory.Instance.creatComponentByStylename("mounts.soulscore");
         _displayShow = ComponentFactory.Instance.creatBitmap("asset.shop.ShopDisplayShow01");
         _creditsLabel = ComponentFactory.Instance.creatBitmap("asset.wildsoul.CreditsTxt");
         _creditsValue = ComponentFactory.Instance.creatComponentByStylename("mounts.CreditValue");
         _loc5_.addChild(_displayShow);
         _loc5_.addChild(_creditsLabel);
         _loc5_.addChild(_creditsValue);
         addToContent(_loc5_);
         _loc5_.tipData = LanguageMgr.GetTranslation("mounts.soulScoreTip");
         _displayShow.x = 8;
         _displayShow.y = 398;
         _loc5_.width = _displayShow.width;
         _displayShow.height = _displayShow.height;
         _creditsValue.text = String(curMountInfo.soulScore);
         addToContent(_buttonMc1);
         addToContent(_buttonMc2);
         _buttonMc2.x = 233;
         addToContent(_buttonMc3);
         _buttonMc3.x = 363;
         addToContent(_buttonMc4);
         _buttonMc4.x = 493;
         _commontTxt = ComponentFactory.Instance.creatCustomObject("wildSoulFrame.commontTxt");
         _commontTxt.visible = false;
         addToContent(_commontTxt);
         setButtonMcState();
      }
      
      private function vipMountCheck() : void
      {
         if(MountsManager.instance.vipMountActivity)
         {
            MountsManager.instance.vipMountActivity = false;
         }
      }
      
      private function setButtonMcState() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MovieClip = null;
         _loc2_ = 0;
         while(_loc2_ < _mcArray.length)
         {
            if(MountsManager.instance.isShineArray[_loc2_] != 0)
            {
               _loc1_ = _mcArray[_loc2_] as MovieClip;
               _loc1_.gotoAndPlay(1);
               addToContentAt(_loc1_,0);
            }
            _loc2_++;
         }
      }
      
      private function stopButtonMcShine() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < _mcArray.length)
         {
            if(MountsManager.instance.isShineArray[_loc1_] == 0)
            {
               _loc2_ = _mcArray[_loc1_] as MovieClip;
               _loc2_.gotoAndStop(1);
               addToContent(_loc2_);
            }
            _loc1_++;
         }
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_mountsPromotionView);
         _mountsPromotionView = null;
         ObjectUtils.disposeObject(_kingTrainView);
         _kingTrainView = null;
         for each(var _loc1_:WildSoulItem in items)
         {
            _loc1_.dispose();
         }
         _prePageBtn = null;
         _nextPageBtn = null;
         _pageTxt = null;
         _changeBtn = null;
         _groupBtn = null;
         _itemContainer = null;
         _txtback = null;
         items = null;
         _border = null;
         _bg = null;
         _helpBtn = null;
         _buttonMc1 = null;
         ObjectUtils.disposeObject(_displayShow);
         _displayShow = null;
         ObjectUtils.disposeObject(_creditsLabel);
         _creditsLabel = null;
         ObjectUtils.disposeObject(_creditsValue);
         _creditsValue = null;
         ObjectUtils.disposeObject(_commontTxt);
         _commontTxt = null;
         _normalBtn && ObjectUtils.disposeObject(_normalBtn);
         _normalBtn = null;
         _magicBtn && ObjectUtils.disposeObject(_magicBtn);
         _magicBtn = null;
         _livestockBtn && ObjectUtils.disposeObject(_livestockBtn);
         _livestockBtn = null;
         _beastBtn && ObjectUtils.disposeObject(_beastBtn);
         _beastBtn = null;
         _technologyBtn && ObjectUtils.disposeObject(_technologyBtn);
         _technologyBtn = null;
         _tipTxt = null;
      }
      
      private function addEvent() : void
      {
         avatarList.addEventListener("mountListChange",__onListChange);
         avatarList.addEventListener("pageIndexChange",__onPageChange);
         _changeBtn.addEventListener("click",__onChangeBtnClick);
         _itemContainer.addEventListener("click",__onItemClick);
         _itemContainer.addEventListener("mouseOver",__onItemOver);
         _itemContainer.addEventListener("mouseOut",__onItemOut);
         _prePageBtn.addEventListener("click",__onPrePageClick);
         _nextPageBtn.addEventListener("click",__onNextPageClick);
         _helpBtn.addEventListener("click",__onHelperBtnClick);
         this.addEventListener("response",__frameResponse);
         _groupBtn.addEventListener("change",__tabChangeHandler);
         thane.addEventListener("THANE_LEVEL_UPDATE",__thaneLevelUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         avatarList.removeEventListener("mountListChange",__onListChange);
         avatarList.removeEventListener("pageIndexChange",__onPageChange);
         _changeBtn.removeEventListener("click",__onChangeBtnClick);
         _itemContainer.removeEventListener("click",__onItemClick);
         _itemContainer.removeEventListener("mouseOver",__onItemOver);
         _itemContainer.removeEventListener("mouseOut",__onItemOut);
         _prePageBtn.removeEventListener("click",__onPrePageClick);
         _nextPageBtn.removeEventListener("click",__onNextPageClick);
         _helpBtn.removeEventListener("click",__onHelperBtnClick);
         this.removeEventListener("response",__frameResponse);
         if(_mountsPromotionView)
         {
            _mountsPromotionView.removeEventListener("dispose",onPromotionViewDisposed);
         }
         _groupBtn.removeEventListener("change",__tabChangeHandler);
         thane.removeEventListener("THANE_LEVEL_UPDATE",__thaneLevelUpdateHandler);
      }
      
      private function __onListChange(param1:MountsEvent) : void
      {
         avatarList.currentIndex = avatarList.currentIndex;
         _creditsValue.text = String(curMountInfo.soulScore);
         if(_mountsPromotionView && _currentPromotionTemplateId != 0)
         {
            _mountsPromotionView.data = avatarList.getWildSoulInfo(_currentPromotionTemplateId);
            _currentPromotionTemplateId = 0;
         }
      }
      
      private function __thaneLevelUpdateHandler() : void
      {
         avatarList.currentIndex = avatarList.currentIndex;
      }
      
      private function __onPageChange(param1:MountsEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         var _loc4_:int = 0;
         currentSelectedItem = null;
         var _loc5_:Boolean = false;
         for each(var _loc3_:WildSoulItem in items)
         {
            if(_loc4_ < _loc2_.length)
            {
               _loc3_.data = _loc2_[_loc4_];
            }
            else
            {
               _loc3_.data = null;
            }
            _loc4_++;
         }
         _pageTxt.text = LanguageMgr.GetTranslation("public.slash",avatarList.currentIndex,avatarList.totalPage);
         _prePageBtn.enable = avatarList.currentIndex > 1;
         _nextPageBtn.enable = avatarList.currentIndex < avatarList.totalPage;
         if(avatarList.currentType == 0)
         {
            _groupBtn.selectIndex = 0;
         }
         else if(avatarList.currentType == 1)
         {
            _groupBtn.selectIndex = 1;
         }
         else if(avatarList.currentType == 2)
         {
            _groupBtn.selectIndex = 2;
         }
         else if(avatarList.currentType == 3)
         {
            _groupBtn.selectIndex = 3;
         }
         else if(avatarList.currentType == 4)
         {
            _groupBtn.selectIndex = 4;
         }
      }
      
      public function onChange(param1:int) : void
      {
         currentSelectedItem = items[param1];
         __onChangeBtnClick(null);
      }
      
      private function __onChangeBtnClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         if(ArmyManager.instance.thane.changeShapeId > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mounts.WildSoulFrame.CannotChangeMount"));
            return;
         }
         var _loc2_:WildSoulItem = this._currentSelectedItem;
         if(_loc2_ && _loc2_.data)
         {
            _loc3_ = int(_loc2_.data.TemplateId);
            if(SpaceManager.instance.model && !SpaceManager.instance.model.canLand(_loc3_))
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.CannotLand"));
               return;
            }
            if(SwitchPageHelp.isInCampaign && Boolean(PlayerManager.instance.currentPlayerModel.isOnObstacle))
            {
               SpaceSocketOutManager.instance.resetSpacePosition();
            }
            MountsManager.instance.mountOperateSend(2,0,0,_loc3_);
            this.dispose();
         }
      }
      
      private function set currentSelectedItem(param1:WildSoulItem) : void
      {
         if(_currentSelectedItem)
         {
            _currentSelectedItem.selected = false;
         }
         _currentSelectedItem = param1;
         if(param1 && param1.data)
         {
            _changeBtn.enable = param1.data.TemplateId != curMountInfo.templateId;
            if(_changeBtn.enable)
            {
               _changeBtnStripView.tipData = null;
            }
            else
            {
               _changeBtnStripView.tipData = [LanguageMgr.GetTranslation("mounts.WildSoulFrame.changeBtnStripView")];
            }
            param1.selected = true;
         }
         else
         {
            _changeBtn.enable = false;
            _changeBtnStripView.tipData = [LanguageMgr.GetTranslation("mounts.WildSoulFrame.changeBtnStripView")];
         }
      }
      
      private function __onItemClick(param1:MouseEvent) : void
      {
         var _loc3_:WildSoulItem = null;
         var _loc11_:DisplayObject = null;
         var _loc4_:DisplayObject = null;
         var _loc7_:String = null;
         var _loc2_:String = null;
         var _loc14_:String = null;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         var _loc15_:int = 0;
         var _loc9_:ConfigInfosTempInfo = null;
         var _loc12_:int = 0;
         var _loc13_:GoodsTemplateInfo = null;
         var _loc8_:Array = null;
         var _loc10_:String = null;
         if(param1.target is BaseButton && param1.target.stylename == "wildSoulItem.promotBtn")
         {
            __showPromotionView(param1);
            _loc11_ = (param1.target as BaseButton).parent;
            while(!(_loc11_ is WildSoulItem))
            {
               _loc11_ = _loc11_.parent;
            }
            _loc3_ = _loc11_ as WildSoulItem;
         }
         else if(param1.target is IconButton && param1.target.stylename == "mounts.kingTrainBtn")
         {
            __showKingTrainView(param1);
            _loc4_ = (param1.target as IconButton).parent;
            while(!(_loc4_ is WildSoulItem))
            {
               _loc4_ = _loc4_.parent;
            }
            _loc3_ = _loc4_ as WildSoulItem;
         }
         else if(param1.target is WildSoulItem)
         {
            SoundManager.instance.play("022");
            _loc3_ = param1.target as WildSoulItem;
            if(_loc3_.isLock)
            {
            }
            if(_loc3_.data && (_loc3_.data.MountType == 1 || _loc3_.data.MountType == 2 || _loc3_.data.MountType == 4) && _loc3_.isLock)
            {
               if(_loc3_.data.NeedMountGrade > curMountInfo.grade)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("mounts.UseGoodNeedGrade",_loc3_.data.NeedMountGrade));
                  return;
               }
               _loc5_ = 0;
               _loc15_ = 0;
               _loc9_ = TempleteManager.instance.getConfigInfoByConfigName("mount_king_active_item");
               _loc12_ = int(_loc3_.data.NeedItemId);
               if(_loc3_.data.MountType == 4)
               {
                  _loc12_ = parseInt(_loc9_.ConfigValue);
               }
               _loc13_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_);
               if(_loc13_)
               {
                  _loc8_ = GoodsManager.instance.getBagGoodsByTemplateId(_loc13_.TemplateId);
                  if(_loc8_ && _loc8_.length > 0)
                  {
                     if(_loc13_.Property2 > 0)
                     {
                        _loc10_ = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips.Day",_loc13_.Property2);
                     }
                     else
                     {
                        _loc10_ = LanguageMgr.GetTranslation("mounts.WildsoulItem.tips.Long");
                     }
                     if(_loc3_.data.MountType == 4)
                     {
                        _loc6_ = LanguageMgr.GetTranslation("mounts.kingAlert.command01",_loc13_.TemplateName);
                     }
                     else
                     {
                        _loc6_ = LanguageMgr.GetTranslation("mounts.command10",_loc13_.TemplateName,_loc10_);
                     }
                     _loc5_ = 1;
                     _loc15_ = 1;
                  }
                  else
                  {
                     if(_loc3_.data.Property1 <= 0)
                     {
                        _loc6_ = LanguageMgr.GetTranslation("mounts.command12",_loc13_.TemplateName);
                        MessageTipManager.instance().show(_loc6_);
                        return;
                     }
                     _loc6_ = LanguageMgr.GetTranslation("mounts.command11",_loc13_.TemplateName,_loc3_.data.Property1);
                     _loc5_ = 2;
                     _loc15_ = int(_loc3_.data.Property1);
                  }
               }
               else
               {
                  if(_loc3_.data.Property1 <= 0)
                  {
                     return;
                  }
                  _loc5_ = 2;
                  _loc15_ = int(_loc3_.data.Property1);
                  _loc6_ = LanguageMgr.GetTranslation("mounts.command11",_loc3_.data.Property1);
               }
               SimpleAlertHelper.instance.data = [__resultHandler,_loc3_.data.TemplateId,_loc5_,_loc15_];
               _loc7_ = LanguageMgr.GetTranslation("public.confirm");
               _loc2_ = LanguageMgr.GetTranslation("public.cancel");
               _loc14_ = LanguageMgr.GetTranslation("public.prompt");
               if(_loc5_ == 2)
               {
                  SimpleAlertHelper.instance.popAlerFrame(_loc14_,_loc6_,_loc7_,_loc2_,true,true,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc15_);
               }
               else
               {
                  SimpleAlertHelper.instance.popAlerFrame(_loc14_,_loc6_,_loc7_,_loc2_,true,true);
               }
            }
            else if(_loc3_.data && _loc3_.data.MountType == 3 && _loc3_.isLock)
            {
               if(!ArmyManager.instance.thane.IsVipAndNoExpirt)
               {
                  SimpleAlertHelper.instance.data = [__vipMountOpenHandler];
                  _loc7_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc2_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc14_ = LanguageMgr.GetTranslation("public.prompt");
                  _loc6_ = LanguageMgr.GetTranslation("mounts.WildSoulFrame.VIPMountOpenTip");
                  SimpleAlertHelper.instance.popAlerFrame(_loc14_,_loc6_,_loc7_,_loc2_,true,true);
                  return;
               }
            }
            else if(_loc3_.data && _loc3_.data.MountType == 0 && _loc3_.isLock)
            {
               return;
            }
         }
      }
      
      private function __vipMountOpenHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("vip");
         }
      }
      
      private function __resultHandler(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:int = 0;
         if(param1)
         {
            _loc6_ = 0;
            if(param2 == false)
            {
               _loc6_ = 1;
            }
            MountsManager.instance.mountOperateSend(4,0,_loc6_,param3);
         }
      }
      
      private function __showPromotionView(param1:Event) : void
      {
         var _loc2_:WildSoulItem = null;
         SoundManager.instance.play("022");
         var _loc4_:BaseButton = param1.target as BaseButton;
         var _loc3_:DisplayObject = _loc4_.parent;
         while(!(_loc3_ is WildSoulItem))
         {
            _loc3_ = _loc3_.parent;
         }
         _loc2_ = _loc3_ as WildSoulItem;
         if(!_loc2_ || !_loc2_.data)
         {
            return;
         }
         showPromotionView(_loc2_.data.TemplateId);
         SharedManager.instance.flashPromotionBtn = false;
         _loc2_.mouseOut();
         _loc2_.unFlash();
      }
      
      public function showPromotionView(param1:int) : void
      {
         _currentPromotionTemplateId = param1;
         if(_mountsPromotionView)
         {
            _mountsPromotionView.dispose();
            _mountsPromotionView = null;
         }
         _normalBtn.visible = _magicBtn.visible = _livestockBtn.visible = _beastBtn.visible = _technologyBtn.visible = false;
         _mountsPromotionView = new MountsPromotionView();
         _mountsPromotionView.x = 3;
         _mountsPromotionView.y = 22;
         _mountsPromotionView.addEventListener("dispose",onPromotionViewDisposed);
         var _loc2_:WildSoulInfo = avatarList.getWildSoulInfo(_currentPromotionTemplateId);
         if(_loc2_)
         {
            _mountsPromotionView.data = _loc2_;
            _currentPromotionTemplateId = 0;
         }
         addToContent(_mountsPromotionView);
         this.titleText = LanguageMgr.GetTranslation("refine2");
         _commontTxt.visible = true;
         _tipTxt.visible = false;
         _currentHelpFrame = "mounts.PromotionHelperFrame";
         _helpBtn.tipData = LanguageMgr.GetTranslation("mounts.PromotionHelpBtnTips");
      }
      
      private function onPromotionViewDisposed(param1:Event) : void
      {
         var _loc2_:MountsPromotionView = param1.currentTarget as MountsPromotionView;
         _loc2_.removeEventListener("dispose",onPromotionViewDisposed);
         _mountsPromotionView = null;
         if(isDie)
         {
            return;
         }
         if(_normalBtn && _magicBtn && _livestockBtn && _beastBtn && _technologyBtn)
         {
            _normalBtn.visible = _magicBtn.visible = _livestockBtn.visible = _beastBtn.visible = _technologyBtn.visible = true;
         }
         var _loc4_:WildSoulInfo = _loc2_.data;
         if(_loc4_)
         {
            for each(var _loc3_:WildSoulItem in items)
            {
               if(_loc3_.data == _loc4_.template)
               {
                  _loc3_.data = _loc4_.template;
                  break;
               }
            }
         }
         _commontTxt.visible = false;
         _tipTxt.visible = true;
         this.titleText = LanguageMgr.GetTranslation("mounts.command08");
         _currentHelpFrame = "mounts.MountHelperFrame";
         _helpBtn.tipData = LanguageMgr.GetTranslation("mounts.tips05");
      }
      
      private function __showKingTrainView(param1:Event) : void
      {
         var _loc2_:WildSoulItem = null;
         SoundManager.instance.play("022");
         var _loc4_:IconButton = param1.target as IconButton;
         var _loc3_:DisplayObject = _loc4_.parent;
         while(!(_loc3_ is WildSoulItem))
         {
            _loc3_ = _loc3_.parent;
         }
         _loc2_ = _loc3_ as WildSoulItem;
         if(!_loc2_ || !_loc2_.data)
         {
            return;
         }
         showKingTrainView(_loc2_.data.TemplateId);
      }
      
      public function showKingTrainView(param1:int) : void
      {
         _currentPromotionTemplateId = param1;
         if(_kingTrainView)
         {
            _kingTrainView.dispose();
            _kingTrainView = null;
         }
         _normalBtn.visible = _magicBtn.visible = _livestockBtn.visible = _beastBtn.visible = _technologyBtn.visible = false;
         _kingTrainView = new MountKingTrainView();
         _kingTrainView.x = 3;
         _kingTrainView.y = 22;
         _kingTrainView.addEventListener("dispose",onKingTrainViewDisposed);
         var _loc2_:MountKingInfo = avatarList.getMountKingInfo(_currentPromotionTemplateId);
         if(_loc2_)
         {
            _kingTrainView.data = _loc2_;
            _currentPromotionTemplateId = 0;
         }
         addToContent(_kingTrainView);
         this.titleText = LanguageMgr.GetTranslation("wildSoulFrame.mountKingTrainView.titleText");
         _tipTxt.visible = false;
         _helpBtn.visible = false;
         _itemContainer.visible = false;
      }
      
      private function onKingTrainViewDisposed(param1:Event) : void
      {
         var _loc2_:MountKingTrainView = param1.currentTarget as MountKingTrainView;
         _loc2_.removeEventListener("dispose",onKingTrainViewDisposed);
         _kingTrainView = null;
         if(isDie)
         {
            return;
         }
         if(_normalBtn && _magicBtn && _livestockBtn && _beastBtn && _technologyBtn)
         {
            _normalBtn.visible = _magicBtn.visible = _livestockBtn.visible = _beastBtn.visible = _technologyBtn.visible = true;
         }
         var _loc4_:MountKingInfo = _loc2_.data;
         if(_loc4_)
         {
            for each(var _loc3_:WildSoulItem in items)
            {
               if(_loc3_.data == _loc4_.template)
               {
                  _loc3_.data = _loc4_.template;
                  break;
               }
            }
         }
         _tipTxt.visible = true;
         this.titleText = LanguageMgr.GetTranslation("mounts.command08");
         _currentHelpFrame = "mounts.MountHelperFrame";
         _helpBtn.tipData = LanguageMgr.GetTranslation("mounts.tips05");
         _itemContainer.visible = true;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __onItemOver(param1:MouseEvent) : void
      {
         var _loc2_:WildSoulItem = null;
         var _loc4_:BaseButton = null;
         var _loc3_:DisplayObject = null;
         if(param1.target is WildSoulItem)
         {
            _loc2_ = param1.target as WildSoulItem;
         }
         else if(param1.target is BaseButton)
         {
            _loc4_ = param1.target as BaseButton;
            _loc3_ = (param1.target as BaseButton).parent;
            while(!(_loc3_ is WildSoulItem))
            {
               _loc3_ = _loc3_.parent;
            }
            _loc2_ = _loc3_ as WildSoulItem;
         }
         if(_loc2_)
         {
            _loc2_.mouseOver(param1);
         }
      }
      
      private function __onItemOut(param1:MouseEvent) : void
      {
         var _loc2_:WildSoulItem = null;
         var _loc3_:DisplayObject = param1.target as DisplayObject;
         while(_loc3_)
         {
            if(_loc3_ is WildSoulItem)
            {
               _loc2_ = _loc3_ as WildSoulItem;
               break;
            }
            if(_loc3_ == _itemContainer)
            {
               break;
            }
            _loc3_ = _loc3_.parent;
         }
         if(_loc2_)
         {
            _loc2_.mouseOut();
         }
      }
      
      private function __onPrePageClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         this.avatarList.currentIndex--;
      }
      
      private function __onNextPageClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         this.avatarList.currentIndex++;
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(this.avatarList.currentType == MountAreaType.AREA_ARRAY[_groupBtn.selectIndex])
         {
            return;
         }
         this.avatarList.currentType = MountAreaType.AREA_ARRAY[_groupBtn.selectIndex];
         MountsManager.instance.isShineArray[_groupBtn.selectIndex - 1] = 0;
         currentSelectedItem = null;
         stopButtonMcShine();
      }
      
      private function __onHelperBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename(_currentHelpFrame);
         _loc2_.show();
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
      
      public function get avatarList() : WildSoulCollection
      {
         return MountsManager.instance.avatarList;
      }
      
      public function get curMountInfo() : MountInfo
      {
         return MountsManager.instance.mountInfo;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         if(isDie)
         {
            return;
         }
         removeEvent();
         uintView();
         _loc1_ = 0;
         while(_loc1_ < MountsManager.instance.isShineArray.length)
         {
            MountsManager.instance.isShineArray[_loc1_] = 0;
            _loc1_++;
         }
         super.dispose();
      }
      
      public function get controller() : MountsController
      {
         return FrameControllerManager.instance.mountsController;
      }
   }
}


package appell
{
   import avatar.view.AppellView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.AppellEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.AppellSocketOutManager;
   import mvc.module.appell.AppellModel;
   import utils.GuideUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.AppellManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.IMEManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class AppellFrame extends Frame implements IManualSize, IEnterFrame
   {
      
      private var _buttongroup:SelectedButtonGroup;
      
      private var _backLeft:ScaleBitmapImage;
      
      private var _backRight:ScaleBitmapImage;
      
      private var _rightBg:Scale9CornerImage;
      
      private var _page1:SelectedIconButton;
      
      private var _page2:SelectedIconButton;
      
      private var _page3:SelectedIconButton;
      
      private var _page4:SelectedIconButton;
      
      private var _page5:SelectedIconButton;
      
      private var _appellList:Array;
      
      private var _firstIn:Boolean = true;
      
      private var _lookAppellId:int = 0;
      
      private var _bigbackBg:Scale9CornerImage;
      
      private var _bigbackBg2:Scale9CornerImage;
      
      private var _listPanel:ListPanel;
      
      private var _title01Bg:Bitmap;
      
      private var _title02Bg:Bitmap;
      
      private var _title03Bg:Bitmap;
      
      private var _title04Bg:Bitmap;
      
      private var _title01:Bitmap;
      
      private var _title02:Bitmap;
      
      private var _title03:Bitmap;
      
      private var _title04:Bitmap;
      
      private var _appellContainer:Component;
      
      private var _propertyTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _validTxt:FilterFrameText;
      
      private var _tipBtn:ScaleFrameImage;
      
      private var _helpBtn:BaseButton;
      
      private var _searchTxt:FilterFrameText;
      
      private var _searchBt:SimpleBitmapButton;
      
      private var _tipTxt:FilterFrameText;
      
      private var _searchBg:Bitmap;
      
      private var _searchContainer:Sprite;
      
      private var _appellTopView:AppellView;
      
      private var _appellTalkView:GradientText;
      
      private var _appellInfo:AppellInfoTemplate;
      
      public function AppellFrame()
      {
         super();
         _appellList = [];
         initView();
         initEvents();
         if(GuideUtils.checkGuideStep("appell",2))
         {
            GuideUtils.flash(_tipBtn);
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,485,445);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("appell.AppellFrame.Title");
         _bigbackBg = ComponentFactory.Instance.creatComponentByStylename("appellFrame.bigbackBg");
         _bigbackBg2 = ComponentFactory.Instance.creatComponentByStylename("appellFrame.bigbackBg2");
         _buttongroup = new SelectedButtonGroup();
         _backLeft = ComponentFactory.Instance.creatComponentByStylename("appellFrame.backLeft");
         _backRight = ComponentFactory.Instance.creatComponentByStylename("appellFrame.backRight");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("appellFrame.rightBg");
         _page1 = ComponentFactory.Instance.creatComponentByStylename("appell.AppellFrame.CasePage1Button");
         _page2 = ComponentFactory.Instance.creatComponentByStylename("appell.AppellFrame.CasePage2Button");
         _page3 = ComponentFactory.Instance.creatComponentByStylename("appell.AppellFrame.CasePage3Button");
         _page4 = ComponentFactory.Instance.creatComponentByStylename("appell.AppellFrame.CasePage4Button");
         _page5 = ComponentFactory.Instance.creatComponentByStylename("appell.AppellFrame.CasePage5Button");
         _buttongroup.addSelectItem(_page1);
         _buttongroup.addSelectItem(_page2);
         _buttongroup.addSelectItem(_page3);
         _buttongroup.addSelectItem(_page4);
         _buttongroup.addSelectItem(_page5);
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("appellFrame.listPanel");
         _title01Bg = ComponentFactory.Instance.creatCustomObject("appellFrame.title01Bg");
         _title02Bg = ComponentFactory.Instance.creatCustomObject("appellFrame.title02Bg");
         _title03Bg = ComponentFactory.Instance.creatCustomObject("appellFrame.title03Bg");
         _title04Bg = ComponentFactory.Instance.creatCustomObject("appellFrame.title04Bg");
         _title01 = ComponentFactory.Instance.creatCustomObject("appellFrame.title01");
         _title02 = ComponentFactory.Instance.creatCustomObject("appellFrame.title02");
         _title03 = ComponentFactory.Instance.creatCustomObject("appellFrame.title03");
         _title04 = ComponentFactory.Instance.creatCustomObject("appellFrame.title04");
         _appellContainer = new Component();
         _appellContainer.x = 267;
         _appellContainer.y = 108;
         _propertyTxt = ComponentFactory.Instance.creatComponentByStylename("appellFrame.propertyTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("appellFrame.descTxt");
         _validTxt = ComponentFactory.Instance.creatComponentByStylename("appellFrame.validTxt");
         _tipBtn = ComponentFactory.Instance.creatComponentByStylename("appellFrame.tipBtn");
         _tipBtn.setFrame(1);
         addToContent(_bigbackBg);
         addToContent(_bigbackBg2);
         addToContent(_page1);
         addToContent(_page2);
         addToContent(_page3);
         addToContent(_page4);
         addToContent(_page5);
         addToContent(_backLeft);
         addToContent(_backRight);
         addToContent(_rightBg);
         addToContent(_title01Bg);
         addToContent(_title04Bg);
         addToContent(_title02Bg);
         addToContent(_title03Bg);
         addToContent(_title01);
         addToContent(_title04);
         addToContent(_title02);
         addToContent(_title03);
         addToContent(_listPanel);
         addToContent(_appellContainer);
         addToContent(_propertyTxt);
         addToContent(_descTxt);
         addToContent(_validTxt);
         addToContent(_tipBtn);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("appellFrame.helpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         _searchBg = ComponentFactory.Instance.creatBitmap("asset.shop.SearchBg");
         _searchTxt = ComponentFactory.Instance.creatComponentByStylename("shop.SearchTextStyle1");
         _searchBt = ComponentFactory.Instance.creatComponentByStylename("shop.SearchBtn");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("shop.SearchTipTextStyle");
         _searchContainer = ComponentFactory.Instance.creatCustomObject("shop.SearchContainer");
         _searchContainer.addChild(_searchBg);
         _searchContainer.addChild(_searchTxt);
         _searchContainer.addChild(_searchBt);
         _searchContainer.addChild(_tipTxt);
         addToContent(_searchContainer);
         _searchTxt.text = "";
         _tipTxt.text = LanguageMgr.GetTranslation("shop.view.AppellFrame.tip");
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__frameResponseHandler);
         _page1.addEventListener("click",__pageClickHandler);
         _page2.addEventListener("click",__pageClickHandler);
         _page3.addEventListener("click",__pageClickHandler);
         _page4.addEventListener("click",__pageClickHandler);
         _page5.addEventListener("click",__pageClickHandler);
         model.addEventListener("APPELL_DATA_UPDATA",__updateAppellDataHandler);
         thane.addEventListener("THANE_INFO_UPDATE",__updateThaneInfoHandler);
         NotificationManager.instance.addEventListener("APPELL",__appellSwitchChange);
         NotificationManager.instance.addEventListener("APPELL_LOAD_COMPLETE",__appellLoadCompleteHandle);
         MsgMan.addObserver("showAppell",null,showAppellInfo);
         _helpBtn.addEventListener("click",__openHelperFrameHandler);
         _tipBtn.addEventListener("rollOver",__tipBtnMouseOverHandler);
         _tipBtn.addEventListener("rollOut",__tipBtnMouseOutHandler);
         _searchBt.addEventListener("click",__onSerachHandler);
         _searchTxt.addEventListener("focusIn",__onFocusin);
         _searchTxt.addEventListener("focusOut",__onFocusout);
         _searchTxt.addEventListener("keyDown",__onKeydownHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _page1.removeEventListener("click",__pageClickHandler);
         _page2.removeEventListener("click",__pageClickHandler);
         _page3.removeEventListener("click",__pageClickHandler);
         _page4.removeEventListener("click",__pageClickHandler);
         _page5.removeEventListener("click",__pageClickHandler);
         model.removeEventListener("APPELL_DATA_UPDATA",__updateAppellDataHandler);
         thane.removeEventListener("THANE_INFO_UPDATE",__updateThaneInfoHandler);
         NotificationManager.instance.removeEventListener("APPELL",__appellSwitchChange);
         NotificationManager.instance.removeEventListener("APPELL_LOAD_COMPLETE",__appellLoadCompleteHandle);
         MsgMan.removeObserver("showAppell",null,showAppellInfo);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__openHelperFrameHandler);
         }
         if(_tipBtn)
         {
            _tipBtn.removeEventListener("rollOver",__tipBtnMouseOverHandler);
            _tipBtn.removeEventListener("rollOut",__tipBtnMouseOutHandler);
         }
         _searchBt.removeEventListener("click",__onSerachHandler);
         _searchTxt.removeEventListener("focusIn",__onFocusin);
         _searchTxt.removeEventListener("focusOut",__onFocusout);
         _searchTxt.removeEventListener("keyDown",__onKeydownHandler);
      }
      
      private function __onFocusin(param1:FocusEvent) : void
      {
         IMEManager.enable();
         _tipTxt.visible = false;
      }
      
      private function __onFocusout(param1:FocusEvent) : void
      {
         if(StringHelper.isNullOrEmpty(_searchTxt.text))
         {
            _tipTxt.visible = true;
            refreshList(true);
         }
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __onSerachHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __onSerachHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = _searchTxt.text;
         if(StringHelper.isNullOrEmpty(_loc2_))
         {
            _tipTxt.visible = true;
            _searchTxt.text = "";
            refreshList(true);
         }
         else
         {
            _tipTxt.visible = false;
            _searchTxt.text = _loc2_;
            refreshList(true);
         }
      }
      
      private function __tipBtnMouseOverHandler(param1:MouseEvent) : void
      {
         GuideUtils.setGuideStep("appell",3);
         GuideUtils.stopFlash(_tipBtn);
         _tipBtn.setFrame(2);
      }
      
      private function __tipBtnMouseOutHandler(param1:MouseEvent) : void
      {
         _tipBtn.setFrame(1);
      }
      
      private function __appellSwitchChange(param1:NotificationEvent) : void
      {
         if(!VersionSwitch.APPELL)
         {
            dispose();
         }
      }
      
      private function __updateThaneInfoHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function __updateAppellDataHandler(param1:AppellEvent) : void
      {
         var _loc2_:AppellInfoTemplate = null;
         if(_firstIn)
         {
            if(_lookAppellId == 0)
            {
               if(FrameControllerManager.instance.appellControler.model.getAcquiredList().length > 0)
               {
                  model.currentPage = 0;
                  _buttongroup.selectIndex = 0;
               }
               else
               {
                  model.currentPage = 1;
                  _buttongroup.selectIndex = 1;
               }
            }
            else
            {
               _loc2_ = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(_lookAppellId);
               if(_loc2_)
               {
                  model.currentPage = _loc2_.Type;
                  _buttongroup.selectIndex = _loc2_.Type;
               }
               else
               {
                  model.currentPage = 0;
                  _buttongroup.selectIndex = 0;
               }
            }
            _firstIn = false;
            refreshList(true);
            _lookAppellId = 0;
         }
         else
         {
            refreshView();
         }
         updateAppellTipData();
      }
      
      private function updateAppellTipData() : void
      {
         var _loc1_:Object = null;
         if(model.isOpenAppellAddition)
         {
            _tipBtn.tipStyle = "yishi.view.tips.ExtraBufferTips";
            _tipBtn.tipDirctions = "7";
            _tipBtn.tipGapV = -_tipBtn.height;
            _tipBtn.tipGapH = 20;
            _loc1_ = {};
            _loc1_.title1 = LanguageMgr.GetTranslation("yishi.view.resourceBar.ExtraBufferTitle21");
            _loc1_.content1 = model.getAppellSummaryTipContent();
            _tipBtn.tipData = _loc1_;
         }
         else
         {
            _tipBtn.tipStyle = "yishi.view.tips.OneLineTip";
            _tipBtn.tipDirctions = "3";
            _tipBtn.tipGapV = 5;
            _tipBtn.tipGapH = 0;
            _tipBtn.tipData = LanguageMgr.GetTranslation("appellFrame.noOpen");
         }
      }
      
      private function __pageClickHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case _page1:
               model.currentPage = 0;
               break;
            case _page2:
               model.currentPage = 1;
               break;
            case _page3:
               model.currentPage = 2;
               break;
            case _page4:
               model.currentPage = 3;
               break;
            case _page5:
               model.currentPage = 4;
         }
         _tipTxt.visible = true;
         _searchTxt.text = "";
         refreshList();
      }
      
      private function refreshList(param1:Boolean = false) : void
      {
         var _loc5_:AppellInfoTemplate = null;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:AppellInfoTemplate = null;
         var _loc3_:String = null;
         var _loc8_:int = 0;
         _listPanel.beginChanges();
         _listPanel.vectorListModel.clear();
         _appellList = model.getCurrentList();
         if(_appellList)
         {
            _loc6_ = int(_appellList.length);
            _loc9_ = 0;
            _loc2_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc4_ = _appellList[_loc7_] as AppellInfoTemplate;
               if(_loc4_.TemplateId == ArmyManager.instance.thane.appellId)
               {
                  _loc4_.isEquiped = true;
               }
               else
               {
                  _loc4_.isEquiped = false;
               }
               _loc3_ = _searchTxt.text;
               _loc8_ = int(_loc4_.htmlTitle.toLowerCase().indexOf(_loc3_.toLowerCase()));
               if(!_tipTxt.visible)
               {
                  if(_loc8_ !== -1)
                  {
                     _listPanel.vectorListModel.append(_loc4_);
                  }
               }
               else
               {
                  _listPanel.vectorListModel.append(_loc4_);
               }
               if(_loc4_.TemplateId == _lookAppellId)
               {
                  _loc9_ = _loc7_;
                  _loc5_ = _loc4_;
               }
               _loc7_++;
            }
            if(!_loc5_)
            {
               _loc5_ = _appellList[0];
            }
         }
         _listPanel.commitChanges();
         _listPanel.invalidateViewport();
         _listPanel.list.defaultSelectItemByCellValue = _loc5_;
         _listPanel.list.updateListView();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function refreshView(param1:Boolean = false) : void
      {
         if(isDie)
         {
            return;
         }
         _listPanel.list.updateListView();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get model() : AppellModel
      {
         return FrameControllerManager.instance.appellControler.model;
      }
      
      public function show(param1:int = 0) : void
      {
         _lookAppellId = param1;
         AppellSocketOutManager.lookAppellInfos();
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         _searchContainer.x = 28;
         _searchContainer.y = 88;
      }
      
      public function enterFrame() : void
      {
         if(_appellTopView)
         {
            _appellTopView.draw();
         }
      }
      
      protected function __appellLoadCompleteHandle(param1:AppellEvent) : void
      {
         if(!_appellTopView)
         {
            return;
         }
         _appellTopView.x = (340 - _appellTopView.appellWidth) * 0.5;
         var _loc2_:int = _appellTopView.appellHeight > 70 ? _appellTopView.appellHeight + 10 : Number(_appellTopView.appellHeight);
         if(_appellInfo.Perfix)
         {
            _appellTopView.y = (84 - _loc2_) * 0.5;
         }
         else
         {
            _appellTopView.y = (170 - _loc2_) * 0.5;
         }
      }
      
      private function showAppellInfo(param1:String, param2:AppellInfoTemplate) : void
      {
         var _loc11_:String = null;
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc7_:int = 0;
         var _loc12_:SkillTempInfo = null;
         var _loc9_:Array = null;
         var _loc8_:int = 0;
         var _loc15_:String = null;
         if(_appellInfo == param2)
         {
            return;
         }
         _appellInfo = param2;
         if(!_appellInfo)
         {
            return;
         }
         ObjectUtils.disposeAllChildren(_appellContainer);
         _appellTopView = new AppellView(param2);
         _appellContainer.addChild(_appellTopView);
         _appellTopView.x = (340 - _appellTopView.appellWidth) * 0.5;
         var _loc14_:int = _appellTopView.appellHeight > 70 ? _appellTopView.appellHeight + 10 : Number(_appellTopView.appellHeight);
         if(param2.Perfix)
         {
            _title04.visible = true;
            _title04Bg.visible = true;
            _appellTopView.y = (84 - _loc14_) * 0.5;
            _appellTalkView = ComponentFactory.Instance.creatComponentByStylename("appell.apellChatText");
            _loc11_ = param2.Perfix;
            _loc5_ = 1;
            _loc3_ = param2.Perfix.split("|");
            if(_loc3_.length > 1)
            {
               _loc11_ = _loc3_[0];
               _loc5_ = int(_loc3_[1]);
            }
            _appellTalkView.colors = AppellModel.COLORS[_loc5_ - 1];
            _appellTalkView.textField.height = 22;
            _appellTalkView.height = 22;
            _appellTalkView.htmlText = "<font size=\'12\'>" + _loc11_ + "</font>";
            _appellTalkView.textField.width = _appellTalkView.textField.textWidth + 5;
            _appellTalkView.width = _appellTalkView.textField.textWidth + 5;
            _appellTalkView.textSize = _appellTalkView.textSize;
            _appellContainer.addChild(_appellTalkView);
            _appellTalkView.x = (340 - _appellTalkView.textField.textWidth) * 0.5;
            _appellTalkView.y = 108 + (62 - _appellTalkView.textField.textHeight) * 0.5;
         }
         else
         {
            _title04.visible = false;
            _title04Bg.visible = false;
            _appellTopView.y = (170 - _loc14_) * 0.5;
         }
         var _loc10_:String = "";
         var _loc4_:Array = TempleteManager.instance.getSkillTemplateInfoByIds(param2.Skills);
         _loc7_ = 0;
         while(_loc7_ < _loc4_.length)
         {
            if(_loc10_)
            {
               _loc10_ += "<br/>";
            }
            _loc12_ = _loc4_[_loc7_] as SkillTempInfo;
            if(_loc12_)
            {
               _loc10_ += _loc12_.TemplateName;
            }
            _loc7_++;
         }
         if(param2.Buffs)
         {
            _loc9_ = model.getAdditionFromBuffer(param2.Buffs);
            _loc8_ = 0;
            while(_loc8_ < _loc9_.length)
            {
               if(_loc10_)
               {
                  _loc10_ += "<br/>";
               }
               _loc10_ += _loc9_[_loc8_];
               _loc8_++;
            }
         }
         if(model.isOpenAppellAddition && Boolean(param2.isGet))
         {
            _propertyTxt.setFrame(1);
         }
         else
         {
            if(_loc10_)
            {
               _loc10_ = LanguageMgr.GetTranslation("appellFrame.property") + _loc10_;
            }
            if(!model.isOpenAppellAddition)
            {
               if(_loc10_)
               {
                  _loc10_ += "\n";
               }
               _loc10_ += LanguageMgr.GetTranslation("appellFrame.noOpen");
            }
            _propertyTxt.setFrame(2);
         }
         _propertyTxt.htmlText = _loc10_;
         _propertyTxt.y = int(303 + (50 - _propertyTxt.textHeight) * 0.5);
         if(param2.isGet && param2.validDate != "2000-01-01 00:00:00")
         {
            _validTxt.text = LanguageMgr.GetTranslation("appellModel.validDate",param2.validDate);
         }
         else
         {
            _validTxt.text = "";
         }
         if(param2.Descript)
         {
            _loc10_ = param2.Descript;
         }
         else
         {
            _loc10_ = "";
         }
         _descTxt.htmlText = _loc10_;
         var _loc6_:int = int(_descTxt.numLines);
         if(AppellManager.instance.model.needShowProgress(param2.CondtionType) && !param2.isGet)
         {
            _loc15_ = param2.getProgress();
            _loc15_ = LanguageMgr.GetTranslation("public.parentheses1",_loc15_);
            _descTxt.htmlText = _loc10_ + _loc15_;
            if(_descTxt.numLines > _loc6_)
            {
               _loc10_ = _loc10_ + "<br/>" + _loc15_;
            }
            else
            {
               _loc10_ += _loc15_;
            }
         }
         _descTxt.htmlText = _loc10_;
         var _loc13_:int = 380 + (70 - _validTxt.textHeight - _descTxt.textHeight) * 0.5;
         _descTxt.y = _loc13_ < 380 ? 380 : _loc13_;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __openHelperFrameHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("appellFrame.helpFrame");
         _loc2_.show();
      }
      
      override public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEvents();
         _buttongroup.removeAllItem();
         ObjectUtils.disposeObject(_backLeft);
         _backLeft = null;
         ObjectUtils.disposeObject(_page1);
         _page1 = null;
         ObjectUtils.disposeObject(_page2);
         _page2 = null;
         ObjectUtils.disposeObject(_page3);
         _page3 = null;
         ObjectUtils.disposeObject(_page4);
         _page4 = null;
         ObjectUtils.disposeObject(_page5);
         _page5 = null;
         ObjectUtils.disposeObject(_bigbackBg2);
         _bigbackBg2 = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeObject(_backRight);
         _backRight = null;
         ObjectUtils.disposeObject(_bigbackBg);
         _bigbackBg = null;
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_appellContainer);
         _appellContainer = null;
         ObjectUtils.disposeObject(_propertyTxt);
         _propertyTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_validTxt);
         _validTxt = null;
         ObjectUtils.disposeObject(_tipBtn);
         _tipBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_searchTxt);
         _searchTxt = null;
         ObjectUtils.disposeObject(_searchBt);
         _searchBt = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         ObjectUtils.disposeObject(_searchBg);
         _searchBg = null;
         ObjectUtils.disposeAllChildren(_searchContainer);
         _searchContainer = null;
         _appellList = null;
         _appellInfo = null;
         _firstIn = true;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}


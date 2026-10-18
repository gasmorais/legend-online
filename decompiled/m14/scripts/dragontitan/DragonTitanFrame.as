package dragontitan
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontitan.charge.DragonTitanChargeView;
   import dragontitan.inject.DragonTitanInjectView;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.DragonTitanManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.dragonTitan.DragonTitanModel;
   import yishi.datas.templates.DragonTitanTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class DragonTitanFrame extends Frame implements IManualSize
   {
      
      private var _selectFrame:DragonTitanSelectFrame;
      
      private var _bg:Image;
      
      private var _skillImgTxt:Image;
      
      private var _switchBtn:BaseButton;
      
      private var _rightBg:Image;
      
      private var _leftBg:Image;
      
      private var _group:SelectedButtonGroup;
      
      private var _injectBtn:SelectedIconButton;
      
      private var _developBtn:SelectedIconButton;
      
      private var _arrangeBtn:SelectedIconButton;
      
      private var _chargeBtn:SelectedIconButton;
      
      private var _titanName:FilterFrameText;
      
      private var _titanLevel:FilterFrameText;
      
      private var _btnHbox:HBox;
      
      private var _icon:BaseIconView;
      
      private var _headVbox:VBox;
      
      private var _currentPanel:DisplayObject;
      
      private var _tabInjectView:DragonTitanInjectView;
      
      private var _tabDevelopView:DragonTitanDevelopView;
      
      private var _tabArrangeView:DragonTitanArrangeView;
      
      private var _tabChargeView:DragonTitanChargeView;
      
      private var _helpBtn:BaseButton;
      
      private var _skills:Vector.<DragonTitanSkillItemView>;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _pageSize:int = 6;
      
      private var _currentPageNum:int = 1;
      
      private var _pageNumMax:int = 1;
      
      private var _formatStr:String = "{0} / {1}";
      
      public function DragonTitanFrame()
      {
         super();
         initView();
         initEvent();
         if(model.titanAllIds.length > 0)
         {
            _pageNumMax = Math.ceil(model.titanAllIds.length / _pageSize);
            currentPageNum = 1;
            refreshView();
         }
         _group.selectIndex = 0;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,796,570);
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:DragonTitanSkillItemView = null;
         titleText = LanguageMgr.GetTranslation("dragontitan.DragonTitanFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.DragonTitanFrameBack");
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.leftBg");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.rightBg");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("dragontitan.btnHbox");
         _injectBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.spiritTabBtn");
         _developBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.developTabBtn");
         _arrangeBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.arrangeTabBtn");
         _chargeBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.energyTabBtn");
         _icon = ComponentFactory.Instance.creatCustomObject("dragontitan.DragonTitanFrame.icon");
         _switchBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.switchBtn");
         _skillImgTxt = ComponentFactory.Instance.creatComponentByStylename("dragontitan.skillImgTxt");
         _titanName = ComponentFactory.Instance.creatComponentByStylename("DragonTitanFrame.titanName");
         _titanLevel = ComponentFactory.Instance.creatComponentByStylename("DragonTitanFrame.titanLevel");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("dragontitan.PageText");
         addToContent(_bg);
         addToContent(_leftBg);
         addToContent(_rightBg);
         addToContent(_titanName);
         addToContent(_titanLevel);
         addToContent(_icon);
         addToContent(_switchBtn);
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_developBtn);
         _group.addSelectItem(_arrangeBtn);
         _group.addSelectItem(_injectBtn);
         _group.addSelectItem(_chargeBtn);
         _btnHbox.addChild(_developBtn);
         _btnHbox.addChild(_arrangeBtn);
         _btnHbox.addChild(_injectBtn);
         _btnHbox.addChild(_chargeBtn);
         addToContent(_btnHbox);
         addToContent(_skillImgTxt);
         _skills = new Vector.<DragonTitanSkillItemView>();
         var _loc4_:Sprite = new Sprite();
         _loc4_.x = 21;
         _loc4_.y = 128;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc2_ = new DragonTitanSkillItemView();
            _loc2_.x = _loc3_ % 2 * 80;
            _loc2_.y = Math.floor(_loc3_ / 2) * 70;
            _loc2_.titanId = getTitanIdByIndex(_loc3_);
            _loc2_.data = model.getSkillTempInfoByTitanId(_loc2_.titanId);
            _loc4_.addChild(_loc2_);
            _skills.push(_loc2_);
            _loc3_++;
         }
         addToContent(_loc4_);
         var _loc1_:Sprite = new Sprite();
         _loc1_.x = -109;
         _loc1_.y = 201;
         _loc1_.addChild(_pageBg);
         _loc1_.addChild(_preBtn);
         _loc1_.addChild(_nextBtn);
         _loc1_.addChild(_pageTxt);
         addToContent(_loc1_);
      }
      
      private function getTitanIdByIndex(param1:int) : int
      {
         if(param1 > model.titanAllIds.length - 1)
         {
            return -1;
         }
         return model.titanAllIds[(currentPageNum - 1) * _pageSize + param1];
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_group)
         {
            _group.addEventListener("change",__tabChangeHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__helpBtnHandler);
         }
         if(_switchBtn)
         {
            _switchBtn.addEventListener("click",__switchBtnHandler);
         }
         _preBtn.addEventListener("click",__preBtnClickHandler);
         _nextBtn.addEventListener("click",__nextBtnClickHandler);
         MsgMan.addObserver("DragonTitanEvent.TITAN_DATA",this,refreshView);
         MsgMan.addObserver("DragonTitanEvent.TITAN_SET_SKILL_BACK",this,refreshView);
         MsgMan.addObserver("TITAN_FAME_CLICK_SKILL",this,refreshListView);
      }
      
      private function refreshView(param1:String = null, param2:Object = null) : void
      {
         var _loc5_:String = null;
         var _loc4_:int = 0;
         _titanLevel.text = LanguageMgr.GetTranslation("DragonTitanFrame.starLevels",model.getSteps(),model.getStars());
         var _loc3_:DragonTitanTempInfo = TempleteManager.instance.titanTemplateCate.getTemplateById(model.templateId);
         if(_loc3_)
         {
            _titanName.text = _loc3_.TemplateName;
            _loc5_ = _loc3_.AvatarPath;
            if(_icon.icon != _loc5_)
            {
               _icon.icon = IconFactory.getCommonIconPath(_loc5_);
               _icon.tipData = model.templateId;
               _icon.tipStyle = "yishi.view.tips.DragonTitanTips";
               _icon.isFollowMouse = false;
               _icon.tipDirctions = "4,5,6,0,1,2,3,7";
            }
         }
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _skills[_loc4_].data = model.getSkillTempInfoByTitanId(getTitanIdByIndex(_loc4_));
            _loc4_++;
         }
         refreshListView();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_group)
         {
            _group.removeEventListener("change",__tabChangeHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         if(_switchBtn)
         {
            _switchBtn.removeEventListener("click",__switchBtnHandler);
         }
         _preBtn.removeEventListener("click",__preBtnClickHandler);
         _nextBtn.removeEventListener("click",__nextBtnClickHandler);
         MsgMan.removeObserver("DragonTitanEvent.TITAN_DATA",this,refreshView);
         MsgMan.removeObserver("DragonTitanEvent.TITAN_SET_SKILL_BACK",this,refreshView);
         MsgMan.removeObserver("TITAN_FAME_CLICK_SKILL",this,refreshListView);
      }
      
      private function __preBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshListView();
      }
      
      private function __nextBtnClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshListView();
      }
      
      private function refreshListView(param1:String = null, param2:Object = null) : void
      {
         var _loc5_:int = 0;
         var _loc3_:DragonTitanSkillItemView = null;
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            _loc3_ = _skills[_loc5_];
            _loc4_ = int(model.titanAllIds[(currentPageNum - 1) * _pageSize + _loc5_]);
            _loc3_.titanId = _loc4_;
            _loc3_.data = model.getSkillTempInfoByTitanId(_loc4_);
            _loc3_.setGridState(model.getTaitanInjectInfo(_loc4_));
            if(_loc4_ > 0 && model.skillGroupArr[model.curUseSkillIndex].indexOf(_loc4_) > -1)
            {
               _skills[_loc5_].setEquipped();
            }
            else
            {
               _skills[_loc5_].setUnequipped();
            }
            _loc5_++;
         }
      }
      
      private function getCurrentList() : Vector.<SkillTempInfo>
      {
         var _loc6_:Array = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:DragonTitanTempInfo = null;
         if(model.titanAllIds)
         {
            _loc1_ = (currentPageNum - 1) * _pageSize;
            _loc2_ = Math.min(_loc1_ + _pageSize,model.titanAllIds.length);
            _loc6_ = model.titanAllIds.slice(_loc1_,_loc2_);
         }
         var _loc5_:Vector.<SkillTempInfo> = new Vector.<SkillTempInfo>();
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            if(_loc4_ < _loc6_.length)
            {
               _loc3_ = TempleteManager.instance.titanTemplateCate.getTemplateById(_loc6_[_loc4_]);
               _loc5_.push(TempleteManager.instance.getSkillById(parseInt(_loc3_.SkillIds)));
            }
            else
            {
               _loc5_.push(null);
            }
            _loc4_++;
         }
         return _loc5_;
      }
      
      public function get currentPageNum() : int
      {
         return _currentPageNum;
      }
      
      public function set currentPageNum(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         if(param1 > _pageNumMax)
         {
            return;
         }
         _currentPageNum = param1;
         updatePageInfo();
      }
      
      private function updatePageInfo() : void
      {
         if(_preBtn)
         {
            _preBtn.enable = currentPageNum > 1;
         }
         if(_nextBtn)
         {
            _nextBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_pageTxt)
         {
            _pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      protected function __switchBtnHandler(param1:MouseEvent) : void
      {
         if(_selectFrame)
         {
            _selectFrame.parent && _selectFrame.parent.removeChild(_selectFrame);
            _selectFrame.dispose();
            _selectFrame = null;
         }
         _selectFrame = ComponentFactory.Instance.creatComponentByStylename("dragontitan.DragonTitanSelectFrame");
         _selectFrame.show();
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_group)
         {
            _loc2_ = int(_group.selectIndex);
            model.currentViewIndex = _loc2_;
            _pageNumMax = Math.ceil(model.titanAllIds.length / _pageSize);
            currentPageNum = 1;
            if(_loc2_ == 0)
            {
               showTab1();
            }
            else if(_loc2_ == 1)
            {
               showTab2();
            }
            else if(_loc2_ == 2)
            {
               model.viewTitanId = model.titanAllIds[0];
               showSpiritView();
            }
            else if(_loc2_ == 3)
            {
               showChargeView();
            }
            refreshView();
         }
      }
      
      private function showSpiritView() : void
      {
         DragonTitanManager.instance.currSelectedPage = "DRAGON_TITAN_SPIRIT";
         if(!_tabInjectView)
         {
            _tabInjectView = new DragonTitanInjectView();
         }
         _tabInjectView.__updateView();
         changeView(_tabInjectView);
      }
      
      private function showTab1() : void
      {
         DragonTitanManager.instance.currSelectedPage = "DRAGON_TITAN_DEVELOP";
         if(_tabDevelopView == null)
         {
            _tabDevelopView = new DragonTitanDevelopView();
            _tabDevelopView.mouseEnabled = false;
         }
         changeView(_tabDevelopView);
      }
      
      private function showTab2() : void
      {
         DragonTitanManager.instance.currSelectedPage = "DRAGON_TITAN_ARRANGE";
         if(_tabArrangeView == null)
         {
            _tabArrangeView = new DragonTitanArrangeView();
            _tabArrangeView.mouseEnabled = false;
         }
         changeView(_tabArrangeView);
      }
      
      private function showChargeView() : void
      {
         DragonTitanManager.instance.currSelectedPage = "DRAGON_TITAN_ENERGY";
         if(!_tabChargeView)
         {
            _tabChargeView = new DragonTitanChargeView();
         }
         changeView(_tabChargeView);
      }
      
      private function changeView(param1:DisplayObject) : void
      {
         if(_currentPanel && _currentPanel.parent)
         {
            _currentPanel.parent.removeChild(_currentPanel);
         }
         if(param1)
         {
            addToContent(param1);
            _currentPanel = param1;
         }
      }
      
      private function get model() : DragonTitanModel
      {
         return DragonTitanManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         removeEvent();
         _loc2_ = 0;
         while(_loc2_ < _skills.length)
         {
            _skills[_loc2_].dispose();
            _loc2_++;
         }
         _skills.length = 0;
         _skills = null;
         var _loc1_:Array = ["_selectFrame","_bg","_skillImgTxt","_rightBg","_leftBg","_group","_injectBtn","_developBtn","_arrangeBtn","_chargeBtn","_titanName","_titanLevel","_btnHbox","_icon","_headVbox","_currentPanel","_tabInjectView","_tabDevelopView","_tabArrangeView","_tabChargeView","_helpBtn","_preBtn","_nextBtn","_pageTxt","_pageBg"];
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            ObjectUtils.disposeObject(this[_loc1_[_loc3_]]);
            this[_loc1_[_loc3_]] = null;
            _loc3_++;
         }
         _loc1_.length = 0;
         super.dispose();
      }
   }
}


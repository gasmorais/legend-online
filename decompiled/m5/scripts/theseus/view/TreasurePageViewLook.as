package theseus.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseussoulModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.TheseusTreasureCoreInfo;
   import yishi.datas.templates.TheseusTreasureGrowupInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.base.StarBar;
   import yishi.view.community.BaseItemView;
   
   public class TreasurePageViewLook extends Sprite
   {
      
      private static const OUTER:int = 9;
      
      private static const INNER:int = 3;
      
      private static const SKILL:int = 3;
      
      private static const OUTER_POINT:Array = [[210,7],[325,45],[390,155],[370,280],[270,360],[145,360],[50,280],[27,155],[90,45]];
      
      private static const INNER_POINT:Array = [[205,80],[290,230],[120,230]];
      
      private var _bg:Bitmap;
      
      private var _lockSprite:Sprite;
      
      private var _lockTxt:FilterFrameText;
      
      private var _sprite:Sprite;
      
      private var _txtImg:Image;
      
      private var _qualityImg:Image;
      
      private var _starBar:StarBar;
      
      private var _itemView:BaseItemView;
      
      private var _line:Bitmap;
      
      private var _lvTxt:FilterFrameText;
      
      private var _propertyVBox:VBox;
      
      private var _titleTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _list:Array;
      
      private var _group:SelectedButtonGroup;
      
      private var _bagView:TreasureBagView;
      
      private var _selectedItem:TreasureOuterItemLook;
      
      private var _skillList:Array = [];
      
      private var _scrollPanel:ScrollPanel;
      
      private var _thane:ThaneInfo;
      
      public function TreasurePageViewLook()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.treasureBg");
         _lockTxt = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.lockTxt");
         _txtImg = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.txtImg");
         _qualityImg = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.qualityImg");
         _itemView = ComponentFactory.Instance.creatCustomObject("TreasurePageView.itemView");
         _line = ComponentFactory.Instance.creatBitmap("asset.theseus.treasureLine");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.lvTxt");
         _propertyVBox = ComponentFactory.Instance.creatCustomObject("TreasurePageView.propertyVBox");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.titleTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.descTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.nameTxt");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.scrollPanel");
         _scrollPanel.setView(_propertyVBox);
         _starBar = new StarBar(6,0,"asset.theseus.EmptyStarBg","asset.theseus.FullStarBg");
         _starBar.x = 605;
         _starBar.y = 107;
         _lockSprite = new Sprite();
         _sprite = new Sprite();
         addChild(_bg);
         addChild(_lockSprite);
         addChild(_sprite);
         _sprite.visible = false;
         _lockSprite.addChild(_lockTxt);
         _lockTxt.text = LanguageMgr.GetTranslation("TreasurePageView.lockTxt.text");
         _sprite.addChild(_nameTxt);
         _sprite.addChild(_txtImg);
         _sprite.addChild(_qualityImg);
         _sprite.addChild(_itemView);
         _sprite.addChild(_line);
         _sprite.addChild(_lvTxt);
         _sprite.addChild(_starBar);
         _sprite.addChild(_scrollPanel);
         _sprite.addChild(_titleTxt);
         _sprite.addChild(_descTxt);
         _titleTxt.text = LanguageMgr.GetTranslation("TreasurePageView.titleTxt");
         _descTxt.text = LanguageMgr.GetTranslation("TreasurePageView.descTxt");
      }
      
      private function initItem() : void
      {
         var _loc2_:TreasureOuterItemLook = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _list = [];
         _group = new SelectedButtonGroup();
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = new TreasureOuterItemLook(_loc3_);
            _loc1_ = OUTER_POINT[_loc3_];
            _loc2_.x = _loc1_[0];
            _loc2_.y = _loc1_[1];
            _loc2_.initData(_thane);
            addChild(_loc2_);
            _list.push(_loc2_);
            _group.addSelectItem(_loc2_);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = new TreasureInnerItemLook(_loc4_ + 9);
            _loc1_ = INNER_POINT[_loc4_];
            _loc2_.x = _loc1_[0];
            _loc2_.y = _loc1_[1];
            _loc2_.initData(_thane);
            addChild(_loc2_);
            _list.push(_loc2_);
            _group.addSelectItem(_loc2_);
            _loc4_++;
         }
         _loc2_ = new TreasureCoreItemLook(12);
         _loc2_.x = 195;
         _loc2_.y = 175;
         _loc2_.initData(_thane);
         addChild(_loc2_);
         _list.push(_loc2_);
         _group.addSelectItem(_loc2_);
         _group.selectIndex = 0;
      }
      
      private function initEvent() : void
      {
         _group.addEventListener("change",__onTabBtnHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_SUIT_UPDATE",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         _group.removeEventListener("change",__onTabBtnHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_SUIT_UPDATE",__updateHandler);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               _bagView.dispose();
               _bagView = null;
               this.mouseChildren = this.mouseEnabled = true;
         }
      }
      
      private function __updateHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         refreshView();
      }
      
      public function initData(param1:ThaneInfo) : void
      {
         _thane = param1;
         initItem();
         initSkillItem();
         initEvent();
         refreshView();
      }
      
      private function refreshView() : void
      {
         _selectedItem = _group.getSelectedItem() as TreasureOuterItemLook;
         _lockSprite.visible = _selectedItem.isLock;
         _sprite.visible = !_selectedItem.isLock;
         if(_selectedItem.type == 0)
         {
            _selectedItem.refreshView();
         }
         refreshSkillItem();
         refreshSprite();
      }
      
      private function refreshSprite() : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc1_:TheseusTreasureGrowupInfo = null;
         if(_selectedItem.type == 0)
         {
            _titleTxt.visible = false;
            _descTxt.visible = false;
            _scrollPanel.visible = true;
            if(!coreInfo)
            {
               clear();
               return;
            }
            _line.visible = true;
            _txtImg.visible = true;
            _txtImg.y = 75;
            _lvTxt.y = 75;
            _qualityImg.visible = true;
            _itemView.visible = true;
            _nameTxt.text = coreInfo.Description;
            _lvTxt.text = LanguageMgr.GetTranslation("public.level2",coreInfo.Level);
            _starBar.visible = true;
            _starBar.progress = coreInfo.Profile;
            _itemView.data = null;
            _itemView.icon.tipData = null;
            _itemView.icon.icon = IconFactory.getSevenYearIconPath(coreInfo.Icon);
            refreshVBox(coreInfo.attNames,coreInfo.attValues);
         }
         else
         {
            if(!_selectedItem.data)
            {
               clear();
               _titleTxt.visible = true;
               _descTxt.visible = true;
               _scrollPanel.visible = false;
               return;
            }
            _txtImg.y = 110;
            _lvTxt.y = 110;
            _qualityImg.visible = false;
            _starBar.visible = false;
            _titleTxt.visible = false;
            _descTxt.visible = false;
            _scrollPanel.visible = true;
            _line.visible = true;
            _txtImg.visible = true;
            _itemView.visible = true;
            _loc2_ = _selectedItem.data;
            _itemView.data = _loc2_;
            _nameTxt.text = _loc2_.templateInfo.TemplateName;
            _lvTxt.text = LanguageMgr.GetTranslation("public.level2",_loc2_.strengthenGrade);
            _loc1_ = TempleteManager.instance.theseusTreasureGrowupCate.getTempInfoByIdLevel(_loc2_.templateId,_loc2_.strengthenGrade);
            if(_loc1_)
            {
               refreshVBox(_loc1_.attNames,_loc1_.attValues);
               refreshSkill(_loc2_);
            }
         }
      }
      
      private function refreshSkillItem() : void
      {
         var _loc3_:int = 0;
         var _loc2_:TreasureSkillItem = null;
         var _loc4_:SkillTempInfo = null;
         var _loc1_:Array = [];
         if(coreInfo && coreInfo.CoreSkills)
         {
            _loc1_ = coreInfo.CoreSkills.split(",");
         }
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = _skillList[_loc3_];
            _loc2_.visible = _selectedItem.type == 0;
            if(_loc1_[_loc3_])
            {
               _loc4_ = TempleteManager.instance.skillTemplateDic[_loc1_[_loc3_]];
               _loc2_.data = _loc4_;
            }
            else
            {
               _loc2_.data = null;
            }
            _loc3_++;
         }
      }
      
      private function initSkillItem() : void
      {
         var _loc1_:TreasureSkillItem = null;
         var _loc2_:int = 0;
         _skillList = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("TreasureCoreFrame.item",[_loc2_ + 1]);
            _loc1_.x = 635;
            _loc1_.y = 160 + _loc2_ * 70;
            _sprite.addChild(_loc1_);
            _skillList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function clear() : void
      {
         _nameTxt.text = "";
         _lvTxt.text = "";
         _itemView.data = null;
         _itemView.visible = false;
         _txtImg.visible = false;
         _qualityImg.visible = false;
         _starBar.visible = false;
         _line.visible = false;
         _propertyVBox.removeAllChild();
      }
      
      private function refreshSkill(param1:GoodsInfo) : void
      {
         var _loc2_:FilterFrameText = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:SkillTempInfo = null;
         _propertyVBox.beginChanges();
         _loc4_ = 1;
         while(_loc4_ < 6)
         {
            _loc5_ = int(param1["randomSkill" + _loc4_]);
            _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_loc5_);
            if(_loc3_)
            {
               if(_loc4_ == 1)
               {
                  _loc2_ = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.propertyTxt");
                  _loc2_.text = LanguageMgr.GetTranslation("TreasurePageView.skill.text");
                  _propertyVBox.addChild(_loc2_);
               }
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.skillTxt");
               _loc2_.text = _loc3_.Description;
               _loc2_.setFrame(_loc3_.ProperType);
               _propertyVBox.addChild(_loc2_);
            }
            _loc4_++;
         }
         _propertyVBox.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      private function refreshVBox(param1:Array, param2:Array) : void
      {
         var _loc3_:FilterFrameText = null;
         _propertyVBox.removeAllChild();
         var _loc4_:int = 0;
         _propertyVBox.beginChanges();
         _loc3_ = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.propertyTxt");
         _loc3_.text = LanguageMgr.GetTranslation("TreasurePageView.property.text");
         _propertyVBox.addChild(_loc3_);
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("TreasurePageView.propertyTxt");
            _loc3_.htmlText = param1[_loc4_] + "<font color=\'#2dfb05\'> +" + param2[_loc4_];
            _propertyVBox.addChild(_loc3_);
            _loc4_++;
         }
         _propertyVBox.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      private function get coreInfo() : TheseusTreasureCoreInfo
      {
         return TempleteManager.instance.theseusTreasureCoreCate.getTempInfoByLevel(model.coreLevel);
      }
      
      private function get model() : TheseussoulModel
      {
         return _thane.theseusInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_lockSprite);
         _lockSprite = null;
         ObjectUtils.disposeObject(_lockTxt);
         _lockTxt = null;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeObject(_txtImg);
         _txtImg = null;
         ObjectUtils.disposeObject(_qualityImg);
         _qualityImg = null;
         ObjectUtils.disposeObject(_starBar);
         _starBar = null;
         ObjectUtils.disposeObject(_itemView);
         _itemView = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeAllChildren(_propertyVBox);
         _propertyVBox = null;
         for each(var _loc1_:TreasureOuterItemLook in _list)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         for each(var _loc2_:TreasureSkillItem in _skillList)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         _selectedItem = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


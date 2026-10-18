package dragontitan
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTitanManager;
   import mvc.module.dragonTitan.DragonTitanData;
   import mvc.module.dragonTitan.DragonTitanModel;
   import yishi.datas.templates.DragonTitanTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class DragonTitanInfoFrame extends Frame
   {
      
      private var _bg:Image;
      
      private var _skillImgTxt:Image;
      
      private var _rightBg:Image;
      
      private var _leftBg:Image;
      
      private var _titanName:FilterFrameText;
      
      private var _titanLevel:FilterFrameText;
      
      private var _icon:BaseIconView;
      
      private var _skills:Vector.<DragonTitanSkillItemView>;
      
      private var _titanLvl:FilterFrameText;
      
      private var _titanProperty:FilterFrameText;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _pageSize:int = 6;
      
      private var _currentPageNum:int = 1;
      
      private var _pageNumMax:int = 1;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _data:DragonTitanData;
      
      public function DragonTitanInfoFrame()
      {
         super();
         initView();
         initEvent();
         if(tempData && tempData.devourTitan.length > 0)
         {
            initSkill();
            _pageNumMax = Math.ceil(tempData.devourTitan.length / _pageSize);
            currentPageNum = 1;
            refreshView();
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.DragonTitanInfoFrameBack");
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.leftBg");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.checkOthersTitanBg");
         _icon = ComponentFactory.Instance.creatCustomObject("dragontitan.DragonTitanFrame.icon");
         _skillImgTxt = ComponentFactory.Instance.creatComponentByStylename("dragontitan.skillImgTxt");
         _titanName = ComponentFactory.Instance.creatComponentByStylename("DragonTitanFrame.titanName");
         _titanLevel = ComponentFactory.Instance.creatComponentByStylename("DragonTitanFrame.titanLevel");
         _titanLvl = ComponentFactory.Instance.creatComponentByStylename("DragonTitanInfoFrame.titanLvl");
         _titanProperty = ComponentFactory.Instance.creatComponentByStylename("DragonTitanDevelopView.titanProperty");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("dragontitan.PageText");
         addToContent(_bg);
         addToContent(_leftBg);
         addToContent(_rightBg);
         addToContent(_titanName);
         addToContent(_titanLevel);
         addToContent(_titanLvl);
         addToContent(_titanProperty);
         addToContent(_icon);
         addToContent(_skillImgTxt);
      }
      
      private function initSkill() : void
      {
         var _loc3_:int = 0;
         var _loc2_:DragonTitanSkillItemView = null;
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
            _loc2_.data = tempData.getSkillTempInfoByTitanId(_loc2_.titanId);
            _loc4_.addChild(_loc2_);
            _skills.push(_loc2_);
            _loc3_++;
         }
         addToContent(_loc4_);
         var _loc1_:Sprite = new Sprite();
         _loc1_.x = -112;
         _loc1_.y = 200;
         _loc1_.addChild(_pageBg);
         _loc1_.addChild(_preBtn);
         _loc1_.addChild(_nextBtn);
         _loc1_.addChild(_pageTxt);
         addToContent(_loc1_);
      }
      
      private function getTitanIdByIndex(param1:int) : int
      {
         if(tempData && tempData.devourTitan.length > 0)
         {
            if(param1 > tempData.devourTitan.length - 1)
            {
               return -1;
            }
            param1 = (currentPageNum - 1) * _pageSize + param1;
            if(param1 > tempData.devourTitan.length - 1)
            {
               return -1;
            }
            return tempData.devourTitan[param1];
         }
         if(param1 > model.devourTitan.length - 1)
         {
            return -1;
         }
         param1 = (currentPageNum - 1) * _pageSize + param1;
         if(param1 > model.devourTitan.length - 1)
         {
            return -1;
         }
         return model.devourTitan[param1];
      }
      
      private function unInitView() : void
      {
         var _loc1_:int = 0;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_skillImgTxt)
         {
            ObjectUtils.disposeObject(_skillImgTxt);
         }
         _skillImgTxt = null;
         if(_rightBg)
         {
            ObjectUtils.disposeObject(_rightBg);
         }
         _rightBg = null;
         if(_leftBg)
         {
            ObjectUtils.disposeObject(_leftBg);
         }
         _leftBg = null;
         if(_titanName)
         {
            ObjectUtils.disposeObject(_titanName);
         }
         _titanName = null;
         if(_titanLevel)
         {
            ObjectUtils.disposeObject(_titanLevel);
         }
         _titanLevel = null;
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         if(_titanLvl)
         {
            ObjectUtils.disposeObject(_titanLvl);
         }
         _titanLvl = null;
         if(_titanProperty)
         {
            ObjectUtils.disposeObject(_titanProperty);
         }
         _titanProperty = null;
         if(_preBtn)
         {
            ObjectUtils.disposeObject(_preBtn);
         }
         _preBtn = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         _pageTxt = null;
         if(_pageBg)
         {
            ObjectUtils.disposeObject(_pageBg);
         }
         _pageBg = null;
         if(_skills)
         {
            _loc1_ = 0;
            while(_loc1_ < _skills.length)
            {
               _skills[_loc1_].dispose();
               _loc1_++;
            }
            _skills.length = 0;
            _skills = null;
         }
      }
      
      private function initEvent() : void
      {
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__preBtnClickHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__nextBtnClickHandler);
         }
         MsgMan.addObserver("DragonTitanEvent.TITAN_DATA",this,refreshView);
      }
      
      private function refreshView(param1:String = null, param2:Object = null) : void
      {
         var _loc5_:String = null;
         var _loc4_:int = 0;
         _titanLevel.text = LanguageMgr.GetTranslation("DragonTitanFrame.starLevels",tempData.getSteps(),tempData.getStars());
         _titanLvl.text = LanguageMgr.GetTranslation("DragonTitanFrame.starLevels",tempData.getSteps(),tempData.getStars());
         _titanProperty.text = LanguageMgr.GetTranslation("DragonTitanDevelopView.addProperty",tempData.starLevel * 100);
         var _loc3_:DragonTitanTempInfo = TempleteManager.instance.titanTemplateCate.getTemplateById(tempData.templateId);
         if(_loc3_)
         {
            _titanName.text = _loc3_.TemplateName;
            _loc5_ = _loc3_.AvatarPath;
            if(_icon.icon != _loc5_)
            {
               _icon.icon = IconFactory.getCommonIconPath(_loc5_);
            }
         }
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _skills[_loc4_].data = tempData.getSkillTempInfoByTitanId(getTitanIdByIndex(_loc4_));
            _loc4_++;
         }
         refreshListView();
      }
      
      private function removeEvent() : void
      {
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__preBtnClickHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnClickHandler);
         }
         MsgMan.removeObserver("DragonTitanEvent.TITAN_DATA",this,refreshView);
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
      
      private function refreshListView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:DragonTitanSkillItemView = null;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = _skills[_loc3_];
            _loc2_ = int(tempData.devourTitan[(currentPageNum - 1) * _pageSize + _loc3_]);
            _loc1_.data = tempData.getSkillTempInfoByTitanId(_loc2_);
            _loc3_++;
         }
      }
      
      private function getCurrentList() : Vector.<SkillTempInfo>
      {
         var _loc6_:Array = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:DragonTitanTempInfo = null;
         if(tempData.devourTitan)
         {
            _loc1_ = (currentPageNum - 1) * _pageSize;
            _loc2_ = Math.min(_loc1_ + _pageSize,tempData.devourTitan.length);
            _loc6_ = tempData.devourTitan.slice(_loc1_,_loc2_);
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
      
      private function get model() : DragonTitanModel
      {
         return DragonTitanManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      public function get data() : DragonTitanData
      {
         return _data;
      }
      
      public function set data(param1:DragonTitanData) : void
      {
         _data = param1;
         if(tempData && tempData.devourTitan.length > 0)
         {
            initSkill();
            _pageNumMax = Math.ceil(tempData.devourTitan.length / _pageSize);
            currentPageNum = 1;
            refreshView();
         }
      }
      
      private function get tempData() : *
      {
         if(data)
         {
            return data;
         }
         return model;
      }
   }
}


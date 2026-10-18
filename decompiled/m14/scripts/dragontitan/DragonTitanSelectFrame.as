package dragontitan
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.DragonTitanManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.dragonTitan.DragonTitanModel;
   import yishi.datas.templates.DragonTitanTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTitanSelectFrame extends Frame implements IManualSize
   {
      
      private var _bg:Image;
      
      private var _skills:Vector.<DragonTitanIconItemView>;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _pageSize:int = 10;
      
      private var _currentPageNum:int = 1;
      
      private var _pageNumMax:int = 1;
      
      private var _formatStr:String = "{0} / {1}";
      
      public function DragonTitanSelectFrame()
      {
         super();
         initView();
         initEvent();
         if(model && model.devourTitan.length > 0)
         {
            _pageNumMax = Math.ceil(model.devourTitan.length / _pageSize);
            currentPageNum = 1;
            refreshView();
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,796,570);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DragonTitanIconItemView = null;
         titleText = LanguageMgr.GetTranslation("dragontitan.DragonTitanFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.selectIconBg");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.PrePageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("dragontitan.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.PageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("dragontitan.PageText");
         addToContent(_bg);
         _skills = new Vector.<DragonTitanIconItemView>();
         var _loc3_:Sprite = new Sprite();
         _loc3_.x = 12;
         _loc3_.y = 4;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new DragonTitanIconItemView();
            _loc1_.addEventListener("click",itemClickHandle);
            _loc1_.x = _loc2_ % 5 * 79;
            _loc1_.y = Math.floor(_loc2_ / 5) * 70;
            _loc1_.titanId = getTitanIdByIndex(_loc2_);
            _loc1_.data = TempleteManager.instance.titanTemplateCate.getTemplateById(_loc1_.titanId);
            _loc3_.addChild(_loc1_);
            _skills.push(_loc1_);
            _loc2_++;
         }
         addToContent(_loc3_);
         addToContent(_pageBg);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(_pageTxt);
      }
      
      protected function itemClickHandle(param1:MouseEvent) : void
      {
         var _loc3_:int = _skills.indexOf(param1.currentTarget);
         var _loc2_:int = getTitanIdByIndex(_loc3_);
         if(_loc2_ <= 0)
         {
            return;
         }
         if(_loc2_ == model.templateId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DragonTitanSelectFrame.using"));
            return;
         }
         DragonTitanManager.instance.sendSetTitanIcon(_loc2_);
         dispose();
      }
      
      private function getTitanIdByIndex(param1:int) : int
      {
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
         if(_skills)
         {
            _loc1_ = 0;
            while(_loc1_ < _skills.length)
            {
               ObjectUtils.disposeObject(_skills[_loc1_]);
               _loc1_++;
            }
            _skills.length = 0;
            _skills = null;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _preBtn.addEventListener("click",__preBtnClickHandler);
         _nextBtn.addEventListener("click",__nextBtnClickHandler);
         MsgMan.addObserver("DragonTitanEvent.TITAN_DATA",this,refreshView);
      }
      
      private function refreshView(param1:String = null, param2:Object = null) : void
      {
         refreshListView();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _preBtn.removeEventListener("click",__preBtnClickHandler);
         _nextBtn.removeEventListener("click",__nextBtnClickHandler);
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
         var _loc1_:DragonTitanIconItemView = null;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc1_ = _skills[_loc3_];
            _loc2_ = getTitanIdByIndex(_loc3_);
            _loc1_.data = TempleteManager.instance.titanTemplateCate.getTemplateById(_loc2_);
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
         if(model.devourTitan)
         {
            _loc1_ = (currentPageNum - 1) * _pageSize;
            _loc2_ = Math.min(_loc1_ + _pageSize,model.devourTitan.length);
            _loc6_ = model.devourTitan.slice(_loc1_,_loc2_);
         }
         var _loc5_:Vector.<SkillTempInfo> = new Vector.<SkillTempInfo>();
         _loc4_ = 0;
         while(_loc4_ < 10)
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
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
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
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}


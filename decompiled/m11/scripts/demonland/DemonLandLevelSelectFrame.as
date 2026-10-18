package demonland
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.demonland.DemonLandModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.DemonLandTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.DemonLandManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class DemonLandLevelSelectFrame extends Frame
   {
      
      private var _str1:Image;
      
      private var _barbg:ScaleBitmapImage;
      
      private var _bar:Image;
      
      private var _imgBg:Image;
      
      private var spLevel:Sprite;
      
      private var arrIcon:Array;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var template:DemonLandTemplate;
      
      private var _txtTitle:FilterFrameText;
      
      public function DemonLandLevelSelectFrame()
      {
         super();
         initView();
         initNodeView();
         addEvent();
         _currentPageNum = model.selectedChapter;
         refreshView();
         model.isOpenSelectFrame = true;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _imgBg = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandLevelSelectFrame.imgBg");
         _str1 = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandLevelSelectFrame.str1");
         _barbg = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandLevelSelectFrame.barbg");
         _bar = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandLevelSelectFrame.bar");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandLevelSelectFrame.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("DemonLand.DemonLandLevelSelectFrame.nextBtn");
         _txtTitle = ComponentFactory.Instance.creatComponentByStylename("demonland.DemonLandLevelSelect.title");
         spLevel = new Sprite();
         addToContent(_imgBg);
         addToContent(_str1);
         addToContent(_barbg);
         addToContent(_bar);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(spLevel);
         spLevel.x = 10;
         addToContent(_txtTitle);
      }
      
      private function initNodeView() : void
      {
         var _loc2_:LevelStateIcon = null;
         var _loc1_:int = 0;
         arrIcon = [];
         _loc1_ = 1;
         while(_loc1_ <= 10)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("DemonLand.DemonLandLevelSelectFrame.level" + _loc1_,[_loc1_]);
            spLevel.addChild(_loc2_);
            arrIcon.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("DEMON_LAND_CLOSE_AWARD_VIEW",onCloseAwardView);
         _preBtn.addEventListener("click",__onLastPageHandler);
         _nextBtn.addEventListener("click",__onNextPageHandler);
         NotificationManager.instance.addEventListener("DEMON_LAND_PAGE_REFRESH",onPageRefreshView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("DEMON_LAND_CLOSE_AWARD_VIEW",onCloseAwardView);
         _preBtn.removeEventListener("click",__onLastPageHandler);
         _nextBtn.removeEventListener("click",__onNextPageHandler);
         NotificationManager.instance.removeEventListener("DEMON_LAND_PAGE_REFRESH",onPageRefreshView);
      }
      
      private function __onLastPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
      }
      
      private function __onNextPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
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
         if(param1 > 30)
         {
            return;
         }
         if(param1 > model.maxChapterId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("demonland.main.text3"));
            return;
         }
         if(currentPageNum > param1 || param1 != model.maxChapterId)
         {
            _currentPageNum = param1;
            model.selectedChapter = _currentPageNum;
            refreshView();
         }
         else
         {
            _currentPageNum = param1;
            model.selectedChapter = _currentPageNum;
            DemonLandManager.instance.sendEnterDemonLandChapter(_currentPageNum);
         }
      }
      
      private function refreshView(param1:Boolean = true) : void
      {
         var _loc2_:LevelStateIcon = null;
         var _loc3_:int = 0;
         template = TempleteManager.instance.demonLandTemplateCate.getTemplateByChapterAndNodeId(model.selectedChapter,1);
         _txtTitle.text = template.Name;
         _preBtn.visible = model.selectedChapter == 1 ? false : true;
         _nextBtn.visible = model.selectedChapter == 30 ? false : true;
         _loc3_ = 1;
         while(_loc3_ <= 10)
         {
            _loc2_ = arrIcon[_loc3_ - 1];
            _loc2_.isPass = false;
            if(model.selectedChapter < model.maxChapterId)
            {
               _loc2_.isPass = true;
               _loc2_.setState(2);
               _bar.width = _barbg.width;
            }
            else
            {
               if(_loc3_ < model.maxNodeId)
               {
                  _loc2_.isPass = true;
                  _loc2_.setState(2);
               }
               else if(_loc3_ == model.maxNodeId)
               {
                  _loc2_.isPass = true;
                  _loc2_.setState(3);
               }
               else
               {
                  _loc2_.setState(1);
               }
               _bar.width = _barbg.width * (model.maxNodeId - 1) / 9;
            }
            if(param1)
            {
               _loc2_.refreshView();
            }
            _loc3_++;
         }
      }
      
      private function onCloseAwardView(param1:NotificationEvent) : void
      {
         refreshView(false);
      }
      
      private function onPageRefreshView(param1:NotificationEvent) : void
      {
         refreshView();
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
      
      private function get model() : DemonLandModel
      {
         return DemonLandManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_str1);
         _str1 = null;
         ObjectUtils.disposeObject(_barbg);
         _barbg = null;
         ObjectUtils.disposeObject(_bar);
         _bar = null;
         ObjectUtils.disposeObject(_imgBg);
         _imgBg = null;
         ObjectUtils.disposeObject(_txtTitle);
         _txtTitle = null;
         ObjectUtils.disposeAllChildren(spLevel);
         spLevel = null;
         model.isOpenSelectFrame = false;
         LogicUtils.disposeDisplayCollection(arrIcon);
         arrIcon = null;
         super.dispose();
      }
   }
}


package child.handbook
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import utils.LogicUtils;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   
   public class ChildHandBookView extends Component
   {
      
      private var bottom:MutipleImage;
      
      private var growthImage:Image;
      
      private var stoneImage:Image;
      
      private var hasStoneText:FilterFrameText;
      
      private var growthLevelText:FilterFrameText;
      
      private var growthMc:MovieClip;
      
      private var growthValueText:FilterFrameText;
      
      private var childList:SimpleTileList;
      
      private var itemList:Vector.<ChildHandBookItem>;
      
      private var helpImage:Image;
      
      private var lastPageBtn:BaseButton;
      
      private var nextPageBtn:BaseButton;
      
      private var pageBg:Image;
      
      private var pageTxt:FilterFrameText;
      
      private var _pageCount:int = 8;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var col:int = 4;
      
      private var rightFrame:ChildHandBookRightFrame;
      
      public function ChildHandBookView()
      {
         super();
         initView();
         addEvent();
         _pageNumMax = Math.ceil(showList.length / _pageCount);
         currentPageNum = 1;
         initChildListView();
         refreshView();
         model.selectedChildTemp = itemList[0].data;
      }
      
      private function initView() : void
      {
         bottom = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.bottom");
         growthImage = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.growthImage");
         stoneImage = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.stoneImage");
         hasStoneText = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.hasStoneText");
         growthLevelText = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.growthLevelText");
         growthMc = ComponentFactory.Instance.creatCustomObject("ChildHandBookView.growthMc");
         growthValueText = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.growthValueText");
         childList = ComponentFactory.Instance.creatCustomObject("ChildHandBookView.SimpleTileList",[col]);
         helpImage = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.helpImage");
         pageBg = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.lookPageBg");
         pageTxt = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.lookPageTextStyle");
         lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.lookLastPageBtn");
         nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.lookNextPageBtn");
         addChild(bottom);
         addChild(growthImage);
         addChild(stoneImage);
         addChild(hasStoneText);
         addChild(growthLevelText);
         addChild(growthMc);
         growthMc["halo"].visible = false;
         addChild(growthValueText);
         addChild(helpImage);
         addChild(lastPageBtn);
         addChild(nextPageBtn);
         addChild(pageBg);
         addChild(pageTxt);
         addChild(childList);
         growthImage.tipData = LanguageMgr.GetTranslation("ChildHandBookView.growthImage.tipdata");
      }
      
      private function initChildListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildHandBookItem = null;
         itemList = new Vector.<ChildHandBookItem>();
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = new ChildHandBookItem();
            _loc1_.data = currentList[_loc2_];
            childList.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         childList.commitChanges();
      }
      
      private function addEvent() : void
      {
         lastPageBtn.addEventListener("click",__onLastPageHandler);
         nextPageBtn.addEventListener("click",__onNextPageHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
         MsgMan.addObserver("ChildEvent.CHILD_HANDBOOK_SELECT",this,__childHandSelectHandler);
      }
      
      private function removeEvent() : void
      {
         lastPageBtn.removeEventListener("click",__onLastPageHandler);
         nextPageBtn.removeEventListener("click",__onNextPageHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_HANDBOOK_SELECT",this,__childHandSelectHandler);
         if(rightFrame)
         {
            rightFrame.removeEventListener("response",__rightFrameDisposeHandler);
         }
      }
      
      private function __rightFrameDisposeHandler(param1:FrameEvent) : void
      {
         rightFrame.removeEventListener("response",__rightFrameDisposeHandler);
         ObjectUtils.disposeObject(rightFrame);
         rightFrame = null;
      }
      
      private function __childInfoHandler(param1:String, param2:Object) : void
      {
         refreshBookView();
      }
      
      public function refreshBookView() : void
      {
         refreshChildListView();
         refreshView();
      }
      
      private function __childHandSelectHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < itemList.length)
         {
            if(itemList[_loc3_].data && model.selectedChildTemp && itemList[_loc3_].data.JobType == model.selectedChildTemp.JobType)
            {
               itemList[_loc3_].selected = true;
            }
            else
            {
               itemList[_loc3_].selected = false;
            }
            _loc3_++;
         }
         if(!rightFrame)
         {
            rightFrame = ComponentFactory.Instance.creatComponentByStylename("ChildHandBookView.rightFrame");
            rightFrame.addEventListener("response",__rightFrameDisposeHandler);
         }
         if(rightFrame && !rightFrame.parent)
         {
            addChild(rightFrame);
         }
         rightFrame.data = model.selectedChildTemp;
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = int(GoodsManager.instance.getGoodsNumInAllBySonType(620));
         hasStoneText.text = _loc6_ + "";
         var _loc1_:int = int(model.curGrowthGrade);
         growthLevelText.text = LanguageMgr.GetTranslation("public.level2",_loc1_);
         var _loc3_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc1_ + 1,120);
         var _loc5_:Array = TempleteManager.instance.getTemplatesByType(120);
         if(!_loc5_ || _loc5_.length <= 0)
         {
            return;
         }
         _loc5_.sortOn("Grades",16);
         if(!_loc3_)
         {
            growthValueText.text = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.RuneMaxTxt");
            growthMc.gotoAndStop(100);
         }
         else
         {
            _loc2_ = int(_loc3_.Data);
            _loc8_ = int(model.totalGrowth);
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc8_ -= _loc5_[_loc4_].Data;
               _loc4_++;
            }
            growthValueText.text = _loc8_ + "/" + _loc2_;
            growthMc.gotoAndStop(int(100 * _loc8_ / _loc2_));
         }
         var _loc7_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(620)[0];
         if(_loc7_)
         {
            stoneImage.tipData = "<font color=\'#12EA17\'>" + _loc7_.TemplateName + "</font>" + "\n" + _loc7_.Description;
         }
         helpImage.tipData = _loc1_ + 1;
      }
      
      private function refreshChildListView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < itemList.length)
         {
            itemList[_loc1_].data = _loc1_ < currentList.length ? currentList[_loc1_] : null;
            if(itemList[_loc1_].data && itemList[_loc1_].data.JobType == model.selectedChildTemp.JobType)
            {
               model.selectedChildTemp = itemList[_loc1_].data;
               itemList[_loc1_].selected = true;
            }
            else
            {
               itemList[_loc1_].selected = false;
            }
            _loc1_++;
         }
      }
      
      private function __onLastPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         model.selectedChildTemp = currentList[0];
         refreshBookView();
      }
      
      private function __onNextPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         model.selectedChildTemp = currentList[0];
         refreshBookView();
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
         if(lastPageBtn)
         {
            lastPageBtn.enable = currentPageNum > 1;
         }
         if(nextPageBtn)
         {
            nextPageBtn.enable = currentPageNum < _pageNumMax;
         }
         if(pageTxt)
         {
            pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      private function get currentList() : Array
      {
         var _loc2_:* = null;
         var _loc1_:int = (currentPageNum - 1) * _pageCount;
         var _loc3_:int = Math.min(_loc1_ + _pageCount,showList.length);
         return showList.slice(_loc1_,_loc3_);
      }
      
      private function get showList() : Array
      {
         return model.collectionTempList;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(bottom);
         bottom = null;
         ObjectUtils.disposeObject(stoneImage);
         stoneImage = null;
         ObjectUtils.disposeObject(hasStoneText);
         hasStoneText = null;
         ObjectUtils.disposeObject(growthLevelText);
         growthLevelText = null;
         ObjectUtils.disposeViolentMc(growthMc);
         growthMc = null;
         ObjectUtils.disposeObject(growthValueText);
         growthValueText = null;
         ObjectUtils.disposeObject(helpImage);
         helpImage = null;
         ObjectUtils.disposeObject(childList);
         childList = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         ObjectUtils.disposeObject(rightFrame);
         rightFrame = null;
         ObjectUtils.disposeObject(growthImage);
         growthImage = null;
         if(pageBg)
         {
            ObjectUtils.disposeObject(pageBg);
         }
         pageBg = null;
         if(pageTxt)
         {
            ObjectUtils.disposeObject(pageTxt);
         }
         pageTxt = null;
         if(lastPageBtn)
         {
            ObjectUtils.disposeObject(lastPageBtn);
         }
         lastPageBtn = null;
         if(nextPageBtn)
         {
            ObjectUtils.disposeObject(nextPageBtn);
         }
         nextPageBtn = null;
         model.selectedChildTemp = null;
         super.dispose();
      }
   }
}


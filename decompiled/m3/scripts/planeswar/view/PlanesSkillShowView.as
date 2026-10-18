package planeswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.planeswar.PlanesWarModel;
   import utils.LogicUtils;
   import yishi.manager.PlanesWarManager;
   
   public class PlanesSkillShowView extends Component
   {
      
      private var preBtn:BaseButton;
      
      private var nextBtn:BaseButton;
      
      private var iconHbox:HBox;
      
      private var iconList:Vector.<PlanesFuncItem>;
      
      private var _pageCount:int = 4;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var showType:int;
      
      public function PlanesSkillShowView(param1:int)
      {
         super();
         showType = param1;
         initView();
         initIconView();
         addEvent();
         if(int(Math.ceil(model.getShowDataByType(showType).length / _pageCount)) > 0)
         {
            _pageNumMax = Math.ceil(model.getShowDataByType(showType).length / _pageCount);
         }
         else
         {
            _pageNumMax = 1;
         }
         currentPageNum = 1;
         refreshView();
      }
      
      private function initView() : void
      {
         preBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesSkillShowView.preBtn");
         nextBtn = ComponentFactory.Instance.creatComponentByStylename("PlanesSkillShowView.nextBtn");
         iconHbox = ComponentFactory.Instance.creatComponentByStylename("PlanesSkillShowView.iconHbox");
         addChild(preBtn);
         addChild(nextBtn);
         addChild(iconHbox);
      }
      
      private function initIconView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PlanesFuncItem = null;
         iconList = new Vector.<PlanesFuncItem>();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("PlanesSkillShowView.funcItem",[showType]);
            iconHbox.addChild(_loc2_);
            iconList.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         preBtn.addEventListener("click",__preClickHandler);
         nextBtn.addEventListener("click",__nextClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(preBtn)
         {
            preBtn.removeEventListener("click",__preClickHandler);
         }
         if(nextBtn)
         {
            nextBtn.removeEventListener("click",__nextClickHandler);
         }
      }
      
      private function __preClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshView();
      }
      
      private function __nextClickHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         if(int(Math.ceil(model.getShowDataByType(showType).length / _pageCount)) > 0)
         {
            _pageNumMax = Math.ceil(model.getShowDataByType(showType).length / _pageCount);
         }
         else
         {
            _pageNumMax = 1;
         }
         updatePageInfo();
         _loc1_ = 0;
         while(_loc1_ < iconList.length)
         {
            iconList[_loc1_].tempId = currentList[_loc1_] ? currentList[_loc1_] : -1;
            if(iconList[_loc1_].tempId == model.skillSelectedTempId)
            {
               iconList[_loc1_].selected = true;
            }
            else
            {
               iconList[_loc1_].selected = false;
            }
            _loc1_++;
         }
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
         if(preBtn)
         {
            preBtn.enable = currentPageNum > 1;
         }
         if(nextBtn)
         {
            nextBtn.enable = currentPageNum < _pageNumMax;
         }
      }
      
      private function get currentList() : Array
      {
         var _loc2_:* = null;
         var _loc1_:int = (currentPageNum - 1) * _pageCount;
         var _loc3_:int = Math.min(_loc1_ + _pageCount,model.getShowDataByType(showType).length);
         return model.getShowDataByType(showType).slice(_loc1_,_loc3_);
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(preBtn);
         preBtn = null;
         ObjectUtils.disposeObject(nextBtn);
         nextBtn = null;
         ObjectUtils.disposeObject(iconHbox);
         iconHbox = null;
         LogicUtils.disposeDisplayCollection(iconList);
         iconList = null;
         super.dispose();
      }
   }
}


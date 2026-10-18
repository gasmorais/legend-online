package alchemical.makeview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.alchemical.AlchemicalMakeFormulaInfo;
   import mvc.module.alchemical.AlchemicalModel;
   import utils.LogicUtils;
   import yishi.manager.AlchemicalManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   
   public class AlchemicalMakeCooperationView extends Component
   {
      
      private var _lastPageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _pageCount:int = 4;
      
      private var _pageNumMax:int = 1;
      
      private var _currentPageNum:int;
      
      private var _formatStr:String = "{0} / {1}";
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<AlchemicalMakeCooperationItem>;
      
      public function AlchemicalMakeCooperationView()
      {
         super();
         initView();
         initListView();
         addEvent();
         _pageNumMax = Math.ceil(model.cooperationList.length / _pageCount);
         if(model.selectFormulaInfo)
         {
            currentPageNum = Math.ceil((model.getSelectFormulaInIndex(model.selectFormulaInfo.shareUid) + 1) / _pageCount);
         }
         else
         {
            currentPageNum = 1;
            model.selectFormulaInfo = currentList[0];
         }
         refreshView();
      }
      
      private function initView() : void
      {
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationView.lookPageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationView.lookPageTextStyle");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationView.lookLastPageBtn");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationView.lookNextPageBtn");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeCooperationView.vbox");
         addChild(_vbox);
         addChild(_lastPageBtn);
         addChild(_nextPageBtn);
         addChild(_pageBg);
         addChild(_pageTxt);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AlchemicalMakeCooperationItem = null;
         _itemList = new Vector.<AlchemicalMakeCooperationItem>();
         _loc2_ = 0;
         while(_loc2_ < _pageCount)
         {
            _loc1_ = new AlchemicalMakeCooperationItem();
            _vbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         _lastPageBtn.addEventListener("click",__onLastPageHandler);
         _nextPageBtn.addEventListener("click",__onNextPageHandler);
         MsgMan.addObserver("SELECT_FORMULA_CHANGE",this,__updateSelectChange);
         MsgMan.addObserver("ALCHEMICAL_FORMULA_UPDATE",this,__updateFormulaInfoChange);
      }
      
      private function removeEvent() : void
      {
         if(_lastPageBtn)
         {
            _lastPageBtn.removeEventListener("click",__onLastPageHandler);
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.removeEventListener("click",__onNextPageHandler);
         }
         MsgMan.removeObserver("SELECT_FORMULA_CHANGE",this,__updateSelectChange);
         MsgMan.removeObserver("ALCHEMICAL_FORMULA_UPDATE",this,__updateFormulaInfoChange);
      }
      
      private function __updateSelectChange(param1:String, param2:Object) : void
      {
         for each(var _loc3_:AlchemicalMakeCooperationItem in _itemList)
         {
            if(model.selectFormulaInfo && _loc3_.data && _loc3_.data.shareUid == model.selectFormulaInfo.shareUid)
            {
               _loc3_.selected = true;
            }
            else
            {
               _loc3_.selected = false;
            }
         }
      }
      
      private function __updateFormulaInfoChange(param1:String, param2:Object) : void
      {
         _pageNumMax = Math.ceil(model.cooperationList.length / _pageCount);
         if(model.selectFormulaInfo)
         {
            currentPageNum = Math.ceil((model.getSelectFormulaInIndex(model.selectFormulaInfo.shareUid) + 1) / _pageCount);
         }
         else
         {
            currentPageNum = 1;
            model.selectFormulaInfo = currentList[0];
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Array = currentList;
         _loc1_ = 0;
         while(_loc1_ < _pageCount)
         {
            _itemList[_loc1_].data = _loc1_ < _loc2_.length ? _loc2_[_loc1_] : null;
            if(model.selectFormulaInfo && _itemList[_loc1_].data && _itemList[_loc1_].data.shareUid == model.selectFormulaInfo.shareUid)
            {
               _itemList[_loc1_].selected = true;
            }
            else
            {
               _itemList[_loc1_].selected = false;
            }
            _loc1_++;
         }
      }
      
      private function __onLastPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum - 1;
         refreshView();
      }
      
      private function __onNextPageHandler(param1:MouseEvent) : void
      {
         currentPageNum = currentPageNum + 1;
         refreshView();
      }
      
      public function get currentPageNum() : int
      {
         return _currentPageNum;
      }
      
      public function set currentPageNum(param1:int) : void
      {
         if(_pageNumMax <= 0)
         {
            _lastPageBtn.enable = _nextPageBtn.enable = false;
            _pageTxt.text = "0/0";
         }
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
         if(_lastPageBtn)
         {
            _lastPageBtn.enable = currentPageNum > 1;
         }
         if(_nextPageBtn)
         {
            _nextPageBtn.enable = currentPageNum < _pageNumMax;
         }
         if(_pageTxt)
         {
            _pageTxt.text = StringHelper.format(_formatStr,_currentPageNum,_pageNumMax);
         }
      }
      
      private function get currentList() : Array
      {
         var _loc2_:Array = [];
         var _loc1_:int = (currentPageNum - 1) * _pageCount;
         var _loc3_:int = Math.min(_loc1_ + _pageCount,model.cooperationList.length);
         return model.cooperationList.slice(_loc1_,_loc3_);
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_pageBg)
         {
            ObjectUtils.disposeObject(_pageBg);
         }
         _pageBg = null;
         if(_pageTxt)
         {
            ObjectUtils.disposeObject(_pageTxt);
         }
         _pageTxt = null;
         if(_lastPageBtn)
         {
            ObjectUtils.disposeObject(_lastPageBtn);
         }
         _lastPageBtn = null;
         if(_nextPageBtn)
         {
            ObjectUtils.disposeObject(_nextPageBtn);
         }
         _nextPageBtn = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         model.selectFormulaType = -1;
         model.selectFormulaInfo = null;
         super.dispose();
      }
   }
}


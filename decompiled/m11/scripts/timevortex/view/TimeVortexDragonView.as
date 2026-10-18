package timevortex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.TimeVortexEvent;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import managers.TimeVortexManager;
   import mvc.module.timevortex.TimeVortexModel;
   import utils.LogicUtils;
   import yishi.filter.UIFilter;
   
   public class TimeVortexDragonView extends Component
   {
      
      private static const posList:Array = [{
         "x":359,
         "y":187
      },{
         "x":122,
         "y":282
      },{
         "x":185,
         "y":108
      },{
         "x":410,
         "y":45
      },{
         "x":642,
         "y":108
      },{
         "x":685,
         "y":282
      }];
      
      private var _mapCover:DisplayObject;
      
      private var _itemList:Array;
      
      private var _changeBtn:IconButton;
      
      private var _currentView:TimeVortexDragonItemView;
      
      private var _index:int = 1;
      
      private var _uifilter:UIFilter;
      
      public function TimeVortexDragonView()
      {
         super();
         initView();
         addEvent();
         initInfo();
      }
      
      private function initView() : void
      {
         var _loc1_:TimeVortexDragonItemView = null;
         var _loc2_:int = 0;
         _mapCover = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexMapView.frameCover");
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("timevortex.view.TimeVortexDragonItemView",[_loc2_]);
            addChild(_loc1_);
            _loc1_.x = posList[_loc2_].x;
            _loc1_.y = posList[_loc2_].y;
            _itemList.push(_loc1_);
            _loc2_ += 1;
         }
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("timevortex.view.TimeVortexDragonItemView.changeBtn");
         addChild(_mapCover);
         addChild(_changeBtn);
         _uifilter = new UIFilter();
      }
      
      private function initInfo() : void
      {
         var _loc1_:TimeVortexDragonItemView = null;
         var _loc4_:int = 0;
         var _loc3_:Boolean = false;
         _index = 0;
         var _loc2_:Boolean = true;
         _loc4_ = 1;
         while(_loc4_ <= 5)
         {
            _loc1_ = _itemList[_loc4_];
            _loc3_ = model.dragonOpenInfo["dragontalker" + _loc4_] == 0 ? false : true;
            _loc1_.isOpen = _loc3_;
            _loc1_.isClick = false;
            if(_loc2_ && !_loc3_)
            {
               _index = _loc4_;
               _loc2_ = false;
            }
            _loc4_ += 1;
         }
         if(_index != 0)
         {
            _loc1_ = _itemList[_index];
            _loc1_.isClick = true;
         }
         _changeBtn.enable = !_loc2_;
         _loc1_ = _itemList[0];
         _loc1_.isOpen = _loc2_;
      }
      
      private function addEvent() : void
      {
         _changeBtn.addEventListener("click",__onClickHander);
         model.addEventListener("DRAGON_OPEN_INFO",__openInfoHander);
      }
      
      private function itemCellBack(param1:TimeVortexDragonItemView) : void
      {
         if(_currentView)
         {
            _currentView.isClick = false;
         }
         if(param1)
         {
            _currentView = param1;
         }
         _currentView.isClick = true;
         _index = _currentView.type;
      }
      
      private function __onClickHander(param1:MouseEvent) : void
      {
         TimeVortexManager.instance.changeDragonIndex(_index);
      }
      
      private function __openInfoHander(param1:TimeVortexEvent) : void
      {
         initInfo();
      }
      
      private function removeEvent() : void
      {
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",__onClickHander);
         }
         model.removeEventListener("DRAGON_OPEN_INFO",__openInfoHander);
      }
      
      private function get model() : TimeVortexModel
      {
         return TimeVortexManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_mapCover);
         _mapCover = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         _uifilter = null;
         super.dispose();
      }
   }
}


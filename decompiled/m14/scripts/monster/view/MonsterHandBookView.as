package monster.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import monster.MonsterMagicCircleFrame;
   import monster.item.MonsterHandBookItem;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.manager.MonsterManager;
   import yishi.view.base.PageBar;
   
   public class MonsterHandBookView extends Component
   {
      
      private var _itemBox:SimpleTileList;
      
      private var _pageBar:PageBar;
      
      private var itemList:Vector.<MonsterHandBookItem>;
      
      private var pageCount:int = 8;
      
      private var _circleFrame:MonsterMagicCircleFrame;
      
      public function MonsterHandBookView()
      {
         super();
         initView();
         initListView();
         addEvent();
         showCircleFrame();
      }
      
      private function initView() : void
      {
         _itemBox = ComponentFactory.Instance.creatCustomObject("MonsterHandBookView.SimpleTileList",[4]);
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("MonsterHandBookView.pageBar");
         addChild(_itemBox);
         addChild(_pageBar);
         this.mouseEnabled = false;
      }
      
      private function initListView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:MonsterHandBookItem = null;
         var _loc4_:Array = model.monsterTempAry;
         _pageBar.setAutoPagingData(_loc4_,pageCount);
         _pageBar.setCurPage(1);
         var _loc1_:Array = _pageBar.getCurPageDatas();
         itemList = new Vector.<MonsterHandBookItem>();
         _loc3_ = 0;
         while(_loc3_ < pageCount)
         {
            _loc2_ = new MonsterHandBookItem();
            _loc2_.data = _loc1_.length > _loc3_ ? _loc1_[_loc3_] : null;
            _itemBox.addChild(_loc2_);
            itemList.push(_loc2_);
            _loc3_++;
         }
         _itemBox.commitChanges();
      }
      
      private function addEvent() : void
      {
         _pageBar.addEventListener("change",_pageChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_pageBar)
         {
            _pageBar.removeEventListener("change",_pageChangeHandler);
         }
      }
      
      private function showCircleFrame() : void
      {
         if(!_circleFrame)
         {
            _circleFrame = ComponentFactory.Instance.creatComponentByStylename("monster.MonsterMagicCircleFrame");
         }
         if(_circleFrame && !_circleFrame.parent)
         {
            addChild(_circleFrame);
         }
      }
      
      private function _pageChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:MonsterHandBookItem = null;
         var _loc1_:Array = _pageBar.getCurPageDatas();
         _loc3_ = 0;
         while(_loc3_ < pageCount)
         {
            _loc2_ = itemList[_loc3_];
            _loc2_.data = _loc1_.length > _loc3_ ? _loc1_[_loc3_] : null;
            _loc3_++;
         }
         _itemBox.commitChanges();
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         ObjectUtils.disposeObject(_circleFrame);
         _circleFrame = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}


package consortia.view.crossguild.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import mvc.module.crossguild.CrossGuildModel;
   import utils.LogicUtils;
   import yishi.manager.CrossGuildManager;
   import yishi.view.base.PageBar;
   
   public class CrossGuildBufferView extends Component
   {
      
      private var _pageBar:PageBar;
      
      private var itemList:Vector.<CrossGuildBufferItem>;
      
      private var pageCount:int = 4;
      
      public function CrossGuildBufferView()
      {
         super();
         initView();
         initListView();
         addEvent();
      }
      
      private function initView() : void
      {
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("CrossGuildBufferView.pageBar");
         addChild(_pageBar);
      }
      
      private function initListView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:CrossGuildBufferItem = null;
         var _loc4_:Array = model.memerShowBuffer;
         _pageBar.setAutoPagingData(_loc4_,pageCount);
         _pageBar.setCurPage(1);
         var _loc1_:Array = _pageBar.getCurPageDatas();
         itemList = new Vector.<CrossGuildBufferItem>();
         _loc3_ = 0;
         while(_loc3_ < pageCount)
         {
            _loc2_ = new CrossGuildBufferItem();
            _loc2_.x = _loc3_ % 2 * 250 + 33;
            _loc2_.y = int(_loc3_ / 2) * 127 + 58;
            _loc2_.data = _loc1_[_loc3_];
            addChild(_loc2_);
            itemList.push(_loc2_);
            _loc3_++;
         }
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
      
      private function _pageChangeHandler(param1:Event) : void
      {
         refreshView(false);
      }
      
      public function refreshView(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:CrossGuildBufferItem = null;
         var _loc5_:Array = model.memerShowBuffer;
         _pageBar.setAutoPagingData(_loc5_,pageCount);
         if(param1)
         {
            _pageBar.setCurPage(1);
         }
         var _loc2_:Array = _pageBar.getCurPageDatas();
         _loc4_ = 0;
         while(_loc4_ < itemList.length)
         {
            _loc3_ = itemList[_loc4_];
            _loc3_.data = _loc2_[_loc4_];
            _loc4_++;
         }
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}


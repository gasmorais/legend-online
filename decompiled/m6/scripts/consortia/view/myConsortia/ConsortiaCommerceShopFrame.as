package consortia.view.myConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import consortia.view.myConsortia.item.ConsortiaBusinessItem;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.TempleteManager;
   import yishi.view.base.PageBar;
   
   public class ConsortiaCommerceShopFrame extends Frame
   {
      
      private var _pageBar:PageBar;
      
      private var itemList:Vector.<ConsortiaBusinessItem>;
      
      private var pageCount:int = 4;
      
      public function ConsortiaCommerceShopFrame()
      {
         super();
         initView();
         initListView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("Consortia.ConsortiaBusinessFrame.previewText.text");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("ConsortiaCommerceShopFrame.pageBar");
         addToContent(_pageBar);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ConsortiaBusinessItem = null;
         var _loc3_:Array = TempleteManager.instance.consortiaCommerceShopTempCate.getTempArray();
         _pageBar.setAutoPagingData(_loc3_,pageCount);
         _pageBar.setCurPage(1);
         itemList = new Vector.<ConsortiaBusinessItem>();
         _loc2_ = 0;
         while(_loc2_ < pageCount)
         {
            _loc1_ = new ConsortiaBusinessItem();
            _loc1_.x = int(_loc2_ % 2) * 225 + 15;
            _loc1_.y = int(_loc2_ / 2) * 130 + 55;
            addToContent(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _pageBar.addEventListener("change",_pageChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_pageBar)
         {
            _pageBar.removeEventListener("change",_pageChangeHandler);
         }
      }
      
      private function _pageChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ConsortiaBusinessItem = null;
         var _loc3_:int = 0;
         var _loc4_:int = int(_pageBar.getCurPage());
         _loc2_ = 0;
         while(_loc2_ < itemList.length)
         {
            _loc1_ = itemList[_loc2_];
            _loc1_.setViewType(3);
            _loc3_ = (_loc4_ - 1) * pageCount + _loc2_;
            _loc1_.index = _loc3_;
            _loc2_++;
         }
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
      
      public function show(param1:int) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}


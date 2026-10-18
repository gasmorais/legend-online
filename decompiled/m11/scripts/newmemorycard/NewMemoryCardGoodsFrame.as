package newmemorycard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class NewMemoryCardGoodsFrame extends Frame
   {
      
      private var _bagScroll:ScrollPanel;
      
      private var _list:SimpleTileList;
      
      public function NewMemoryCardGoodsFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.MazeFallItemsFrame.title");
         _list = ComponentFactory.Instance.creatCustomObject("NewMemoryCardGoodsFrame.SimpleTileList",[6]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("NewMemoryCardGoodsFrame.ScrollPanel");
         _bagScroll.setView(_list);
         addToContent(_bagScroll);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function set data(param1:String) : void
      {
         var _loc7_:int = 0;
         var _loc6_:BaseItemView = null;
         var _loc4_:Array = null;
         var _loc8_:GoodsInfo = null;
         var _loc2_:Array = param1.split("|");
         var _loc3_:int = int(_loc2_.length);
         _loc3_ = Math.ceil(_loc3_ / 6) * 6;
         var _loc5_:int = int(_loc3_ > 30 ? _loc3_ : 30);
         _list.beginChanges();
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = ComponentFactory.Instance.creatCustomObject("NewMemoryCardGoodsFrame.BagCell");
            if(_loc7_ < _loc3_)
            {
               _loc4_ = String(_loc2_[_loc7_]).split(",");
               if(_loc4_.length == 2)
               {
                  _loc8_ = new GoodsInfo();
                  _loc8_.templateId = _loc4_[0];
                  _loc8_.count = _loc4_[1];
                  _loc6_.data = _loc8_;
               }
            }
            _list.addChild(_loc6_);
            _loc7_++;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
         if(_bagScroll.vScrollbar.visible)
         {
            _bagScroll.x = -17;
         }
         else
         {
            _bagScroll.x = -7;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bagScroll);
         _bagScroll = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}


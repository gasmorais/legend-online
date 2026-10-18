package mopup.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import flash.display.InteractiveObject;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.view.community.BaseItemView;
   
   public class MopupGainGoodsFrame extends Frame
   {
      
      private var _bagScroll:ScrollPanel;
      
      private var _list:SimpleTileList;
      
      private var _prev:InteractiveObject;
      
      public function MopupGainGoodsFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.MazeFallItemsFrame.title");
         _list = ComponentFactory.Instance.creatCustomObject("mopup.SimpleTileList",[6]);
         _bagScroll = ComponentFactory.Instance.creatComponentByStylename("mopup.GainGoodsScrollPanel");
         _bagScroll.setView(_list);
         this.addToContent(_bagScroll);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
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
      
      public function set data(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc4_:BaseItemView = null;
         _list.beginChanges();
         var _loc2_:int = int(param1.length);
         _loc2_ = Math.ceil(_loc2_ / 6) * 6;
         var _loc3_:int = int(_loc2_ > 30 ? _loc2_ : 30);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("mopup.BagCellIcon");
            if(_loc5_ < _loc2_)
            {
               _loc4_.data = param1[_loc5_];
            }
            _list.addChild(_loc4_);
            _loc5_++;
         }
         _list.commitChanges();
         _bagScroll.invalidateViewport();
         if(_bagScroll.vScrollbar.visible)
         {
            _bagScroll.x = -7;
         }
         else
         {
            _bagScroll.x = -7;
         }
      }
      
      public function show(param1:InteractiveObject = null, param2:int = 2) : void
      {
         _prev = param1;
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,param2);
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEventListener("response",__frameResponseHandler);
         if(_list)
         {
            _list.dispose();
         }
         _list = null;
         if(_bagScroll)
         {
            _bagScroll.dispose();
         }
         _bagScroll = null;
         if(_prev)
         {
            StageReferance.stage.focus = _prev;
         }
         super.dispose();
      }
   }
}


package godpvpenter
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import godpvpenter.item.TheseusDoublePvpEnterItem;
   import godpvpenter.item.TheseusPvpEnterItem;
   import manager.LanguageMgr;
   
   public class GodPvpEnterFrame extends Frame implements IManualSize
   {
      
      public var _enterBox:VBox;
      
      public var _enterSpanel:ScrollPanel;
      
      public function GodPvpEnterFrame()
      {
         super();
         initView();
         initData();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,790,566);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("godpvp.enter.title");
         _enterBox = ComponentFactory.Instance.creatCustomObject("ui.godpvpenter.enterBox");
         _enterSpanel = ComponentFactory.Instance.creatComponentByStylename("ui.godpvpenter.enterSpanel");
         addToContent(_enterSpanel);
         _enterSpanel.setView(_enterBox);
      }
      
      private function initData() : void
      {
         _enterBox.beginChanges();
         var _loc2_:TheseusPvpEnterItem = new TheseusPvpEnterItem();
         _enterBox.addChild(_loc2_);
         var _loc1_:TheseusDoublePvpEnterItem = new TheseusDoublePvpEnterItem();
         _enterBox.addChild(_loc1_);
         _enterBox.commitChanges();
         _enterSpanel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_enterBox);
         _enterBox = null;
         ObjectUtils.disposeObject(_enterSpanel);
         _enterSpanel = null;
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
   }
}


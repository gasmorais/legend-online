package theseusdoublepvp
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.TheseusPvpManager;
   import theseuspvp.item.TheseusPvpReportItem;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class TheseusDoublePvpReportFrame extends Frame
   {
      
      public var _reportVbox:VBox;
      
      private var _reportSpanel:ScrollPanel;
      
      private var _itemList:Array = [];
      
      public function TheseusDoublePvpReportFrame()
      {
         super();
         initView();
         initEvent();
         TheseusPvpManager.Instance.doSomething1(5);
      }
      
      private function initView() : void
      {
         _reportVbox = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.reportVbox");
         _reportSpanel = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.reportSpanel");
         addToContent(_reportSpanel);
         _reportSpanel.setView(_reportVbox);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("theseusDoublepvpReportEvent",dataHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("theseusDoublepvpReportEvent",dataHandler);
      }
      
      private function dataHandler(param1:NotificationEvent) : void
      {
         var _loc2_:TheseusPvpReportItem = null;
         var _loc4_:int = 0;
         var _loc5_:Array = param1.data as Array;
         _loc5_ = _loc5_.reverse();
         _reportVbox.beginChanges();
         var _loc3_:int = int(_loc5_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new TheseusPvpReportItem();
            _loc2_.data = _loc5_[_loc4_];
            _reportVbox.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc4_++;
         }
         _reportVbox.commitChanges();
         _reportSpanel.invalidateViewport();
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
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("theseuspvp.reportTitle");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseusPvpReportItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_reportVbox);
         _reportVbox = null;
         ObjectUtils.disposeObject(_reportSpanel);
         _reportSpanel = null;
         super.dispose();
      }
   }
}


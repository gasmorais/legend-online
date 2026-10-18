package consortiachess
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.ui.ChesspvpRecordGroupUI;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpOp;
   import mvc.module.chesspvp.ChesspvpRecordInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class ChesspvpRecordFrame extends Frame implements IManualSize
   {
      
      protected var _rdSpane:ScrollPanel;
      
      protected var _rdVbox:VBox;
      
      private var _groupList:Array = [];
      
      public function ChesspvpRecordFrame()
      {
         super();
         initView();
         initEvent();
         ChessPvpManager.Instance.operFun(ChessPvpOp.OP_VIEW_RECORD);
      }
      
      private function initView() : void
      {
         _rdSpane = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdSpane");
         _rdVbox = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.rdVbox");
         addToContent(_rdSpane);
         _rdSpane.setView(_rdVbox);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,515,620);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener(ChessPvpOp.EVENT_OP_FUN,updataHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener(ChessPvpOp.EVENT_OP_FUN,updataHandler);
      }
      
      private function updataHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = param1.data as Array;
         if(_loc4_ && _loc4_[0] == ChessPvpOp.OP_VIEW_RECORD)
         {
            _rdVbox.beginChanges();
            _loc2_ = _loc4_[1];
            doGroupList(_loc2_,1);
            _loc3_ = _loc4_[2];
            doGroupList(_loc3_,2);
            _rdVbox.commitChanges();
            _rdSpane.invalidateViewport();
         }
      }
      
      private function doGroupList(param1:Array, param2:int) : void
      {
         var _loc9_:Array = null;
         var _loc10_:ChesspvpRecordInfo = null;
         var _loc3_:ChesspvpRecordGroupUI = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = int(param1 ? param1.length : 0);
         var _loc7_:Array = [];
         var _loc6_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc10_ = param1[_loc8_];
            if(_loc7_[_loc10_.group] == null)
            {
               _loc7_[_loc10_.group] = [];
               _loc6_.push(_loc10_.group);
            }
            _loc9_ = _loc7_[_loc10_.group];
            _loc9_.push(_loc10_);
            _loc8_++;
         }
         _loc5_ = int(_loc6_.length);
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc3_ = new ChesspvpRecordGroupUI();
            _groupList.push(_loc3_);
            _loc4_ = int(_loc6_[_loc8_]);
            _loc3_.updateView(_loc4_,_loc7_[_loc4_],param2);
            _rdVbox.addChild(_loc3_);
            _loc8_++;
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_rdSpane);
         _rdSpane = null;
         ObjectUtils.disposeObject(_rdVbox);
         _rdVbox = null;
         LogicUtils.disposeDisplayCollection(_groupList);
         _groupList = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("chesspvp.recored.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}


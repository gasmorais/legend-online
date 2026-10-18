package bingo
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.bingo.BingoResultDataMsg;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.BingoManager;
   
   public class BingoBallFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _bg:DisplayObject;
      
      private var _resultMsg:BingoResultDataMsg;
      
      public function BingoBallFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,407,393);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:BingoBallItem = null;
         titleText = LanguageMgr.GetTranslation("bingo.BingoBallFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("bingo.BingoBallFrameBack");
         _bg = ComponentFactory.Instance.creatBitmap("asset.bingo.numberBg");
         addToContent(_back);
         addToContent(_bg);
         _resultMsg = BingoManager.instance.resultMsg;
         if(!_resultMsg)
         {
            return;
         }
         var _loc1_:Array = _resultMsg.lotteryNum;
         var _loc3_:int = int(_loc1_.length >= 24 ? 24 : _loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new BingoBallItem();
            _loc2_.data = _loc1_[_loc4_];
            _loc2_.x = 338 - int(_loc4_ % 6) * 61;
            _loc2_.y = 256 - int(_loc4_ / 6) * 70;
            addToContent(_loc2_);
            _loc4_++;
         }
      }
      
      private function addEvent() : void
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _resultMsg = null;
         super.dispose();
      }
   }
}


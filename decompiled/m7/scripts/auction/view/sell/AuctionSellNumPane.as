package auction.view.sell
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import yishi.view.community.BaseItemView;
   
   public class AuctionSellNumPane extends Frame
   {
      
      private static const GAP_TIME:int = 150;
      
      private var _countTxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _reduceBtn:BaseButton;
      
      private var _lableIcon:Bitmap;
      
      private var _inputBack:ScaleBitmapImage;
      
      private var _warmTxt:FilterFrameText;
      
      private var _ensureBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      public var callBack:Function;
      
      private var _item:BaseItemView;
      
      private var _targetCell:AuctionSellTargetCell;
      
      private var _timeId:int;
      
      public function AuctionSellNumPane()
      {
         super();
         initView();
         addHandler();
         titleText = LanguageMgr.GetTranslation("Auction.AuctionSellNumTitle");
         _warmTxt.text = LanguageMgr.GetTranslation("Auction.EnterSellNum");
      }
      
      private function initView() : void
      {
         _lableIcon = ComponentFactory.Instance.creatBitmap("asset.auction.AuctionNumIcon");
         _inputBack = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionInputBack");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionBuyNumText");
         _warmTxt = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionInputWarmText");
         _ensureBtn = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionCancelBtn");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("auction.AddButton");
         _reduceBtn = ComponentFactory.Instance.creatComponentByStylename("auction.ReduceButton");
         addToContent(_inputBack);
         addToContent(_lableIcon);
         addToContent(_ensureBtn);
         addToContent(_cancelBtn);
         addToContent(_countTxt);
         addToContent(_warmTxt);
         addToContent(_addBtn);
         addToContent(_reduceBtn);
      }
      
      private function addHandler() : void
      {
         _ensureBtn.addEventListener("click",onEnsureHandler);
         _cancelBtn.addEventListener("click",onCancelHandler);
         _countTxt.addEventListener("keyDown",__onKeydownHandler);
         _countTxt.addEventListener("change",changeHandler);
         _addBtn.addEventListener("click",onAddHandler);
         _addBtn.addEventListener("mouseDown",onAddDownHandler);
         _addBtn.addEventListener("rollOut",onUpHandler);
         _reduceBtn.addEventListener("click",onReduceHandler);
         _reduceBtn.addEventListener("mouseDown",onReduceDownHandler);
         _reduceBtn.addEventListener("rollOut",onUpHandler);
         addEventListener("response",__frameResponse);
         addEventListener("addedToStage",__onAddedToStage);
         addEventListener("mouseUp",onUpHandler);
      }
      
      protected function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13 && Boolean(_ensureBtn.enable))
         {
            onEnsureHandler(null);
         }
         param1.stopPropagation();
      }
      
      protected function onUpHandler(param1:MouseEvent) : void
      {
         clearInterval(_timeId);
      }
      
      protected function onReduceDownHandler(param1:MouseEvent) : void
      {
         _timeId = setTimeout(reducing,150);
      }
      
      private function reducing() : void
      {
         onReduceHandler(null);
         _timeId = setTimeout(reducing,150);
      }
      
      protected function onAddDownHandler(param1:MouseEvent) : void
      {
         _timeId = setTimeout(adding,150);
      }
      
      private function adding() : void
      {
         onAddHandler(null);
         _timeId = setTimeout(adding,150);
      }
      
      protected function changeHandler(param1:Event) : void
      {
         if(!_item.data)
         {
            return;
         }
         if(curNum <= 1)
         {
            _countTxt.text = "1";
            _reduceBtn.enable = false;
         }
         else
         {
            _reduceBtn.enable = true;
         }
         if(_item.data && curNum >= _item.data.count)
         {
            _countTxt.text = _item.data.count + "";
            _addBtn.enable = false;
         }
         else
         {
            _addBtn.enable = true;
         }
         _countTxt.text = curNum + "";
      }
      
      protected function __onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__onAddedToStage);
         stage.focus = _countTxt;
         _countTxt.setSelection(0,_countTxt.length);
      }
      
      public function show(param1:BaseItemView, param2:AuctionSellTargetCell) : void
      {
         _item = param1;
         _targetCell = param2;
         _countTxt.text = _item.data.count + "";
         changeHandler(null);
         LayerManager.Instance.addToLayer(this,2,true,true,1);
      }
      
      private function removeHandler() : void
      {
         _ensureBtn.removeEventListener("click",onEnsureHandler);
         _cancelBtn.removeEventListener("click",onCancelHandler);
         _countTxt.removeEventListener("keyDown",__onKeydownHandler);
         _countTxt.removeEventListener("change",changeHandler);
         _addBtn.removeEventListener("click",onAddHandler);
         _addBtn.removeEventListener("mouseDown",onAddDownHandler);
         _addBtn.removeEventListener("rollOut",onUpHandler);
         _reduceBtn.removeEventListener("click",onReduceHandler);
         _reduceBtn.removeEventListener("mouseDown",onReduceDownHandler);
         _reduceBtn.removeEventListener("rollOut",onUpHandler);
         removeEventListener("response",__frameResponse);
         removeEventListener("addedToStage",__onAddedToStage);
         removeEventListener("mouseUp",onUpHandler);
      }
      
      protected function onReduceHandler(param1:MouseEvent) : void
      {
         _countTxt.text = (curNum - 1).toString();
         changeHandler(null);
      }
      
      protected function onAddHandler(param1:MouseEvent) : void
      {
         _countTxt.text = (curNum + 1).toString();
         changeHandler(null);
      }
      
      protected function onCancelHandler(param1:MouseEvent) : void
      {
         _item.setNormalFilter();
         _targetCell.data = null;
         dispose();
      }
      
      protected function onEnsureHandler(param1:MouseEvent) : void
      {
         _targetCell.setNumText(curNum);
         _targetCell.data.willSellCount = curNum;
         if(callBack != null)
         {
            callBack();
         }
         dispose();
      }
      
      private function get curNum() : int
      {
         var _loc1_:int = int(_countTxt.text);
         if(_loc1_ <= 0)
         {
            _loc1_ = 0;
         }
         else if(_loc1_ > 999)
         {
            _loc1_ = 999;
         }
         return _loc1_;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               onCancelHandler(null);
               break;
            case 1:
               onCancelHandler(null);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeHandler();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}


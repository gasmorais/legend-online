package feedback
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import feedback.datas.FeedBackItemData;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FeedBackManager;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class FeedBackItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _back:ScaleFrameImage;
      
      private var _title:FilterFrameText;
      
      private var _giftImage:ScaleFrameImage;
      
      private var _getBtn:IconButton;
      
      private var _giftBack:Bitmap;
      
      private var _data:FeedBackItemData;
      
      private var _selectedBack:ScaleBitmapImage;
      
      private var _selected:Boolean;
      
      private var _isGet:Boolean;
      
      private var _hasGet:Bitmap;
      
      public function FeedBackItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _selectedBack = ComponentFactory.Instance.creatComponentByStylename("feedBackItem.selectedBack");
         _back = ComponentFactory.Instance.creatComponentByStylename("feedBackItem.back");
         _title = ComponentFactory.Instance.creatComponentByStylename("feedBackItem.title");
         _giftImage = ComponentFactory.Instance.creatComponentByStylename("feedBackItem.giftImage");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("feedBackItem.getBtn");
         _giftBack = ComponentFactory.Instance.creatBitmap("asset.feedback.goodsBack");
         _hasGet = ComponentFactory.Instance.creatBitmap("asset.core.ReceivedImg");
         addChild(_selectedBack);
         _selectedBack.visible = false;
         addChild(_back);
         _back.setFrame(1);
         addChild(_title);
         addChild(_giftBack);
         addChild(_giftImage);
         addChild(_hasGet);
         _hasGet.x = 20;
         _hasGet.y = 85;
         _hasGet.visible = false;
         addChild(_getBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         addEventListener("click",__selectedHandler);
         if(_getBtn)
         {
            _getBtn.addEventListener("click",__clickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         removeEventListener("click",__selectedHandler);
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         var _loc4_:Number = FeedBackManager.instance.data.endTime;
         var _loc3_:Number = FeedBackManager.instance.data.startTime;
         if(_loc2_ >= _loc3_ && _loc2_ <= _loc4_)
         {
            SocketSendManager.instance.sendGetFeedBack(FeedBackManager.instance.data.id,data.id,2);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate"));
         }
      }
      
      private function __selectedHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.dispatchEvent(new FeedBackEvent("FEEDBACK_ITEM_CLICK",this.data ? this : null));
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(!_selected && _selectedBack)
         {
            _selectedBack.visible = false;
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_selectedBack)
         {
            _selectedBack.visible = true;
         }
      }
      
      public function set data(param1:FeedBackItemData) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         setState();
         setTitle();
      }
      
      public function setGiftFrame(param1:int) : void
      {
         _giftImage.setFrame(param1);
      }
      
      private function setState() : void
      {
         if(FeedBackManager.instance.data.userPoint < _data.point)
         {
            _getBtn.enable = false;
         }
         else
         {
            _getBtn.enable = true;
         }
         _isGet = _data.state;
         if(_isGet)
         {
            this.filters = [UIFilter.getGrayFilter()];
            _hasGet.visible = true;
            _getBtn.visible = false;
         }
      }
      
      private function setTitle() : void
      {
         if(_data.point <= 0)
         {
            _title.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.title01");
         }
         else
         {
            _title.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.title02",_data.point);
         }
      }
      
      public function get data() : FeedBackItemData
      {
         return _data;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected)
         {
            _selectedBack.visible = true;
            _back.setFrame(2);
         }
         else
         {
            _selectedBack.visible = false;
            _back.setFrame(1);
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         this.filters = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_hasGet);
         _back = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_giftImage);
         _giftImage = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_giftBack);
         _giftBack = null;
         ObjectUtils.disposeObject(_selectedBack);
         _selectedBack = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}


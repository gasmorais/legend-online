package feedback
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import feedback.datas.FeedBackData;
   import feedback.datas.FeedBackItemData;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.FeedBackManager;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.goods.GoodsInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   
   public class FeedBackFrame extends Frame
   {
      
      private var _giftGroup:SelectedButtonGroup;
      
      private var _back1:Scale9CornerImage;
      
      private var _back2:Scale9CornerImage;
      
      private var _giftHBox:HBox;
      
      private var _giftList:Vector.<FeedBackItem>;
      
      private var _goodsHBox:HBox;
      
      private var _giftTitle:FilterFrameText;
      
      private var _titleBack:Bitmap;
      
      private var _priceBit:ScaleFrameImage;
      
      private var _priceContainer:Sprite;
      
      private var _priceNumBitMap:Bitmap;
      
      private var _remainTimeBit:Bitmap;
      
      private var _remainTimeText:FilterFrameText;
      
      private var _describeText:FilterFrameText;
      
      private var _progressBack:Bitmap;
      
      private var _progress:Progress;
      
      private var _chargeBtn:IconButton;
      
      private var _firstOpen:Boolean = true;
      
      private var _timer:Timer;
      
      private var _effectContainer:Sprite;
      
      public function FeedBackFrame()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("feedBackFrame.back1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("feedBackFrame.back2");
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.feedback.titleBack");
         _priceNumBitMap = ComponentFactory.Instance.creatBitmap("asset.feedback.priceNumber");
         _progressBack = ComponentFactory.Instance.creatBitmap("asset.feedback.progress1");
         _giftTitle = ComponentFactory.Instance.creatComponentByStylename("feedBackFrame.giftTitle");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("feedBackFrame.remainTimeText");
         _remainTimeBit = ComponentFactory.Instance.creatBitmap("asset.feedback.timeDownImage");
         _describeText = ComponentFactory.Instance.creatComponentByStylename("feedBackFrame.describeText");
         _priceBit = ComponentFactory.Instance.creatComponentByStylename("feedBackFrame.priceIcon");
         _chargeBtn = ComponentFactory.Instance.creatComponentByStylename("feedBackFrame.chargeBtn");
         _giftHBox = new HBox();
         _giftHBox.x = 2;
         _giftHBox.y = 4;
         _giftHBox.spacing = -18;
         _goodsHBox = new HBox();
         _goodsHBox.x = 9;
         _goodsHBox.y = 195;
         _goodsHBox.spacing = 24;
         _priceContainer = new Sprite();
         _giftGroup = new SelectedButtonGroup();
         _giftList = new Vector.<FeedBackItem>();
         _progress = ComponentFactory.Instance.creatCustomObject("feedBackFrame.Progress",["asset.feedback.progress2","progress.text"]);
         _timer = new Timer(1000);
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_giftHBox);
         addGoodsBack();
         addToContent(_goodsHBox);
         addToContent(_titleBack);
         addToContent(_giftTitle);
         addToContent(_priceBit);
         _priceBit.setFrame(1);
         addToContent(_priceContainer);
         addToContent(_remainTimeBit);
         addToContent(_remainTimeText);
         addToContent(_describeText);
         addToContent(_progressBack);
         addToContent(_progress);
         _progress.x = 11;
         _progress.y = 339;
         _progress.setData(80,100);
         addToContent(_chargeBtn);
         _remainTimeText.text = DateFormatter.getFullDateString(data.endTime - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         _effectContainer = new Sprite();
         _effectContainer.x = _goodsHBox.x;
         _effectContainer.y = _goodsHBox.y;
         _effectContainer.mouseEnabled = false;
         _effectContainer.mouseChildren = false;
         addToContent(_effectContainer);
      }
      
      private function addGoodsBack() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Bitmap = null;
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.feedback.goodsBack");
            _loc2_.x = 7 + _loc1_ * 76;
            _loc2_.y = 193;
            addToContent(_loc2_);
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("FEEDBACK_ITEM_CLICK",__itemClickHandler);
         FeedBackManager.instance.addEventListener("FEEDBACK_RECEIVE_USERINFO",__updateHandler);
         FeedBackManager.instance.addEventListener("FEEDBACK_DELETE_ACTIVE",__deleteHandler);
         _chargeBtn.addEventListener("click",__chargeHandler);
         addEventListener("response",__frameResponse);
         _timer.addEventListener("timer",__timerHandler);
      }
      
      private function get data() : FeedBackData
      {
         return FeedBackManager.instance.data;
      }
      
      private function __deleteHandler(param1:FeedBackEvent) : void
      {
         dispose();
      }
      
      private function __updateHandler(param1:FeedBackEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         refreshItem();
         if(data.userPoint >= itemList[itemList.length - 1].point)
         {
            _describeText.text = LanguageMgr.GetTranslation("feedback.FeedBackFrame.describeText02");
            _progress.setData(itemList[itemList.length - 1].point,itemList[itemList.length - 1].point);
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < itemList.length)
            {
               if(data.userPoint < itemList[_loc2_].point)
               {
                  _loc1_ = itemList[_loc2_].point - data.userPoint;
                  _describeText.htmlText = LanguageMgr.GetTranslation("feedback.FeedBackFrame.describeText03",_loc1_,itemList[_loc2_].price);
                  break;
               }
               _loc2_++;
            }
            _progress.setData(data.userPoint,itemList[_loc2_].point);
         }
      }
      
      private function refreshItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FeedBackItem = null;
         var _loc3_:int = 0;
         if(!itemList || itemList.length < 7)
         {
            return;
         }
         if(_firstOpen)
         {
            _loc2_ = 0;
            while(_loc2_ < itemList.length)
            {
               _loc1_ = new FeedBackItem();
               _loc1_.data = itemList[_loc2_] as FeedBackItemData;
               _loc1_.setGiftFrame(_loc2_ + 1);
               _giftList.push(_loc1_);
               _giftHBox.addChild(_loc1_);
               _giftGroup.addSelectItem(_loc1_);
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < _giftList.length)
            {
               if(!_giftList[_loc2_].data.state)
               {
                  _giftGroup.selectIndex = _loc2_;
                  refreshGoods(_giftList[_loc2_]);
                  break;
               }
               if(_loc2_ == _giftList.length - 1)
               {
                  _giftGroup.selectIndex = _loc2_;
                  refreshGoods(_giftList[_loc2_]);
               }
               _loc2_++;
            }
            _firstOpen = false;
            _timer.start();
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _giftList.length)
            {
               _giftList[_loc3_].data = itemList[_loc3_];
               _loc3_++;
            }
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(data.endTime > PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond)
         {
            _remainTimeText.text = DateFormatter.getFullDateString(data.endTime - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         }
         else
         {
            FeedBackManager.instance.switchBtn1 = false;
            TopToolsBar.instance.show();
            dispose();
         }
      }
      
      private function __itemClickHandler(param1:FeedBackEvent) : void
      {
         refreshGoods(param1.data as FeedBackItem);
      }
      
      private function refreshGoods(param1:FeedBackItem) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc5_:MovieImage = null;
         if(!param1)
         {
            return;
         }
         ObjectUtils.disposeAllChildren(_effectContainer);
         _goodsHBox.disposeAllChildren();
         _loc3_ = 1;
         while(_loc3_ <= 8)
         {
            if(param1.data.getGoodsIdByIndex(_loc3_) != 0)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = param1.data.getGoodsIdByIndex(_loc3_);
               _loc4_.count = param1.data.getGoodsCountByIndex(_loc3_);
               _loc2_.data = _loc4_;
               _goodsHBox.addChild(_loc2_);
               if(_loc4_.templateInfo && _loc4_.templateInfo.Profile >= 5)
               {
                  _loc5_ = ComponentFactory.Instance.creatComponentByStylename("feedback.LightEffect");
                  _loc5_.mouseEnabled = false;
                  _loc5_.mouseChildren = false;
                  _loc5_.x = _loc2_.x + 26;
                  _loc5_.y = _loc2_.y - 26;
                  _effectContainer.addChild(_loc5_);
               }
            }
            _loc3_++;
         }
         _giftTitle.text = LanguageMgr.GetTranslation("feedback.FeedBackFrame.giftTitle",param1.data.price);
         setPriceNumberView(param1.data.price);
      }
      
      private function __chargeHandler(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      public function get itemList() : Array
      {
         return FeedBackManager.instance.list;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("FEEDBACK_ITEM_CLICK",__itemClickHandler);
         FeedBackManager.instance.removeEventListener("FEEDBACK_RECEIVE_USERINFO",__updateHandler);
         if(_chargeBtn)
         {
            _chargeBtn.removeEventListener("click",__chargeHandler);
         }
         removeEventListener("response",__frameResponse);
         if(_timer)
         {
            _timer.removeEventListener("timer",__timerHandler);
         }
         FeedBackManager.instance.removeEventListener("FEEDBACK_DELETE_ACTIVE",__deleteHandler);
      }
      
      private function setPriceNumberView(param1:int = 0) : void
      {
         NumberViewUtils.getNumberView(param1,_priceContainer,_priceNumBitMap.bitmapData,22,26,16,22,"0123456789");
         if(param1 < 100)
         {
            _priceContainer.x = 581;
            _priceContainer.y = 178;
            _priceBit.setFrame(2);
            _priceBit.x = 525;
            _priceBit.y = 150;
         }
         else if(param1 >= 100 && param1 < 1000)
         {
            _priceContainer.x = 579;
            _priceContainer.y = 183;
            _priceBit.setFrame(3);
            _priceBit.x = 515;
            _priceBit.y = 145;
         }
         else if(param1 >= 1000 && param1 < 10000)
         {
            _priceContainer.x = 562;
            _priceContainer.y = 178;
            _priceBit.setFrame(3);
            _priceBit.x = 503;
            _priceBit.y = 140;
         }
         else
         {
            _priceContainer.x = 552;
            _priceContainer.y = 179;
            _priceBit.setFrame(3);
            _priceBit.x = 503;
            _priceBit.y = 140;
         }
         _priceContainer.rotation = -10;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("feedback.FeedBackFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function cleanGiftLift() : void
      {
         while(_giftList.length > 0)
         {
            (_giftList.pop() as FeedBackItem).dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
         cleanGiftLift();
         _giftList = null;
         ObjectUtils.disposeObject(_giftGroup);
         _giftGroup = null;
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_giftHBox);
         _giftHBox = null;
         ObjectUtils.disposeObject(_giftTitle);
         _giftTitle = null;
         ObjectUtils.disposeObject(_goodsHBox);
         _goodsHBox = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_priceBit);
         _priceBit = null;
         ObjectUtils.disposeObject(_priceContainer);
         _priceContainer = null;
         ObjectUtils.disposeObject(_priceNumBitMap);
         _priceNumBitMap = null;
         ObjectUtils.disposeObject(_remainTimeBit);
         _remainTimeBit = null;
         ObjectUtils.disposeObject(_remainTimeText);
         _remainTimeText = null;
         ObjectUtils.disposeObject(_describeText);
         _describeText = null;
         ObjectUtils.disposeObject(_progressBack);
         _progressBack = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_chargeBtn);
         _chargeBtn = null;
         ObjectUtils.disposeAllChildren(_effectContainer);
         ObjectUtils.disposeObject(_effectContainer);
         _effectContainer = null;
         ObjectUtils.disposeAllChildren(this);
         KeyBoardRegister.instance.keyEnable = true;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


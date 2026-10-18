package blackjack
{
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.blackjack.BlackjackExchangeInfo;
   import mvc.module.blackjack.BlackjackTempInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.BlackjackManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class BlackjackExchangeView extends Component
   {
      
      private var _exchangeNote:Bitmap;
      
      private var _mulNote1:MutipleImage;
      
      private var _hBox:HBox;
      
      private var _excCurBmp:Bitmap;
      
      private var _excNeedBmp:Bitmap;
      
      private var _excCurTxt:FilterFrameText;
      
      private var _excNeedTxt:FilterFrameText;
      
      private var _excBtn:IconButton;
      
      private var _mulNote2:MutipleImage;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _numberAsset:BitmapData;
      
      private var _exchangeTemp:BlackjackExchangeInfo;
      
      private var _container1:Component;
      
      private var _container2:Component;
      
      public function BlackjackExchangeView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc8_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc5_:int = 0;
         var _loc2_:BlackjackTempInfo = null;
         _exchangeNote = ComponentFactory.Instance.creatBitmap("asset.blackjack.exchangeNote");
         _mulNote1 = ComponentFactory.Instance.creatComponentByStylename("blackjack.ExchangeMulNote1");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("blackjack.ExchangeHBox");
         _excCurBmp = ComponentFactory.Instance.creatBitmap("asset.blackjack.excCurrentTxt");
         _excNeedBmp = ComponentFactory.Instance.creatBitmap("asset.blackjack.excNeedTxt");
         _excCurTxt = ComponentFactory.Instance.creatComponentByStylename("blackjack.excCurTxt");
         _excNeedTxt = ComponentFactory.Instance.creatComponentByStylename("blackjack.excNeedTxt");
         _excBtn = ComponentFactory.Instance.creatComponentByStylename("blackjack.exchangeBtn");
         _mulNote2 = ComponentFactory.Instance.creatComponentByStylename("blackjack.ExchangeMulNote2");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("blackjack.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("blackjack.Vbox");
         _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.blackjack.exchangeNum");
         _container1 = new Component();
         _container1.x = 162;
         _container1.y = 22;
         _container2 = new Component();
         _container2.x = 162;
         _container2.y = 50;
         addChild(_exchangeNote);
         addChild(_container1);
         addChild(_container2);
         addChild(_mulNote1);
         addChild(_hBox);
         addChild(_excCurBmp);
         addChild(_excNeedBmp);
         addChild(_excCurTxt);
         addChild(_excNeedTxt);
         addChild(_excBtn);
         addChild(_mulNote2);
         addChild(_scrolPanel);
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vBox,true);
         _scrolPanel.invalidateViewport();
         var _loc9_:Dictionary = BlackjackManager.instance.blackExchangeDic;
         for each(var _loc7_:BlackjackExchangeInfo in _loc9_)
         {
            _exchangeTemp = _loc7_;
         }
         if(!_exchangeTemp)
         {
            return;
         }
         var _loc1_:Array = _exchangeTemp.rewardItems.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc8_ = ComponentFactory.Instance.creatCustomObject("blackjack.iconRewardView");
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc1_[_loc5_].split(",")[0];
            _loc6_.count = _loc1_[_loc5_].split(",")[1];
            _loc8_.data = _loc6_;
            _hBox.addChild(_loc8_);
            _loc5_++;
         }
         _excNeedTxt.text = String(_exchangeTemp.score);
         _excBtn.tipData = LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.exchangeBtnTip");
         _loc9_ = BlackjackManager.instance.blackTempDic;
         var _loc13_:int = 0;
         var _loc12_:Dictionary = _loc9_;
         for each(var _loc3_:BlackjackTempInfo in _loc12_)
         {
            _loc2_ = _loc3_;
         }
         var _loc4_:Number = Number((_loc2_.winScoreReward / _loc2_.generalScoreReward).toFixed(1));
         NumberViewUtils.refreshValue(_loc4_,_container1,_numberAsset,15,20,10,15,"0123456789.");
         _loc4_ = 1;
         NumberViewUtils.refreshValue(_loc4_,_container2,_numberAsset,15,20,10,15,"0123456789.");
      }
      
      private function addEvent() : void
      {
         _excBtn.addEventListener("click",__excClickHandler);
         NotificationManager.instance.addEventListener("BLACKJACK_EXCHANGE_RECORD",__exchangeMsgHandler);
         __exchangeMsgHandler(null);
      }
      
      private function removeEvent() : void
      {
         _excBtn.removeEventListener("click",__excClickHandler);
         NotificationManager.instance.removeEventListener("BLACKJACK_EXCHANGE_RECORD",__exchangeMsgHandler);
      }
      
      public function set curPointTxt(param1:int) : void
      {
         _excCurTxt.text = String(param1);
      }
      
      public function __exchangeMsgHandler(param1:Event) : void
      {
         var _loc3_:BlackjackExchangeItem = null;
         var _loc5_:int = 0;
         var _loc4_:ChatData = null;
         _vBox.disposeAllChildren();
         _vBox.beginChanges();
         var _loc2_:Array = BlackjackManager.instance.blackjackMsgArr;
         if(_loc2_.length)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc3_ = new BlackjackExchangeItem();
               _loc4_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc4_.channel = 103;
               _loc4_.msg = _loc2_[_loc5_];
               _loc4_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc4_);
               _loc3_.data = _loc4_;
               _vBox.addChildAt(_loc3_,0);
               _loc5_++;
            }
         }
         _vBox.commitChanges();
         if(param1 == null)
         {
            _scrolPanel.invalidateViewport(true);
         }
         else
         {
            _scrolPanel.invalidateViewport();
         }
      }
      
      private function __excClickHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(!ConfigManager.info.BLACKJACK || playerModel.nowDate && ConfigManager.info.BLACKJACK_BEGIN_DATE && ConfigManager.info.BLACKJACK_END_DATE && (ConfigManager.info.BLACKJACK_BEGIN_DATE.time > playerModel.nowDate || playerModel.nowDate > ConfigManager.info.BLACKJACK_END_DATE.time))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.ActivityManager.command02"));
            return;
         }
         BlackjackManager.instance.OperateBlackjack(5,_exchangeTemp.id);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_exchangeNote);
         _exchangeNote = null;
         ObjectUtils.disposeObject(_mulNote1);
         _mulNote1 = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_excCurBmp);
         _excCurBmp = null;
         ObjectUtils.disposeObject(_excNeedBmp);
         _excNeedBmp = null;
         ObjectUtils.disposeObject(_excCurTxt);
         _excCurTxt = null;
         ObjectUtils.disposeObject(_excNeedTxt);
         _excNeedTxt = null;
         ObjectUtils.disposeObject(_excBtn);
         _excBtn = null;
         ObjectUtils.disposeObject(_mulNote2);
         _mulNote2 = null;
         ObjectUtils.disposeObject(_scrolPanel);
         _scrolPanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         ObjectUtils.disposeObject(_container1);
         _container1 = null;
         ObjectUtils.disposeObject(_container2);
         _container2 = null;
         super.dispose();
      }
   }
}


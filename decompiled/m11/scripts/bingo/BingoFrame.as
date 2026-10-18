package bingo
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.bingo.BingoBuyInfoMsg;
   import com.road.yishi.proto.bingo.BingoResultDataMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.BingoManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.NumberViewUtils;
   
   public class BingoFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _bg:DisplayObject;
      
      private var _movieView:BingoBallMovieView;
      
      private var _shopBtn:IconButton;
      
      private var _numberBtn:BaseButton;
      
      private var _numView1:BingoNumView;
      
      private var _numView2:BingoNumView;
      
      private var _numView3:BingoNumView;
      
      private var _numView4:BingoNumView;
      
      private var _grayBg:Image;
      
      private var _firstBmp:Image;
      
      private var _secondBmp:Image;
      
      private var _thirdBmp:Image;
      
      private var _cellbg1:Image;
      
      private var _cellbg2:Image;
      
      private var _cellbg3:Image;
      
      private var _jiangchifanli:Bitmap;
      
      private var _jiangchi:Bitmap;
      
      private var _zhongjiangkazu:Bitmap;
      
      private var _detailBtn:IconButton;
      
      private var _resultMsg:BingoResultDataMsg;
      
      private var _buyInfo:BingoBuyInfoMsg;
      
      private var _cardContain1:Component;
      
      private var _cardContain2:Component;
      
      private var _cardContain3:Component;
      
      private var _cardAsset:BitmapData;
      
      private var _poolContain:Component;
      
      private var _poolAsset:BitmapData;
      
      private var _movieImg:MovieImage;
      
      private var _additionNum:FilterFrameText;
      
      private var _calendarContain:Component;
      
      private var _calendarAsset:BitmapData;
      
      private var _redStone1:Image;
      
      private var _redStone2:Image;
      
      private var _xingyunshuzi1:Image;
      
      private var _helpBtn:BaseButton;
      
      private var _poolTip:StripView;
      
      private var _rankTip1:StripView;
      
      private var _rankTip2:StripView;
      
      private var _rankTip3:StripView;
      
      private var _isChange:Boolean = false;
      
      private var _isPlaying:Boolean = false;
      
      public function BingoFrame()
      {
         super();
         initView();
         addEvent();
         BingoManager.instance.OperateBingo(0);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,989,633);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc4_:Array = null;
         var _loc3_:int = 0;
         titleText = LanguageMgr.GetTranslation("bingo.BingoFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("bingo.BingoFrameBack");
         _bg = ComponentFactory.Instance.creatBitmap("asset.bingo.Bg");
         _movieView = ComponentFactory.Instance.creatCustomObject("bingo.BingoBallMovieView");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("bingo.shopBtn");
         _detailBtn = ComponentFactory.Instance.creatComponentByStylename("bingo.zhongjiangDetail");
         _numberBtn = ComponentFactory.Instance.creatComponentByStylename("bingo.numberBtn");
         _numView1 = ComponentFactory.Instance.creatCustomObject("bingo.BingoNumView1");
         _numView2 = ComponentFactory.Instance.creatCustomObject("bingo.BingoNumView2");
         _numView3 = ComponentFactory.Instance.creatCustomObject("bingo.BingoNumView3");
         _numView4 = ComponentFactory.Instance.creatCustomObject("bingo.BingoNumView4");
         _grayBg = ComponentFactory.Instance.creatComponentByStylename("bingo.grayBg");
         _firstBmp = ComponentFactory.Instance.creatComponentByStylename("bingo.firstBmp1");
         _secondBmp = ComponentFactory.Instance.creatComponentByStylename("bingo.secondBmp1");
         _thirdBmp = ComponentFactory.Instance.creatComponentByStylename("bingo.thirdBmp1");
         _cellbg1 = ComponentFactory.Instance.creatComponentByStylename("bingo.cellbg1");
         _cellbg2 = ComponentFactory.Instance.creatComponentByStylename("bingo.cellbg2");
         _cellbg3 = ComponentFactory.Instance.creatComponentByStylename("bingo.cellbg3");
         _redStone1 = ComponentFactory.Instance.creatComponentByStylename("bingo.redStone1");
         _redStone2 = ComponentFactory.Instance.creatComponentByStylename("bingo.redStone2");
         _xingyunshuzi1 = ComponentFactory.Instance.creatComponentByStylename("bingo.xingyunshuzi1");
         _jiangchifanli = ComponentFactory.Instance.creatBitmap("asset.bingo.jiangchifanli");
         _jiangchi = ComponentFactory.Instance.creatBitmap("asset.bingo.jiangchi");
         _zhongjiangkazu = ComponentFactory.Instance.creatBitmap("asset.bingo.zhongjiangkazu");
         _cardAsset = ComponentFactory.Instance.creatBitmapData("asset.bingo.rankNumAsset");
         _poolAsset = ComponentFactory.Instance.creatBitmapData("asset.bingo.poolNumAsset");
         _movieImg = ComponentFactory.Instance.creatComponentByStylename("bingo.resultMovie");
         _additionNum = ComponentFactory.Instance.creatComponentByStylename("bingo.additionNumTextStyle");
         _calendarAsset = ComponentFactory.Instance.creatBitmapData("asset.bingo.calendarAsset");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("bingo.pvpShopHelpBtn");
         _poolTip = ComponentFactory.Instance.creatCustomObject("bingo.poolTip.StripView");
         _rankTip1 = ComponentFactory.Instance.creatCustomObject("bingo.rankTip.StripView1");
         _rankTip2 = ComponentFactory.Instance.creatCustomObject("bingo.rankTip.StripView2");
         _rankTip3 = ComponentFactory.Instance.creatCustomObject("bingo.rankTip.StripView3");
         _cardContain1 = new Component();
         _cardContain2 = new Component();
         _cardContain3 = new Component();
         _poolContain = new Component();
         _calendarContain = new Component();
         addToContent(_back);
         addToContent(_bg);
         addToContent(_movieView);
         addToContent(_shopBtn);
         addToContent(_detailBtn);
         addToContent(_numberBtn);
         addToContent(_numView1);
         _numView1.index = 0;
         addToContent(_numView2);
         _numView2.index = 1;
         addToContent(_numView3);
         _numView3.index = 2;
         addToContent(_numView4);
         _numView4.index = 3;
         addToContent(_grayBg);
         addToContent(_firstBmp);
         addToContent(_secondBmp);
         addToContent(_thirdBmp);
         addToContent(_cellbg1);
         addToContent(_cellbg2);
         addToContent(_cellbg3);
         addToContent(_redStone1);
         addToContent(_redStone2);
         addToContent(_xingyunshuzi1);
         addToContent(_jiangchifanli);
         addToContent(_jiangchi);
         addToContent(_zhongjiangkazu);
         addToContent(_cardContain1);
         addToContent(_cardContain2);
         addToContent(_cardContain3);
         addToContent(_poolContain);
         addToContent(_calendarContain);
         addToContent(_additionNum);
         addToContent(_helpBtn);
         addToContent(_poolTip);
         addToContent(_rankTip1);
         addToContent(_rankTip2);
         addToContent(_rankTip3);
         _firstBmp.visible = false;
         _secondBmp.visible = false;
         _thirdBmp.visible = false;
         _cellbg1.visible = false;
         _cellbg2.visible = false;
         _cellbg3.visible = false;
         _rankTip1.visible = false;
         _rankTip2.visible = false;
         _rankTip3.visible = false;
         _grayBg.buttonMode = true;
         _movieImg.mouseChildren = _movieImg.mouseEnabled = false;
         _movieImg.movie.addFrameScript(_movieImg.movie.totalFrames - 1,onFrameEnd);
         _movieImg.movie.gotoAndStop(1);
         _rankTip1.setHitArea(0,0,46,46);
         _rankTip2.setHitArea(0,0,46,46);
         _rankTip3.setHitArea(0,0,46,46);
         _poolTip.setHitArea(0,0,100,25);
         var _loc1_:String = "";
         var _loc2_:Array = ConfigInfoManager.instance.getBingoPondAddition();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_].split(",");
            _loc1_ += LanguageMgr.GetTranslation("bingo.BingoFrame.poolTip.tipData",_loc3_ + 1,_loc4_[0],_loc4_[1]) + "\n";
            _loc3_++;
         }
         _poolTip.tipData = _loc1_;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _shopBtn.addEventListener("click",__shopBtnHandler);
         _detailBtn.addEventListener("click",__detailBtnHandler);
         _numberBtn.addEventListener("click",__numberBtnHandler);
         _grayBg.addEventListener("click",__changeBtnHandler);
         _helpBtn.addEventListener("click",__helpHandler);
         NotificationManager.instance.addEventListener("BALL_TEMP_UPDATE",__bingoHandler);
         NotificationManager.instance.addEventListener("BALL_BUY",__buyHandler);
         NotificationManager.instance.addEventListener("BALL_WIN_MOVIE",__winHandler);
         NotificationManager.instance.addEventListener("BALL_START",__ballStartHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _shopBtn.removeEventListener("click",__shopBtnHandler);
         _detailBtn.removeEventListener("click",__detailBtnHandler);
         _numberBtn.removeEventListener("click",__numberBtnHandler);
         _grayBg.removeEventListener("click",__changeBtnHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
         NotificationManager.instance.removeEventListener("BALL_TEMP_UPDATE",__bingoHandler);
         NotificationManager.instance.removeEventListener("BALL_BUY",__buyHandler);
         NotificationManager.instance.removeEventListener("BALL_WIN_MOVIE",__winHandler);
         NotificationManager.instance.removeEventListener("BALL_START",__ballStartHandler);
      }
      
      private function __shopBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",1005);
      }
      
      private function __detailBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("bingo",2);
      }
      
      private function __numberBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("bingo",1);
      }
      
      private function __changeBtnHandler(param1:MouseEvent) : void
      {
         _buyInfo = BingoManager.instance.buyInfo;
         if(_buyInfo && _buyInfo.detail.length < 3)
         {
            return;
         }
         _isChange = !_isChange;
         refreshView();
      }
      
      private function __bingoHandler(param1:NotificationEvent) : void
      {
         var _loc3_:BingoResultDataMsg = null;
         var _loc2_:int = int(BingoManager.instance.op);
         if(_loc2_ == 0)
         {
            _loc3_ = BingoManager.instance.resultMsg;
            _movieView.constructBalls(_loc3_);
         }
         refreshView();
      }
      
      private function __buyHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function __ballStartHandler(param1:NotificationEvent) : void
      {
         refreshRank();
      }
      
      private function refreshView() : void
      {
         _buyInfo = BingoManager.instance.buyInfo;
         if(_buyInfo && _buyInfo.detail[0])
         {
            _numView1.data = _buyInfo.detail[0];
         }
         if(_buyInfo && _buyInfo.detail[1])
         {
            _numView2.data = _buyInfo.detail[1];
         }
         if(_buyInfo && _buyInfo.detail[2])
         {
            _numView3.data = _buyInfo.detail[2];
         }
         if(_buyInfo && _buyInfo.detail[3])
         {
            _numView4.data = _buyInfo.detail[3];
         }
         if(!_isChange)
         {
            _numView1.x = 138;
            _numView1.y = 119;
            _numView1.scaleX = 1;
            _numView1.scaleY = 1;
            _numView2.x = 459;
            _numView2.y = 119;
            _numView2.scaleX = 1;
            _numView2.scaleY = 1;
            _numView3.x = 816;
            _numView3.y = 164;
            _numView3.scaleX = 0.4;
            _numView3.scaleY = 0.4;
            _numView4.x = 816;
            _numView4.y = 336;
            _numView4.scaleX = 0.4;
            _numView4.scaleY = 0.4;
         }
         else
         {
            _numView1.x = 816;
            _numView1.y = 164;
            _numView1.scaleX = 0.4;
            _numView1.scaleY = 0.4;
            _numView2.x = 816;
            _numView2.y = 336;
            _numView2.scaleX = 0.4;
            _numView2.scaleY = 0.4;
            _numView3.x = 138;
            _numView3.y = 119;
            _numView3.scaleX = 1;
            _numView3.scaleY = 1;
            _numView4.x = 459;
            _numView4.y = 119;
            _numView4.scaleX = 1;
            _numView4.scaleY = 1;
         }
         refreshRank();
      }
      
      private function refreshRank() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:Array = null;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _resultMsg = BingoManager.instance.resultMsg;
         if(_resultMsg && _resultMsg.rankData[0] && _cardContain1.displayWidth == 0)
         {
            _loc3_ = int(_resultMsg.rankData[0].card_Id[0]);
            NumberViewUtils.refreshValue(_loc3_,_cardContain1,_cardAsset,21,29,18,21,"0123456789");
            _cardContain1.x = _cellbg1.x + (_cellbg1.width - _cardContain1.displayWidth) / 2 - 4;
            _cardContain1.y = 327;
            _cardContain1.scaleX = 0.8;
            _cardContain1.scaleY = 0.8;
            _firstBmp.visible = true;
            _cellbg1.visible = true;
            if(_resultMsg.rankData[0].card_Id.length > 1)
            {
               _rankTip1.visible = true;
            }
            _rankTip1.tipData = LanguageMgr.GetTranslation("bingo.BingoFrame.rankTips",_resultMsg.rankData[0].card_Id.toString());
         }
         if(_resultMsg && _resultMsg.rankData[1] && _cardContain2.displayWidth == 0)
         {
            _loc3_ = int(_resultMsg.rankData[1].card_Id[0]);
            NumberViewUtils.refreshValue(_loc3_,_cardContain2,_cardAsset,21,29,18,21,"0123456789");
            _cardContain2.x = _cellbg2.x + (_cellbg2.width - _cardContain2.displayWidth) / 2 - 4;
            _cardContain2.y = 379;
            _cardContain2.scaleX = 0.8;
            _cardContain2.scaleY = 0.8;
            _secondBmp.visible = true;
            _cellbg2.visible = true;
            if(_resultMsg.rankData[1].card_Id.length > 1)
            {
               _rankTip2.visible = true;
            }
            _rankTip2.tipData = LanguageMgr.GetTranslation("bingo.BingoFrame.rankTips",_resultMsg.rankData[1].card_Id.toString());
         }
         if(_resultMsg && _resultMsg.rankData[2] && _cardContain3.displayWidth == 0)
         {
            _loc3_ = int(_resultMsg.rankData[2].card_Id[0]);
            NumberViewUtils.refreshValue(_loc3_,_cardContain3,_cardAsset,21,29,18,21,"0123456789");
            _cardContain3.x = _cellbg3.x + (_cellbg3.width - _cardContain3.displayWidth) / 2 - 4;
            _cardContain3.y = 430;
            _cardContain3.scaleX = 0.8;
            _cardContain3.scaleY = 0.8;
            _thirdBmp.visible = true;
            _cellbg3.visible = true;
            if(_resultMsg.rankData[2].card_Id.length > 1)
            {
               _rankTip3.visible = true;
            }
            _rankTip3.tipData = LanguageMgr.GetTranslation("bingo.BingoFrame.rankTips",_resultMsg.rankData[2].card_Id.toString());
         }
         if(BingoManager.instance)
         {
            _loc1_ = int(ConfigInfoManager.instance.getBingoPondInit());
            _loc3_ = BingoManager.instance.currentPond + _loc1_;
            NumberViewUtils.refreshValue(_loc3_,_poolContain,_poolAsset,19,27,17,19,"0123456789");
            _poolContain.x = (131 - _poolContain.displayWidth) / 2;
            _poolContain.y = 222;
            _loc2_ = ConfigInfoManager.instance.getBingoPondAddition();
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc6_ = _loc2_[_loc4_].split(",");
               if(BingoManager.instance.currentPond >= _loc6_[0])
               {
                  _loc7_ += int(_loc6_[1]);
               }
               _loc4_++;
            }
            _additionNum.text = "+" + _loc7_;
            if(BingoManager.instance.eventDate.length > 0)
            {
               _loc5_ = int(BingoManager.instance.eventDate.split("-")[2]);
               NumberViewUtils.refreshValue(_loc5_,_calendarContain,_calendarAsset,14,19,13,14,"0123456789");
               _calendarContain.x = (97 - _calendarContain.displayWidth) / 2;
               _calendarContain.y = 33;
            }
         }
      }
      
      private function onFrameEnd() : void
      {
         _movieImg.movie.stop();
         _movieImg.movie.gotoAndStop(1);
         if(_movieImg.parent)
         {
            removeChild(_movieImg);
         }
         _isPlaying = false;
      }
      
      private function __winHandler(param1:NotificationEvent) : void
      {
         if(!_movieImg)
         {
            return;
         }
         if(_isPlaying)
         {
            return;
         }
         if(!_movieImg.parent)
         {
            addChild(_movieImg);
         }
         _movieImg.movie.play();
         _isPlaying = true;
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("bingo.BingoHelpFrame");
         _loc2_["show"]();
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
         ObjectUtils.disposeObject(_movieView);
         _movieView = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_numberBtn);
         _numberBtn = null;
         ObjectUtils.disposeObject(_numView1);
         _numView1 = null;
         ObjectUtils.disposeObject(_numView2);
         _numView2 = null;
         ObjectUtils.disposeObject(_numView3);
         _numView3 = null;
         ObjectUtils.disposeObject(_numView4);
         _numView4 = null;
         ObjectUtils.disposeObject(_grayBg);
         _grayBg = null;
         ObjectUtils.disposeObject(_firstBmp);
         _firstBmp = null;
         ObjectUtils.disposeObject(_secondBmp);
         _secondBmp = null;
         ObjectUtils.disposeObject(_thirdBmp);
         _thirdBmp = null;
         ObjectUtils.disposeObject(_cellbg1);
         _cellbg1 = null;
         ObjectUtils.disposeObject(_cellbg2);
         _cellbg2 = null;
         ObjectUtils.disposeObject(_cellbg3);
         _cellbg3 = null;
         ObjectUtils.disposeObject(_jiangchifanli);
         _jiangchifanli = null;
         ObjectUtils.disposeObject(_jiangchi);
         _jiangchi = null;
         ObjectUtils.disposeObject(_zhongjiangkazu);
         _zhongjiangkazu = null;
         ObjectUtils.disposeObject(_detailBtn);
         _detailBtn = null;
         ObjectUtils.disposeObject(_cardContain1);
         _cardContain1 = null;
         ObjectUtils.disposeObject(_cardContain2);
         _cardContain2 = null;
         ObjectUtils.disposeObject(_cardContain3);
         _cardContain3 = null;
         ObjectUtils.disposeObject(_cardAsset);
         _cardAsset = null;
         ObjectUtils.disposeObject(_poolContain);
         _poolContain = null;
         ObjectUtils.disposeObject(_poolAsset);
         _poolAsset = null;
         ObjectUtils.disposeObject(_movieImg);
         _movieImg = null;
         ObjectUtils.disposeObject(_additionNum);
         _additionNum = null;
         ObjectUtils.disposeObject(_calendarContain);
         _calendarContain = null;
         ObjectUtils.disposeObject(_calendarAsset);
         _calendarAsset = null;
         ObjectUtils.disposeObject(_redStone1);
         _redStone1 = null;
         ObjectUtils.disposeObject(_redStone2);
         _redStone2 = null;
         ObjectUtils.disposeObject(_xingyunshuzi1);
         _xingyunshuzi1 = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_poolTip);
         _poolTip = null;
         ObjectUtils.disposeObject(_rankTip1);
         _rankTip1 = null;
         ObjectUtils.disposeObject(_rankTip2);
         _rankTip2 = null;
         ObjectUtils.disposeObject(_rankTip3);
         _rankTip3 = null;
         _resultMsg = null;
         _buyInfo = null;
         super.dispose();
      }
   }
}


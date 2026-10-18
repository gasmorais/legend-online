package poker
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.pet.TablePotDivisionListMsg;
   import com.road.yishi.proto.pet.TablePotDivisionMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class PokerPrizesFrame extends Frame
   {
      
      private var _bg:DisplayObject;
      
      private var _titleBg:MutipleImage;
      
      private var _titleName:FilterFrameText;
      
      private var _titleCash:FilterFrameText;
      
      private var _titleScore:FilterFrameText;
      
      private var _patternsScore:FilterFrameText;
      
      private var _listMsg:TablePotDivisionListMsg;
      
      private var _vBox:VBox;
      
      private var _itemList:Array = [];
      
      private var _timer:Timer;
      
      private var _timeNumber:int = 5;
      
      private var _splitLine:Bitmap;
      
      private var _confirmBtn:BaseButton;
      
      private var _downTxt:FilterFrameText;
      
      public function PokerPrizesFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,490,700);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc1_:PokerPrizesItem = null;
         var _loc2_:int = 0;
         titleText = LanguageMgr.GetTranslation("poker.PokerPrizesFrame.titleTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("poker.PokerPrizesBackground");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("poker.PokerTitleBg");
         _titleName = ComponentFactory.Instance.creatComponentByStylename("poker.PrizesTitleNameTxt");
         _titleCash = ComponentFactory.Instance.creatComponentByStylename("poker.PrizesTitleCashTxt");
         _titleScore = ComponentFactory.Instance.creatComponentByStylename("poker.PrizesTitleScoreTxt");
         _patternsScore = ComponentFactory.Instance.creatComponentByStylename("poker.PrizesTitlePatternsTxt");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("poker.PrizesVBox");
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.poker.SplitLine");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("poker.PokerPrizesConfirmBtn");
         _downTxt = ComponentFactory.Instance.creatComponentByStylename("poker.PrizesConfirmDownTxt");
         addToContent(_bg);
         addToContent(_titleBg);
         addToContent(_titleName);
         addToContent(_titleCash);
         addToContent(_titleScore);
         addToContent(_patternsScore);
         addToContent(_vBox);
         addToContent(_splitLine);
         addToContent(_confirmBtn);
         addToContent(_downTxt);
         _titleName.text = LanguageMgr.GetTranslation("poker.PokerLayer.NameTxt");
         _titleCash.text = LanguageMgr.GetTranslation("poker.PokerLayer.CashTxt");
         _titleScore.text = LanguageMgr.GetTranslation("poker.PokerLayer.ScoreTxt");
         _patternsScore.text = LanguageMgr.GetTranslation("poker.PokerLayer.PatternsTxt");
         _downTxt.text = "(" + _timeNumber + ")";
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new PokerPrizesItem();
            _vBox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _timer = new Timer(1000,_timeNumber);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _confirmBtn.addEventListener("click",__confirmHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _confirmBtn.removeEventListener("click",__confirmHandler);
      }
      
      private function refreshView() : void
      {
         var _loc1_:PokerPrizesItem = null;
         var _loc3_:TablePotDivisionMsg = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_] as PokerPrizesItem;
            _loc3_ = _listMsg.potDivision[_loc2_] as TablePotDivisionMsg;
            if(_loc3_)
            {
               _loc1_.data = _loc3_;
            }
            _loc2_++;
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         _timeNumber = _timeNumber - 1;
         _downTxt.text = "(" + _timeNumber + ")";
         if(_timeNumber <= 0)
         {
            _timer.stop();
            dispose();
         }
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
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      public function show(param1:Object = null) : void
      {
         _listMsg = param1 as TablePotDivisionListMsg;
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         refreshView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_titleName);
         _titleName = null;
         ObjectUtils.disposeObject(_titleCash);
         _titleCash = null;
         ObjectUtils.disposeObject(_titleScore);
         _titleScore = null;
         ObjectUtils.disposeObject(_patternsScore);
         _patternsScore = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_splitLine);
         _splitLine = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_downTxt);
         _downTxt = null;
         if(_itemList)
         {
            while(_itemList.length)
            {
               ObjectUtils.disposeObject(_itemList.pop());
            }
            _itemList = null;
         }
         if(_timer)
         {
            _timer.removeEventListener("timer",__timerHandler);
            _timer.stop();
            _timer = null;
         }
         _listMsg = null;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("POKER_LEAVE"));
         super.dispose();
      }
   }
}


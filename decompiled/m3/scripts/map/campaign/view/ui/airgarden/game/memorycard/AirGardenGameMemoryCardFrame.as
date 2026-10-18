package map.campaign.view.ui.airgarden.game.memorycard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.AirGardenGameEvent;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.AirGardenMemoryCardManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.airgarden.game.MemoryCardData;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.CarnivalPlayGroundTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   import yishi.utils.HashMap;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class AirGardenGameMemoryCardFrame extends Frame
   {
      
      private var _btnUse1:IconButton;
      
      private var _btnUse2:IconButton;
      
      private var _txtMemoryCardScore:FilterFrameText;
      
      private var _txtMemoryCardTime:FilterFrameText;
      
      private var _txtMemoryCardGoods1Count:FilterFrameText;
      
      private var _txtMemoryCardGoods2Count:FilterFrameText;
      
      private var _txtMemoryCardGoods1Name:FilterFrameText;
      
      private var _txtMemoryCardGoods2Name:FilterFrameText;
      
      private var _memoryCardBg:MutipleImage;
      
      private var _targetScoreTxt:FilterFrameText;
      
      private var cardSp:Sprite;
      
      private var _btnStart:IconButton;
      
      private var ROW:int = 4;
      
      private var COLOME:int = 6;
      
      private var cards:HashMap;
      
      private var _combNumRes:BitmapData;
      
      private var _scoreNumRes:BitmapData;
      
      private var _deleMc:SimpleMovie;
      
      private var _timer:Timer;
      
      private var tickTime:int = 0;
      
      public function AirGardenGameMemoryCardFrame()
      {
         super();
         _timer = new Timer(1000);
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("AirGardenGame.memorycard.title");
         _btnUse1 = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.btnUse1");
         _btnUse2 = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.btnUse2");
         _txtMemoryCardScore = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.txtMemoryCardScore");
         _txtMemoryCardTime = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.txtMemoryCardTime");
         _txtMemoryCardGoods1Count = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.txtMemoryCardGoods1Count");
         _txtMemoryCardGoods2Count = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.txtMemoryCardGoods2Count");
         _txtMemoryCardGoods1Name = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.txtMemoryCardGoods1Name");
         _txtMemoryCardGoods2Name = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.txtMemoryCardGoods2Name");
         _memoryCardBg = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.memoryCardBg");
         _targetScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.txtMemoryCardScore");
         addToContent(_memoryCardBg);
         addToContent(_btnUse1);
         addToContent(_btnUse2);
         addToContent(_txtMemoryCardScore);
         addToContent(_txtMemoryCardTime);
         addToContent(_txtMemoryCardGoods1Count);
         addToContent(_txtMemoryCardGoods2Count);
         addToContent(_txtMemoryCardGoods1Name);
         addToContent(_txtMemoryCardGoods2Name);
         addToContent(_targetScoreTxt);
         _txtMemoryCardGoods1Name.text = LanguageMgr.GetTranslation("AirGardenGame.memorycard.str1");
         _txtMemoryCardGoods2Name.text = LanguageMgr.GetTranslation("AirGardenGame.memorycard.str2");
         var _loc1_:CarnivalPlayGroundTemplateInfo = TempleteManager.instance.carnivalPlayGroundTemplateCate.getTempByType(2);
         if(_loc1_)
         {
            _targetScoreTxt.text = LanguageMgr.GetTranslation("samll.game.score",_loc1_.Target);
         }
         _btnStart = ComponentFactory.Instance.creatComponentByStylename("airGarden.memorycard.startBtn");
         addToContent(_btnStart);
         _combNumRes = ComponentFactory.Instance.creatBitmapData("asset.llk.combNum");
         _scoreNumRes = ComponentFactory.Instance.creatBitmapData("asset.llk.scoreNum");
         _txtMemoryCardGoods1Count.text = "x0";
         _txtMemoryCardGoods2Count.text = "x0";
         _txtMemoryCardScore.text = "0";
         _txtMemoryCardTime.text = "0";
      }
      
      private function initCards() : void
      {
         var _loc4_:AirGardenGameMemoryCardItem = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         cardSp = new Sprite();
         addToContent(cardSp);
         cardSp.x = 110;
         cardSp.y = 30;
         cards = new HashMap();
         _loc2_ = 0;
         while(_loc2_ < ROW)
         {
            _loc3_ = 0;
            while(_loc3_ < COLOME)
            {
               _loc1_ = _loc2_ * 6 + _loc3_ + 1;
               _loc4_ = new AirGardenGameMemoryCardItem(_loc1_);
               cardSp.addChild(_loc4_);
               _loc4_.x = _loc3_ * 76;
               _loc4_.y = _loc2_ * 97;
               cards.put(_loc1_,_loc4_);
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _btnStart.addEventListener("click",onClickStart);
         _btnUse1.addEventListener("click",onClickUse);
         _btnUse2.addEventListener("click",onClickUse);
         m.addEventListener("INIT_MEMORY_CARD",initData);
         m.addEventListener("FLIP_MEMORY_CARD",flipCard);
         m.addEventListener("AUTO_MEMORY_CARD",autoCard);
         m.addEventListener("SHOW_MEMORY_CARD",showCard);
         m.addEventListener("UPDATE_DATA_MEMORY_CARD",updateData);
         _timer.addEventListener("timer",tick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_btnStart)
         {
            _btnStart.removeEventListener("click",onClickStart);
         }
         if(_btnUse1)
         {
            _btnUse1.removeEventListener("click",onClickUse);
         }
         if(_btnUse2)
         {
            _btnUse2.removeEventListener("click",onClickUse);
         }
         m.removeEventListener("INIT_MEMORY_CARD",initData);
         m.removeEventListener("FLIP_MEMORY_CARD",flipCard);
         m.removeEventListener("AUTO_MEMORY_CARD",autoCard);
         m.removeEventListener("SHOW_MEMORY_CARD",showCard);
         m.removeEventListener("UPDATE_DATA_MEMORY_CARD",updateData);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",tick);
         }
      }
      
      private function updateData(param1:AirGardenGameEvent) : void
      {
         _txtMemoryCardGoods1Count.text = "x" + m.model.leftAutoChance;
         _txtMemoryCardGoods2Count.text = "x" + m.model.leftCheckChance;
         _txtMemoryCardScore.text = m.model.score + "";
      }
      
      private function tick(param1:TimerEvent) : void
      {
         if(m.model.duration == 0)
         {
            return;
         }
         var _loc2_:int = m.model.duration - tickTime;
         _txtMemoryCardTime.text = _loc2_ + "";
         tickTime = tickTime + 1;
         if(_loc2_ <= 0)
         {
            dispose();
         }
      }
      
      private function onClickUse(param1:MouseEvent) : void
      {
         var t:int;
         var e:MouseEvent = param1;
         if(!_timer.running)
         {
            return;
         }
         if(m.model.lock)
         {
            return;
         }
         if(m.model.openCards.length == 1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AirGardenGame.memorycard.str3"));
            return;
         }
         if(e.target == _btnUse1)
         {
            m.model.lock = true;
            m.sendAuto();
         }
         else if(e.target == _btnUse2)
         {
            m.model.lock = true;
            m.sendShow();
         }
         t = int(setTimeout(function():void
         {
            m.model.lock = false;
            clearTimeout(t);
         },3000));
      }
      
      private function showCard(param1:AirGardenGameEvent) : void
      {
         var _loc2_:MemoryCardData = null;
         var _loc4_:AirGardenGameMemoryCardItem = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < m.model.cardShow.size)
         {
            _loc2_ = m.model.cardShow.getValueByIndex(_loc3_) as MemoryCardData;
            _loc4_ = cards.getValue(_loc2_.index) as AirGardenGameMemoryCardItem;
            _loc4_.justShow = true;
            _loc4_.flip();
            _loc3_++;
         }
      }
      
      private function autoCard(param1:AirGardenGameEvent) : void
      {
         var event:AirGardenGameEvent = param1;
         var tempCard1:AirGardenGameMemoryCardItem = cards.getValue(m.model.cIndex1) as AirGardenGameMemoryCardItem;
         var tempCard2:AirGardenGameMemoryCardItem = cards.getValue(m.model.cIndex2) as AirGardenGameMemoryCardItem;
         tempCard1.isClickFlip = true;
         tempCard2.isClickFlip = true;
         tempCard1.isResultOpen = true;
         tempCard2.isResultOpen = true;
         tempCard1.flip();
         tempCard2.flip();
         playAddScoreEffect(tempCard2);
         setTimeout(function():void
         {
            m.model.lock = false;
         },700);
      }
      
      private function flipCard(param1:AirGardenGameEvent) : void
      {
         var e:AirGardenGameEvent = param1;
         var tempCard1:AirGardenGameMemoryCardItem = m.model.openCards[0];
         var tempCard2:AirGardenGameMemoryCardItem = m.model.openCards[1];
         if(m.model.result)
         {
            tempCard1.isResultOpen = true;
            tempCard2.isResultOpen = true;
            m.model.lock = false;
            playAddScoreEffect(tempCard2);
         }
         else
         {
            tempCard1.flip(0.5);
            tempCard2.flip(0.5);
            setTimeout(function():void
            {
               m.model.lock = false;
            },700);
         }
         m.model.openCards = [];
      }
      
      private function playAddScoreEffect(param1:DisplayObject) : void
      {
         if(_deleMc)
         {
            _deleMc.dispose();
            _deleMc = null;
         }
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.llk.addScoreMc");
         NumberViewUtils.refreshValue(m.model.addScore + m.model.addScore2,_loc2_["effect"]["sp2"],_scoreNumRes,11,17,11,11,"0123456789");
         if(m.model.addScore2 > 0)
         {
            NumberViewUtils.refreshValue(m.model.addScore2 / 10,_loc2_["effect"]["sp1"],_combNumRes,13,19,13,13,"0123456789");
         }
         else
         {
            _loc2_["effect"]["combTxt"].visible = false;
         }
         _deleMc = new SimpleMovie(_loc2_);
         _deleMc.x = param1.x;
         _deleMc.y = param1.y;
         addToContent(_deleMc);
      }
      
      private function initData(param1:AirGardenGameEvent) : void
      {
         var _loc3_:AirGardenGameMemoryCardItem = null;
         var _loc2_:int = 0;
         _loc2_ = 1;
         while(_loc2_ <= ROW * COLOME)
         {
            _loc3_ = cards.getValue(_loc2_) as AirGardenGameMemoryCardItem;
            _loc3_.data = m.model.cards.getValue(_loc2_) as MemoryCardData;
            _loc3_.reset();
            _loc2_++;
         }
         if(!_timer.running)
         {
            _timer.start();
         }
      }
      
      private function onClickStart(param1:MouseEvent) : void
      {
         _btnStart.visible = false;
         initCards();
         m.sendStart();
      }
      
      public function get m() : AirGardenMemoryCardManager
      {
         return AirGardenMemoryCardManager.instance;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               check();
         }
      }
      
      private function check() : void
      {
         SimpleAlertHelper.instance.data = [realDispose];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("AirGardenGame.exit.hint");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc3_,_loc1_,_loc2_,true,true);
      }
      
      private function realDispose(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         m.model.openCards = [];
         m.model.lock = false;
         m.sendClose();
         if(cards)
         {
            _loc1_ = 0;
            while(_loc1_ < cards.size)
            {
               (cards.getValueByIndex(_loc1_) as AirGardenGameMemoryCardItem).dispose();
               _loc1_++;
            }
            cards.clear();
            m.model.clear();
         }
         ObjectUtils.disposeObject(_btnUse1);
         _btnUse1 = null;
         ObjectUtils.disposeObject(_btnUse2);
         _btnUse2 = null;
         ObjectUtils.disposeObject(_txtMemoryCardScore);
         _txtMemoryCardScore = null;
         ObjectUtils.disposeObject(_txtMemoryCardTime);
         _txtMemoryCardTime = null;
         ObjectUtils.disposeObject(_txtMemoryCardGoods1Count);
         _txtMemoryCardGoods1Count = null;
         ObjectUtils.disposeObject(_txtMemoryCardGoods2Count);
         _txtMemoryCardGoods2Count = null;
         ObjectUtils.disposeObject(_txtMemoryCardGoods1Name);
         _txtMemoryCardGoods1Name = null;
         ObjectUtils.disposeObject(_txtMemoryCardGoods2Name);
         _txtMemoryCardGoods2Name = null;
         ObjectUtils.disposeObject(_memoryCardBg);
         _memoryCardBg = null;
         ObjectUtils.disposeObject(cardSp);
         cardSp = null;
         ObjectUtils.disposeObject(_btnStart);
         _btnStart = null;
         ObjectUtils.disposeObject(_combNumRes);
         _combNumRes = null;
         ObjectUtils.disposeObject(_scoreNumRes);
         _scoreNumRes = null;
         ObjectUtils.disposeObject(_deleMc);
         _deleMc = null;
         ObjectUtils.disposeObject(_targetScoreTxt);
         _targetScoreTxt = null;
         super.dispose();
      }
   }
}


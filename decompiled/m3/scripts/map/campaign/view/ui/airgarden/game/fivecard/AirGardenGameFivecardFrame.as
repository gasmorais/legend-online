package map.campaign.view.ui.airgarden.game.fivecard
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
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.AirGardenFivecardManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.airgarden.game.FivecardData;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.CarnivalPlayGroundTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   import yishi.utils.HashMap;
   import yishi.utils.SimpleAlertHelper;
   
   public class AirGardenGameFivecardFrame extends Frame
   {
      
      private var _btnFivecardContinue:IconButton;
      
      private var _txtFivecardMyScore:FilterFrameText;
      
      private var _txtFivecardCount:FilterFrameText;
      
      private var _txtFivecardRule:FilterFrameText;
      
      private var _btnFivecardOK:IconButton;
      
      private var _imgPic1:MutipleImage;
      
      private var cards:HashMap;
      
      private var scores:Vector.<AirGardenGameFivecardScoreItem>;
      
      private var _btnStart:IconButton;
      
      private var _targetScoreTxt:FilterFrameText;
      
      public function AirGardenGameFivecardFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("AirGardenGame.fivecard.title");
         _btnFivecardContinue = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.btnFivecardContinue");
         _txtFivecardMyScore = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.txtFivecardMyScore");
         _txtFivecardCount = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.txtFivecardCount");
         _txtFivecardRule = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.txtFivecardRule");
         _btnFivecardOK = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.btnFivecardOK");
         _imgPic1 = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.imgPic1");
         _targetScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.txtSuHaCardScore");
         addToContent(_imgPic1);
         addToContent(_btnFivecardContinue);
         addToContent(_txtFivecardMyScore);
         addToContent(_txtFivecardCount);
         addToContent(_txtFivecardRule);
         addToContent(_btnFivecardOK);
         addToContent(_targetScoreTxt);
         _btnFivecardOK.visible = _btnFivecardContinue.visible = false;
         _btnStart = ComponentFactory.Instance.creatComponentByStylename("airGarden.fivecard.startBtn");
         addToContent(_btnStart);
         initScores();
         _txtFivecardRule.text = LanguageMgr.GetTranslation("AirGardenGame.fivecard.rule");
         _txtFivecardCount.text = "0";
         _txtFivecardMyScore.text = "0";
         var _loc1_:CarnivalPlayGroundTemplateInfo = TempleteManager.instance.carnivalPlayGroundTemplateCate.getTempByType(3);
         if(_loc1_)
         {
            _targetScoreTxt.text = LanguageMgr.GetTranslation("samll.game.score",_loc1_.Target);
         }
      }
      
      private function initScores() : void
      {
         var _loc1_:AirGardenGameFivecardScoreItem = null;
         var _loc2_:int = 0;
         scores = new Vector.<AirGardenGameFivecardScoreItem>();
         _loc2_ = 1;
         while(_loc2_ <= 9)
         {
            _loc1_ = new AirGardenGameFivecardScoreItem(_loc2_);
            scores.push(_loc1_);
            _loc1_.x = 20 + (_loc2_ > 6 ? 372 : 0);
            _loc1_.y = 296 + (_loc2_ - 1) % 6 * 16;
            addToContent(_loc1_);
            _loc2_++;
         }
      }
      
      private function initCards() : void
      {
         var _loc2_:AirGardenGameFivecardItem = null;
         var _loc1_:int = 0;
         cards = new HashMap();
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _loc2_ = new AirGardenGameFivecardItem(_loc1_);
            cards.put(_loc1_,_loc2_);
            _loc2_.x = 112 + 100 * (_loc1_ - 1);
            _loc2_.y = 92;
            addToContent(_loc2_);
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _btnStart.addEventListener("click",onClickStart);
         _btnFivecardOK.addEventListener("click",onClickOK);
         _btnFivecardContinue.addEventListener("click",onClickContinue);
         m.addEventListener("INIT_FIVE_CARD",updateCards);
         m.addEventListener("SHOW_FIVE_CARD",showCards);
         m.addEventListener("FIVE_CARD_ADD_SCORE",addScore);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_btnStart)
         {
            _btnStart.removeEventListener("click",onClickStart);
         }
         if(_btnFivecardOK)
         {
            _btnFivecardOK.removeEventListener("click",onClickOK);
         }
         if(_btnFivecardContinue)
         {
            _btnFivecardContinue.removeEventListener("click",onClickContinue);
         }
         m.removeEventListener("INIT_FIVE_CARD",updateCards);
         m.removeEventListener("SHOW_FIVE_CARD",showCards);
         m.removeEventListener("FIVE_CARD_ADD_SCORE",addScore);
      }
      
      private function addScore(param1:AirGardenGameEvent) : void
      {
         var _loc2_:AirGardenGameFivecardScoreItem = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < scores.length)
         {
            _loc2_ = scores[_loc3_];
            if(_loc2_.score == m.model.addScore)
            {
               _loc2_.shine();
            }
            _loc3_++;
         }
      }
      
      private function onClickContinue(param1:MouseEvent) : void
      {
         var _loc2_:AirGardenGameFivecardScoreItem = null;
         var _loc3_:int = 0;
         m.sendNext();
         _btnFivecardOK.visible = true;
         _btnFivecardContinue.visible = false;
         _loc3_ = 0;
         while(_loc3_ < scores.length)
         {
            _loc2_ = scores[_loc3_];
            _loc2_.reset();
            _loc3_++;
         }
      }
      
      private function onClickOK(param1:MouseEvent) : void
      {
         var tempCard:AirGardenGameFivecardItem;
         var t:int;
         var e:MouseEvent = param1;
         var arr:Array = [];
         var i:int = 1;
         while(i <= 5)
         {
            tempCard = cards.getValue(i) as AirGardenGameFivecardItem;
            tempCard.data = m.model.pokers.getValue(i) as FivecardData;
            if(tempCard.isHold)
            {
               arr.push(tempCard.index);
            }
            else
            {
               tempCard.flip();
            }
            i = i + 1;
         }
         m.sendShow(arr);
         _btnFivecardOK.visible = false;
         _btnFivecardContinue.visible = false;
         t = int(setTimeout(function():void
         {
            if(_btnFivecardContinue)
            {
               _btnFivecardContinue.visible = true;
               clearTimeout(t);
            }
         },2000));
      }
      
      private function showCards(param1:AirGardenGameEvent) : void
      {
         var _loc3_:AirGardenGameFivecardItem = null;
         var _loc2_:int = 0;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc3_ = cards.getValue(_loc2_) as AirGardenGameFivecardItem;
            _loc3_.showData = m.model.pokers.getValue(_loc2_) as FivecardData;
            _loc3_.lock(true);
            _loc2_++;
         }
         refreshUI();
      }
      
      private function updateCards(param1:AirGardenGameEvent = null) : void
      {
         var _loc3_:AirGardenGameFivecardItem = null;
         var _loc2_:int = 0;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc3_ = cards.getValue(_loc2_) as AirGardenGameFivecardItem;
            _loc3_.showData = null;
            _loc3_.data = m.model.pokers.getValue(_loc2_) as FivecardData;
            _loc3_.lock(false);
            _loc3_.flip(true);
            _loc2_++;
         }
         refreshUI();
      }
      
      private function refreshUI() : void
      {
         var count:int;
         _txtFivecardMyScore.text = m.model.score + "";
         count = 5 - m.model.curTurn;
         if(count < 0)
         {
            count = 0;
         }
         _txtFivecardCount.text = "" + count;
         if(m.model.curTurn - 1 >= 5)
         {
            _btnFivecardContinue.visible = _btnFivecardOK.visible = false;
            setTimeout(function():void
            {
               dispose();
            },1);
         }
      }
      
      private function onClickStart(param1:MouseEvent) : void
      {
         _btnFivecardOK.visible = _btnFivecardContinue.visible = true;
         _btnStart.visible = false;
         initCards();
         m.sendStart();
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
      
      public function get m() : AirGardenFivecardManager
      {
         return AirGardenFivecardManager.instance;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         m.sendClose();
         ObjectUtils.disposeObject(_btnFivecardContinue);
         _btnFivecardContinue = null;
         ObjectUtils.disposeObject(_txtFivecardMyScore);
         _txtFivecardMyScore = null;
         ObjectUtils.disposeObject(_txtFivecardCount);
         _txtFivecardCount = null;
         ObjectUtils.disposeObject(_txtFivecardRule);
         _txtFivecardRule = null;
         ObjectUtils.disposeObject(_btnFivecardOK);
         _btnFivecardOK = null;
         ObjectUtils.disposeObject(_imgPic1);
         _imgPic1 = null;
         ObjectUtils.disposeObject(_btnStart);
         _btnStart = null;
         LogicUtils.disposeDisplayCollection(scores);
         scores = null;
         ObjectUtils.disposeObject(_targetScoreTxt);
         _targetScoreTxt = null;
         if(cards)
         {
            cards.clear();
         }
         cards = null;
         super.dispose();
      }
   }
}


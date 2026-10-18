package apex.guess
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ApexEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import mvc.module.apex.ApexBetData;
   import mvc.module.apex.ApexModel;
   import mvc.module.apex.ApexRankTeamData;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.ApexManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.TimerUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class ApexGuessFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _img1:ScaleBitmapImage;
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _txtGuessLastBig:FilterFrameText;
      
      private var _txtGuessStr1:FilterFrameText;
      
      private var _txtGuessStr2:FilterFrameText;
      
      private var _txtGuessStr22:FilterFrameText;
      
      private var _txtGuessStr3:FilterFrameText;
      
      private var _txtGuessPlayerName:FilterFrameText;
      
      private var _txtGuessTimeCountDown:FilterFrameText;
      
      private var _txtGuessMyCount:FilterFrameText;
      
      private var _txtGuessCount:FilterFrameText;
      
      private var _btnGuess:IconButton;
      
      private var _txtGuessSsuccessGet:FilterFrameText;
      
      private var _txtGuessFailGet:FilterFrameText;
      
      private var _txtGuessTurn:GradientText;
      
      private var _txtGuessRank:GradientText;
      
      private var _bit2:Bitmap;
      
      private var _guessMoney1:MutipleImage;
      
      private var _guessMoney2:MutipleImage;
      
      private var _guessMoney3:MutipleImage;
      
      private var _guessMoney4:MutipleImage;
      
      private var _bit3:Bitmap;
      
      private var guessDataList:Array;
      
      private var btnArr:Array;
      
      private var vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var bt:SelectedIconButton;
      
      private var btnLinkAwardList:TextButton;
      
      private var numBitmap:BitmapData;
      
      private var numPool:Sprite;
      
      private var selectedTeamData:ApexRankTeamData;
      
      private var isGuessed:Boolean = false;
      
      private var t:int;
      
      private var btnGuessed:IconButton;
      
      public function ApexGuessFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,809,491);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("apex.guess.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("apex.guess.framebg");
         addChild(_bg);
         _img1 = ComponentFactory.Instance.creatComponentByStylename("apex.guess.img1");
         addChild(_img1);
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.str.awardpool");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.apex.str.lastAward");
         _txtGuessLastBig = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessLastBig");
         _txtGuessStr1 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessStr1");
         _txtGuessStr2 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessStr2");
         _txtGuessStr22 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessStr2_2");
         _txtGuessStr3 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessStr3");
         _txtGuessPlayerName = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessPlayerName");
         _txtGuessTimeCountDown = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessTimeCountDown");
         _txtGuessMyCount = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessMyCount");
         _txtGuessCount = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessCount");
         _btnGuess = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnGuess");
         _txtGuessTurn = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessTurn.gradient");
         _txtGuessRank = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessRank.gradient");
         _txtGuessSsuccessGet = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessSsuccessGet");
         _txtGuessFailGet = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessFailGet");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.apex.guess.str2");
         _guessMoney1 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.guessMoney1");
         _guessMoney2 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.guessMoney2");
         _guessMoney3 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.guessMoney3");
         _guessMoney4 = ComponentFactory.Instance.creatComponentByStylename("ui.apex.guessMoney4");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.apex.bg2");
         btnGuessed = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnGuessed");
         btnGuessed.enable = false;
         btnLinkAwardList = ComponentFactory.Instance.creatComponentByStylename("apex.guess.linkAwardList");
         addChild(_bit3);
         addChild(_bit0);
         addChild(_bit1);
         addChild(_txtGuessLastBig);
         addChild(_txtGuessStr1);
         addChild(_txtGuessStr2);
         addChild(_txtGuessStr22);
         addChild(_txtGuessStr3);
         addChild(_txtGuessPlayerName);
         addChild(_txtGuessTimeCountDown);
         addChild(_txtGuessTurn);
         addChild(_txtGuessRank);
         addChild(_txtGuessCount);
         addChild(_txtGuessMyCount);
         addChild(_btnGuess);
         addChild(_txtGuessSsuccessGet);
         addChild(_txtGuessFailGet);
         addChild(_bit2);
         addChild(_guessMoney1);
         addChild(_guessMoney2);
         addChild(_guessMoney3);
         addChild(_guessMoney4);
         addChild(btnLinkAwardList);
         addChild(btnGuessed);
         _txtGuessCount.text = "0";
         numBitmap = ComponentFactory.Instance.creatBitmapData("asset.apex.guess.num");
         numPool = new Sprite();
         addChild(numPool);
         numPool.x = 541;
         numPool.y = 76;
         _txtGuessStr1.text = LanguageMgr.GetTranslation("apex.guess.str1");
         _txtGuessStr2.text = LanguageMgr.GetTranslation("apex.guess.str2");
         _txtGuessStr22.text = LanguageMgr.GetTranslation("apex.guess.str2_2");
         _txtGuessStr3.text = LanguageMgr.GetTranslation("apex.guess.str3");
         _txtGuessTimeCountDown.text = LanguageMgr.GetTranslation("apex.guess.str4");
         btnLinkAwardList.text = LanguageMgr.GetTranslation("apex.guess.str7");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("apex.scrollPanel.guess");
         addChild(_scrollPanel);
         guessDataList = apexBetData.rankList;
         refreshView();
         initGuessArr();
         _btnGuess.enable = false;
         onInputChange();
         tick();
      }
      
      private function initGuessArr() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ApexGuessListItem = null;
         vbox = ComponentFactory.Instance.creatComponentByStylename("apex.vbox.guess.vbox");
         addChild(vbox);
         btnArr = [];
         _loc2_ = 0;
         while(_loc2_ < guessDataList.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("apex.guess.ApexGuessListItem");
            vbox.addChild(_loc1_);
            _loc1_.data = guessDataList[_loc2_];
            _loc1_.clickback = clickItemBack;
            _loc1_.selectback = selectItemBack;
            _loc1_.canBet = !isGuessed;
            btnArr.push(_loc1_);
            _loc2_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.setView(vbox);
         _scrollPanel.invalidateViewport();
         vbox.commitChanges();
      }
      
      private function selectItemBack(param1:ApexRankTeamData) : void
      {
         selectedTeamData = param1;
         if(!isGuessed)
         {
            _btnGuess.enable = true;
         }
         if(!isGuessed)
         {
            _txtGuessPlayerName.text = selectedTeamData.teamName;
         }
      }
      
      private function clickItemBack(param1:ApexGuessListItem) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ApexGuessListItem = null;
         _btnGuess.enable = false;
         if(!isGuessed)
         {
            _txtGuessPlayerName.text = "";
         }
         _loc3_ = 0;
         while(_loc3_ < btnArr.length)
         {
            _loc2_ = btnArr[_loc3_];
            _loc2_.show(false);
            _loc3_++;
         }
         param1.show(true);
         vbox.refreshChildPos();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         btnLinkAwardList.addEventListener("click",onClickAwardList);
         _btnGuess.addEventListener("click",onClickGuess);
         ApexManager.instance.addEventListener("REFRESH_GUESS_STATE",refreshGuessView);
         _txtGuessCount.addEventListener("change",onInputChange);
         TimerUtils.addSecendTimer("ApexGuessFrame",1,2147483647,tick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         btnLinkAwardList.removeEventListener("click",onClickAwardList);
         _btnGuess.removeEventListener("click",onClickGuess);
         ApexManager.instance.removeEventListener("REFRESH_GUESS_STATE",refreshGuessView);
         _txtGuessCount.removeEventListener("change",onInputChange);
         TimerUtils.removeSecendTimer("ApexGuessFrame");
      }
      
      private function tick() : void
      {
         if(model.apexState)
         {
            t = (model.apexState.betEndTime - PlayerManager.instance.currentPlayerModel.sysCurtime.time) / 1000;
            if(t < 0)
            {
               t = 0;
               _txtGuessTimeCountDown.text = LanguageMgr.GetTranslation("apex.guess.str10");
            }
            else
            {
               _txtGuessTimeCountDown.text = LanguageMgr.GetTranslation("apex.guess.str4",DateFormatter.getStopDateString(t));
            }
         }
      }
      
      private function onInputChange(param1:Event = null) : void
      {
         var _loc2_:int = int(_txtGuessCount.text);
         if(_loc2_ > 50000)
         {
            _loc2_ = 50000;
         }
         _txtGuessCount.text = _loc2_ + "";
         _txtGuessSsuccessGet.htmlText = LanguageMgr.GetTranslation("apex.guess.str5",_loc2_ * 20);
         _txtGuessFailGet.htmlText = LanguageMgr.GetTranslation("apex.guess.str6",_loc2_);
      }
      
      protected function refreshGuessView(param1:ApexEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         NumberViewUtils.refreshValue(apexBetData.currentBonusPool,numPool,numBitmap,22,32,20,22,"1234567890");
         _txtGuessLastBig.text = apexBetData.lastBetWinningCount + "";
         if(apexBetData.selfBetCount > 0)
         {
            isGuessed = true;
            _btnGuess.visible = false;
            btnGuessed.visible = true;
            if(apexBetData.betTeamData)
            {
               _txtGuessPlayerName.text = apexBetData.betTeamData.teamName;
            }
            _txtGuessCount.text = apexBetData.selfBetCount + "";
            _txtGuessCount.mouseEnabled = false;
         }
         else
         {
            isGuessed = false;
            _btnGuess.visible = true;
            btnGuessed.visible = false;
            _txtGuessCount.mouseEnabled = true;
         }
         _txtGuessRank.text = LanguageMgr.GetTranslation("apex.guess.str8",apexBetData.guessRank);
         _txtGuessTurn.text = LanguageMgr.GetTranslation("apex.turn.turn" + ApexManager.instance.model.apexState.stage) + " " + LanguageMgr.GetTranslation("vehicle.scoresort");
         _txtGuessMyCount.htmlText = LanguageMgr.GetTranslation("apex.guess.str9",PlayerCurrencyManager.instance.currencyInfo.apexCoin.amount);
      }
      
      public function get apexBetData() : ApexBetData
      {
         return ApexManager.instance.model.apexBetData;
      }
      
      public function get model() : ApexModel
      {
         return ApexManager.instance.model;
      }
      
      private function onClickGuess(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!model.apexState.canGuess)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("apex.guess.hint2"));
            return;
         }
         var _loc8_:int = int(_txtGuessCount.text);
         if(_loc8_ < 100)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("apex.guess.str2"));
            return;
         }
         var _loc4_:int = int(_txtGuessCount.text);
         var _loc3_:int = int(PlayerCurrencyManager.instance.currencyInfo.apexCoin.amount);
         if(_loc3_ - _loc4_ >= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("apex.guess.hint3",_loc4_);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("apex.guess.hint",_loc4_ - _loc3_);
         }
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc6_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [__requestFrameCloseHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc2_,_loc5_,_loc6_,false,false,false,1);
      }
      
      private function __requestFrameCloseHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ApexManager.instance.sendToGuess(selectedTeamData.teamUid,int(_txtGuessCount.text));
         }
      }
      
      protected function onClickAwardList(param1:MouseEvent) : void
      {
         ApexManager.instance.sendGetAwardList();
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
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_txtGuessLastBig);
         _txtGuessLastBig = null;
         ObjectUtils.disposeObject(_txtGuessStr1);
         _txtGuessStr1 = null;
         ObjectUtils.disposeObject(_txtGuessStr2);
         _txtGuessStr2 = null;
         ObjectUtils.disposeObject(_txtGuessStr22);
         _txtGuessStr2 = null;
         ObjectUtils.disposeObject(_txtGuessStr3);
         _txtGuessStr3 = null;
         ObjectUtils.disposeObject(_txtGuessTurn);
         _txtGuessTurn = null;
         ObjectUtils.disposeObject(_txtGuessRank);
         _txtGuessRank = null;
         ObjectUtils.disposeObject(_txtGuessPlayerName);
         _txtGuessPlayerName = null;
         ObjectUtils.disposeObject(_txtGuessTimeCountDown);
         _txtGuessTimeCountDown = null;
         ObjectUtils.disposeObject(_txtGuessCount);
         _txtGuessCount = null;
         ObjectUtils.disposeObject(_btnGuess);
         _btnGuess = null;
         ObjectUtils.disposeObject(_txtGuessSsuccessGet);
         _txtGuessSsuccessGet = null;
         ObjectUtils.disposeObject(_txtGuessFailGet);
         _txtGuessFailGet = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_guessMoney1);
         _guessMoney1 = null;
         ObjectUtils.disposeObject(_guessMoney2);
         _guessMoney2 = null;
         ObjectUtils.disposeObject(_guessMoney3);
         _guessMoney3 = null;
         ObjectUtils.disposeObject(_guessMoney4);
         _guessMoney4 = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(btnGuessed);
         btnGuessed = null;
         ObjectUtils.disposeObject(_txtGuessMyCount);
         _txtGuessMyCount = null;
         ObjectUtils.disposeObject(vbox);
         vbox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(bt);
         bt = null;
         ObjectUtils.disposeObject(btnLinkAwardList);
         btnLinkAwardList = null;
         ObjectUtils.disposeObject(numBitmap);
         numBitmap = null;
         ObjectUtils.disposeObject(numPool);
         numPool = null;
         ObjectUtils.disposeObject(btnGuessed);
         btnGuessed = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}


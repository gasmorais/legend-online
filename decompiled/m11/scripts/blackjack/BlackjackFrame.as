package blackjack
{
   import bag.helper.BagHelper;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.blackjack.BlackjackBoardInfo;
   import mvc.module.blackjack.BlackjackTempInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.BlackjackManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class BlackjackFrame extends Frame implements IManualSize
   {
      
      private var _bg:DisplayObject;
      
      private var _helpBtn:BaseButton;
      
      private var _cardStack:MovieClip;
      
      private var _exchangeView:BlackjackExchangeView;
      
      private var _blackjackLayer:BlackjackLayer;
      
      private var _pointNote1:Image;
      
      private var _pointNote2:Image;
      
      private var _pointTxt1:FilterFrameText;
      
      private var _pointTxt2:FilterFrameText;
      
      private var _pointImage:ScaleFrameImage;
      
      private var _pointTxt:FilterFrameText;
      
      private var _itemCon:Sprite;
      
      private var _bankerCon:Sprite;
      
      private var _playerCon:Sprite;
      
      private var _takeCardBtn:IconButton;
      
      private var _stopCardBtn:IconButton;
      
      private var _goldCardBtn:TextButton;
      
      private var _blackjackTemp:BlackjackTempInfo;
      
      private var _goodsList:Array;
      
      private var _bankerCardArr:Array = [-1,-1,-1,-1,-1];
      
      private var _playerCardArr:Array = [-1,-1,-1,-1,-1];
      
      private var _timeId:int;
      
      private var _clickTime:int = 0;
      
      private var _timeDrop:int;
      
      private var _newGoodsCount:int;
      
      private var _newGoodsInfo:GoodsInfo;
      
      private var _timeClose:int;
      
      public function BlackjackFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,875,620);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("view.BlackjackFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.blackjack.back");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("blackjack.blackjackHelpBtn");
         _exchangeView = ComponentFactory.Instance.creatCustomObject("blackjack.BlackjackExchangeView");
         _cardStack = ComponentFactory.Instance.creatCustomObject("asset.blackjack.cardStack");
         _pointNote1 = ComponentFactory.Instance.creatComponentByStylename("blackjack.currentPointNote1");
         _pointNote2 = ComponentFactory.Instance.creatComponentByStylename("blackjack.currentPointNote2");
         _pointTxt1 = ComponentFactory.Instance.creatComponentByStylename("blackjack.currentPointTxt1");
         _pointTxt2 = ComponentFactory.Instance.creatComponentByStylename("blackjack.currentPointTxt2");
         _pointImage = ComponentFactory.Instance.creatComponentByStylename("blackjack.betPointImage");
         _pointImage.x = 276;
         _pointImage.y = 188;
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("blackjack.betPointTxt1");
         _itemCon = new Sprite();
         _itemCon.x = 161;
         _itemCon.y = 200;
         _bankerCon = new Sprite();
         _bankerCon.x = 31;
         _bankerCon.y = 17;
         _playerCon = new Sprite();
         _playerCon.x = 31;
         _playerCon.y = 278;
         _takeCardBtn = ComponentFactory.Instance.creatComponentByStylename("blackjack.takeCardBtn");
         _goldCardBtn = ComponentFactory.Instance.creatComponentByStylename("blackjack.goldCardBtn");
         _stopCardBtn = ComponentFactory.Instance.creatComponentByStylename("blackjack.stopCardBtn");
         addToContent(_bg);
         addToContent(_helpBtn);
         addToContent(_pointNote1);
         addToContent(_pointNote2);
         addToContent(_pointTxt1);
         addToContent(_pointTxt2);
         addToContent(_pointImage);
         addToContent(_pointTxt);
         addToContent(_itemCon);
         addToContent(_bankerCon);
         addToContent(_playerCon);
         addToContent(_takeCardBtn);
         addToContent(_goldCardBtn);
         addToContent(_stopCardBtn);
         addToContent(_exchangeView);
         _takeCardBtn.tipData = LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.takeCardTip");
         _goldCardBtn.tipData = LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.goldCardTip",0);
         _stopCardBtn.tipData = LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.stopCardTip");
         _cardStack.gotoAndStop(1);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _takeCardBtn.addEventListener("click",__takeCardHandler);
         _goldCardBtn.addEventListener("click",__goldCardHandler);
         _stopCardBtn.addEventListener("click",__stopCardHandler);
         _helpBtn.addEventListener("click",__helpHandler);
         NotificationManager.instance.addEventListener("BLACKJACK_RECORD",__blackRecordHandler);
         __blackRecordHandler(null);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _takeCardBtn.removeEventListener("click",__takeCardHandler);
         _goldCardBtn.removeEventListener("click",__goldCardHandler);
         _stopCardBtn.removeEventListener("click",__stopCardHandler);
         _helpBtn.removeEventListener("click",__helpHandler);
         NotificationManager.instance.removeEventListener("BLACKJACK_RECORD",__blackRecordHandler);
         if(_blackjackLayer)
         {
            _blackjackLayer.removeEventListener("dispose",__onBlackLayerDispose);
         }
      }
      
      private function __blackRecordHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1 ? param1.data.op : BlackjackManager.instance.op);
         var _loc4_:int = int(param1 ? param1.data.param1 : BlackjackManager.instance.param1);
         var _loc3_:int = int(param1 ? param1.data.score : BlackjackManager.instance.score);
         switch(_loc2_ - -1)
         {
            case 0:
               startLayer();
               break;
            case 2:
               firstLayer(_loc4_,_loc3_,param1);
               break;
            case 3:
               createPlayerBoard(param1);
               break;
            case 4:
               createPlayerBoard(param1);
               break;
            case 5:
               createBankerBoard(param1,_loc4_);
               break;
            case 6:
               exchangeReward(_loc3_);
         }
         _exchangeView.curPointTxt = _loc3_;
      }
      
      private function startLayer() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:BlackjackBoardInfo = BlackjackManager.instance.blackjackBoardInfo;
         if(_loc2_.playerCard.length == 0)
         {
            _blackjackLayer = ComponentFactory.Instance.creatCustomObject("blackjack.BlackjackLayer");
            _blackjackLayer.addEventListener("dispose",__onBlackLayerDispose);
            addToContent(_blackjackLayer);
         }
         else
         {
            _loc3_ = int(_loc2_.rewardId);
            _loc1_ = int(BlackjackManager.instance.score);
            firstLayer(_loc3_,_loc1_,null);
         }
      }
      
      private function firstLayer(param1:int = 0, param2:int = 0, param3:Event = null) : void
      {
         var _loc7_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc5_:int = 0;
         ObjectUtils.disposeAllChildren(_itemCon);
         _blackjackTemp = BlackjackManager.instance.blackTempDic[param1];
         if(!_blackjackTemp)
         {
            return;
         }
         var _loc4_:Array = _blackjackTemp.winItemReward.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc7_ = ComponentFactory.Instance.creatCustomObject("blackjack.iconRewardView");
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc4_[_loc5_].split(",")[0];
            _loc6_.count = _loc4_[_loc5_].split(",")[1];
            _loc7_.data = _loc6_;
            if(_loc5_ < 2)
            {
               _loc7_.x = 5 + _loc5_ % 2 * 58;
            }
            else
            {
               _loc7_.x = 188 + _loc5_ % 2 * 60;
            }
            _itemCon.addChild(_loc7_);
            _loc5_++;
         }
         _goldCardBtn.text = String(_blackjackTemp.changeCardCost);
         _pointTxt.text = String(_blackjackTemp.cost);
         _goldCardBtn.tipData = LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.goldCardTip",_blackjackTemp.changeCardCost);
         _bankerCardArr = [-1,-1,-1,-1,-1];
         _playerCardArr = [-1,-1,-1,-1,-1];
         ObjectUtils.disposeAllChildren(_bankerCon);
         ObjectUtils.disposeAllChildren(_playerCon);
         createPlayerBoard(param3);
         createBankerBoard(param3);
      }
      
      private function exchangeReward(param1:int = 0) : void
      {
         _exchangeView.curPointTxt = param1;
      }
      
      private function createPlayerBoard(param1:Event = null) : void
      {
         var _loc2_:BlackjackCard = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:BlackjackBoardInfo = BlackjackManager.instance.blackjackBoardInfo;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.playerCard.length)
         {
            _loc2_ = new BlackjackCard();
            _loc3_ = int(_loc4_.playerCard[_loc5_]);
            if(_loc3_ >= 0 && _playerCardArr[_loc5_] != _loc3_)
            {
               _loc2_.num = _loc3_;
               _loc2_.x = _loc5_ * 114;
               _playerCardArr[_loc5_] = _loc3_;
               _playerCon.addChild(_loc2_);
               if(param1)
               {
                  new BlackjackFlyMediator(_loc2_,_playerCon);
               }
            }
            _loc5_++;
         }
         _pointTxt2.text = String(_loc4_.playerCardPoint);
         if(_loc4_.playerCardPoint == 21)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.stopCard"));
            BlackjackManager.instance.OperateBlackjack(4);
         }
         else if(_loc4_.playerCardPoint > 21)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.explodeCard"));
         }
      }
      
      private function createBankerBoard(param1:Event = null, param2:int = 0) : void
      {
         var _cardItem:BlackjackCard;
         var _cardNum:int;
         var m:int;
         var e:Event = param1;
         param1 = param2;
         var boardInfo:BlackjackBoardInfo = BlackjackManager.instance.blackjackBoardInfo;
         _cardStack.gotoAndStop(1);
         _bankerCon.addChild(_cardStack);
         m = 0;
         while(m < boardInfo.bankerCard.length)
         {
            _cardItem = new BlackjackCard();
            _cardNum = int(boardInfo.bankerCard[m]);
            if(_cardNum >= 0 && _bankerCardArr[m] != _cardNum)
            {
               _cardItem.num = _cardNum;
               _cardItem.x = m * 114;
               _bankerCardArr[m] = _cardNum;
               _bankerCon.addChild(_cardItem);
               if(m != 0 && e && param1 != 0)
               {
                  new BlackjackFlyMediator(_cardItem,_bankerCon,false,changeBanker,m,0.5 + (m - 1) * 0.5);
               }
               else if(m != 0 && e)
               {
                  new BlackjackFlyMediator(_cardItem,_bankerCon,false);
               }
               else if(m == 0 && e && param1 != 0)
               {
                  _cardStack.gotoAndPlay(1);
                  new BlackjackFlyMediator(_cardItem,_bankerCon,true,changeBanker,m);
               }
            }
            m = m + 1;
         }
         if(!(e && param1 != 0))
         {
            _pointTxt1.text = String(boardInfo.bankerCardPoint);
         }
         if(e && param1 != 0)
         {
            _timeId = setTimeout(function():void
            {
               var _loc4_:MovieClip = null;
               var _loc6_:MovieClip = null;
               var _loc3_:SimpleMovie = null;
               var _loc2_:SimpleMovie = null;
               var _loc7_:GoodsInfo = null;
               var _loc5_:int = 0;
               clearTimeout(_timeId);
               var _loc8_:String = "";
               if(param1 == 1)
               {
                  _loc4_ = ComponentFactory.Instance.creatCustomObject("asset.blackjack.cardVictory");
                  _loc3_ = new SimpleMovie(_loc4_,operateBlackjack);
                  _loc3_.x = 330;
                  _loc3_.y = 370;
                  addToContent(_loc3_);
                  _loc6_ = ComponentFactory.Instance.creatCustomObject("asset.blackjack.cardFailure");
                  _loc2_ = new SimpleMovie(_loc6_);
                  _loc2_.x = 335;
                  _loc2_.y = 110;
                  addToContent(_loc2_);
                  _loc8_ = _blackjackTemp.winItemReward;
               }
               else
               {
                  _loc4_ = ComponentFactory.Instance.creatCustomObject("asset.blackjack.cardVictory");
                  _loc3_ = new SimpleMovie(_loc4_,operateBlackjack);
                  _loc3_.x = 330;
                  _loc3_.y = 110;
                  addToContent(_loc3_);
                  _loc6_ = ComponentFactory.Instance.creatCustomObject("asset.blackjack.cardFailure");
                  _loc2_ = new SimpleMovie(_loc6_);
                  _loc2_.x = 335;
                  _loc2_.y = 370;
                  addToContent(_loc2_);
                  _loc8_ = _blackjackTemp.generalItemReward;
               }
               _goodsList = [];
               var _loc1_:Array = _loc8_.split("|");
               _loc5_ = 0;
               while(_loc5_ < _loc1_.length)
               {
                  _loc7_ = new GoodsInfo();
                  _loc7_.templateId = _loc1_[_loc5_].split(",")[0];
                  _loc7_.count = _loc1_[_loc5_].split(",")[1];
                  _goodsList.push(_loc7_);
                  _loc5_++;
               }
               _timeDrop = setInterval(popGoods,500);
            },(boardInfo.bankerCard.length - 1) * 500);
         }
      }
      
      private function changeBanker(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(param1 == 0)
         {
            param1 = 1;
         }
         var _loc3_:BlackjackBoardInfo = BlackjackManager.instance.blackjackBoardInfo;
         var _loc5_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc3_.bankerCard.length)
         {
            _loc2_ = int(_loc3_.bankerCard[_loc4_]);
            if(_loc2_ >= 0 && _loc4_ <= param1)
            {
               _loc5_.push(_loc2_);
            }
            _loc4_++;
         }
         if(_pointTxt1)
         {
            _pointTxt1.text = "" + BlackjackBoardInfo.countPoints(_loc5_);
         }
      }
      
      private function popGoods() : void
      {
         _newGoodsInfo = _goodsList.pop();
         _newGoodsCount += 1;
         if(_newGoodsInfo)
         {
            BagHelper.instance.playNewGoodsEffect(_newGoodsInfo);
         }
         if(_goodsList.length == 0)
         {
            clearInterval(_timeDrop);
            _goodsList = [];
            _newGoodsCount = 0;
         }
         if(_newGoodsCount >= 3)
         {
            clearInterval(_timeDrop);
            _goodsList = [];
            _newGoodsCount = 0;
         }
      }
      
      private function operateBlackjack() : void
      {
         BlackjackManager.instance.OperateBlackjack(0);
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
      
      private function __onBlackLayerDispose(param1:Event) : void
      {
         _blackjackLayer.removeEventListener("dispose",__onBlackLayerDispose);
         _blackjackLayer = null;
      }
      
      private function __takeCardHandler(param1:Event) : void
      {
         if(getTimer() - _clickTime < 500)
         {
            return;
         }
         _clickTime = getTimer();
         SoundManager.instance.play("022");
         if(checkFullCard())
         {
            return;
         }
         if(checkStop())
         {
            return;
         }
         if(checkCards())
         {
            return;
         }
         if(checkWin())
         {
            return;
         }
         setCloseDisable(1000);
         BlackjackManager.instance.OperateBlackjack(2);
      }
      
      private function __goldCardHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         if(getTimer() - _clickTime < 500)
         {
            return;
         }
         _clickTime = getTimer();
         SoundManager.instance.play("022");
         if(!_blackjackTemp)
         {
            return;
         }
         if(checkStop())
         {
            return;
         }
         if(checkWin())
         {
            return;
         }
         var _loc3_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(_loc3_ >= int(_blackjackTemp.changeCardCost))
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_ = LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.goldCard",_blackjackTemp.changeCardCost);
            SharedManagerHelper.ins.needAlert("mounts.MountKingTrainView.refreshAlert",refreshResultHandler,_loc2_,_loc4_);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function refreshResultHandler() : void
      {
         setCloseDisable(1000);
         BlackjackManager.instance.OperateBlackjack(3);
      }
      
      private function __stopCardHandler(param1:Event) : void
      {
         if(getTimer() - _clickTime < 500)
         {
            return;
         }
         _clickTime = getTimer();
         SoundManager.instance.play("022");
         if(checkStop())
         {
            return;
         }
         if(checkWin())
         {
            return;
         }
         setCloseDisable(4000);
         BlackjackManager.instance.OperateBlackjack(4);
      }
      
      private function setCloseDisable(param1:int) : void
      {
         var time:int = param1;
         clearTimeout(_timeClose);
         closeButton.enable = false;
         _timeClose = setTimeout(function():void
         {
            clearTimeout(_timeClose);
            closeButton.enable = true;
         },time);
      }
      
      private function checkCards() : Boolean
      {
         var _loc1_:BlackjackBoardInfo = BlackjackManager.instance.blackjackBoardInfo;
         if(_loc1_.playerCardPoint > 21)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.explodeCard"));
            return true;
         }
         return false;
      }
      
      private function checkWin() : Boolean
      {
         var _loc1_:BlackjackBoardInfo = BlackjackManager.instance.blackjackBoardInfo;
         if(_loc1_.playerCardPoint == 21)
         {
            return true;
         }
         return false;
      }
      
      private function checkStop() : Boolean
      {
         var _loc1_:BlackjackBoardInfo = BlackjackManager.instance.blackjackBoardInfo;
         return _loc1_.stoped;
      }
      
      private function checkFullCard() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:BlackjackBoardInfo = BlackjackManager.instance.blackjackBoardInfo;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.playerCard.length)
         {
            if(_loc1_.playerCard[_loc2_] < 0)
            {
               return false;
            }
            _loc2_++;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.blackjack.BlackjackFrame.fullCard"));
         return true;
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("blackjack.blackjackHelpFrame");
         _loc2_.show();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearTimeout(_timeId);
         clearTimeout(_timeDrop);
         clearTimeout(_timeClose);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeViolentMc(_cardStack);
         _cardStack = null;
         ObjectUtils.disposeObject(_exchangeView);
         _exchangeView = null;
         ObjectUtils.disposeObject(_blackjackLayer);
         _blackjackLayer = null;
         ObjectUtils.disposeObject(_pointNote1);
         _pointNote1 = null;
         ObjectUtils.disposeObject(_pointNote2);
         _pointNote2 = null;
         ObjectUtils.disposeObject(_pointTxt1);
         _pointTxt1 = null;
         ObjectUtils.disposeObject(_pointTxt2);
         _pointTxt2 = null;
         ObjectUtils.disposeObject(_pointImage);
         _pointImage = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeAllChildren(_itemCon);
         _itemCon = null;
         ObjectUtils.disposeObject(_itemCon);
         _itemCon = null;
         ObjectUtils.disposeAllChildren(_playerCon);
         _playerCon = null;
         ObjectUtils.disposeObject(_playerCon);
         _playerCon = null;
         ObjectUtils.disposeAllChildren(_bankerCon);
         _bankerCon = null;
         ObjectUtils.disposeObject(_bankerCon);
         _bankerCon = null;
         ObjectUtils.disposeObject(_takeCardBtn);
         _takeCardBtn = null;
         ObjectUtils.disposeObject(_stopCardBtn);
         _stopCardBtn = null;
         ObjectUtils.disposeObject(_goldCardBtn);
         _goldCardBtn = null;
         BlackjackManager.instance.op = -1;
         BlackjackManager.instance.OperateBlackjack(0);
         _goodsList = null;
         _newGoodsInfo = null;
         super.dispose();
      }
   }
}


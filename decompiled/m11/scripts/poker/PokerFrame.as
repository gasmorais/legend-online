package poker
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PokerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class PokerFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _bg:DisplayObject;
      
      private var _cardsSprite:Sprite;
      
      private var _waitTxt:FilterFrameText;
      
      private var _dealerImg:Bitmap;
      
      private var _showLayer:Boolean;
      
      private var _pokerLayer:PokerLayer;
      
      private var _poolView:PokerPoolView;
      
      private var _scrollView:PokerScrollView;
      
      private var _exchangeView:PokerExchangeView;
      
      private var _posArr:Array = [[531,497],[60,393],[60,197],[521,73],[1000,197],[1000,393]];
      
      private var _dealerArr:Array = [[472,384],[236,344],[237,147],[470,149],[858,145],[858,340]];
      
      private var _timeId:int;
      
      public function PokerFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1155,745);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("poker.PokerFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("poker.BagBack");
         _bg = ComponentFactory.Instance.creatBitmap("asset.poker.back");
         _dealerImg = ComponentFactory.Instance.creatBitmap("asset.poker.dealerImg");
         _pokerLayer = ComponentFactory.Instance.creatCustomObject("poker.PokerLayer");
         _cardsSprite = ComponentFactory.Instance.creatCustomObject("poker.cardsSprite");
         _waitTxt = ComponentFactory.Instance.creatComponentByStylename("poker.waitStartTimeTxt");
         addToContent(_back);
         addToContent(_bg);
         addToContent(_dealerImg);
         addToContent(_cardsSprite);
         addToContent(_waitTxt);
         _waitTxt.text = LanguageMgr.GetTranslation("poker.PokerFrame.waitStart");
         _waitTxt.visible = false;
         _dealerImg.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("POKER_TABLE",__pokerTableHandler);
         NotificationManager.instance.addEventListener("POKER_BOARD",__pokerBoardHandler);
         NotificationManager.instance.addEventListener("POKER_LEAVE",__pokerLeaveHandler);
         NotificationManager.instance.addEventListener("POT_PRIZES_MSG",__pokerPrizesHandler);
         NotificationManager.instance.addEventListener("POKER_HAND_START",__handStartHandler);
         NotificationManager.instance.addEventListener("POKER_HAND_END",__handEndHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshAllBtnHandler);
         __pokerTableHandler(null);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("POKER_TABLE",__pokerTableHandler);
         NotificationManager.instance.removeEventListener("POKER_BOARD",__pokerBoardHandler);
         NotificationManager.instance.removeEventListener("POKER_LEAVE",__pokerLeaveHandler);
         NotificationManager.instance.removeEventListener("POT_PRIZES_MSG",__pokerPrizesHandler);
         NotificationManager.instance.removeEventListener("POKER_HAND_START",__handStartHandler);
         NotificationManager.instance.removeEventListener("POKER_HAND_END",__handEndHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshAllBtnHandler);
      }
      
      private function __pokerTableHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = PokerManager.instance.pokerPlayerArr;
         if(_loc2_.length > 0)
         {
            _waitTxt.visible = false;
            if(_pokerLayer)
            {
               _pokerLayer.refreshView();
            }
            if(_pokerLayer && _pokerLayer.parent)
            {
               _pokerLayer.parent.removeChild(_pokerLayer);
            }
            FrameControllerManager.instance.pokerControler.showPoker = true;
            _loc3_ = int(PokerManager.instance.getPokerPlayerNum());
            if(_loc3_ == 1)
            {
               _waitTxt.visible = true;
            }
            else if(!PokerManager.instance.checkPlayerActive())
            {
               _waitTxt.visible = true;
            }
            firstLayer(param1);
         }
         else
         {
            addToContent(_pokerLayer);
            ObjectUtils.disposeAllChildren(_cardsSprite);
            if(_poolView && _poolView.parent)
            {
               _poolView.parent.removeChild(_poolView);
            }
            if(_scrollView && _scrollView.parent)
            {
               _scrollView.parent.removeChild(_scrollView);
            }
            if(_exchangeView && _exchangeView.parent)
            {
               _exchangeView.parent.removeChild(_exchangeView);
            }
            FrameControllerManager.instance.pokerControler.showPoker = false;
            _waitTxt.visible = false;
            _dealerImg.visible = false;
            _showLayer = true;
         }
      }
      
      private function firstLayer(param1:NotificationEvent) : void
      {
         var _loc9_:PokerPlayerView = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:Array = PokerManager.instance.pokerPlayerArr;
         var _loc10_:int = int(PokerManager.instance.getMyselfPokerIdx());
         var _loc7_:int = int(param1.data ? param1.data.idx : -1);
         var _loc8_:int = -1;
         _loc11_ = 0;
         while(_loc11_ < _loc2_.length)
         {
            if(_loc11_ >= _loc10_)
            {
               _loc6_ = ++_loc8_;
               _loc3_ = int(_posArr[_loc6_][0]);
               _loc4_ = int(_posArr[_loc6_][1]);
            }
            else
            {
               _loc6_ = _loc2_.length - _loc10_ + _loc11_;
               _loc3_ = int(_posArr[_loc6_][0]);
               _loc4_ = int(_posArr[_loc6_][1]);
            }
            if(_loc7_ == -1)
            {
               _loc9_ = new PokerPlayerView(_loc2_[_loc11_],_loc6_);
               _loc9_.x = _loc3_;
               _loc9_.y = _loc4_;
               _cardsSprite.addChild(_loc9_);
            }
            else
            {
               _loc9_ = _cardsSprite.getChildAt(_loc11_) as PokerPlayerView;
               if(_loc11_ == _loc7_)
               {
                  _loc9_.refreshByOper(_loc2_[_loc11_]);
               }
            }
            _loc11_++;
         }
         if(!_poolView)
         {
            _poolView = ComponentFactory.Instance.creatCustomObject("poker.PokerPoolView");
         }
         if(!_scrollView)
         {
            _scrollView = ComponentFactory.Instance.creatCustomObject("poker.PokerScrollView");
         }
         if(!_exchangeView)
         {
            _exchangeView = ComponentFactory.Instance.creatCustomObject("poker.PokerExchangeView");
         }
         addToContent(_poolView);
         addToContent(_scrollView);
         addToContent(_exchangeView);
         _poolView.refreshView();
         _scrollView.refreshScrollVisible();
         _exchangeView.refreshView(_showLayer);
         _showLayer = false;
      }
      
      private function __pokerBoardHandler(param1:NotificationEvent) : void
      {
         _poolView.refreshView();
      }
      
      private function __pokerLeaveHandler(param1:NotificationEvent) : void
      {
         if(!PokerManager.instance.openSign)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poker.PokerFrame.gameOver"));
            dispose();
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __pokerPrizesHandler(param1:NotificationEvent) : void
      {
         var e:NotificationEvent = param1;
         _poolView.removePool();
         _scrollView.visible = false;
         _timeId = setTimeout(function():void
         {
            clearTimeout(_timeId);
            FrameControllerManager.instance.openControllerByInfo("poker",2,e.data);
         },1000);
      }
      
      private function __handStartHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         _waitTxt.visible = false;
         var _loc4_:int = int(PokerManager.instance.getMyselfPokerIdx());
         var _loc2_:int = int(PokerManager.instance.dealerPosition);
         if(_loc2_ != -1)
         {
            if(_loc2_ >= _loc4_)
            {
               _loc3_ = _loc2_ - _loc4_;
            }
            else
            {
               _loc3_ = _dealerArr.length - _loc4_ + _loc2_;
            }
            _dealerImg.visible = true;
            _dealerImg.x = _dealerArr[_loc3_][0];
            _dealerImg.y = _dealerArr[_loc3_][1];
         }
      }
      
      private function __handEndHandler(param1:NotificationEvent) : void
      {
         _dealerImg.visible = false;
         _waitTxt.visible = true;
      }
      
      private function __refreshAllBtnHandler(param1:NotificationEvent) : void
      {
         if(!PokerManager.instance.openSign)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("poker.PokerLayer.timeOver"));
         }
      }
      
      private function get palyerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function disposeFrame() : void
      {
         removeEvent();
         clearTimeout(_timeId);
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_dealerImg);
         _dealerImg = null;
         ObjectUtils.disposeAllChildren(_cardsSprite);
         ObjectUtils.disposeObject(_cardsSprite);
         _cardsSprite = null;
         ObjectUtils.disposeObject(_waitTxt);
         _waitTxt = null;
         ObjectUtils.disposeObject(_pokerLayer);
         _pokerLayer = null;
         ObjectUtils.disposeObject(_poolView);
         _poolView = null;
         ObjectUtils.disposeObject(_scrollView);
         _scrollView = null;
         ObjectUtils.disposeObject(_exchangeView);
         _exchangeView = null;
         FrameControllerManager.instance.pokerControler.showPoker = false;
         PokerManager.instance.clearPokerPlayerArr();
         KeyBoardRegister.instance.keyEnable = true;
         super.dispose();
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            PokerManager.instance.RequestPoker(4);
            disposeFrame();
         }
      }
      
      override public function dispose() : void
      {
         if(!PokerManager.instance.checkPlayerActive() || PokerManager.instance.pokerPlayerArr.length == 0)
         {
            __alertBackHandler(true,true);
            return;
         }
         SimpleAlertHelper.instance.data = [__alertBackHandler];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("poker.PokerFrame.quitPool");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,false,true);
      }
   }
}


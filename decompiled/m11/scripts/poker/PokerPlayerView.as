package poker
{
   import chat.datas.ChatData;
   import chat.datas.ChatFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.pet.CardMsg;
   import com.road.yishi.proto.pet.TableChannelMessage;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.poker.PokerPlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PokerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PokerPlayerView extends Component
   {
      
      private var _blackGound:Sprite;
      
      private var _headBg:Bitmap;
      
      private var _headIcon:BaseIconView;
      
      private var _nameBg:Bitmap;
      
      private var _card1:PokerCardView;
      
      private var _card2:PokerCardView;
      
      private var _cardSprite:Sprite;
      
      private var _info:PokerPlayerInfo;
      
      private var _idx:int;
      
      private var _chipIconBg:Bitmap;
      
      private var _chipBgSprite:Sprite;
      
      private var _chipSmallBg:Bitmap;
      
      private var _chipIcon:Image;
      
      private var _chipsIcon:Image;
      
      private var _actionImage:ScaleFrameImage;
      
      private var _playerNameTxt:FilterFrameText;
      
      private var _hasChipsTxt:FilterFrameText;
      
      private var _downChipsTxt:FilterFrameText;
      
      private var _handTypeTxt:FilterFrameText;
      
      private var _foldIcon:Bitmap;
      
      private var _cardStack1:MovieClip;
      
      private var _cardStack2:MovieClip;
      
      private var _cdEffect:PokerCDEffect;
      
      private var _chatPopView:Component;
      
      public function PokerPlayerView(param1:PokerPlayerInfo, param2:int)
      {
         super();
         _info = param1;
         _idx = param2;
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _blackGound = new Sprite();
         _blackGound.graphics.clear();
         _blackGound.graphics.beginFill(0,0.6);
         _blackGound.graphics.drawRect(6,2,90,96);
         _blackGound.graphics.endFill();
         _headBg = ComponentFactory.Instance.creatBitmap("asset.poker.playerHeadBg");
         _headIcon = ComponentFactory.Instance.creatCustomObject("poker.PokerPlayerIcon");
         _nameBg = ComponentFactory.Instance.creatBitmap("asset.poker.playerNameBg");
         _chipIconBg = ComponentFactory.Instance.creatBitmap("asset.poker.chipIconBg");
         _chipBgSprite = ComponentFactory.Instance.creatCustomObject("poker.chipBgSprite");
         _chipSmallBg = ComponentFactory.Instance.creatBitmap("asset.poker.chipSmallBg");
         _chipIcon = ComponentFactory.Instance.creatComponentByStylename("poker.chipIcon1");
         _chipsIcon = ComponentFactory.Instance.creatComponentByStylename("poker.chipsIcon");
         _actionImage = ComponentFactory.Instance.creatComponentByStylename("poker.actionFrameImage");
         _playerNameTxt = ComponentFactory.Instance.creatComponentByStylename("poker.playerNameTxt");
         _hasChipsTxt = ComponentFactory.Instance.creatComponentByStylename("poker.hasChipsTxt");
         _downChipsTxt = ComponentFactory.Instance.creatComponentByStylename("poker.downChipsTxt");
         _handTypeTxt = ComponentFactory.Instance.creatComponentByStylename("poker.handTypeTxt");
         _foldIcon = ComponentFactory.Instance.creatBitmap("asset.poker.foldIcon");
         _cardSprite = ComponentFactory.Instance.creatCustomObject("poker.playCardSprite");
         _cardStack1 = ComponentFactory.Instance.creatCustomObject("poker.cardStack");
         _cardStack2 = ComponentFactory.Instance.creatCustomObject("poker.cardStack");
         _cardStack1.stop();
         _cardStack2.stop();
         addChild(_headBg);
         addChild(_headIcon);
         addChild(_nameBg);
         addChild(_chipIconBg);
         addChild(_chipIcon);
         addChild(_chipBgSprite);
         _chipBgSprite.addChild(_chipSmallBg);
         _chipBgSprite.addChild(_chipsIcon);
         _chipBgSprite.addChild(_downChipsTxt);
         addChild(_actionImage);
         addChild(_playerNameTxt);
         addChild(_hasChipsTxt);
         addChild(_handTypeTxt);
         addChild(_blackGound);
         addChild(_foldIcon);
         addChild(_cardSprite);
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("POKER_PLAYER_UPDATE",__playerUpdateHandler);
         NotificationManager.instance.addEventListener("POKER_ROTATE",__playerRotateHandler);
         NotificationManager.instance.addEventListener("POKER_PLAYER_ACTED",__playerActedHandler);
         NotificationManager.instance.addEventListener("POKER_HAND_START",__handStartHandler);
         NotificationManager.instance.addEventListener("POKER_HAND_END",__handEndHandler);
         NotificationManager.instance.addEventListener("POKER_CHAT_MSG",__chatMsgHandler);
         NotificationManager.instance.addEventListener("POT_PRIZES_MSG",__pokerPrizesHandler);
         __handStartHandler(null);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("POKER_PLAYER_UPDATE",__playerUpdateHandler);
         NotificationManager.instance.removeEventListener("POKER_ROTATE",__playerRotateHandler);
         NotificationManager.instance.removeEventListener("POKER_PLAYER_ACTED",__playerActedHandler);
         NotificationManager.instance.removeEventListener("POKER_HAND_START",__handStartHandler);
         NotificationManager.instance.removeEventListener("POKER_HAND_END",__handEndHandler);
         NotificationManager.instance.removeEventListener("POKER_CHAT_MSG",__chatMsgHandler);
         NotificationManager.instance.removeEventListener("POT_PRIZES_MSG",__pokerPrizesHandler);
      }
      
      private function __playerUpdateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:PokerPlayerInfo = param1.data as PokerPlayerInfo;
         if(_loc2_.userId == _info.userId && _loc2_.serverName == _info.serverName)
         {
            _info = _loc2_;
            refreshView();
         }
      }
      
      private function __playerRotateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:PokerPlayerInfo = param1.data as PokerPlayerInfo;
         if(_loc2_.cash != 0 && _loc2_.userId == _info.userId && _loc2_.serverName == _info.serverName)
         {
            _cdEffect = new PokerCDEffect(15000,cdCompleteHandler,updateCDNum,72);
            _cdEffect.x = 14;
            _cdEffect.y = 4;
            _cdEffect.start();
            addChild(_cdEffect);
         }
      }
      
      private function __playerActedHandler(param1:NotificationEvent) : void
      {
         var _loc2_:PokerPlayerInfo = param1.data as PokerPlayerInfo;
         if(_loc2_.userId == _info.userId && _loc2_.serverName == _info.serverName)
         {
            _info = _loc2_;
            cdCompleteHandler();
            refreshView();
         }
      }
      
      private function __handStartHandler(param1:NotificationEvent) : void
      {
         var _loc4_:PokerPlayerInfo = null;
         var _loc3_:int = 0;
         var _loc2_:Array = PokerManager.instance.activePlayersArr;
         setUnActive = true;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_] as PokerPlayerInfo;
            if(_loc4_.userId == _info.userId && _loc4_.serverName == _info.serverName)
            {
               setUnActive = false;
            }
            _loc3_++;
         }
      }
      
      private function __pokerPrizesHandler(param1:NotificationEvent) : void
      {
         cdCompleteHandler();
      }
      
      protected function cdCompleteHandler() : void
      {
         if(_cdEffect)
         {
            _cdEffect.stop();
            ObjectUtils.disposeObject(_cdEffect);
            _cdEffect = null;
         }
      }
      
      protected function updateCDNum() : void
      {
      }
      
      private function __handEndHandler(param1:NotificationEvent) : void
      {
         if(!_info)
         {
            return;
         }
         setUnActive = true;
      }
      
      private function __chatMsgHandler(param1:NotificationEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:TableChannelMessage = param1.data as TableChannelMessage;
         if(_loc2_.source.userId != _info.userId || _loc2_.source.serverName != _info.serverName)
         {
            return;
         }
         var _loc3_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         if(_loc2_.type == 1)
         {
            _loc4_ = analyzeExpression(_loc2_.msg);
            _loc3_.msg = _loc4_;
         }
         else if(_loc2_.type == 2)
         {
            _loc3_.msg = _loc2_.msg;
         }
         if(_chatPopView)
         {
            _chatPopView.dispose();
            _chatPopView = null;
         }
         if(!_chatPopView)
         {
            _chatPopView = ChatFactory.createChatPopByType(_loc3_,chatBack);
            if(_idx == 3)
            {
               _chatPopView.x = -181;
               _chatPopView.y = -3;
            }
            else
            {
               _chatPopView.x = -23;
               _chatPopView.y = -60;
            }
            addChild(_chatPopView);
         }
      }
      
      private function chatBack() : void
      {
         _chatPopView = null;
      }
      
      private function analyzeExpression(param1:String) : String
      {
         var _loc2_:String = param1.replace(/\<([^>]*)>*/g,"");
         if(_loc2_.search(/(#)([0-3][0-9])/g) != -1)
         {
            _loc2_ = param1.replace(/(#)([0-3][0-9])/g,"<a t=\'9\' index=\'$2\' name=\'$2\'/>");
            return filterSpecialChar(_loc2_);
         }
         return filterSpecialChar(param1);
      }
      
      private function filterSpecialChar(param1:String) : String
      {
         return param1.replace(/­/g,"-");
      }
      
      public function refreshByOper(param1:PokerPlayerInfo) : void
      {
         _info = param1;
         if(_info && PokerManager.instance.activePlayersArr.indexOf(_info) == -1)
         {
            setUnActive = true;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:CardMsg = null;
         ObjectUtils.disposeObject(_card1);
         _card1 = null;
         ObjectUtils.disposeObject(_card2);
         _card2 = null;
         if(_cardStack1.parent)
         {
            _cardStack1.parent.removeChild(_cardStack1);
         }
         if(_cardStack2.parent)
         {
            _cardStack2.parent.removeChild(_cardStack2);
         }
         if(_info.userId != 0)
         {
            this.visible = true;
            this.alpha = 1;
            _headIcon.icon = IconFactory.getPlayerIcon(_info.headId,"head");
            _playerNameTxt.text = _info.userName;
            _hasChipsTxt.text = _info.cash + "";
            _downChipsTxt.text = _info.bet + "";
            _handTypeTxt.text = LanguageMgr.GetTranslation("poker.PokerPlayerView.handType" + _info.handType);
            if(_info.cardArr.length == 2)
            {
               _loc1_ = _info.cardArr[0];
               _card1 = new PokerCardView(_loc1_.suit,_loc1_.rank);
               _loc1_ = _info.cardArr[1];
               _card2 = new PokerCardView(_loc1_.suit,_loc1_.rank);
               _card2.x = 40;
               _cardSprite.addChild(_card1);
               _cardSprite.addChild(_card2);
            }
            else
            {
               addChild(_cardStack1);
               addChild(_cardStack2);
            }
            _downChipsTxt.visible = _info.bet > 0;
            _chipSmallBg.visible = _info.bet > 0;
            _chipsIcon.visible = _info.bet > 0;
            _handTypeTxt.visible = isHandType();
            _foldIcon.visible = false;
            _actionImage.visible = false;
            if(isAllIn())
            {
               _actionImage.visible = true;
               _actionImage.setFrame(2);
            }
            else if(isFollow())
            {
               _actionImage.visible = true;
               _actionImage.setFrame(1);
            }
            else if(isQuit())
            {
               _actionImage.visible = true;
               _actionImage.setFrame(3);
               if(_blackGound)
               {
                  _blackGound.visible = true;
               }
               if(_foldIcon)
               {
                  _foldIcon.visible = true;
               }
               if(_cardStack1)
               {
                  _cardStack1.visible = false;
               }
               if(_cardStack2)
               {
                  _cardStack2.visible = false;
               }
            }
            else if(isCheck())
            {
               _actionImage.visible = true;
               _actionImage.setFrame(4);
            }
            else if(isRaise())
            {
               _actionImage.visible = true;
               _actionImage.setFrame(5);
            }
         }
         else
         {
            this.visible = false;
            cdCompleteHandler();
         }
         checkAllPos();
      }
      
      private function isFollow() : Boolean
      {
         return _info.action == 1 || _info.action == 3;
      }
      
      private function isAllIn() : Boolean
      {
         var _loc3_:PokerPlayerInfo = null;
         var _loc2_:int = 0;
         var _loc1_:Array = PokerManager.instance.activePlayersArr;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as PokerPlayerInfo;
            if(_loc3_.userId == _info.userId && _info.cash == 0)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function isQuit() : Boolean
      {
         return _info.action == 5;
      }
      
      private function isCheck() : Boolean
      {
         return _info.action == 4;
      }
      
      private function isRaise() : Boolean
      {
         return _info.action == 6;
      }
      
      private function isHandType() : Boolean
      {
         return _info.hasCard && _info.cardArr.length == 2;
      }
      
      private function set setUnActive(param1:Boolean) : void
      {
         if(_blackGound)
         {
            _blackGound.visible = param1;
         }
         if(_cardStack1)
         {
            _cardStack1.visible = !param1;
         }
         if(_cardStack2)
         {
            _cardStack2.visible = !param1;
         }
      }
      
      private function checkAllPos() : void
      {
         switch(_idx)
         {
            case 0:
               if(_cardSprite)
               {
                  _cardSprite.x = 96;
               }
               if(_cardSprite)
               {
                  _cardSprite.y = 3;
               }
               _cardStack1.x = 96;
               _cardStack1.y = 3;
               _cardStack2.x = 136;
               _cardStack2.y = 3;
               _chipBgSprite.x = 0;
               _chipBgSprite.y = 0;
               _actionImage.x = 106;
               _actionImage.y = 94;
               break;
            case 1:
               if(_cardSprite)
               {
                  _cardSprite.x = 96;
               }
               if(_cardSprite)
               {
                  _cardSprite.y = 3;
               }
               _cardStack1.x = 97;
               _cardStack1.y = 3;
               _cardStack2.x = 132;
               _cardStack2.y = 3;
               _chipBgSprite.x = 199;
               _chipBgSprite.y = 101;
               _actionImage.x = 108;
               _actionImage.y = 97;
               break;
            case 2:
               if(_cardSprite)
               {
                  _cardSprite.x = 96;
               }
               if(_cardSprite)
               {
                  _cardSprite.y = 3;
               }
               _cardStack1.x = 97;
               _cardStack1.y = 3;
               _cardStack2.x = 130;
               _cardStack2.y = 3;
               _chipBgSprite.x = 199;
               _chipBgSprite.y = 101;
               _actionImage.x = 108;
               _actionImage.y = 97;
               break;
            case 3:
               if(_cardSprite)
               {
                  _cardSprite.x = 96;
               }
               if(_cardSprite)
               {
                  _cardSprite.y = 3;
               }
               _cardStack1.x = 96;
               _cardStack1.y = 3;
               _cardStack2.x = 136;
               _cardStack2.y = 3;
               _chipBgSprite.x = 6;
               _chipBgSprite.y = 186;
               _actionImage.x = 106;
               _actionImage.y = 94;
               break;
            case 4:
               if(_cardSprite)
               {
                  _cardSprite.x = -90;
               }
               if(_cardSprite)
               {
                  _cardSprite.y = 3;
               }
               _cardStack1.x = -90;
               _cardStack1.y = 3;
               _cardStack2.x = -50;
               _cardStack2.y = 3;
               _chipBgSprite.x = -193;
               _chipBgSprite.y = 96;
               _actionImage.x = -50;
               _actionImage.y = 94;
               break;
            case 5:
               if(_cardSprite)
               {
                  _cardSprite.x = -90;
               }
               if(_cardSprite)
               {
                  _cardSprite.y = 3;
               }
               _cardStack1.x = -90;
               _cardStack1.y = 3;
               _cardStack2.x = -50;
               _cardStack2.y = 3;
               _chipBgSprite.x = -193;
               _chipBgSprite.y = 96;
               _actionImage.x = -50;
               _actionImage.y = 94;
         }
      }
      
      public function get info() : PokerPlayerInfo
      {
         return _info;
      }
      
      public function get cardSprite() : Sprite
      {
         return _cardSprite;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_blackGound);
         _blackGound = null;
         ObjectUtils.disposeObject(_headBg);
         _headBg = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_nameBg);
         _nameBg = null;
         ObjectUtils.disposeObject(_card1);
         _card1 = null;
         ObjectUtils.disposeObject(_card2);
         _card2 = null;
         ObjectUtils.disposeObject(_cardSprite);
         _cardSprite = null;
         ObjectUtils.disposeObject(_chipIconBg);
         _chipIconBg = null;
         ObjectUtils.disposeObject(_chipSmallBg);
         _chipSmallBg = null;
         ObjectUtils.disposeObject(_chipIcon);
         _chipIcon = null;
         ObjectUtils.disposeObject(_chipsIcon);
         _chipsIcon = null;
         ObjectUtils.disposeObject(_actionImage);
         _actionImage = null;
         ObjectUtils.disposeObject(_playerNameTxt);
         _playerNameTxt = null;
         ObjectUtils.disposeObject(_hasChipsTxt);
         _hasChipsTxt = null;
         ObjectUtils.disposeObject(_downChipsTxt);
         _downChipsTxt = null;
         ObjectUtils.disposeObject(_handTypeTxt);
         _handTypeTxt = null;
         ObjectUtils.disposeObject(_foldIcon);
         _foldIcon = null;
         ObjectUtils.disposeViolentMc(_cardStack1);
         _cardStack1 = null;
         ObjectUtils.disposeViolentMc(_cardStack2);
         _cardStack2 = null;
         ObjectUtils.disposeObject(_cdEffect);
         _cdEffect = null;
         ObjectUtils.disposeObject(_chatPopView);
         _chatPopView = null;
         _info = null;
         super.dispose();
      }
   }
}


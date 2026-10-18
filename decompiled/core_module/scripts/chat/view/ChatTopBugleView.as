package chat.view
{
   import chat.ChatManager;
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import simplegame.roses.PetalFlyView;
   import yishi.actions.base.AlertTipAction;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DelayActionsUtils;
   
   public class ChatTopBugleView extends Sprite implements Disposeable
   {
      
      private static var _instance:ChatTopBugleView;
      
      private var _bg:ScaleFrameImage;
      
      private var _bugleIcon:ScaleFrameImage;
      
      private var _roseLaceImg:MutipleImage;
      
      private var _petalFlyView:PetalFlyView;
      
      private var _flower:MovieClip;
      
      private var _contentTxt1:FilterFrameText;
      
      private var _contentTxt2:ExpressionChatNotic;
      
      private var _list:Vector.<ChatData>;
      
      private var _posY1:int = 30;
      
      private var _posY2:int = -42;
      
      private var _dwellTime:int = 2000;
      
      private var _curBugleType:int = -1;
      
      private var _timeId1:uint;
      
      private const NO_PLAY_SCENE_LIST:Array = ["BATTLE_SCENE","PVE_ROOM_SCENE","PVP_ROOM_SCENE","MULTILORDS_ROOM","CHANLLENGE_ROOM_SCENE","PLANES_WAR_SCENE","UNREAL_SHOOTING_ROOM"];
      
      private var _isShowing:Boolean;
      
      private var _currentData:ChatData;
      
      private var _isPlaying:Boolean;
      
      public function ChatTopBugleView()
      {
         super();
      }
      
      public static function get instance() : ChatTopBugleView
      {
         if(_instance == null)
         {
            _instance = new ChatTopBugleView();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _list = new Vector.<ChatData>();
         initView();
         addEvent();
         if(thane.grades < 6)
         {
            visible = false;
            thane.addEventListener("THANE_LEVEL_UPDATE",__levelUpHandler);
         }
      }
      
      private function initView() : void
      {
         mouseEnabled = mouseChildren = false;
         _bg = ComponentFactory.Instance.creatComponentByStylename("chatII.BugleBg");
         _bugleIcon = ComponentFactory.Instance.creatComponentByStylename("chatII.BugleIcon");
         _roseLaceImg = ComponentFactory.Instance.creatComponentByStylename("chatII.RoseLaceImg");
         _contentTxt1 = ComponentFactory.Instance.creatComponentByStylename("chatII.BugleViewText");
         _contentTxt2 = new ExpressionChatNotic();
         _contentTxt2.x = 68;
         _contentTxt2.y = 30;
         _contentTxt2.lineWidth = 560;
         _bg.setFrame(1);
         _roseLaceImg.visible = false;
         addChild(_bg);
         addChild(_bugleIcon);
         addChild(_roseLaceImg);
         _bg.addChild(_contentTxt1);
         _bg.addChild(_contentTxt2);
         __resize(null);
         _bg.scrollRect = new Rectangle(0,0,_bg.displayWidth,_bg.displayHeight);
      }
      
      private function __levelUpHandler(param1:PlayerEvent) : void
      {
         if(thane.grades >= 6)
         {
            visible = true;
            thane.removeEventListener("THANE_LEVEL_UPDATE",__levelUpHandler);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function moveOut() : void
      {
         if(_isShowing)
         {
            if(_contentTxt1.numLines == 1)
            {
               TweenMax.to(_contentTxt1,1,{
                  "y":_posY2 + 23,
                  "onComplete":outComplete
               });
               TweenMax.to(_contentTxt2,1,{
                  "y":_posY2 + 23,
                  "onComplete":outComplete
               });
            }
            else
            {
               TweenMax.to(_contentTxt1,1,{
                  "y":_posY2,
                  "onComplete":outComplete
               });
               TweenMax.to(_contentTxt2,1,{
                  "y":_posY2,
                  "onComplete":outComplete
               });
            }
         }
      }
      
      private function outComplete() : void
      {
         TweenMax.killTweensOf(_contentTxt1);
         TweenMax.killTweensOf(_contentTxt2);
         _isShowing = false;
         _contentTxt1.y = _posY1;
         _contentTxt2.y = _posY1;
         playNext();
      }
      
      private function moveIn() : void
      {
         var _loc1_:String = null;
         var _loc4_:Array = null;
         var _loc9_:int = 0;
         var _loc2_:String = null;
         var _loc6_:XML = null;
         var _loc8_:String = null;
         var _loc7_:String = null;
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc11_:String = null;
         if(_currentData.bigBugleType == 4)
         {
            _isShowing = true;
            _contentTxt1.setFrame(1);
            _contentTxt1.visible = true;
            _contentTxt1.x = 85;
            _contentTxt1.y = 45;
            _contentTxt1.width = 560;
            _contentTxt2.visible = false;
            _contentTxt2.x = 85;
            _contentTxt2.y = 45;
            _contentTxt2.lineWidth = 560;
         }
         else
         {
            _isShowing = true;
            _contentTxt1.setFrame(1);
            _contentTxt1.visible = true;
            _contentTxt1.x = 68;
            _contentTxt1.y = 30;
            _contentTxt1.width = 560;
            _contentTxt2.visible = false;
            _contentTxt2.x = 68;
            _contentTxt2.y = 30;
            _contentTxt2.lineWidth = 560;
         }
         if(_currentData.channel == 11)
         {
            _loc1_ = _currentData.msg;
            _loc4_ = _loc1_.match(/\<([^>]*)>*/g);
            _loc9_ = 0;
            while(_loc9_ < _loc4_.length)
            {
               try
               {
                  _loc2_ = _loc4_[_loc9_];
                  _loc6_ = new XML(_loc2_);
                  _loc8_ = _loc6_.@name;
                  _loc1_ = _loc1_.replace(_loc2_,_loc8_);
               }
               catch(e:Error)
               {
                  _loc1_ = "";
               }
               _loc9_++;
            }
            _contentTxt1.htmlText = _loc1_;
         }
         else if(_currentData.channel == 12)
         {
            _contentTxt1.htmlText = _currentData.msg;
            if(isMarryBugleType)
            {
               _currentData.channel = 13;
            }
            _currentData.msg = ChatManager.instance.analyzeExpressionAfterNormal(_currentData.msg);
            _currentData.msg = _currentData.msg;
            _currentData.chatItemData.cellVector = ChatFormat.getContentCellData(_currentData);
            _contentTxt2.needFilters = true;
            _contentTxt2.data = _currentData;
            _currentData.channel = 12;
            _contentTxt1.visible = false;
            _contentTxt2.visible = true;
         }
         else if(_currentData.channel == 1 || _currentData.channel == 15)
         {
            if(!isMarryBugleType)
            {
               _loc7_ = LanguageMgr.GetTranslation("chatII.view.ChatTopBugleView.useBigHorn");
               _loc5_ = "[" + _currentData.senderName + "]" + _loc7_;
            }
            _contentTxt1.htmlText = _loc5_ + _currentData.getNormalMsg();
            _currentData.msg = ChatManager.instance.analyzeExpressionAfterNormal(_currentData.msg);
            _currentData.msg = _loc5_ + _currentData.msg;
            _currentData.channel = 1;
            _currentData.chatItemData.cellVector = ChatFormat.getContentCellData(_currentData);
            _contentTxt2.needFilters = true;
            _contentTxt2.data = _currentData;
            _contentTxt1.visible = false;
            _contentTxt2.visible = true;
         }
         else if(_currentData.channel == 13)
         {
            _loc3_ = LanguageMgr.GetTranslation("chatII.view.ChatTopBugleView.useCrossHorn");
            _loc11_ = "<font color=\'#00d8ff\'>[" + _currentData.serverName + "-" + _currentData.senderName + "]</font><font color=\'#ffba01\'>" + _loc3_;
            _contentTxt1.setFrame(2);
            _contentTxt1.htmlText = _loc11_ + _currentData.getNormalMsg() + "</font>";
            _loc11_ = "[" + _currentData.serverName + "-" + _currentData.senderName + "]" + _loc3_;
            _currentData.msg = ChatManager.instance.analyzeExpressionAfterNormal(_currentData.msg);
            _currentData.msg = _loc11_ + _currentData.msg;
            _currentData.channel = 13;
            _currentData.chatItemData.cellVector = ChatFormat.getContentCellData(_currentData);
            _contentTxt2.needFilters = true;
            _contentTxt2.data = _currentData;
            _contentTxt1.visible = false;
            _contentTxt2.visible = true;
         }
         _contentTxt1.height = _contentTxt1.textHeight + 4;
         var _loc10_:int = 5;
         if(isMarryBugleType)
         {
            _contentTxt1.x = _contentTxt2.x = 118;
            _loc10_ = 7;
         }
         if(_currentData.bigBugleType == 4)
         {
            _loc10_ = 18;
         }
         if(_contentTxt1.numLines == 1)
         {
            if(_currentData.bigBugleType == 4)
            {
               TweenMax.to(_contentTxt1,1,{
                  "y":25,
                  "onComplete":inComplete
               });
            }
            else
            {
               TweenMax.to(_contentTxt1,1,{
                  "y":12,
                  "onComplete":inComplete
               });
            }
         }
         else
         {
            TweenMax.to(_contentTxt1,1,{
               "y":_loc10_,
               "onComplete":inComplete
            });
         }
         if(_contentTxt2.totalLine == 1)
         {
            if(_currentData.bigBugleType == 4)
            {
               TweenMax.to(_contentTxt2,1,{
                  "y":25,
                  "onComplete":inComplete
               });
            }
            else
            {
               TweenMax.to(_contentTxt2,1,{
                  "y":12,
                  "onComplete":inComplete
               });
            }
         }
         else
         {
            TweenMax.to(_contentTxt2,1,{
               "y":_loc10_,
               "onComplete":inComplete
            });
         }
      }
      
      private function get isMarryBugleType() : Boolean
      {
         return _curBugleType == 6 || _curBugleType == 7 || _curBugleType == 8 || _curBugleType == 9;
      }
      
      private function inComplete() : void
      {
         TweenMax.killTweensOf(_contentTxt1);
         TweenMax.killTweensOf(_contentTxt2);
         setTimeout(moveOut,_dwellTime);
      }
      
      private function playNext() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_currentData)
         {
            _currentData.dispose();
            _currentData = null;
         }
         _currentData = _list.shift();
         if(!_currentData)
         {
            dispose();
            return;
         }
         show();
         setViewByBugleType(_currentData.bigBugleType);
         if(!_isShowing)
         {
            moveIn();
            if(checkScene())
            {
               switch(_currentData.bigBugleType - 1)
               {
                  case 0:
                  case 1:
                  case 5:
                  case 8:
                     if(_currentData.receiverName == thane.nickName)
                     {
                        _loc1_ = _currentData.bigBugleType == 1 ? 2170003 : 2170004;
                        DelayActionsUtils.instance.addAction(new AlertTipAction([_loc1_,_currentData.senderName],showPresentBackCall));
                     }
                     break;
                  case 2:
                     CheckUIModuleUtil.instance.tryCall("warlords",showFireworkCall,[50,_dwellTime / 1000,_currentData.bigBugleType,3,20]);
                     break;
                  case 3:
                     if(_currentData.friendId == thane.userId)
                     {
                        _loc2_ = 2170005;
                        DelayActionsUtils.instance.addAction(new AlertTipAction([_loc2_,_currentData.senderName,_currentData.uid],showPresentBackCall1));
                     }
                     break;
                  case 4:
                     CheckUIModuleUtil.instance.tryCall("warlords",showFireworkCall,[0,_dwellTime / 1000,_currentData.bigBugleType,5,100]);
                     break;
                  case 6:
                     CheckUIModuleUtil.instance.tryCall("wedding",showFireworkCall,[90,_dwellTime / 1000,_currentData.bigBugleType,3,0]);
                     break;
                  case 7:
                     CheckUIModuleUtil.instance.tryCall("wedding",showKiloWeddingCall,[150,_dwellTime / 1000,_currentData.bigBugleType,3]);
                     break;
                  case 9:
                     CheckUIModuleUtil.instance.tryCall("wedding",showWeddingFlowerCall);
                     break;
                  case 10:
                     CheckUIModuleUtil.instance.tryCall("warlords",showFireworkCall,[0,_dwellTime / 1000,_currentData.bigBugleType,15,100]);
                     break;
                  case 13:
                     break;
                  case 14:
                     CheckUIModuleUtil.instance.tryCall("warlords",showFireworkCall,[80,_dwellTime / 1000,_currentData.bigBugleType]);
               }
            }
         }
      }
      
      private function showPresentBackCall(param1:Array) : void
      {
         FrameControllerManager.instance.friendControler.startFrameByType(5,param1);
      }
      
      private function showPresentBackCall1(param1:Array) : void
      {
         FrameControllerManager.instance.friendControler.startFrameByType(8,param1);
      }
      
      private function showWeddingFlowerCall() : void
      {
         _flower = ClassUtils.CreatInstance("asset.wedding.flower2") as MovieClip;
         LayerManager.Instance.addToLayer(_flower,2,true,false);
         _flower.x -= 300;
         _flower.y -= 200;
         _timeId1 = setTimeout(cleanFlower,5000);
         var _loc1_:Frame = FrameControllerManager.instance.armyController.frame;
         if(_loc1_)
         {
            _loc1_.dispose();
         }
      }
      
      private function cleanFlower() : void
      {
         clearTimeout(_timeId1);
         ObjectUtils.disposeViolentMc(_flower);
         _flower = null;
      }
      
      private function showFireworkCall(param1:Array) : void
      {
      }
      
      private function showKiloWeddingCall(param1:Array) : void
      {
      }
      
      private function setViewByBugleType(param1:int) : void
      {
         if(_curBugleType == param1)
         {
            return;
         }
         _curBugleType = param1;
         switch(_curBugleType)
         {
            case 0:
               _bg.setFrame(1);
               _bugleIcon.visible = true;
               _bugleIcon.setFrame(1);
               _roseLaceImg.visible = false;
               _contentTxt1.width = 560;
               _contentTxt1.x = 68;
               _contentTxt2.lineWidth = 560;
               _contentTxt2.x = 68;
               _dwellTime = 2000;
               break;
            case 1:
               _bg.setFrame(2);
               _bugleIcon.visible = false;
               _roseLaceImg.visible = true;
               _contentTxt1.width = 560;
               _contentTxt1.x = 48;
               _contentTxt2.lineWidth = 560;
               _contentTxt2.x = 48;
               _dwellTime = 20000;
               break;
            case 2:
               _bg.setFrame(2);
               _bugleIcon.visible = false;
               _roseLaceImg.visible = true;
               _contentTxt1.width = 590;
               _contentTxt1.x = 43;
               _contentTxt2.lineWidth = 590;
               _contentTxt2.x = 43;
               _dwellTime = 20000;
               break;
            case 3:
               _bg.setFrame(3);
               _bugleIcon.visible = true;
               _bugleIcon.setFrame(1);
               _roseLaceImg.visible = false;
               _contentTxt1.width = 520;
               _contentTxt1.x = 81;
               _contentTxt2.lineWidth = 520;
               _contentTxt2.x = 81;
               _dwellTime = 20000;
               break;
            case 4:
               _bg.setFrame(8);
               _bugleIcon.visible = false;
               _roseLaceImg.visible = false;
               _contentTxt1.width = 590;
               _contentTxt1.x = 80;
               _contentTxt2.lineWidth = 590;
               _contentTxt2.x = 80;
               _dwellTime = 60000;
               break;
            case 5:
            case 11:
               _bugleIcon.visible = false;
               _dwellTime = 6000;
               break;
            case 6:
               _bg.setFrame(5);
               _bugleIcon.visible = true;
               _bugleIcon.setFrame(2);
               _roseLaceImg.visible = false;
               _contentTxt1.width = 560;
               _contentTxt1.x = 68;
               _contentTxt2.lineWidth = 560;
               _contentTxt2.x = 118;
               _dwellTime = 18000;
               break;
            case 7:
            case 9:
               _bg.setFrame(5);
               _bugleIcon.visible = true;
               _bugleIcon.setFrame(3);
               _roseLaceImg.visible = false;
               _contentTxt1.width = 560;
               _contentTxt1.x = 68;
               _contentTxt2.lineWidth = 560;
               _contentTxt2.x = 118;
               _dwellTime = 18000;
               break;
            case 8:
               _bg.setFrame(5);
               _bugleIcon.visible = true;
               _bugleIcon.setFrame(3);
               _roseLaceImg.visible = false;
               _contentTxt1.width = 560;
               _contentTxt1.x = 68;
               _contentTxt2.lineWidth = 560;
               _contentTxt2.x = 118;
               _dwellTime = 12000;
               break;
            case 13:
               _bg.setFrame(6);
               _bugleIcon.visible = false;
               _roseLaceImg.visible = false;
               _contentTxt1.width = 590;
               _contentTxt1.x = 143;
               _contentTxt2.lineWidth = 590;
               _contentTxt2.x = 143;
               _dwellTime = 20000;
               break;
            case 14:
               _bg.setFrame(7);
               _bugleIcon.visible = false;
               _roseLaceImg.visible = false;
               _contentTxt1.width = 560;
               _contentTxt1.x = 48;
               _contentTxt2.lineWidth = 560;
               _contentTxt2.x = 48;
               _dwellTime = 20000;
               break;
            case 15:
               _bugleIcon.visible = false;
               _dwellTime = 18000;
         }
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resize);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__onSceneChangeHandler);
         NotificationManager.instance.addEventListener("UPDATE_BIGBUGLE_VIEW",__addDataHandler);
      }
      
      private function __addDataHandler(param1:NotificationEvent) : void
      {
         var _loc5_:Boolean = false;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         ObjectUtils.copyProperties(_loc3_,param1.data,true);
         if(thane.grades < 6)
         {
            return;
         }
         if(_loc3_)
         {
            _loc5_ = false;
            _loc2_ = int(_list.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               if(_list[_loc4_].bigBugleType == 5)
               {
                  _list.splice(_loc4_,0,_loc3_);
                  _loc5_ = true;
                  break;
               }
               _loc4_++;
            }
            if(!_loc5_)
            {
               _list.push(_loc3_);
            }
         }
         if(!_isPlaying)
         {
            _isPlaying = true;
            playNext();
         }
      }
      
      private function __resize(param1:Event) : void
      {
         setPos();
      }
      
      private function __onSceneChangeHandler(param1:NotificationEvent) : void
      {
         if(checkScene())
         {
            visible = !(_currentData && (_currentData.bigBugleType == 5 || _currentData.bigBugleType == 10 || _currentData.bigBugleType == 11));
         }
         else
         {
            visible = false;
            clearPetalFly();
         }
      }
      
      public function show() : void
      {
         if(!parent)
         {
            LayerManager.Instance.addToLayer(this,2);
         }
         __onSceneChangeHandler(null);
         setPos();
      }
      
      public function setPos(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         var _loc4_:String = SceneManager.instance.currentType;
         if("BATTLE_SCENE" !== _loc4_)
         {
            y = 103;
         }
         else if(param3)
         {
            y = param2;
         }
         x = (StageReferance.stage.stageWidth - width) / 2 + 60;
      }
      
      private function checkScene() : Boolean
      {
         return NO_PLAY_SCENE_LIST.indexOf(SceneManager.instance.currentType) == -1;
      }
      
      private function clearPetalFly() : void
      {
         if(_petalFlyView)
         {
            _petalFlyView.dispose();
            _petalFlyView = null;
         }
      }
      
      public function dispose() : void
      {
         TweenMax.killTweensOf(_contentTxt1);
         TweenMax.killTweensOf(_contentTxt2);
         _isShowing = false;
         _isPlaying = false;
         cleanFlower();
         clearPetalFly();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


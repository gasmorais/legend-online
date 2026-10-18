package mainBar
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.TimeBoxEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.view.BoxMovieView;
   import managers.BoxManager;
   import managers.BoxSocketOutManager;
   import map.campaign.CampaignManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.TimeDownView;
   
   public class TimeBoxView extends Sprite implements Disposeable
   {
      
      private static var _instance:TimeBoxView;
      
      private var _box:MovieClip;
      
      private var _back:Bitmap;
      
      private var _downTime:TimeDownView;
      
      private var _timeSprite:StripView;
      
      private var _currentTime:int;
      
      private var isExist:Boolean;
      
      private var _isLoaded:Boolean = false;
      
      public function TimeBoxView()
      {
         super();
      }
      
      public static function get instance() : TimeBoxView
      {
         if(!_instance)
         {
            _instance = new TimeBoxView();
         }
         return _instance;
      }
      
      private function initView() : void
      {
         _box = ComponentFactory.Instance.creatCustomObject("timebox.TimeBoxMc");
         _back = ComponentFactory.Instance.creatBitmap("asset.timeBox.timeBGAsset");
         _downTime = ComponentFactory.Instance.creatComponentByStylename("timeBox.TimeDown");
         _timeSprite = ComponentFactory.Instance.creat("TimeBox.TimeTip");
         _timeSprite.tipStyle = "yishi.view.tips.TimeBoxTip";
         var _loc2_:int = BoxManager.instance.getCurrentTimePeriod();
         var _loc1_:Array = TempleteManager.instance.timeBoxTemplateCate.getTemplatesByIndex(_loc2_);
         _timeSprite.tipData = _loc1_;
         _timeSprite.tipDirctions = "7,3,6";
         _timeSprite.addChild(_box);
         _timeSprite.addChild(_back);
         _timeSprite.addChild(_downTime);
         addChild(_timeSprite);
         _box.gotoAndStop(1);
         this.buttonMode = true;
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
         BoxManager.instance.addEventListener("UPDATE_TIME_BOX",__startCountTime);
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         addEventListener("click",__clickHandler);
         _downTime.addEventListener("TIMERUPDATE",__timeUpdateHandler);
         _downTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         playerInfo.addEventListener("TIMEBOX_UPDATE",__boxUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         BoxManager.instance.removeEventListener("UPDATE_TIME_BOX",__startCountTime);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
         removeEventListener("click",__clickHandler);
         _downTime.removeEventListener("TIMERUPDATE",__timeUpdateHandler);
         _downTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         playerInfo.removeEventListener("TIMEBOX_UPDATE",__boxUpdateHandler);
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = SceneManager.instance.currentType;
         if(_loc2_ == "CAMPAIGN_MAP_SCENE")
         {
            if(CampaignManager.instance.mapModel)
            {
               _loc3_ = CampaignManager.instance.mapModel.mapId;
               if(WorldBossHelper.checkWorldBoss(_loc3_) || WorldBossHelper.checkUnrealShooting(_loc3_))
               {
                  hide();
                  return;
               }
            }
         }
         switch(_loc2_)
         {
            case "BATTLE_SCENE":
            case "PVE_ROOM_SCENE":
            case "PVP_ROOM_SCENE":
            case "VEHICLE":
            case "EMPTY_SCENE":
            case "UNREAL_SHOOTING_ROOM":
               hide();
               break;
            default:
               show();
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         x = 300;
         y = 95;
      }
      
      private function __boxUpdateHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function __timeUpdateHandler(param1:Event) : void
      {
         BoxManager.instance.remainTime = _downTime.timeCount;
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         _box.gotoAndPlay(1);
         BoxManager.instance.remainTime = 0;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BoxMovieView = null;
         ShowTipManager.Instance.hideTip(_timeSprite);
         if(BoxManager.instance.remainTime > 0)
         {
            FrameControllerManager.instance.openControllerByInfo("box");
         }
         else
         {
            _loc2_ = new BoxMovieView();
            _loc2_.show();
         }
      }
      
      private function __startCountTime(param1:TimeBoxEvent) : void
      {
         _downTime.timeCount = needCountTime;
         refreshView();
      }
      
      private function get needCountTime() : Number
      {
         var _loc1_:Number = 0;
         if(playerInfo.timeProgress == 0)
         {
            _loc1_ = BoxManager.instance.timeBoxList[0] * 60 - playerInfo.timeRun;
         }
         else if(playerInfo.timeGet)
         {
            _loc1_ = BoxManager.instance.nextTimePeriod * 60 - playerInfo.timeRun;
         }
         else
         {
            _loc1_ = 0;
         }
         if(_loc1_ <= 0)
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      private function refreshView() : void
      {
         if(!BoxManager.instance.needCountTime && parent)
         {
            dispose();
         }
         if(!_box)
         {
            return;
         }
         if(_downTime.timeCount == 0)
         {
            _box.gotoAndPlay(1);
         }
         else
         {
            _box.gotoAndStop(1);
         }
         if(!isExist)
         {
            BoxSocketOutManager.sendBoxTime(false,-1);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __completehandler(param1:LoaderInfo, param2:Object) : void
      {
         if(!_isLoaded)
         {
            _isLoaded = true;
            initView();
            initEvent();
            LayerManager.Instance.addToLayer(this,4,false,false,0,0);
            __switchSceneHandler(null);
         }
      }
      
      public function show() : void
      {
         var _loc1_:String = null;
         if(SceneManager.instance.currentType == "SELF_CHESS_SCENE")
         {
            return;
         }
         if(!_isLoaded)
         {
            _loc1_ = ComponentSetting.getUISourcePath("box");
            LoaderManagerII.instance.load(_loc1_,3,8,__completehandler);
            return;
         }
         if(!isExist)
         {
            refreshView();
            isExist = true;
         }
         visible = true;
         __resizeHandler(null);
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function showView() : void
      {
         __switchSceneHandler(null);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_box);
         _box = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_downTime);
         _downTime = null;
         ObjectUtils.disposeObject(_timeSprite);
         _timeSprite = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}


package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.MovieImage;
   import flash.display.Sprite;
   import map.campaign.CampaignManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   
   public class MessageTipManager extends Sprite
   {
      
      private static var _instance:MessageTipManager;
      
      private var _cartoon:MovieImage;
      
      public var enable:Boolean;
      
      private var _isLoaded:Boolean = false;
      
      private var _callBack:Function;
      
      private var _caches:Array = [];
      
      private var _preMouseEnabled:Boolean;
      
      public function MessageTipManager()
      {
         super();
         addEvent();
      }
      
      public static function instance() : MessageTipManager
      {
         if(_instance == null)
         {
            _instance = new MessageTipManager();
         }
         return _instance;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__onSceneChangeHandler);
      }
      
      private function __onSceneChangeHandler(param1:NotificationEvent) : void
      {
         visible = SceneManager.instance.currentType != "BATTLE_SCENE";
      }
      
      private function init() : void
      {
         mouseEnabled = false;
         mouseChildren = false;
         _cartoon = ComponentFactory.Instance.creatComponentByStylename("tips.MessageTipAsset");
         addChild(_cartoon);
         _cartoon.mouseChildren = _cartoon.mouseEnabled = false;
         _cartoon.cacheAsBitmap = true;
         _cartoon.x = 293;
         _cartoon.movie.addFrameScript(_cartoon.movie.totalFrames - 1,end);
         setCenter();
      }
      
      private function end() : void
      {
         _cartoon.movie.gotoAndStop(_cartoon.movie.totalFrames);
         hide();
      }
      
      private function setCenter() : void
      {
      }
      
      private function setContent(param1:String) : void
      {
         _cartoon.movie.content.tip_txt.text = param1;
         _cartoon.y = -30 * (_cartoon.movie.content.tip_txt.numLines - 1) - 35;
         setCenter();
      }
      
      public function show(param1:String, param2:Boolean = true, param3:Function = null, param4:Boolean = false) : void
      {
         if(param1.length > 185)
         {
            param1 = param1.substr(0,184) + "...";
         }
         var _loc5_:int = CampaignManager.instance.mapId;
         if((SceneManager.instance.currentType == "BATTLE_SCENE" || WorldBossHelper.checkIsNoviceMap(_loc5_)) && !param4)
         {
            if(param3 != null)
            {
               param3();
            }
            param3 = null;
            return;
         }
         enable = true;
         if(_callBack != null)
         {
            _callBack();
         }
         _callBack = null;
         _callBack = param3;
         if(_cartoon == null)
         {
            init();
         }
         _cartoon.movie.gotoAndPlay(1);
         addChild(_cartoon);
         param1 = checkLong(param1);
         setContent(param1);
         LayerManager.Instance.addToLayer(this,0,true);
         _preMouseEnabled = this.parent.mouseEnabled;
         _cartoon.mouseChildren = _cartoon.mouseEnabled = false;
         this.parent.mouseEnabled = false;
      }
      
      private function checkLong(param1:String) : String
      {
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return "";
         }
         var _loc4_:RegExp = /\\n/g;
         param1 = param1.replace(_loc4_,"");
         var _loc2_:Array = param1.split("、");
         var _loc3_:String = "";
         if(_loc2_.length > 10)
         {
            _loc5_ = 0;
            while(_loc5_ < 3)
            {
               _loc3_ += _loc2_[_loc5_];
               if(_loc5_ < 2)
               {
                  _loc3_ += "、";
               }
               _loc5_++;
            }
            return _loc3_ + "...";
         }
         return param1;
      }
      
      public function hide() : void
      {
         if(parent)
         {
            this.parent.mouseEnabled = _preMouseEnabled;
         }
         enable = false;
         if(_cartoon && _cartoon.parent)
         {
            removeChild(_cartoon);
         }
         if(_callBack != null)
         {
            _callBack();
         }
         _callBack = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}


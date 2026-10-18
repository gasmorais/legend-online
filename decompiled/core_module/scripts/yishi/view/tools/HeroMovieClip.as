package yishi.view.tools
{
   import battle.BattleManager;
   import battle.data.GameLoadNeedData;
   import battle.utils.Helpers;
   import battle.view.GameView;
   import battle.view.roles.HeroLoadDataFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.PathManager;
   import yishi.utils.CallBacker;
   import yishi.utils.TimerUtils;
   
   public class HeroMovieClip extends MovieClip implements IEnterFrame, Disposeable
   {
      
      private static var _isLoading:Boolean = false;
      
      private static var _loadingHeroBufferList:Vector.<HeroMovieClip>;
      
      private var _heroInfo:HeroRoleInfo;
      
      private var _heroBody:GameView;
      
      private var _heroParts:Vector.<GameView>;
      
      private var _callBackComplete:CallBacker = new CallBacker(this);
      
      private var _needLoadNum:int;
      
      private var _partRecord:Dictionary;
      
      private var _partCompleteCount:int = 0;
      
      public function HeroMovieClip(param1:HeroRoleInfo)
      {
         super();
         _heroInfo = param1;
         _partRecord = new Dictionary();
         if(_loadingHeroBufferList == null)
         {
            _loadingHeroBufferList = new Vector.<HeroMovieClip>();
         }
      }
      
      public function startLoad() : void
      {
         var _loc1_:BattleModel = null;
         if(_isLoading)
         {
            _loc1_ = BattleManager.getInstance().battleModel;
            if(_loc1_ != null && _loc1_.selfHero == _heroInfo)
            {
               _loadingHeroBufferList.unshift(this);
            }
            else
            {
               _loadingHeroBufferList.push(this);
            }
         }
         else
         {
            _isLoading = createView();
            if(!_isLoading)
            {
               if(_loadingHeroBufferList.length > 0)
               {
                  _loadingHeroBufferList.shift().startLoad();
               }
            }
         }
      }
      
      private function createView() : Boolean
      {
         var _loc1_:Boolean = false;
         _heroParts = new Vector.<GameView>();
         if(_heroInfo != null)
         {
            if(_heroInfo.templateId == 100)
            {
               _needLoadNum = 1;
               _heroParts.push(addPart("body",true,true));
            }
            else if(_heroInfo.isPetFake)
            {
               _needLoadNum = 1;
               _heroParts.push(addPart("pet_follow",true,true));
            }
            else if(_heroInfo.isChildFake)
            {
               _needLoadNum = 1;
               _heroParts.push(addPart("children",true,true));
            }
            else
            {
               if(PathManager.isShowDragon(HeroRoleInfo(_heroInfo).heroInfo))
               {
                  _needLoadNum = 5;
               }
               else
               {
                  _needLoadNum = 4;
               }
               _heroParts.push(addPart("cloak2",true));
               _heroParts.push(addPart("mount",PathManager.isShowDragon(HeroRoleInfo(_heroInfo).heroInfo)));
               _heroParts.push(addPart("arms2",true));
               _heroParts.push(addPart("hair4",true));
               _heroParts.push(addPart("hair3"));
               _heroParts.push(addPart("body",true,true));
               _heroParts.push(addPart("hair2"));
               _heroParts.push(addPart("arms"));
               _heroParts.push(addPart("hair1"));
               _heroParts.push(addPart("cloak1"));
            }
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function addPart(param1:String, param2:Boolean = false, param3:Boolean = false) : GameView
      {
         var _loc4_:GameView = new GameView(false);
         if(param3)
         {
            _heroBody = _loc4_;
         }
         if(param2)
         {
            _loc4_.onComplete = onPartComplete;
         }
         _loc4_.data = HeroLoadDataFactory.create(HeroRoleInfo(_heroInfo).heroInfo,param1,PathManager.isShowDragon(HeroRoleInfo(_heroInfo).heroInfo));
         addChild(_loc4_);
         return _loc4_;
      }
      
      private function onPartComplete(param1:GameView) : void
      {
         var _loc2_:GameLoadNeedData = param1.data as GameLoadNeedData;
         if(!_loc2_ || _partRecord[_loc2_.urlPath])
         {
            return;
         }
         Helpers.getPos(_heroInfo.pos_body_hero,param1.content,"pos_body");
         Helpers.getPos(_heroInfo.pos_head_hero,param1.content,"pos_head");
         Helpers.getPos(_heroInfo.pos_leg_hero,param1.content,"pos_leg");
         _partRecord[_loc2_.urlPath] = true;
         _partCompleteCount = _partCompleteCount + 1;
         if(_partCompleteCount > _needLoadNum - 1)
         {
            TimerUtils.setTimeout(loadCompleted,30);
         }
      }
      
      private function loadCompleted() : void
      {
         if(!_callBackComplete)
         {
            return;
         }
         _callBackComplete.dispatch();
         addEventListener("removedFromStage",onRemoved);
         gotoAndPlay(1);
         _isLoading = false;
         clearSelfInLoadingBuffer();
         if(_loadingHeroBufferList.length > 0)
         {
            _loadingHeroBufferList.shift().startLoad();
         }
      }
      
      private function clearSelfInLoadingBuffer() : void
      {
         var _loc1_:int = _loadingHeroBufferList.indexOf(this);
         if(_loc1_ >= 0)
         {
            _loadingHeroBufferList.splice(_loc1_,1);
         }
         if(_loadingHeroBufferList.length == 0)
         {
            _isLoading = false;
         }
      }
      
      private function onRemoved(param1:Event) : void
      {
         removeEventListener("removedFromStage",onRemoved);
      }
      
      public function get headMovie() : GameView
      {
         return body;
      }
      
      public function getPosMovie() : MovieClip
      {
         return headMovie.getChildAt(0) as MovieClip;
      }
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         var _loc3_:* = null;
         for each(_loc3_ in _heroParts)
         {
            if(_loc3_.content)
            {
               MovieClip(_loc3_.content).gotoAndPlay(param1,param2);
            }
         }
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         var _loc3_:* = null;
         for each(_loc3_ in _heroParts)
         {
            if(_loc3_.content)
            {
               MovieClip(_loc3_.content).gotoAndStop(param1,param2);
            }
         }
      }
      
      override public function stop() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _heroParts)
         {
            if(_loc1_.content)
            {
               MovieClip(_loc1_.content).stop();
            }
         }
      }
      
      override public function play() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _heroParts)
         {
            if(_loc1_.content)
            {
               MovieClip(_loc1_.content).play();
            }
         }
      }
      
      override public function get currentLabel() : String
      {
         return MovieClip(body.content).currentLabel;
      }
      
      override public function get currentLabels() : Array
      {
         return MovieClip(body.content).currentLabels;
      }
      
      override public function get totalFrames() : int
      {
         if(!(body && body.content))
         {
            return 0;
         }
         return MovieClip(body.content).totalFrames;
      }
      
      override public function addFrameScript(... rest) : void
      {
         if(body)
         {
            (body.content as MovieClip).addFrameScript.apply(null,rest);
         }
         for each(var _loc2_:GameView in _heroParts)
         {
            if(_loc2_ && _loc2_.content && _loc2_ != _heroBody)
            {
               MovieClip(_loc2_.content).addFrameScript(rest[0],addStopFun);
            }
         }
      }
      
      private function addStopFun() : void
      {
      }
      
      public function enterFrame() : void
      {
         var _loc2_:int = 0;
         if(!(body && body.content))
         {
            return;
         }
         var _loc1_:int = int(MovieClip(_heroBody.content).currentFrame);
         for each(var _loc3_:GameView in _heroParts)
         {
            if(_loc3_.content && _loc3_ != _heroBody)
            {
               _loc2_ = int(MovieClip(_loc3_.content).currentFrame);
            }
         }
      }
      
      private function get body() : GameView
      {
         return _heroBody;
      }
      
      public function get pos_head() : DisplayObject
      {
         return MovieClip(body.content)["pos_head"];
      }
      
      public function get pos_body() : DisplayObject
      {
         return MovieClip(body.content)["pos_body"];
      }
      
      public function get pos_leg() : DisplayObject
      {
         return MovieClip(body.content)["pos_leg"];
      }
      
      override public function get currentFrame() : int
      {
         return MovieClip(body.content).currentFrame;
      }
      
      override AS3 function hasOwnProperty(param1:* = null) : Boolean
      {
         return MovieClip(body.content) && MovieClip(body.content).hasOwnProperty(param1);
      }
      
      public function get callBackComplete() : CallBacker
      {
         return _callBackComplete;
      }
      
      public function getBodyMC() : MovieClip
      {
         if(body)
         {
            return MovieClip(body.content);
         }
         return null;
      }
      
      public function dispose() : void
      {
         var _loc1_:GameView = null;
         clearSelfInLoadingBuffer();
         for each(_loc1_ in _heroParts)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         if(_heroParts)
         {
            _heroParts.length = 0;
         }
         _loc1_ = null;
         _heroParts = null;
         _heroBody = null;
         _partRecord = null;
         _callBackComplete = null;
         _heroInfo = null;
         clearSelfInLoadingBuffer();
      }
   }
}


package yishi.view.tools
{
   import battle.data.GameLoadNeedData;
   import battle.utils.Helpers;
   import battle.view.roles.HeroLoadDataFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.PathManager;
   import yishi.utils.CallBacker;
   import yishi.utils.TimerUtils;
   
   public class PetFormationMovieClip extends MovieClip implements IEnterFrame, Disposeable
   {
      
      private var _heroInfo:HeroRoleInfo;
      
      private var _heroBody:PetFormationGameView;
      
      private var _heroParts:Vector.<PetFormationGameView>;
      
      private var _callBackComplete:CallBacker = new CallBacker(this);
      
      private var _needLoadNum:int;
      
      private var _partRecord:Dictionary;
      
      private var _needInitBodyLabel:Boolean = false;
      
      private var _partCompleteCount:int = 0;
      
      private var _labesDic:Dictionary;
      
      private var _labels:Array;
      
      public function PetFormationMovieClip(param1:HeroRoleInfo, param2:Boolean = false)
      {
         _needInitBodyLabel = param2;
         super();
         _heroInfo = param1;
         _partRecord = new Dictionary();
         if(_needInitBodyLabel)
         {
            _labesDic = new Dictionary(true);
         }
      }
      
      public function startLoad() : void
      {
         createView();
      }
      
      private function isShowDragon(param1:ThaneInfo) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.bodyAvata && param1.bodyAvata.indexOf(PathManager.DRAGONIC) != -1 || param1.bodyFashionAvata && param1.bodyFashionAvata.indexOf(PathManager.DRAGONIC) != -1 || param1.armsFashionAvata && param1.armsFashionAvata.indexOf(PathManager.DRAGONIC) != -1 || param1.armsAvata && param1.armsAvata.indexOf(PathManager.DRAGONIC) != -1 || param1.hairFashionAvata && param1.hairFashionAvata.indexOf(PathManager.DRAGONIC) != -1 || param1.hairAvata && param1.hairAvata.indexOf(PathManager.DRAGONIC) != -1 || param1.wingAvata && param1.wingAvata.indexOf(PathManager.DRAGONIC) != -1)
         {
            return true;
         }
         return false;
      }
      
      private function createView() : void
      {
         _heroParts = new Vector.<PetFormationGameView>();
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
         else
         {
            if(isShowDragon(_heroInfo.heroInfo))
            {
               _needLoadNum = 5;
            }
            else
            {
               _needLoadNum = 4;
            }
            _heroParts.push(addPart("cloak2",true));
            _heroParts.push(addPart("mount",isShowDragon(_heroInfo.heroInfo)));
            _heroParts.push(addPart("arms2",true));
            _heroParts.push(addPart("hair4",true));
            _heroParts.push(addPart("hair3"));
            _heroParts.push(addPart("body",true,true));
            _heroParts.push(addPart("hair2"));
            _heroParts.push(addPart("arms"));
            _heroParts.push(addPart("hair1"));
            _heroParts.push(addPart("cloak1"));
         }
      }
      
      private function addPart(param1:String, param2:Boolean = false, param3:Boolean = false) : PetFormationGameView
      {
         var _loc4_:PetFormationGameView = new PetFormationGameView(false);
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
      
      private function onPartComplete(param1:PetFormationGameView) : void
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
         if(_needInitBodyLabel)
         {
            initMovieLabels();
         }
         _callBackComplete.dispatch();
         addEventListener("removedFromStage",onRemoved);
         gotoAndPlay(1);
      }
      
      private function onRemoved(param1:Event) : void
      {
         removeEventListener("removedFromStage",onRemoved);
      }
      
      public function get headMovie() : PetFormationGameView
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
         return MovieClip(body.content).totalFrames;
      }
      
      override public function addFrameScript(... rest) : void
      {
         if(body)
         {
            (body.content as MovieClip).addFrameScript.apply(null,rest);
         }
         for each(var _loc2_:PetFormationGameView in _heroParts)
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
         for each(var _loc3_:PetFormationGameView in _heroParts)
         {
            if(_loc3_.content && _loc3_ != _heroBody)
            {
               _loc2_ = int(MovieClip(_loc3_.content).currentFrame);
            }
         }
      }
      
      public function addTagFinalFrameScript(param1:String, param2:Function) : void
      {
         if(!bodyMovieClip)
         {
            return;
         }
         var _loc3_:int = getTagFinalFrame(param1) - 1;
         bodyMovieClip.addFrameScript(_loc3_,param2);
      }
      
      private function initMovieLabels() : void
      {
         var _loc1_:FrameLabel = null;
         var _loc2_:int = 0;
         if(!bodyMovieClip)
         {
            return;
         }
         _labels = bodyMovieClip.currentLabels;
         _loc2_ = 0;
         while(_loc2_ < _labels.length)
         {
            if(_loc2_ != 0)
            {
               _loc1_ = _labels[_loc2_ - 1] as FrameLabel;
               _labesDic[_loc1_.name] = int(_labels[_loc2_].frame) - _loc1_.frame;
            }
            _loc2_++;
         }
         _loc1_ = _labels[_labels.length - 1] as FrameLabel;
         if(_loc1_)
         {
            _labesDic[_loc1_.name] = bodyMovieClip.totalFrames + 1 - _loc1_.frame;
         }
         _loc1_ = null;
      }
      
      private function getTagFinalFrame(param1:String) : int
      {
         var _loc3_:FrameLabel = null;
         for each(var _loc4_:FrameLabel in _labels)
         {
            if(_loc4_.name == param1)
            {
               _loc3_ = _loc4_;
            }
         }
         var _loc2_:int = int(_labesDic[param1]);
         if(_loc3_)
         {
            return _loc3_.frame + _loc2_ - 1;
         }
         return _loc2_;
      }
      
      private function getTagFrame(param1:String) : int
      {
         return _labesDic[param1] as int;
      }
      
      private function get bodyMovieClip() : MovieClip
      {
         return MovieClip(body.content);
      }
      
      private function get body() : PetFormationGameView
      {
         return _heroBody;
      }
      
      public function get pos_head() : DisplayObject
      {
         var _loc1_:String = null;
         if(!body.content)
         {
            _loc1_ = HeroLoadDataFactory.create(HeroRoleInfo(_heroInfo).heroInfo,"body",PathManager.isShowDragon(HeroRoleInfo(_heroInfo).heroInfo)).urlPath;
            throw new Error("== POS_HEAD error [" + _loc1_ + "] ==");
         }
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
         return MovieClip(body.content);
      }
      
      public function dispose() : void
      {
         var _loc1_:PetFormationGameView = null;
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
         _labesDic = null;
      }
   }
}


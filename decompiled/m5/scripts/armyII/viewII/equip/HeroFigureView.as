package armyII.viewII.equip
{
   import battle.view.GameView;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.PathManager;
   import yishi.utils.SimpleDictionary;
   
   public class HeroFigureView extends Sprite implements Disposeable
   {
      
      protected var _data:ThaneInfo;
      
      private var _frontHair:GameView;
      
      private var _frontMantle:GameView;
      
      private var _body:GameView;
      
      private var _arms:GameView;
      
      private var _backMantle:GameView;
      
      private var _backHair:GameView;
      
      protected var _bodyPath:String;
      
      protected var _armsPath:String;
      
      private var _needLoadLen:int;
      
      private var _currentLoadedLen:int;
      
      protected var _defaultDic:Dictionary;
      
      private var _layerList:Array;
      
      private var _type:String;
      
      private var _method:String;
      
      private var _direction:String;
      
      private var _heroEquipDic:SimpleDictionary;
      
      public function HeroFigureView(param1:String, param2:String = null, param3:String = null)
      {
         super();
         _type = param1;
         _method = param2;
         _direction = param3;
         _defaultDic = new Dictionary();
         _defaultDic[2] = "/hunter_default";
         _defaultDic[3] = "/wizard_default";
         _defaultDic[1] = "/warrior_default";
         _layerList = [];
         _body = new GameView();
         _arms = new GameView();
         initEvent();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function get body() : GameView
      {
         return _body;
      }
      
      private function initEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("PLAYER_AVATA_CHANGE",__equipChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("PLAYER_AVATA_CHANGE",__equipChangeHandler);
         }
      }
      
      private function __equipChangeHandler(param1:PlayerEvent) : void
      {
         _data = _data;
      }
      
      private function clean() : void
      {
         if(_body && _body.parent)
         {
            _body.parent.removeChild(_body);
         }
         if(_arms && _arms.parent)
         {
            _arms.parent.removeChild(_arms);
         }
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _currentLoadedLen = 0;
         _needLoadLen = 2;
         _data = param1;
         clean();
         if(!_data)
         {
            return;
         }
         initLayer();
         initView();
         initDefaultPath();
         initPath();
         startLoad();
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      protected function initLayer() : void
      {
         _layerList.splice(0,_layerList.length);
         _layerList.push(_body);
         _layerList.push(_arms);
      }
      
      private function initView() : void
      {
         for each(var _loc1_:DisplayObject in _layerList)
         {
            addChild(_loc1_);
         }
      }
      
      protected function initDefaultPath() : void
      {
         _armsPath = _defaultDic[_data.templateInfo.Job] + "_arms";
         _bodyPath = _defaultDic[_data.templateInfo.Job] + "_body";
      }
      
      protected function initPath() : void
      {
         _armsPath = _data.armsAvata == "" ? _armsPath : _data.armsAvata;
         _bodyPath = _data.bodyAvata == "" ? _bodyPath : _data.bodyAvata;
      }
      
      private function startLoad() : void
      {
         _arms.data = PathManager.solveShowHeroAvatarPath(_type,_method,_direction,_armsPath,_data.templateInfo.Sexs);
         _arms.onComplete = onComplete;
         _body.data = PathManager.solveShowHeroAvatarPath(_type,_method,_direction,_bodyPath,_data.templateInfo.Sexs);
         _body.onComplete = onComplete;
      }
      
      private function onComplete() : void
      {
         _currentLoadedLen = _currentLoadedLen + 1;
         initCurrentFrame();
         tryComplete();
      }
      
      private function initCurrentFrame() : void
      {
         if(_body && _arms && _body.content && _arms.content)
         {
            MovieClip(_body.content).gotoAndPlay(1);
            MovieClip(_arms.content).gotoAndPlay(1);
         }
      }
      
      public function tryComplete() : void
      {
         if(_currentLoadedLen == _needLoadLen)
         {
            _currentLoadedLen = 0;
            dispatchEvent(new Event("complete"));
         }
      }
      
      public function set heroEquipDic(param1:SimpleDictionary) : void
      {
         _heroEquipDic = param1;
      }
      
      public function stop() : void
      {
         if(_body && _body.content)
         {
            (_body.content as MovieClip).stop();
         }
         if(_arms && _arms.content)
         {
            (_arms.content as MovieClip).stop();
         }
      }
      
      public function play() : void
      {
         if(_body && _body.content)
         {
            (_body.content as MovieClip).play();
         }
         if(_arms && _arms.content)
         {
            (_arms.content as MovieClip).play();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _currentLoadedLen = 0;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _body = null;
         _arms = null;
      }
   }
}


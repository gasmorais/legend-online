package dreamarena.item
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import mvc.controler.PetChallengeController;
   import mvc.module.children.ChildData;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.view.tools.PetFormationMovieClip;
   
   public class DreamArenaFormationItem extends Component
   {
      
      public var site:int;
      
      public var isLock:Boolean;
      
      private var _data:*;
      
      private var _bottom:MovieClip;
      
      private var _controller:PetChallengeController = FrameControllerManager.instance.petchallengeController;
      
      private var _pos:int;
      
      private var _loader:Loader;
      
      private var _body:MovieClip;
      
      private var _heroMovie:PetFormationMovieClip;
      
      private const SCALE:Number = 0.815;
      
      public function DreamArenaFormationItem(param1:int = 0)
      {
         _pos = param1;
         super();
         initView();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _bottom = ComponentFactory.Instance.creat("asset.common.formationBottom");
         _bottom.scaleX = _bottom.scaleY = 0.815;
         addChild(_bottom);
         setBottomVisible(false);
         this.hitArea = _bottom;
      }
      
      public function setBottomVisible(param1:Boolean) : void
      {
         if(_bottom)
         {
            _bottom.visible = param1;
            _bottom.stop();
         }
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
         if(_data)
         {
            refresh();
         }
         else
         {
            clean();
         }
      }
      
      private function refresh() : void
      {
         var _loc2_:HeroRoleInfo = null;
         var _loc1_:String = null;
         clearBody();
         if(data is ThaneInfo)
         {
            _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
            setBodyProperty();
            _loc2_ = new HeroRoleInfo();
            _loc2_.heroInfo = data as ThaneInfo;
            _loc2_.heroInfo.dragonTalkerInfo.isDragonTalker = (data as ThaneInfo).dragonTalkerInfo.isDragonTalker;
            _loc2_.heroInfo.dragonTalkerInfo.battleBeastId = 8;
            _heroMovie = new PetFormationMovieClip(_loc2_);
            _heroMovie.callBackComplete.addSingleListener(heroMovieClipLoadComplete);
            _heroMovie.startLoad();
         }
         else if(data is ChildData)
         {
            if(_controller.childDefineDic[(_data as ChildData).job + "_" + (_data as ChildData).growthGrade])
            {
               createBody();
            }
            else
            {
               _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
               setBodyProperty();
               _loc1_ = PathManager.solveChildAvatarPath(_data.job,_data.growthGrade);
               LoaderManagerII.instance.load(_loc1_,1,8,__loadedCompleteHandler);
            }
         }
         if(_body)
         {
            addChild(_body);
         }
         setBottomVisible(false);
         this.buttonMode = true;
      }
      
      private function __loadedCompleteHandler(param1:com.pickgliss.loader.data.LoaderInfo, param2:Object) : void
      {
         var _loc5_:Class = null;
         var _loc3_:ApplicationDomain = null;
         var _loc4_:LoaderContext = null;
         clearBody();
         if(isDie)
         {
            return;
         }
         if(!_data)
         {
            return;
         }
         if(_data is ChildData)
         {
            _loc5_ = _controller.childDefineDic[(_data as ChildData).job + "_" + (_data as ChildData).growthGrade] as Class;
         }
         if(!_loc5_)
         {
            if(param2)
            {
               _loc3_ = new ApplicationDomain(ApplicationDomain.currentDomain);
               _loc4_ = new LoaderContext(false,_loc3_);
               disposeLoader();
               _loader = new Loader();
               _loader.contentLoaderInfo.addEventListener("complete",__complete);
               _loader.loadBytes(param2 as ByteArray,_loc4_);
            }
         }
         else
         {
            createBody();
         }
      }
      
      private function heroMovieClipLoadComplete() : void
      {
         if(!_data)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         clearBody();
         if(_heroMovie)
         {
            _body = _heroMovie;
            setBodyProperty();
            addChild(_body);
            _body.gotoAndPlay(1);
         }
      }
      
      private function __complete(param1:Event) : void
      {
         var _loc3_:Class = null;
         var _loc2_:flash.display.LoaderInfo = param1.currentTarget as flash.display.LoaderInfo;
         _loc2_.removeEventListener("complete",__complete);
         if(_data is ChildData)
         {
            _loc3_ = _controller.childDefineDic[(_data as ChildData).job + "_" + (_data as ChildData).growthGrade] as Class;
            if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("ClassExport"))
            {
               _loc3_ = _loc2_.applicationDomain.getDefinition("ClassExport") as Class;
               _controller.childDefineDic[(_data as ChildData).job + "_" + (_data as ChildData).growthGrade] = _loc3_;
            }
         }
         createBody();
         _loader.unloadAndStop(false);
         _loader = null;
      }
      
      private function createBody() : void
      {
         var _loc1_:Class = null;
         if(!data)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         clearBody();
         if(data is ChildData)
         {
            _loc1_ = _controller.childDefineDic[(_data as ChildData).job + "_" + (_data as ChildData).growthGrade] as Class;
         }
         if(_loc1_)
         {
            _body = new _loc1_();
            setBodyProperty();
            addChild(_body);
            if(data && data is ChildData && (data as ChildData).isSlaveChild)
            {
               _body.filters = [UIFilter.getDarkFilter()];
            }
         }
      }
      
      private function setBodyProperty() : void
      {
         _body.mouseChildren = _body.mouseEnabled = false;
         _body.scaleX = _body.scaleY = 0.815;
      }
      
      private function clean() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         ObjectUtils.disposeObject(_body);
         _body = null;
         this.hitArea = _bottom;
         this.buttonMode = false;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      private function disposeLoader() : void
      {
         if(_loader)
         {
            _loader.contentLoaderInfo.removeEventListener("complete",__complete);
            _loader.unloadAndStop(false);
            _loader = null;
         }
      }
      
      private function clearBody() : void
      {
         ObjectUtils.disposeViolentMc(_body);
         _body = null;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      override public function dispose() : void
      {
         if(_heroMovie && _heroMovie.callBackComplete)
         {
            _heroMovie.callBackComplete.removeListener(heroMovieClipLoadComplete);
         }
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadedCompleteHandler);
         disposeLoader();
         ObjectUtils.disposeViolentMc(_bottom);
         _bottom = null;
         clearBody();
         _loader = null;
         super.dispose();
         _controller = null;
      }
   }
}


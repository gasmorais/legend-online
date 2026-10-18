package armyII.viewII.lineUp
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import managers.ChildManager;
   import managers.DragonTalkerManager;
   import mvc.controler.ArmyControler;
   import mvc.controler.MonsterControler;
   import mvc.controler.PetChallengeController;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.children.ChildData;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.pet.PetData;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.BaseManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.view.tools.PetFormationMovieClip;
   
   public class LineUpFormationItem extends Component
   {
      
      public var site:int;
      
      public var isLock:Boolean;
      
      private var _data:*;
      
      private var _bottom:MovieClip;
      
      private var _controller:PetChallengeController = FrameControllerManager.instance.petchallengeController;
      
      private var _pos:int;
      
      private var _loader:Loader;
      
      private var _body:MovieClip;
      
      private var _poolSprite:Shape;
      
      private var _heroMovie:PetFormationMovieClip;
      
      private const SCALE:Number = 0.815;
      
      public function LineUpFormationItem(param1:int = 0)
      {
         _pos = param1;
         super();
         initView();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _bottom = ComponentFactory.Instance.creat("asset.army.lineUpBottom");
         _bottom.scaleX = _bottom.scaleY = 0.815;
         addChild(_bottom);
         setBottomVisible(false);
         this.hitArea = _bottom;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bottom);
         _bottom = null;
         clearBody();
         _loader = null;
      }
      
      private function clearBody() : void
      {
         ObjectUtils.disposeObject(_body);
         _body = null;
      }
      
      public function setBottomVisible(param1:Boolean) : void
      {
         if(_bottom)
         {
            _bottom.visible = param1;
            _bottom.stop();
         }
      }
      
      protected function freePawn(param1:ArmyPawn) : void
      {
         var _loc2_:int = int(param1.ownPawns);
         ArmyManager.instance.army.removeArmyPawnCountByIndex(0,_loc2_);
         ArmyManager.instance.addPawnCountById(param1.templateId,_loc2_);
         control.sendMovePawnInfo();
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
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
         if(_data is PetData)
         {
            _loc5_ = _controller.classDefineDic[_data.templateId] as Class;
         }
         else if(_data is ArmyPawn)
         {
            _loc5_ = _controller.armyPawnDefineDic[_data.templateId] as Class;
         }
         else if(_data is ChildData)
         {
            _loc5_ = _controller.childDefineDic[_data.childId] as Class;
         }
         else if(_data is MonsterInfo)
         {
            _loc5_ = monsterControl.monsterDefineDic[(_data as MonsterInfo).tempInfo.TemplateId] as Class;
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
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function refresh() : void
      {
         var _loc5_:HeroRoleInfo = null;
         var _loc4_:String = null;
         var _loc1_:String = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         clearBody();
         if(getArmyType() == 4)
         {
            _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
            setBodyProperty();
            _loc5_ = new HeroRoleInfo();
            _loc5_.heroInfo = thane;
            _loc5_.heroInfo.dragonTalkerInfo.isDragonTalker = dragonTalkerModel.isDragonTalker;
            _loc5_.heroInfo.dragonTalkerInfo.battleBeastId = PathManager.isShowDragon(_loc5_.heroInfo) ? dragonTalkerModel.selectBattleBeastId : 0;
            _heroMovie = new PetFormationMovieClip(_loc5_);
            _heroMovie.callBackComplete.addSingleListener(heroMovieClipLoadComplete);
            _heroMovie.startLoad();
         }
         else if(getArmyType() == 2)
         {
            if(_controller.classDefineDic[_data.templateId])
            {
               createBody();
            }
            else
            {
               _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
               setBodyProperty();
               _loc4_ = PathManager.solveHeroAvatarPath(data.template.PetAvatar,2);
               LoaderManagerII.instance.load(_loc4_,1,8,__loadedCompleteHandler);
            }
         }
         else if(getArmyType() == 3)
         {
            if(_controller.childDefineDic[_data.templateId])
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
         else if(getArmyType() == 1)
         {
            if(_controller.armyPawnDefineDic[_data.templateId])
            {
               createBody();
            }
            else
            {
               _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
               setBodyProperty();
               _loc3_ = PathManager.solveRolePath((_data as ArmyPawn).templateInfo.Swf);
               LoaderManagerII.instance.load(_loc3_,1,8,__loadedCompleteHandler);
            }
         }
         else if(getArmyType() == 5)
         {
            if(monsterControl.monsterDefineDic[(_data as MonsterInfo).tempInfo.TemplateId])
            {
               createBody();
            }
            else
            {
               _body = ComponentFactory.Instance.creat("asset.avatar.DefaultAvatarMovieAsset");
               setBodyProperty();
               _loc2_ = PathManager.solveRolePath((_data as MonsterInfo).tempInfo.ResPath);
               LoaderManagerII.instance.load(_loc2_,1,8,__loadedCompleteHandler);
            }
         }
         if(_body)
         {
            addChild(_body);
         }
         setBottomVisible(false);
         this.buttonMode = true;
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
         if(_data is PetData)
         {
            _loc3_ = _controller.classDefineDic[_data.templateId] as Class;
            if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("ClassExport"))
            {
               _loc3_ = _loc2_.applicationDomain.getDefinition("ClassExport") as Class;
               _controller.classDefineDic[_data.templateId] = _loc3_;
            }
         }
         else if(_data is ArmyPawn)
         {
            _loc3_ = _controller.armyPawnDefineDic[_data.templateId] as Class;
            if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("slg.resource.movie.MovieAsset" + (_data as ArmyPawn).templateInfo.Swf))
            {
               _loc3_ = _loc2_.applicationDomain.getDefinition("slg.resource.movie.MovieAsset" + (_data as ArmyPawn).templateInfo.Swf) as Class;
               _controller.armyPawnDefineDic[_data.templateId] = _loc3_;
            }
         }
         else if(_data is ChildData)
         {
            _loc3_ = _controller.childDefineDic[_data.childId] as Class;
            if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("ClassExport"))
            {
               _loc3_ = _loc2_.applicationDomain.getDefinition("ClassExport") as Class;
               _controller.childDefineDic[_data.childId] = _loc3_;
            }
         }
         else if(_data is MonsterInfo)
         {
            _loc3_ = monsterControl.monsterDefineDic[(_data as MonsterInfo).tempInfo.TemplateId] as Class;
            if(!_loc3_ && _loc2_.applicationDomain.hasDefinition("slg.resource.movie.MovieAsset" + (_data as MonsterInfo).tempInfo.ResPath))
            {
               _loc3_ = _loc2_.applicationDomain.getDefinition("slg.resource.movie.MovieAsset" + (_data as MonsterInfo).tempInfo.ResPath) as Class;
               monsterControl.monsterDefineDic[(_data as MonsterInfo).tempInfo.TemplateId] = _loc3_;
            }
         }
         createBody();
         _loader.unloadAndStop(false);
         _loader = null;
      }
      
      private function createBody() : void
      {
         var _loc2_:Class = null;
         var _loc1_:MovieClip = null;
         if(!_data)
         {
            return;
         }
         if(isDie)
         {
            return;
         }
         clearBody();
         if(_data is PetData)
         {
            _loc2_ = _controller.classDefineDic[_data.templateId] as Class;
         }
         else if(_data is ArmyPawn)
         {
            _loc2_ = _controller.armyPawnDefineDic[_data.templateId] as Class;
         }
         else if(_data is ChildData)
         {
            _loc2_ = _controller.childDefineDic[_data.childId] as Class;
         }
         else if(_data is MonsterInfo)
         {
            _loc2_ = monsterControl.monsterDefineDic[(_data as MonsterInfo).tempInfo.TemplateId] as Class;
         }
         if(_loc2_)
         {
            _body = new _loc2_();
            setBodyProperty();
            addChild(_body);
            if(_data && _data is ChildData && slavedChild && _data.childId == slavedChild.childId)
            {
               _body.filters = [UIFilter.getDarkFilter()];
            }
            _loc1_ = _body["pos_head"] as MovieClip;
            if(!_loc1_)
            {
            }
         }
      }
      
      private function get slavedChild() : ChildData
      {
         return ChildManager.instance.model.getSlavedEnterWar();
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
         clearTimeout(BaseManager.delayId);
         BaseManager.delayId = 0;
         this.buttonMode = false;
      }
      
      private function isSmaeData(param1:*, param2:*) : Boolean
      {
         if(param1 == param2)
         {
            if(param1 is ArmyPawn && param2 is ArmyPawn)
            {
               if((param1 as ArmyPawn).templateId == (param2 as ArmyPawn).templateId)
               {
                  return true;
               }
               return false;
            }
            return true;
         }
         return false;
      }
      
      public function set data(param1:*) : void
      {
         if(isSmaeData(_data,param1))
         {
            return;
         }
         if(param1 == null && _data != null && _data.hasOwnProperty("templateId"))
         {
            _controller.saveShape(_data.templateId,_poolSprite);
            _poolSprite = null;
         }
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
      
      public function get data() : *
      {
         return _data;
      }
      
      public function refreshHeroState() : void
      {
         if(data && _data.hasOwnProperty("templateId"))
         {
            _controller.saveShape(_data.templateId,_poolSprite);
            _poolSprite = null;
            refresh();
         }
      }
      
      public function get pawn() : ArmyPawn
      {
         if(_data is ArmyPawn)
         {
            return _data as ArmyPawn;
         }
         return null;
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
         if(_data && _controller && _data.hasOwnProperty("templateId"))
         {
            _controller.saveShape(_data.templateId,_poolSprite);
            _poolSprite = null;
         }
         clearTimeout(BaseManager.delayId);
         disposeLoader();
         uintView();
         super.dispose();
         _controller = null;
      }
      
      private function getArmyType() : int
      {
         var _loc1_:int = 0;
         if(_data is ArmyPawn)
         {
            _loc1_ = 1;
         }
         else if(_data is PetData)
         {
            _loc1_ = 2;
         }
         else if(_data is ChildData)
         {
            _loc1_ = 3;
         }
         else if(_data is MonsterInfo)
         {
            _loc1_ = 5;
         }
         else
         {
            _loc1_ = 4;
         }
         return _loc1_;
      }
      
      private function get dragonTalkerModel() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      private function get monsterControl() : MonsterControler
      {
         return FrameControllerManager.instance.monsterController;
      }
   }
}


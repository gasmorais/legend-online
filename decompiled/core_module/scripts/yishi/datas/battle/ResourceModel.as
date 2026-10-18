package yishi.datas.battle
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import battle.view.skillname.SkillNameLoader;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.GoddessRoleInfo;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   
   public class ResourceModel extends EventDispatcher
   {
      
      private static const SINGLE:int = 1;
      
      private static const MULTY:int = 2;
      
      private var _applicationDomain:ApplicationDomain;
      
      private var _applicationMap:Dictionary;
      
      private var _skillNameLoader:SkillNameLoader;
      
      private var _otherResLoader:BattleOtherResByteLoader;
      
      private var _loadedUrl:Array = [];
      
      private var _mapPath:String;
      
      private var _publicSkillPath:String;
      
      private var _mapLoaded:Boolean;
      
      private var _publicSkillLoaded:Boolean;
      
      private var _nessaryCount:int = 5;
      
      private var _currentCunt:int = 0;
      
      public var battleMap:MovieClip;
      
      private var _proDic:Dictionary = new Dictionary(true);
      
      private var _newbieLoader1:Loader;
      
      private var _newbieLoader2:Loader;
      
      private var _newbieLoader3:Loader;
      
      private var _newbieLoader4:Loader;
      
      private var _newbieLoader5:Loader;
      
      private var _newbieLoader6:Loader;
      
      private var _resistResLoader:Loader;
      
      private var _skillLoader:Loader;
      
      private var _mapLoader:Loader;
      
      public var moviePool:Dictionary = new Dictionary(true);
      
      public var outMovie:Dictionary = new Dictionary(true);
      
      public function ResourceModel()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         _applicationMap = new Dictionary();
      }
      
      public function getInstanceByDefinition(param1:String) : Object
      {
         var _loc3_:Class = getDefinition(param1);
         if(!_loc3_)
         {
            _loc3_ = MovieClip;
         }
         return new _loc3_();
      }
      
      private function getDefinition(param1:String) : Class
      {
         var _loc2_:Class = null;
         if(_applicationDomain.hasDefinition(param1))
         {
            _loc2_ = _applicationDomain.getDefinition(param1) as Class;
         }
         return _loc2_;
      }
      
      public function getInstanceByPath(param1:String, param2:int = 0) : Object
      {
         var _loc4_:Class = null;
         var _loc3_:* = null;
         switch(param2)
         {
            case 0:
               _loc4_ = ApplicationDomain(_applicationMap[param1]).getDefinition("ClassExport") as Class;
               break;
            default:
               _loc4_ = ApplicationDomain(_applicationMap[param1]).getDefinition("ClassExport" + param2) as Class;
         }
         return new _loc4_();
      }
      
      public function startLoad() : void
      {
         if(PlayerManager.instance.newbieProcess < 12500)
         {
            _nessaryCount = 9;
            loadNewbie1();
            loadNewbie2();
            loadNewbie3();
            loadNewbie5();
         }
         else if(PlayerManager.instance.newbieProcess < 14000)
         {
            _nessaryCount = 9;
            loadNewbie1();
            loadNewbie2();
            loadNewbie3();
            loadNewbie6();
         }
         loadBattleCommonUI();
         loadBattleJobUI();
         loadPublicSkill();
         loadBattleMap();
         loadOtherRes();
      }
      
      public function loadOtherRes() : void
      {
         var _loc4_:GoddessRoleInfo = null;
         var _loc1_:String = null;
         var _loc5_:Array = [];
         var _loc3_:Dictionary = BattleManager.getInstance().battleModel.roleList;
         for each(var _loc2_:RoleInfo in _loc3_)
         {
            if(_loc2_ is GoddessRoleInfo && (_loc2_ as GoddessRoleInfo).isGoddess)
            {
               _loc4_ = _loc2_ as GoddessRoleInfo;
               _loc1_ = PathManager.getBattleGoddessAvatarPath(_loc4_.template.Type);
               if(_loc5_.indexOf(_loc1_) == -1)
               {
                  _loc5_.push(_loc1_);
               }
            }
         }
         _otherResLoader = new BattleOtherResByteLoader(_loc5_,otherResLoadComplete);
         _otherResLoader.startLoad();
      }
      
      private function otherResLoadComplete() : void
      {
         _currentCunt = _currentCunt + 1;
         isUIComplete();
      }
      
      private function loadNewbie1() : void
      {
         var _loc2_:ThaneInfo = thane;
         var _loc1_:String = PathManager.solveRoleDefaultPath(_loc2_.templateInfo.Job,"hair",_loc2_.templateInfo.Sexs,"");
         addSingleClassResourcePath(_loc1_.toLowerCase());
         LoaderManagerII.instance.load(_loc1_,1,10,onNPComplete1,onNPProgress1);
      }
      
      private function onNPProgress1(param1:LoaderInfo) : void
      {
         _proDic[param1.url] = param1.bytesLoaded / param1.bytesTotal;
      }
      
      private function onNPComplete1(param1:LoaderInfo, param2:Object) : void
      {
         _loadedUrl.push(param1.url);
         var _loc3_:ApplicationDomain = getDomainByPaty(param1.url);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _loc4_.allowCodeImport = true;
         }
         _newbieLoader1 = new Loader();
         _newbieLoader1.contentLoaderInfo.addEventListener("complete",__loadNewbieComplete1);
         _newbieLoader1.loadBytes(param2 as ByteArray,_loc4_);
      }
      
      private function __loadNewbieComplete1(param1:Event) : void
      {
         _currentCunt = _currentCunt + 1;
         isUIComplete();
         _newbieLoader1.contentLoaderInfo.removeEventListener("complete",__loadNewbieComplete1);
         _newbieLoader1.unloadAndStop(false);
         _newbieLoader1 = null;
      }
      
      private function loadNewbie2() : void
      {
         var _loc2_:ThaneInfo = thane;
         var _loc1_:String = PathManager.solveRoleDefaultPath(_loc2_.templateInfo.Job,"body",_loc2_.templateInfo.Sexs,"");
         addSingleClassResourcePath(_loc1_.toLowerCase());
         LoaderManagerII.instance.load(_loc1_,1,10,onNPComplete2,onNPProgress2);
      }
      
      private function onNPProgress2(param1:LoaderInfo) : void
      {
         _proDic[param1.url] = param1.bytesLoaded / param1.bytesTotal;
      }
      
      private function onNPComplete2(param1:LoaderInfo, param2:Object) : void
      {
         _loadedUrl.push(param1.url);
         var _loc3_:ApplicationDomain = getDomainByPaty(param1.url);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _loc4_.allowCodeImport = true;
         }
         _newbieLoader2 = new Loader();
         _newbieLoader2.contentLoaderInfo.addEventListener("complete",__loadNewbieComplete2);
         _newbieLoader2.loadBytes(param2 as ByteArray,_loc4_);
      }
      
      private function __loadNewbieComplete2(param1:Event) : void
      {
         _currentCunt = _currentCunt + 1;
         isUIComplete();
         _newbieLoader2.contentLoaderInfo.removeEventListener("complete",__loadNewbieComplete2);
         _newbieLoader2.unloadAndStop(false);
         _newbieLoader2 = null;
      }
      
      private function loadNewbie3() : void
      {
         var _loc2_:ThaneInfo = thane;
         var _loc1_:String = PathManager.solveRoleDefaultPath(_loc2_.templateInfo.Job,"arms",_loc2_.templateInfo.Sexs,"");
         addSingleClassResourcePath(_loc1_.toLowerCase());
         LoaderManagerII.instance.load(_loc1_,1,10,onNPComplete3,onNPProgress3);
      }
      
      private function onNPProgress3(param1:LoaderInfo) : void
      {
         _proDic[param1.url] = param1.bytesLoaded / param1.bytesTotal;
      }
      
      private function onNPComplete3(param1:LoaderInfo, param2:Object) : void
      {
         _loadedUrl.push(param1.url);
         var _loc3_:ApplicationDomain = getDomainByPaty(param1.url);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _loc4_.allowCodeImport = true;
         }
         _newbieLoader3 = new Loader();
         _newbieLoader3.contentLoaderInfo.addEventListener("complete",__loadNewbieComplete3);
         _newbieLoader3.loadBytes(param2 as ByteArray,_loc4_);
      }
      
      private function __loadNewbieComplete3(param1:Event) : void
      {
         _currentCunt = _currentCunt + 1;
         isUIComplete();
         _newbieLoader3.contentLoaderInfo.removeEventListener("complete",__loadNewbieComplete3);
         _newbieLoader3.unloadAndStop(false);
         _newbieLoader3 = null;
      }
      
      private function loadNewbie4() : void
      {
         var _loc2_:ThaneInfo = thane;
         var _loc1_:String = PathManager.solveRoleDefaultPath(_loc2_.templateInfo.Job,"body",_loc2_.templateInfo.Sexs,"_cloak");
         addSingleClassResourcePath(_loc1_.toLowerCase());
         LoaderManagerII.instance.load(_loc1_,1,10,onNPComplete4,onNPProgress4);
      }
      
      private function onNPProgress4(param1:LoaderInfo) : void
      {
         _proDic[param1.url] = param1.bytesLoaded / param1.bytesTotal;
      }
      
      private function onNPComplete4(param1:LoaderInfo, param2:Object) : void
      {
         _loadedUrl.push(param1.url);
         var _loc3_:ApplicationDomain = getDomainByPaty(param1.url);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _loc4_.allowCodeImport = true;
         }
         _newbieLoader4 = new Loader();
         _newbieLoader4.contentLoaderInfo.addEventListener("complete",__loadNewbieComplete4);
         _newbieLoader4.loadBytes(param2 as ByteArray,_loc4_);
      }
      
      private function __loadNewbieComplete4(param1:Event) : void
      {
         _currentCunt = _currentCunt + 1;
         isUIComplete();
         _newbieLoader4.contentLoaderInfo.removeEventListener("complete",__loadNewbieComplete4);
         _newbieLoader4.unloadAndStop(false);
         _newbieLoader4 = null;
      }
      
      private function loadNewbie5() : void
      {
         var _loc1_:String = PathManager.solveRolePath("monster038");
         addMultiClassResourcePath(_loc1_.toLowerCase());
         LoaderManagerII.instance.load(_loc1_,1,10,onNPComplete5,onNPProgress5);
      }
      
      private function onNPProgress5(param1:LoaderInfo) : void
      {
         _proDic[param1.url] = param1.bytesLoaded / param1.bytesTotal;
      }
      
      private function onNPComplete5(param1:LoaderInfo, param2:Object) : void
      {
         _loadedUrl.push(param1.url);
         var _loc3_:ApplicationDomain = getDomainByPaty(param1.url);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _loc4_.allowCodeImport = true;
         }
         _newbieLoader5 = new Loader();
         _newbieLoader5.contentLoaderInfo.addEventListener("complete",__loadNewbieComplete5);
         _newbieLoader5.loadBytes(param2 as ByteArray,_loc4_);
      }
      
      private function __loadNewbieComplete5(param1:Event) : void
      {
         _currentCunt = _currentCunt + 1;
         isUIComplete();
         _newbieLoader5.contentLoaderInfo.removeEventListener("complete",__loadNewbieComplete5);
         _newbieLoader5.unloadAndStop(false);
         _newbieLoader5 = null;
      }
      
      private function loadNewbie6() : void
      {
         var _loc1_:String = PathManager.solveRolePath("boss032");
         addMultiClassResourcePath(_loc1_.toLowerCase());
         LoaderManagerII.instance.load(_loc1_,1,10,onNPComplete6,onNPProgress6);
      }
      
      private function onNPProgress6(param1:LoaderInfo) : void
      {
         _proDic[param1.url] = param1.bytesLoaded / param1.bytesTotal;
      }
      
      private function onNPComplete6(param1:LoaderInfo, param2:Object) : void
      {
         _loadedUrl.push(param1.url);
         var _loc3_:ApplicationDomain = getDomainByPaty(param1.url);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _loc4_.allowCodeImport = true;
         }
         _newbieLoader6 = new Loader();
         _newbieLoader6.contentLoaderInfo.addEventListener("complete",__loadNewbieComplete6);
         _newbieLoader6.loadBytes(param2 as ByteArray,_loc4_);
      }
      
      private function __loadNewbieComplete6(param1:Event) : void
      {
         _currentCunt = _currentCunt + 1;
         isUIComplete();
         _newbieLoader6.contentLoaderInfo.removeEventListener("complete",__loadNewbieComplete6);
         _newbieLoader6.unloadAndStop(false);
         _newbieLoader6 = null;
      }
      
      private function loadBattleCommonUI() : void
      {
         var _loc1_:String = ComponentSetting.getUISourcePath("battle");
         LoaderManagerII.instance.load(_loc1_,3,10,onUIComplete,onUIProgress);
      }
      
      private function onUIProgress(param1:LoaderInfo) : void
      {
         _proDic[param1.url] = param1.bytesLoaded / param1.bytesTotal;
      }
      
      private function onUIComplete(param1:LoaderInfo, param2:Object) : void
      {
         _currentCunt = _currentCunt + 1;
         isUIComplete();
      }
      
      private function loadBattleJobUI() : void
      {
         var _loc2_:String = null;
         var _loc1_:HeroRoleInfo = BattleManager.getInstance().battleModel.selfHero;
         var _loc3_:ThaneInfo = _loc1_ && _loc1_.heroInfo ? _loc1_.heroInfo : thane;
         var _loc4_:int = _loc3_.templateInfo.Job;
         _loc4_ = int(_loc4_ == 100 ? 1 : _loc4_);
         if(_loc1_ && _loc1_.heroInfo && _loc1_.heroInfo.dragonTalkerInfo.isDragonTalker)
         {
            _loc4_ = 4;
         }
         if(_loc3_.grades < 50)
         {
            _loc2_ = ComponentSetting.getUISourcePath("battlejob" + _loc4_);
         }
         else
         {
            _loc2_ = ComponentSetting.getUISourcePath("battlejob50" + _loc4_);
         }
         LoaderManagerII.instance.load(_loc2_,3,10,onJobComplete,onJobProgress);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function onJobProgress(param1:LoaderInfo) : void
      {
         _proDic[param1.url] = param1.bytesLoaded / param1.bytesTotal;
      }
      
      private function onJobComplete(param1:LoaderInfo, param2:Object) : void
      {
         _currentCunt = _currentCunt + 1;
         isUIComplete();
      }
      
      private function loadResistRes() : void
      {
         var _loc1_:String = PathManager.info.ResourcePath + "skillEffect/resist_sheld.swf";
         addMultiClassResourcePath(_loc1_.toLowerCase());
         LoaderManagerII.instance.load(_loc1_,1,10,resistResourceLoadComplete,resistResourceProgress);
      }
      
      private function resistResourceProgress(param1:LoaderInfo) : void
      {
         _proDic[param1.url] = param1.bytesLoaded / param1.bytesTotal;
      }
      
      private function resistResourceLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:ApplicationDomain = getDomainByPaty(param1.url);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _loc4_.allowCodeImport = true;
         }
         _resistResLoader = new Loader();
         _resistResLoader.contentLoaderInfo.addEventListener("complete",__loadResistResComplete);
         _resistResLoader.loadBytes(param2 as ByteArray,_loc4_);
      }
      
      private function __loadResistResComplete(param1:Event) : void
      {
         _currentCunt = _currentCunt + 1;
         isUIComplete();
         _resistResLoader.contentLoaderInfo.removeEventListener("complete",__loadResistResComplete);
         _resistResLoader.unloadAndStop(true);
         _resistResLoader = null;
      }
      
      private function loadPublicSkill() : void
      {
         var _loc1_:String = PathManager.info.ResourcePath + "skillEffect/skill_public.swf";
         addMultiClassResourcePath(_loc1_.toLowerCase());
         LoaderManagerII.instance.load(_loc1_,1,10,publicSkillLoadComplete,onpPublicSkillProgress);
      }
      
      private function onpPublicSkillProgress(param1:LoaderInfo) : void
      {
         _proDic[param1.url] = param1.bytesLoaded / param1.bytesTotal;
      }
      
      private function publicSkillLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:ApplicationDomain = getDomainByPaty(param1.url);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _loc4_.allowCodeImport = true;
         }
         _skillLoader = new Loader();
         _skillLoader.contentLoaderInfo.addEventListener("complete",__loadSkillComplete);
         _skillLoader.loadBytes(param2 as ByteArray,_loc4_);
      }
      
      private function __loadSkillComplete(param1:Event) : void
      {
         _currentCunt = _currentCunt + 1;
         isUIComplete();
         _skillLoader.contentLoaderInfo.removeEventListener("complete",__loadSkillComplete);
         _skillLoader.unloadAndStop(false);
         _skillLoader = null;
      }
      
      private function loadBattleMap() : void
      {
         var _loc1_:String = PathManager.getBattleMapPath(BattleManager.getInstance().battleModel.mapResId);
         addSingleClassResourcePath(_loc1_.toLowerCase());
         LoaderManagerII.instance.load(_loc1_,1,10,battleMapComplete,onBattleMapProgress);
      }
      
      private function onBattleMapProgress(param1:LoaderInfo) : void
      {
         _proDic[param1.url] = param1.bytesLoaded / param1.bytesTotal;
      }
      
      private function battleMapComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:ApplicationDomain = BattleManager.getInstance().resourceModel.getDomainByPaty(param1.url);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _loc4_.allowCodeImport = true;
         }
         _mapLoader = new Loader();
         _mapLoader.contentLoaderInfo.addEventListener("complete",__loadMapComplete);
         _mapLoader.loadBytes(param2 as ByteArray,_loc4_);
      }
      
      private function __loadMapComplete(param1:Event) : void
      {
         var _loc2_:String = PathManager.getBattleMapPath(BattleManager.getInstance().battleModel.mapResId);
         battleMap = MovieClip(getInstanceByPath(_loc2_.toLowerCase(),0));
         _currentCunt = _currentCunt + 1;
         isUIComplete();
         _mapLoader.contentLoaderInfo.removeEventListener("complete",__loadMapComplete);
         _mapLoader.unloadAndStop(false);
         _mapLoader = null;
      }
      
      private function isUIComplete() : void
      {
         if(_currentCunt >= _nessaryCount)
         {
            BattleModel.battleUILoaded = true;
            NotificationManager.instance.dispatchEvent(new BattleEvent("battleUILoaded",null));
         }
      }
      
      public function addSkillNameIds(param1:Array) : void
      {
         _skillNameLoader = new SkillNameLoader(param1,skillNameLoadComplete);
         _skillNameLoader.load();
      }
      
      private function skillNameLoadComplete() : void
      {
      }
      
      public function getSkillName(param1:int) : DisplayObject
      {
         return _skillNameLoader.getRes(param1);
      }
      
      public function addSingleClassResourcePath(param1:String) : void
      {
         param1 = param1.toLowerCase();
         if(_applicationMap[param1])
         {
            return;
         }
         var _loc2_:ApplicationDomain = new ApplicationDomain(_applicationDomain);
         _applicationMap[param1] = _loc2_;
      }
      
      public function addMultiClassResourcePath(param1:String) : void
      {
         param1 = param1.toLowerCase();
         if(_applicationMap[param1])
         {
            return;
         }
         _applicationMap[param1] = _applicationDomain;
      }
      
      public function getDomainByPaty(param1:String) : ApplicationDomain
      {
         param1 = param1.toLowerCase();
         return _applicationMap[param1];
      }
      
      public function isLoaded(param1:String) : Boolean
      {
         return _loadedUrl.indexOf(param1) < 0 ? false : true;
      }
      
      public function progress() : int
      {
         var _loc1_:Number = 0;
         for each(var _loc2_:Number in _proDic)
         {
            _loc1_ += _loc2_;
         }
         return _loc1_ / _nessaryCount * 100;
      }
      
      public function getOrCreateInstanse(param1:String) : MovieClip
      {
         var _loc3_:MovieClip = null;
         var _loc2_:Array = moviePool[param1] as Array;
         if(!_loc2_)
         {
            _loc2_ = [];
            moviePool[param1] = _loc2_;
         }
         if(_loc2_.length > 0)
         {
            _loc3_ = _loc2_.pop() as MovieClip;
         }
         else
         {
            _loc3_ = getInstanceByDefinition(param1) as MovieClip;
         }
         if(_loc3_)
         {
            outMovie[_loc3_] = _loc3_;
         }
         return _loc3_;
      }
      
      public function recyleInstanse(param1:MovieClip) : void
      {
         var _loc4_:int = 0;
         if(!param1)
         {
            return;
         }
         if(outMovie[param1])
         {
            outMovie[param1] = null;
            delete outMovie[param1];
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         _loc4_ = 0;
         while(_loc4_ < param1.totalFrames)
         {
            param1.addFrameScript(_loc4_ + 1,null);
            _loc4_++;
         }
         param1.gotoAndStop(1);
         if(!moviePool)
         {
            return;
         }
         var _loc3_:String = getQualifiedClassName(param1);
         _loc3_ = _loc3_.replace("::",".");
         var _loc2_:Array = moviePool[_loc3_] as Array;
         if(!_loc2_)
         {
            _loc2_ = [];
            moviePool[_loc3_] = _loc2_;
         }
         _loc2_.push(param1);
      }
      
      private function disposeMoviePool() : void
      {
         var _loc2_:Object = null;
         for(var _loc3_:String in outMovie)
         {
            recyleInstanse(outMovie[_loc3_] as MovieClip);
            delete outMovie[_loc3_];
         }
         for each(var _loc1_:Array in moviePool)
         {
            while(_loc1_.length > 0)
            {
               _loc2_ = _loc1_.pop();
               ObjectUtils.disposeObject(_loc2_);
            }
         }
         moviePool = null;
      }
      
      public function dispose() : void
      {
         disposeMoviePool();
         if(_skillNameLoader)
         {
            _skillNameLoader.dispose();
            _skillNameLoader = null;
         }
         if(_otherResLoader)
         {
            _otherResLoader.dispose();
            _otherResLoader = null;
         }
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(battleMapComplete);
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(publicSkillLoadComplete);
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onJobComplete);
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onUIComplete);
         for(var _loc1_:String in _applicationMap)
         {
            delete _applicationMap[_loc1_];
         }
         _applicationMap = null;
         _applicationDomain = null;
         _loadedUrl = null;
         battleMap = null;
      }
   }
}


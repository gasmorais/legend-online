package unrealshooting.helper
{
   import com.pickgliss.loader.ResourceDomain;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import unrealshooting.helper.view.VehicleMapSkillMovie;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class VehicleResourceManager extends EventDispatcher
   {
      
      private static var _instance:VehicleResourceManager;
      
      private var _setup:Boolean;
      
      private var _objectPool:Dictionary;
      
      private var _resDomain:ResourceDomain;
      
      public function VehicleResourceManager()
      {
         super();
      }
      
      public static function get instance() : VehicleResourceManager
      {
         if(!_instance)
         {
            _instance = new VehicleResourceManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(_setup)
         {
            return;
         }
         _setup = true;
         _resDomain = new ResourceDomain();
         _objectPool = new Dictionary();
         startLoadSkillResource();
      }
      
      private function startLoadSkillResource() : void
      {
         var _loc1_:String = null;
         var _loc3_:Dictionary = TempleteManager.instance.vehicleSkillTempteCate.getTemplates();
         for each(var _loc2_:VehicleSkillTempInfo in _loc3_)
         {
            _loc1_ = PathManager.getVehicleSkillPath(String(_loc2_.ActionId));
            _resDomain.load(_loc1_);
         }
      }
      
      public function createStartEffect(param1:int) : VehicleMapSkillMovie
      {
         var _loc3_:String = "asset.vehicle.start" + param1;
         return getSkillMovieFromPool(_loc3_);
      }
      
      public function getSkillMovieFromPool(param1:String) : VehicleMapSkillMovie
      {
         var _loc4_:VehicleMapSkillMovie = null;
         var _loc3_:MovieClip = null;
         var _loc2_:Array = _objectPool[param1];
         if(!_loc2_)
         {
            _loc2_ = [];
            _objectPool[param1] = _loc2_;
         }
         if(_loc2_.length > 0)
         {
            _loc4_ = _loc2_.pop();
         }
         else if(_resDomain.hasDefinition(param1))
         {
            _loc3_ = _resDomain.createInstane(param1) as MovieClip;
            if(_loc3_)
            {
               _loc4_ = new VehicleMapSkillMovie(param1,_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function getFlyClassArray(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc2_:Array = [];
         var _loc5_:String = "asset.vehicle.fly" + param1;
         _loc4_ = 1;
         while(_loc4_ < 11)
         {
            _loc3_ = _loc5_ + ".fx" + _loc4_;
            if(domain.hasDefinition(_loc3_))
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function createEndEffect(param1:int) : VehicleMapSkillMovie
      {
         var _loc2_:String = null;
         var _loc4_:String = "asset.vehicle.end" + param1;
         var _loc3_:VehicleMapSkillMovie = getSkillMovieFromPool(_loc4_);
         if(!_loc3_)
         {
            _loc2_ = PathManager.getVehicleSkillPath(String(param1));
            _resDomain.load(_loc2_);
         }
         return _loc3_;
      }
      
      public function recycle(param1:String, param2:VehicleMapSkillMovie) : void
      {
         var _loc3_:Array = _objectPool[param1];
         if(!_loc3_)
         {
            _loc3_ = [];
            _objectPool[param1] = _loc3_;
         }
         _loc3_.push(param2);
      }
      
      public function createBuffEffect(param1:int) : MovieClip
      {
         var _loc3_:MovieClip = null;
         var _loc2_:VehicleSkillBuffTemplate = TempleteManager.instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(param1);
         if(!_loc2_)
         {
            return null;
         }
         if(StringHelper.isNullOrEmpty(_loc2_.LastEffect))
         {
            return null;
         }
         var _loc4_:String = "asset.vehicle." + _loc2_.LastEffect;
         if(_resDomain.hasDefinition(_loc4_))
         {
            _loc3_ = _resDomain.createInstane(_loc4_) as MovieClip;
            if(_loc3_)
            {
               _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
            }
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         if(_resDomain)
         {
            _resDomain.dispose();
         }
         _resDomain = null;
         for each(var _loc1_:Array in _objectPool)
         {
            for each(var _loc2_:Object in _loc1_)
            {
               ObjectUtils.disposeObject(_loc2_);
            }
         }
         _objectPool = null;
         _instance = null;
         _setup = false;
      }
      
      public function get domain() : ResourceDomain
      {
         return _resDomain;
      }
   }
}


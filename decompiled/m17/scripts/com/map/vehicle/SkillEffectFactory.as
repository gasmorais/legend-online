package com.map.vehicle
{
   import com.map.vehicle.data.UseSkillInfo;
   import com.map.vehicle.utils.VehicleUtil;
   import com.map.vehicle.view.VehicleSkillMovie;
   import com.pickgliss.loader.ResourceDomain;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class SkillEffectFactory extends EventDispatcher
   {
      
      private static var _instance:SkillEffectFactory;
      
      private var _setup:Boolean;
      
      private var _objectPool:Dictionary;
      
      private var _resDomain:ResourceDomain;
      
      public function SkillEffectFactory()
      {
         super();
      }
      
      public static function get instance() : SkillEffectFactory
      {
         if(!_instance)
         {
            _instance = new SkillEffectFactory();
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
      
      public function createStartEffect(param1:UseSkillInfo) : VehicleSkillMovie
      {
         var _loc4_:int = int(param1.skillTemplate.ActionId);
         var _loc3_:String = "asset.vehicle.start" + _loc4_;
         return getSkillMovie(_loc3_);
      }
      
      public function createEndEffect(param1:UseSkillInfo) : VehicleSkillMovie
      {
         var _loc2_:String = null;
         var _loc5_:int = int(param1.skillTemplate.ActionId);
         var _loc4_:String = "asset.vehicle.end" + _loc5_;
         var _loc3_:VehicleSkillMovie = getSkillMovie(_loc4_);
         if(!_loc3_)
         {
            _loc2_ = PathManager.getVehicleSkillPath(String(_loc5_));
            _resDomain.load(_loc2_);
         }
         return _loc3_;
      }
      
      private function getInstanceOfClass(param1:String) : MovieClip
      {
         var _loc2_:MovieClip = null;
         if(domain.hasDefinition(param1))
         {
            _loc2_ = domain.createInstane(param1) as MovieClip;
         }
         return _loc2_;
      }
      
      public function recycle(param1:String, param2:VehicleSkillMovie) : void
      {
         var _loc3_:Array = _objectPool[param1];
         if(!_loc3_)
         {
            _loc3_ = [];
            _objectPool[param1] = _loc3_;
         }
         _loc3_.push(param2);
      }
      
      public function getSkillMovie(param1:String) : VehicleSkillMovie
      {
         var _loc4_:VehicleSkillMovie = null;
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
         else
         {
            _loc3_ = getInstanceOfClass(param1);
            if(_loc3_)
            {
               _loc4_ = new VehicleSkillMovie(param1,_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function getFlyClassArray(param1:UseSkillInfo) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc2_:Array = [];
         var _loc5_:int = int(param1.skillTemplate.ActionId);
         var _loc6_:String = "asset.vehicle.fly" + _loc5_;
         _loc4_ = 1;
         while(_loc4_ < 11)
         {
            _loc3_ = _loc6_ + ".fx" + _loc4_;
            if(domain.hasDefinition(_loc3_))
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function createBuffEffect(param1:int) : MovieClip
      {
         var _loc3_:MovieClip = null;
         var _loc2_:VehicleSkillBuffTemplate = VehicleUtil.getBuffTemplate(param1);
         if(!_loc2_)
         {
            return null;
         }
         if(StringHelper.isNullOrEmpty(_loc2_.LastEffect))
         {
            return null;
         }
         var _loc4_:String = "asset.vehicle." + _loc2_.LastEffect;
         if(domain.hasDefinition(_loc4_))
         {
            _loc3_ = domain.createInstane(_loc4_) as MovieClip;
            _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
         }
         return _loc3_;
      }
      
      private function slicePath(param1:String) : String
      {
         var _loc2_:int = param1.indexOf("?");
         return _loc2_ > -1 ? param1.slice(0,_loc2_) : param1;
      }
      
      public function get domain() : ResourceDomain
      {
         return _resDomain;
      }
      
      public function dispose() : void
      {
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
   }
}

0;


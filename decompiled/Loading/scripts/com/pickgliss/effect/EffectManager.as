package com.pickgliss.effect
{
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   
   public final class EffectManager
   {
      
      private static var _instance:EffectManager;
      
      private var _effects:Dictionary;
      
      private var _effectIDCounter:int = 0;
      
      public function EffectManager()
      {
         super();
         _effects = new Dictionary();
      }
      
      public static function get Instance() : EffectManager
      {
         if(_instance == null)
         {
            _instance = new EffectManager();
         }
         return _instance;
      }
      
      public function getEffectID() : int
      {
         return _effectIDCounter++;
      }
      
      public function creatEffect(param1:int, param2:Object, ... rest) : IEffect
      {
         var _loc4_:IEffect = creatEffectByEffectType(param1);
         _loc4_.init(param2 as DisplayObject,rest);
         _effects[_loc4_.id] = _loc4_;
         return _loc4_;
      }
      
      public function getEffectByTarget(param1:Object) : IEffect
      {
         for each(var _loc2_:IEffect in _effects)
         {
            if(param1 == _loc2_.target)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function removeEffect(param1:IEffect) : void
      {
         param1.dispose();
         delete _effects[param1.id];
      }
      
      public function creatEffectByEffectType(param1:int) : IEffect
      {
         var _loc2_:IEffect = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = new AddMovieEffect(getEffectID());
               break;
            case 1:
               _loc2_ = new ShinerAnimation(getEffectID());
               break;
            case 2:
               _loc2_ = new AlphaShinerAnimation(getEffectID());
         }
         return _loc2_;
      }
   }
}


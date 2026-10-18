package com.speedEngine.speedBones.manager
{
   import com.speedEngine.speedBones.interfaces.ISound;
   
   public class SoundManager
   {
      
      private static var _instance:SoundManager;
      
      private var _soundDatas:Object = {};
      
      public function SoundManager()
      {
         super();
      }
      
      public static function get instance() : SoundManager
      {
         if(_instance == null)
         {
            _instance = new SoundManager();
         }
         return _instance;
      }
      
      public function addSound(param1:int, param2:ISound) : void
      {
         if(_soundDatas[param1] == null)
         {
            _soundDatas[param1] = param2;
         }
         else
         {
            trace("音频已经存在，id=" + param1 + "|com.speedEngine.speedBones.manager.SoundManager");
         }
      }
      
      public function removeSound(param1:int) : void
      {
         var _loc2_:ISound = _soundDatas[param1];
         if(_loc2_)
         {
            _loc2_.dispose();
         }
         _soundDatas[param1] = null;
         delete _soundDatas[param1];
      }
      
      public function removeSounds() : void
      {
         var _loc2_:ISound = null;
         for(var _loc1_:int in _soundDatas)
         {
            _loc2_ = _soundDatas[_loc1_];
            if(_loc2_)
            {
               _loc2_.dispose();
            }
            _soundDatas[_loc1_] = null;
            delete _soundDatas[_loc1_];
         }
      }
      
      public function hasSound(param1:int) : Boolean
      {
         return _soundDatas[param1] != null;
      }
      
      public function getSound(param1:int) : ISound
      {
         return _soundDatas[param1];
      }
      
      public function playSound(param1:int, param2:int = 1) : ISound
      {
         var _loc3_:ISound = _soundDatas[param1];
         if(_loc3_)
         {
            _loc3_.play(param2);
            return _loc3_;
         }
         return null;
      }
   }
}


package com.speedEngine.speedBones.interfaces
{
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public interface ISound
   {
      
      function play(param1:Number = 0, param2:int = 1, param3:SoundTransform = null) : SoundChannel;
      
      function stop() : void;
      
      function load() : void;
      
      function getSoundChannel() : SoundChannel;
      
      function dispose() : void;
   }
}


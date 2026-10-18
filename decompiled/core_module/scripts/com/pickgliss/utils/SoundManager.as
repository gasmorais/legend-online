package com.pickgliss.utils
{
   import com.greensock.TweenLite;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.ModuleLoader;
   import flash.events.Event;
   import flash.events.NetStatusEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class SoundManager
   {
      
      private static const MusicFailedTryTime:int = 3;
      
      private static const WORLDBOSSMUSIC:String = "BattleMusicBoss";
      
      private static const BOSSMUSIC:String = "BattleMusicWorldBoss";
      
      private static const BATTLEMUSIC:String = "BattleMusic";
      
      private static const MAP_NUM:int = 11;
      
      public static const CASTLE:String = "castle";
      
      public static const OUTER_CITY:String = "outercity";
      
      public static const BATTLE:String = "battle";
      
      public static const FARM:String = "farm";
      
      public static const CAMPAIGN_SUCCEED:String = "campaign_succeed";
      
      public static const VEHICLE:String = "vehicle";
      
      public static const SPACE:String = "space";
      
      public static const PETLAND:String = "petland";
      
      public static const WEDDING_HOLD:String = "wedding";
      
      public static const WEDDING_ROOM:String = "bgm_wedding";
      
      private static var _instance:SoundManager;
      
      private var _soundDic:Dictionary;
      
      private var _currentSound:Dictionary;
      
      private var _allowSound:Boolean;
      
      private var _musicList:Array;
      
      private var _musicDic:Dictionary;
      
      private var _currentMusic:String;
      
      private var _currentMusicIndex:int;
      
      private var _allowMusic:Boolean;
      
      private var _musicLoop:Boolean;
      
      private var _musicPlaying:Boolean;
      
      private var _currentMusicTry:int = 0;
      
      private var _musicVolumn:Number;
      
      private var _soundVolumn:Number;
      
      private var _nc:NetConnection;
      
      private var _ns:NetStream;
      
      private var _ncII:NetConnection;
      
      private var _nsII:NetStream;
      
      private var _preNs:NetStream;
      
      private var _curNs:NetStream;
      
      private var _musicSite:String;
      
      private var _battleMapDic:Dictionary;
      
      private var _currentState:String;
      
      private var _musicCanStart:Boolean;
      
      private var _fadeOutTweener:TweenLite;
      
      private var _fadeInTweener:TweenLite;
      
      public function SoundManager()
      {
         super();
         _soundDic = new Dictionary();
         _currentSound = new Dictionary();
         _musicLoop = false;
         _musicPlaying = false;
         _nc = new NetConnection();
         _nc.connect(null);
         _ns = new NetStream(_nc);
         _ns.bufferTime = 0.3;
         _ns.client = this;
         _ns.addEventListener("netStatus",__netStatus);
         _ncII = new NetConnection();
         _ncII.connect(null);
         _nsII = new NetStream(_nc);
         _nsII.bufferTime = 0.3;
         _nsII.client = this;
         _nsII.addEventListener("netStatus",__netStatus);
         _musicDic = new Dictionary(true);
         _battleMapDic = new Dictionary(true);
      }
      
      public static function get instance() : SoundManager
      {
         if(!_instance)
         {
            _instance = new SoundManager();
         }
         return _instance;
      }
      
      public function get allowSound() : Boolean
      {
         return _allowSound;
      }
      
      public function set allowSound(param1:Boolean) : void
      {
         if(_allowSound == param1)
         {
            return;
         }
         _allowSound = param1;
         if(_allowSound == false)
         {
            stopAllSound();
         }
      }
      
      public function get allowMusic() : Boolean
      {
         return _allowMusic;
      }
      
      public function set allowMusic(param1:Boolean) : void
      {
         if(_allowMusic == param1)
         {
            return;
         }
         _allowMusic = param1;
         if(_allowMusic)
         {
            resumeMusic();
         }
         else
         {
            pauseMusic();
         }
      }
      
      public function get soundVolumn() : Number
      {
         return _soundVolumn;
      }
      
      public function get musicVolumn() : Number
      {
         return _musicVolumn;
      }
      
      public function setup(param1:XML) : void
      {
         var _loc5_:String = null;
         var _loc13_:XMLList = null;
         var _loc2_:String = null;
         var _loc7_:XMLList = null;
         var _loc9_:Array = null;
         var _loc3_:XMLList = param1..sounds;
         for each(var _loc11_:XML in _loc3_)
         {
            _loc13_ = _loc11_..sound;
            _loc5_ = _loc11_.@source;
            for each(var _loc12_:XML in _loc13_)
            {
               _soundDic[String(_loc12_.@id)] = String(_loc12_.@cls);
            }
         }
         var _loc8_:XMLList = param1..musics;
         for each(var _loc10_:XML in _loc8_)
         {
            _loc7_ = _loc10_..music;
            _loc2_ = _loc10_.@root;
            for each(var _loc6_:XML in _loc7_)
            {
               _loc9_ = String(_loc6_.@filename).split(",");
               _musicDic[String(_loc6_.@key)] = _loc9_;
            }
         }
         _musicSite = _loc2_;
         var _loc4_:Sound = new Sound(new URLRequest(""));
         _loc4_.play();
         try
         {
            _loc4_.close();
         }
         catch(e:Error)
         {
         }
      }
      
      public function initbattleMusics(param1:Array, param2:Dictionary) : void
      {
         _musicDic["battle"] = param1;
         _battleMapDic = param2;
      }
      
      public function setupAudioResource() : void
      {
      }
      
      public function setConfig(param1:Boolean, param2:Boolean, param3:Number, param4:Number) : void
      {
         allowMusic = param2;
         allowSound = param1;
         _musicVolumn = param3;
         _soundVolumn = param4;
         _ns.soundTransform = new SoundTransform(_musicVolumn / 100);
         _nsII.soundTransform = new SoundTransform(_musicVolumn / 100);
      }
      
      public function hasSound(param1:String) : Boolean
      {
         if(_soundDic[param1] != null)
         {
            if(_soundDic[param1] is String && ModuleLoader.hasDefinition(_soundDic[param1]))
            {
               _soundDic[param1] = ModuleLoader.getDefinition(_soundDic[param1]);
            }
            return true;
         }
         return false;
      }
      
      public function isPlaying(param1:String) : Boolean
      {
         return _currentSound[param1] != null;
      }
      
      public function play(param1:String, param2:Boolean = false, param3:Boolean = true, param4:int = 0) : void
      {
         if(hasSound(param1) == false)
         {
            return;
         }
         if(_allowSound)
         {
            try
            {
               if(param2 || isPlaying(param1) == false)
               {
                  playSoundImp(param1,param3,param4);
               }
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private function playSoundImp(param1:String, param2:Boolean, param3:Number) : void
      {
         var _loc6_:SoundChannel = null;
         if(_currentSound[param1] != null && param2)
         {
            _loc6_ = _currentSound[param1] as SoundChannel;
            _loc6_.removeEventListener("soundComplete",__soundComplete);
            _loc6_.stop();
            _currentSound[param1] = null;
         }
         var _loc4_:Sound = new _soundDic[param1]();
         var _loc5_:SoundChannel = _loc4_.play(0,param3,new SoundTransform(_soundVolumn / 100));
         _loc5_.addEventListener("soundComplete",__soundComplete);
         _currentSound[param1] = _loc5_;
      }
      
      private function __soundComplete(param1:Event) : void
      {
         var _loc2_:SoundChannel = param1.currentTarget as SoundChannel;
         _loc2_.removeEventListener("soundComplete",__soundComplete);
         _loc2_.stop();
         for(var _loc3_:String in _currentSound)
         {
            if(_currentSound[_loc3_] == _loc2_)
            {
               _currentSound[_loc3_] = null;
               return;
            }
         }
      }
      
      public function stop(param1:String) : void
      {
         if(_currentSound[param1])
         {
            _currentSound[param1].removeEventListener("soundComplete",__soundComplete);
            _currentSound[param1].stop();
            _currentSound[param1] = null;
         }
      }
      
      public function stopAllSound() : void
      {
         for each(var _loc1_:SoundChannel in _currentSound)
         {
            if(_loc1_)
            {
               _loc1_.removeEventListener("soundComplete",__soundComplete);
               _loc1_.stop();
            }
         }
         _currentSound = new Dictionary();
      }
      
      public function playMusic(param1:String, param2:int = -1, param3:Boolean = true, param4:Boolean = false) : void
      {
         _musicList = _musicDic[param1] as Array;
         _currentMusicTry = 0;
         if(_musicList == null)
         {
            return;
         }
         if(param2 == -1 || param2 >= _musicList.length)
         {
            param2 = getRandomIndex();
         }
         if(_currentMusic != _musicList[param2] || param4)
         {
            prepared();
            playMusicImp(param2,param3);
         }
      }
      
      public function getMusicListByType(param1:String) : Array
      {
         return _musicDic[param1] as Array;
      }
      
      public function getBattleMapMusics(param1:int) : Array
      {
         return _battleMapDic[param1];
      }
      
      public function dynamicPlayMusic(param1:String, param2:Boolean = true, param3:Boolean = false) : void
      {
         if(!param1)
         {
            return;
         }
         _musicList = param1.split(",");
         _currentMusicTry = 0;
         var _loc4_:int = getRandomIndex();
         if(_currentMusic != _musicList[_loc4_] || param3)
         {
            prepared();
            playMusicImp(_loc4_,param2);
         }
      }
      
      private function prepared() : void
      {
         _preNs = _curNs != _ns ? _nsII : _ns;
         _preNs.removeEventListener("netStatus",__onMusicStaus);
         _curNs = _curNs == _ns ? _nsII : _ns;
         _musicPlaying = false;
         _currentMusic = null;
         _currentMusicIndex = -1;
      }
      
      private function getRandomIndex() : int
      {
         return int(Math.random() * _musicList.length);
      }
      
      private function getMusicIndexByID(param1:String) : int
      {
         var _loc2_:int = _musicList.indexOf(param1);
         return _loc2_ == -1 ? 0 : _loc2_;
      }
      
      private function playMusicImp(param1:int, param2:Boolean) : void
      {
         var _loc4_:String = null;
         var _loc3_:SoundTransform = null;
         if(param1 == -1)
         {
            return;
         }
         if(!_musicList)
         {
            return;
         }
         if(param1 >= _musicList.length)
         {
            param1 = 0;
         }
         _musicLoop = param2;
         if(_musicList.length > 0)
         {
            _currentMusicIndex = param1;
            _currentMusic = _musicList[param1];
            _currentMusic = _currentMusic.toLowerCase();
            _musicPlaying = true;
            _loc4_ = LoaderManagerII.instance.getMd5PathByUrl(_musicSite + _currentMusic + ".flv");
            _curNs.play(_loc4_);
            _curNs.soundTransform = new SoundTransform(0);
            if(_allowMusic)
            {
               _musicCanStart = false;
               _curNs.addEventListener("netStatus",__onMusicStaus);
               removeMusicTweener();
               _loc3_ = new SoundTransform(_musicVolumn / 100);
               _fadeOutTweener = TweenLite.to(_loc3_,1.5,{
                  "volume":0.4,
                  "onUpdate":updateFadeOutChannel,
                  "onUpdateParams":[_preNs,_loc3_],
                  "onComplete":musicFadeOutComplete,
                  "onCompleteParams":[_preNs]
               });
            }
            else
            {
               _curNs.removeEventListener("netStatus",__onMusicStaus);
               pauseMusic();
            }
         }
      }
      
      private function updateFadeOutChannel(param1:NetStream, param2:SoundTransform) : void
      {
         param1.soundTransform = new SoundTransform(param2.volume);
      }
      
      private function musicFadeOutComplete(param1:NetStream) : void
      {
         var _loc2_:SoundTransform = null;
         _fadeOutTweener = null;
         try
         {
            param1.close();
         }
         catch(err:Error)
         {
         }
         if(_musicCanStart)
         {
            _loc2_ = new SoundTransform(0);
            _curNs.soundTransform = _loc2_;
            _fadeInTweener = TweenLite.to(_loc2_,1.5,{
               "volume":_musicVolumn / 100,
               "onUpdate":onMusicFadeInUpdate,
               "onUpdateParams":[_loc2_],
               "onComplete":musicFadeInComplete
            });
            resumeMusic();
         }
      }
      
      private function onMusicFadeInUpdate(param1:SoundTransform) : void
      {
         _curNs.soundTransform = new SoundTransform(param1.volume);
      }
      
      private function musicFadeInComplete() : void
      {
         _fadeInTweener = null;
      }
      
      private function removeMusicTweener() : void
      {
         if(_fadeOutTweener)
         {
            _fadeOutTweener.kill();
            _fadeOutTweener = null;
            try
            {
               _preNs.close();
            }
            catch(err:Error)
            {
            }
         }
         if(_fadeInTweener)
         {
            _fadeInTweener.kill();
            _fadeInTweener = null;
         }
      }
      
      private function __onMusicStaus(param1:NetStatusEvent) : void
      {
         var _loc2_:String = null;
         if(param1.info.code == "NetConnection.Connect.Failed" || param1.info.code == "NetStream.Play.StreamNotFound")
         {
            if(_currentMusicTry < 3)
            {
               _currentMusicTry = _currentMusicTry + 1;
               _currentMusic = _currentMusic.toLowerCase();
               _loc2_ = LoaderManagerII.instance.getMd5PathByUrl(_musicSite + _currentMusic + ".flv");
               _curNs.play(_loc2_);
            }
            else
            {
               _curNs.removeEventListener("netStatus",__onMusicStaus);
               try
               {
                  _curNs.close();
               }
               catch(err:Error)
               {
               }
            }
         }
         else if(param1.info.code == "NetStream.Play.Start")
         {
            _curNs.removeEventListener("netStatus",__onMusicStaus);
            if(_fadeOutTweener)
            {
               _musicCanStart = true;
               pauseMusic();
            }
         }
      }
      
      public function pauseMusic() : void
      {
         if(_musicPlaying)
         {
            _curNs.pause();
            _musicPlaying = false;
         }
      }
      
      public function resumeMusic() : void
      {
         if(_allowMusic && _currentMusic)
         {
            _curNs.resume();
            _musicPlaying = true;
         }
      }
      
      public function stopMusic() : void
      {
         if(_currentMusic)
         {
            _musicPlaying = false;
            try
            {
               _curNs.close();
            }
            catch(err:Error)
            {
            }
            _currentMusic = null;
            _currentMusicIndex = -1;
         }
      }
      
      private function __netStatus(param1:NetStatusEvent) : void
      {
         if(param1.info.code == "NetStream.Play.Stop")
         {
            if(_musicLoop)
            {
               playMusicImp(_currentMusicIndex,_musicLoop);
            }
            else
            {
               _currentMusicIndex = _currentMusicIndex + 1;
               playMusicImp(_currentMusicIndex,_musicLoop);
            }
         }
      }
      
      public function onMetaData(param1:Object) : void
      {
      }
      
      public function onPlayStatus(param1:Object) : void
      {
      }
      
      public function playExtraMusic(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:SoundTransform = null;
         prepared();
         _musicPlaying = true;
         param1 = param1.toLowerCase();
         _curNs.play(param1);
         _curNs.soundTransform = new SoundTransform(0);
         if(_allowMusic)
         {
            _musicCanStart = false;
            _curNs.addEventListener("netStatus",__onMusicStaus);
            removeMusicTweener();
            _loc3_ = new SoundTransform(_musicVolumn / 100);
            _fadeOutTweener = TweenLite.to(_loc3_,1.5,{
               "volume":0.4,
               "onUpdate":updateFadeOutChannel,
               "onUpdateParams":[_preNs,_loc3_],
               "onComplete":musicFadeOutComplete,
               "onCompleteParams":[_preNs]
            });
         }
         else
         {
            _curNs.removeEventListener("netStatus",__onMusicStaus);
            pauseMusic();
         }
      }
   }
}


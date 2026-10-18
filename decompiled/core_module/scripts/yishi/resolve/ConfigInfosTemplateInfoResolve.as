package yishi.resolve
{
   import com.pickgliss.utils.SoundManager;
   import flash.utils.Dictionary;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.utils.ClassFactory;
   
   public class ConfigInfosTemplateInfoResolve extends TemplateBaseResolve
   {
      
      private static const WORLDBOSSMUSIC:String = "BattleMusicBoss";
      
      private static const BOSSMUSIC:String = "BattleMusicWorldBoss";
      
      private static const BATTLEMUSIC:String = "BattleMusic";
      
      private var musicArr:Array = [];
      
      private var worldBossMusic:Array = [];
      
      private var bossMusic:Array = [];
      
      private var battleMusic:Array = [];
      
      private var battleMapMusicDic:Dictionary = new Dictionary();
      
      public function ConfigInfosTemplateInfoResolve(param1:XMLList, param2:Function)
      {
         super(param1,param2);
         _dic = new Dictionary();
      }
      
      override public function resolveImp() : void
      {
         var _loc1_:Array = null;
         var _loc2_:ConfigInfosTempInfo = ClassFactory.createInstanceIII(ConfigInfosTempInfo,_list[_index]);
         _dic[_loc2_.ConfigName] = _loc2_;
         if(_loc2_.ConfigName == "BattleMusicWorldBoss" && _loc2_.ConfigValue)
         {
            worldBossMusic = _loc2_.ConfigValue.split(",");
            battleMapMusicDic["0"] = worldBossMusic;
         }
         if(_loc2_.ConfigName == "BattleMusicBoss" && _loc2_.ConfigValue)
         {
            bossMusic = _loc2_.ConfigValue.split(",");
            battleMapMusicDic["1"] = bossMusic;
         }
         if(_loc2_.ConfigName.indexOf("BattleMusic") > -1 && _loc2_.ConfigValue)
         {
            _loc1_ = [];
            _loc1_ = _loc2_.ConfigValue.split(",");
            battleMapMusicDic[(int(_loc2_.ConfigName.substring(11)) + 1).toString()] = _loc1_;
            battleMusic = battleMusic.concat(_loc1_);
         }
         _index = _index + 1;
         if(_index == totalLength)
         {
            isComplete = true;
            musicArr = worldBossMusic.concat(bossMusic);
            musicArr = musicArr.concat(battleMusic);
            SoundManager.instance.initbattleMusics(musicArr,battleMapMusicDic);
            _callback(_dic);
            _callback = null;
         }
      }
   }
}


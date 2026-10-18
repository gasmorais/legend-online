package yishi.utils
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.utils.SoundManager;
   
   public class BackUpLoaderStartupUtil
   {
      
      public function BackUpLoaderStartupUtil()
      {
         super();
      }
      
      public static function addUIModule() : void
      {
         var _loc1_:String = ComponentSetting.getUISourcePath("core");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getProjectSourcePath("audio.swf");
         LoaderManagerII.instance.load(_loc1_,3,1,__audioCompleteHandler);
         _loc1_ = ComponentSetting.getUISourcePath("castlemap1");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("politics");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("casern");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("transferbuilding");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("offerreward");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("pveroomlist");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("pvproomlist");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("seminarybless");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("countlogin");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("worldmap");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("setting");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("selectcampaign");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("gradebox");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("colosseum");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("sort");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("worldboss");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("friends");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("consortia");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("dayguide");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("box");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("invite");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("roompvp");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("room");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("baseroom");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("maphorse");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("campaign");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("seminary");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("market");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("mounts");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("consortiagroupchat");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("kingcontract");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("teammanager");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("qte");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("hamster");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("phone");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("playerinfo");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("rename");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("lookconsortiainfo");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("quickbuy");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("hook");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("maze");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("auction");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("vip");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("securitycode");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("customerservice");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("farm");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("farmmap");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("rechargetime");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("firstpay");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("pvp");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("chest");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("clearance");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("bag360");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("feedback");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("funny");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("playerlevelup");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("writeemail");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("taskextra");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("warlords");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("mopup");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("questionnaire");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("castle");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("map");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("battle");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("shop");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("store");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("email");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("task");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("army");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("tasktracebar");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("smallmap");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("toptoolbar");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("chat");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("maintoolbar");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("queuebar");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("resourcesbar");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("tips");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("funpreview");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("newfirstpay");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("question");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
         _loc1_ = ComponentSetting.getUISourcePath("newmemorycard");
         LoaderManagerII.instance.load(_loc1_,1,1,null);
      }
      
      private static function __audioCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         SoundManager.instance.setupAudioResource();
      }
   }
}


package map.campaign.mediator.randomboss
{
   import com.road.yishi.proto.campaign.DragonCampaingnDataMsg;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import map.campaign.mediator.molong.MolongManager;
   import ui.toptoolbar.TopToolsBar;
   import yishi.manager.NotificationManager;
   
   public class RandomShaiziManager extends MolongManager
   {
      
      private static var _instance:RandomShaiziManager;
      
      public static const NAME:String = "map.campaign.mediator.randomboss.RandomShaiziManager";
      
      public var currentRound:int;
      
      protected var _mediatorKey:String;
      
      private var _cdTime:int = 1801;
      
      private var cdUint:uint;
      
      public function RandomShaiziManager()
      {
         super();
      }
      
      public static function get instance() : RandomShaiziManager
      {
         if(!_instance)
         {
            _instance = new RandomShaiziManager();
         }
         return _instance;
      }
      
      public function get cdTime() : int
      {
         return _cdTime;
      }
      
      public function set cdTime(param1:int) : void
      {
         _cdTime = param1;
         clearInterval(cdUint);
         if(_cdTime <= 1800)
         {
            cdUint = setInterval(onCd,1000);
         }
      }
      
      private function onCd() : void
      {
         _cdTime -= 1;
         NotificationManager.instance.sendNotification("RANDOM_CAMPAIGN_CD");
         if(_cdTime <= 0)
         {
            clearInterval(cdUint);
         }
      }
      
      public function init() : void
      {
         super.molongInit();
         TopToolsBar.instance.show();
      }
      
      override public function countDownInit() : void
      {
      }
      
      override public function acceptedServerInfo(param1:DragonCampaingnDataMsg) : void
      {
         reconnectedInfo = param1;
         NotificationManager.instance.sendNotification("RANDOM_CAMPAIGN_UPDATE_TIME");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         cdTime = 0;
         clearInterval(cdUint);
      }
      
      override public function forBattle() : void
      {
         super.forBattle();
      }
   }
}


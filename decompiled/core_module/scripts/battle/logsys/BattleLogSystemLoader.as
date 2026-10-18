package battle.logsys
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class BattleLogSystemLoader
   {
      
      private var _callback:Function;
      
      private var _loader:Loader;
      
      public function BattleLogSystemLoader(param1:Function)
      {
         super();
         _callback = param1;
      }
      
      public function load() : void
      {
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener("complete",onComplete);
         _loader.load(new URLRequest("BattleLogSys.swf"));
      }
      
      private function onComplete(param1:Event) : void
      {
         BattleLogSystem.battleLogSys = _loader.content;
         BattleLogSystem.battleLogSys.setup(StageReferance.stage);
         _loader.contentLoaderInfo.removeEventListener("complete",onComplete);
         if(_callback != null)
         {
            _callback();
         }
      }
   }
}


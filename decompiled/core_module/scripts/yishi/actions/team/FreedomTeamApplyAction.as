package yishi.actions.team
{
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import yishi.actions.map.MapBaseAction;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class FreedomTeamApplyAction extends MapBaseAction
   {
      
      private var _isPop:Boolean;
      
      private var _id:int;
      
      private var _serverName:String;
      
      private var _msg:String;
      
      public function FreedomTeamApplyAction(param1:int, param2:String, param3:String)
      {
         super();
         _id = param1;
         _serverName = param2;
         _msg = param3;
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         if(!_isPop)
         {
            createApplyFrame(_msg);
            _isPop = true;
         }
      }
      
      private function createApplyFrame(param1:String) : void
      {
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [__requestFrameCloseHandler];
         SimpleAlertHelper.instance.addEventListener("dispose",__disposeHandler);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,param1,_loc2_,_loc3_,false,false,false,1);
      }
      
      private function __disposeHandler(param1:Event) : void
      {
         SimpleAlertHelper.instance.removeEventListener("dispose",__disposeHandler);
         dispose();
      }
      
      private function __requestFrameCloseHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FreedomTeamManager.instance.applyInvite(_id,true,_serverName);
         }
         else
         {
            FreedomTeamManager.instance.applyInvite(_id,false,_serverName);
         }
         dispose();
         SimpleAlertHelper.instance.removeEventListener("dispose",__disposeHandler);
      }
   }
}


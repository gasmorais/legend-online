package battle.actions
{
   import yishi.actions.map.DialogAction;
   import yishi.comm.PackageIn;
   import yishi.service.managers.SocketSendManager;
   
   public class BattleDialogAction extends DialogAction
   {
      
      public function BattleDialogAction(param1:PackageIn)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         _finished = true;
         super.dispose();
         SocketSendManager.instance.sendBattlePlotComplete();
      }
   }
}


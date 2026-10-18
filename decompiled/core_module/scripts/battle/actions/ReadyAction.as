package battle.actions
{
   import yishi.datas.objects.RoleInfo;
   
   public class ReadyAction extends GameBaseAction
   {
      
      public static const READY:String = "Ready";
      
      private var _roleInfo:RoleInfo;
      
      public function ReadyAction(param1:RoleInfo)
      {
         super(false);
         _roleInfo = param1;
         _roleInfo.addAction(this);
      }
      
      override public function prepare() : void
      {
         _roleInfo.action("Ready");
      }
      
      override public function get type() : String
      {
         return "Ready";
      }
   }
}


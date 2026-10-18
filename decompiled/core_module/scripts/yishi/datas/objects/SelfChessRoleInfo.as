package yishi.datas.objects
{
   import battle.view.roles.SelfChessRoleView;
   import flash.events.IEventDispatcher;
   import yishi.datas.templates.SelfChessTempInfo;
   import yishi.events.RoleEvent;
   import yishi.manager.TempleteManager;
   
   public class SelfChessRoleInfo extends HeroRoleInfo
   {
      
      public var userLivingId:int;
      
      public var selfChessId:int;
      
      public var name:String;
      
      public var isFollowHero:Boolean;
      
      private var _tempId:int;
      
      private var _tempInfo:SelfChessTempInfo;
      
      public function SelfChessRoleInfo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get tempInfo() : SelfChessTempInfo
      {
         return _tempInfo;
      }
      
      public function set selfChessTempId(param1:int) : void
      {
         if(_tempId == param1)
         {
            return;
         }
         _tempId = param1;
         _tempInfo = TempleteManager.instance.selfChessTempCate.getTempById(_tempId);
      }
      
      override public function initView() : void
      {
         _roleView = new SelfChessRoleView(this);
      }
      
      override public function updateAwaken(param1:int) : void
      {
         if(_awaken == param1)
         {
            return;
         }
         _awaken = param1;
         if(_awaken < 0)
         {
            _awaken = 0;
         }
         dispatchEvent(new RoleEvent("AWAKEN",{"awaken":param1}));
      }
   }
}


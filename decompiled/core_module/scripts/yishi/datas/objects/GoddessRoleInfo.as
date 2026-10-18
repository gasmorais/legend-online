package yishi.datas.objects
{
   import battle.BattleManager;
   import battle.view.roles.GoddessRoleView;
   import flash.events.IEventDispatcher;
   import yishi.datas.BattleModel;
   import yishi.datas.templates.GoddessTempInfo;
   import yishi.manager.TempleteManager;
   
   public class GoddessRoleInfo extends RoleInfo
   {
      
      public var userId:int;
      
      public var goddessId:int;
      
      public var template:GoddessTempInfo;
      
      public var name:String;
      
      public var grades:int;
      
      public var userLivingId:int;
      
      private var _heroRoleInfo:HeroRoleInfo;
      
      private var _visible:Boolean = true;
      
      public function GoddessRoleInfo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      override public function set templateId(param1:int) : void
      {
         super.templateId = param1;
         template = TempleteManager.instance.goddessTempCate.getTemplateById(param1);
      }
      
      override public function initView() : void
      {
         _roleView = new GoddessRoleView(this);
         _roleView.visible = true;
      }
      
      public function get heroRoleInfo() : HeroRoleInfo
      {
         return _heroRoleInfo;
      }
      
      public function set heroRoleInfo(param1:HeroRoleInfo) : void
      {
         _heroRoleInfo = param1;
         if(param1)
         {
            this.pos = param1.pos;
            this.face = param1.face;
            this.side = param1.side;
         }
      }
      
      public function get userRoleInfo() : HeroRoleInfo
      {
         return battleModel.getRoleById(userLivingId) as HeroRoleInfo;
      }
      
      override public function get isLiving() : Boolean
      {
         return super.isLiving;
      }
      
      override public function set isLiving(param1:Boolean) : void
      {
         super.isLiving = param1;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _visible = param1;
         if(_roleView)
         {
            _roleView.visible = _visible;
         }
      }
      
      override public function showBody() : void
      {
         if(_roleView && visible)
         {
            _roleView.visible = true;
         }
      }
      
      override public function updateBlood(param1:Number, param2:int, param3:Boolean = false, param4:int = 6, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false) : void
      {
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      override public function get roleName() : String
      {
         return name;
      }
   }
}


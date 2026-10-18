package yishi.datas.objects
{
   import battle.view.roles.PawnRoleView;
   import flash.events.IEventDispatcher;
   import manager.LanguageMgr;
   import yishi.datas.PawnViewType;
   import yishi.events.RoleEvent;
   import yishi.manager.TempleteManager;
   
   public class PawnRoleInfo extends RoleInfo
   {
      
      public var level:int;
      
      private var _tempInfo:Object;
      
      private var _count:int;
      
      private var _armyType:int;
      
      public function PawnRoleInfo(param1:IEventDispatcher = null)
      {
         var vSwf:String;
         var vResourceError:String;
         var target:IEventDispatcher = param1;
         super(target);
         vSwf = "swf";
         vResourceError = LanguageMgr.GetTranslation("yishi.datas.objects.PawnRoleInfo.vResourceError",vSwf);
         actionMovie.errorCallBack = function():void
         {
            throw new Error(vResourceError + _tempInfo.Swf + "!");
         };
      }
      
      override public function initView() : void
      {
         _roleView = new PawnRoleView(this);
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
         _count = param1 < 0 ? 0 : param1;
         dispatchEvent(new RoleEvent("count",param1));
      }
      
      public function get tempInfo() : Object
      {
         return _tempInfo;
      }
      
      override public function set templateId(param1:int) : void
      {
         _templateId = param1;
         initTempInfoAndEffeInfo();
      }
      
      public function get armyType() : int
      {
         return _armyType;
      }
      
      public function set armyType(param1:int) : void
      {
         _armyType = param1;
         if(_templateId != 0)
         {
            initTempInfoAndEffeInfo();
         }
      }
      
      private function initTempInfoAndEffeInfo() : void
      {
         _tempInfo = TempleteManager.instance.pawnTemplateCate.getTemplateByID(_templateId);
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.datas.objects.PawnRoleInfo.vArmyModuleError");
         if(_tempInfo == null)
         {
            throw new Error(_loc1_ + _templateId);
         }
         if(int(PawnViewType.swf) > 0)
         {
            _tempInfo.Swf = PawnViewType.swf;
         }
         effectId = _tempInfo.Swf;
      }
      
      override public function clone() : RoleInfo
      {
         var _loc1_:PawnRoleInfo = new PawnRoleInfo();
         _loc1_.livingId = livingId;
         _loc1_.templateId = templateId;
         _loc1_.armyType = armyType;
         _loc1_.side = side;
         _loc1_.pos = pos;
         return _loc1_;
      }
   }
}


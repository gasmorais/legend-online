package yishi.datas.objects
{
   import battle.view.roles.MonsterRoleView;
   import flash.events.IEventDispatcher;
   import manager.LanguageMgr;
   import yishi.datas.templates.MonsterTempInfo;
   import yishi.manager.TempleteManager;
   
   public class MonsterRoleInfo extends HeroRoleInfo
   {
      
      public var userLivingId:int;
      
      public var monsterId:int;
      
      public var name:String;
      
      public var isFollowHero:Boolean;
      
      private var _monsterTempId:int;
      
      public var isCaptain:Boolean;
      
      private var _tempInfo:MonsterTempInfo;
      
      public function MonsterRoleInfo(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      override public function initView() : void
      {
         _roleView = new MonsterRoleView(this);
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      private function checkResLoad() : void
      {
         var vSwf:String = "swf";
         var vResourceError:String = LanguageMgr.GetTranslation("yishi.datas.objects.PawnRoleInfo.vResourceError",vSwf);
         actionMovie.errorCallBack = function():void
         {
            throw new Error(vResourceError + tempInfo.ResPath + "!");
         };
      }
      
      public function get tempInfo() : MonsterTempInfo
      {
         return _tempInfo;
      }
      
      public function get monsterTempId() : int
      {
         return _monsterTempId;
      }
      
      public function set monsterTempId(param1:int) : void
      {
         _monsterTempId = param1;
         _tempInfo = TempleteManager.instance.monsterTempCate.getTemplateById(_monsterTempId);
      }
   }
}


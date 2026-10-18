package mvc.module.childnswar
{
   import yishi.utils.SimpleDictionary;
   
   public class ChildNswarBattleInfo
   {
      
      private var _battleRoleList:SimpleDictionary;
      
      public var battleId:String;
      
      public var buffId:int;
      
      public function ChildNswarBattleInfo()
      {
         super();
         _battleRoleList = new SimpleDictionary();
      }
      
      public function get battleRoleList() : SimpleDictionary
      {
         return _battleRoleList;
      }
      
      public function clear() : void
      {
         _battleRoleList.clear();
         battleId = "-1";
         buffId = -1;
      }
   }
}


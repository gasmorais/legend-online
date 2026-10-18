package mvc.module.theseus
{
   import yishi.datas.templates.WarSoulReformTempInfo;
   import yishi.datas.templates.WarSoulStarTempInfo;
   import yishi.datas.templates.WarSoulStrengthenTempInfo;
   import yishi.datas.templates.WarSoulTempInfo;
   import yishi.manager.TempleteManager;
   
   public class TheseusWarsoulItemInfo
   {
      
      public var id:int;
      
      public var learnSkill:int;
      
      public var ramdomSkills:String;
      
      public var isEquip:Boolean;
      
      public var isExist:Boolean;
      
      public var objectId:int;
      
      public var num:int;
      
      public var newLearnSkill:int;
      
      private var _warSoulId:int = -1;
      
      private var _warTempInfo:WarSoulTempInfo;
      
      private var _star:int = -1;
      
      private var _warStartempInfo:WarSoulStarTempInfo;
      
      private var _strengthen:int = -1;
      
      private var _warStrengthTempInfo:WarSoulStrengthenTempInfo;
      
      private var _reform:int = -1;
      
      private var _warReformTempInfo:WarSoulReformTempInfo;
      
      private var _reformBuff:String;
      
      private var _reformBuffList:Array = [];
      
      private var _isLock:Boolean;
      
      public function TheseusWarsoulItemInfo()
      {
         super();
      }
      
      public function get reformBuffList() : Array
      {
         return _reformBuffList;
      }
      
      public function get reformBuff() : String
      {
         return _reformBuff;
      }
      
      public function set reformBuff(param1:String) : void
      {
         if(_reformBuff == param1)
         {
            return;
         }
         _reformBuff = param1;
         if(_reformBuff && _reformBuff.length > 0)
         {
            _reformBuffList = _reformBuff.split("|");
         }
         else
         {
            _reformBuffList.length = 0;
         }
      }
      
      public function get warReformTempInfo() : WarSoulReformTempInfo
      {
         return _warReformTempInfo;
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
      }
      
      public function get reform() : int
      {
         return _reform;
      }
      
      public function set reform(param1:int) : void
      {
         if(_reform == param1)
         {
            return;
         }
         _reform = param1;
         _warReformTempInfo = TempleteManager.instance.warsoulReformCate.getTemp(_warSoulId,_reform);
      }
      
      public function get warStrengthTempInfo() : WarSoulStrengthenTempInfo
      {
         return _warStrengthTempInfo;
      }
      
      public function get strengthen() : int
      {
         return _strengthen;
      }
      
      public function set strengthen(param1:int) : void
      {
         if(_strengthen == param1)
         {
            return;
         }
         _strengthen = param1;
         _warStrengthTempInfo = TempleteManager.instance.warsoulStrengthenCate.getTemp(_warSoulId,_strengthen);
      }
      
      public function get star() : int
      {
         return _star;
      }
      
      public function set star(param1:int) : void
      {
         if(_star == param1)
         {
            return;
         }
         _star = param1;
         _warStartempInfo = TempleteManager.instance.warsoulStarCate.getTemp(_warSoulId,_star);
      }
      
      public function get warStartempInfo() : WarSoulStarTempInfo
      {
         return _warStartempInfo;
      }
      
      public function get warSoulId() : int
      {
         return _warSoulId;
      }
      
      public function set warSoulId(param1:int) : void
      {
         if(_warSoulId == param1)
         {
            return;
         }
         _warSoulId = param1;
         _warTempInfo = TempleteManager.instance.warsoulCate.getTempInfoById(_warSoulId);
      }
      
      public function get warTempInfo() : WarSoulTempInfo
      {
         return _warTempInfo;
      }
      
      public function clone() : TheseusWarsoulItemInfo
      {
         var _loc1_:TheseusWarsoulItemInfo = new TheseusWarsoulItemInfo();
         _loc1_.id = id;
         _loc1_.warSoulId = warSoulId;
         _loc1_.star = star;
         _loc1_.strengthen = strengthen;
         _loc1_.reform = reform;
         _loc1_.learnSkill = learnSkill;
         _loc1_.ramdomSkills = ramdomSkills;
         _loc1_.isEquip = isEquip;
         _loc1_.isExist = isExist;
         _loc1_.isLock = isLock;
         return _loc1_;
      }
   }
}


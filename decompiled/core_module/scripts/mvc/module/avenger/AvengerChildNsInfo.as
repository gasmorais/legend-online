package mvc.module.avenger
{
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   
   public class AvengerChildNsInfo
   {
      
      public var childId:int;
      
      public var grade:int;
      
      public var exp:int;
      
      public var stageGrade:int;
      
      public var liveGrade:int;
      
      public var attackGrade:int;
      
      public var defenseGrade:int;
      
      public var magicDefenseGrade:int;
      
      public var point:int;
      
      public var skills:String;
      
      public var skillTempDic:SimpleDictionary;
      
      public var skillExpDic:SimpleDictionary;
      
      public var clientFlg:int = -1;
      
      public function AvengerChildNsInfo()
      {
         super();
         skillTempDic = new SimpleDictionary();
         skillExpDic = new SimpleDictionary();
      }
      
      public function resolveSkills() : void
      {
         var _loc1_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:SkillTempInfo = null;
         var _loc4_:int = 0;
         skillTempDic.clear();
         skillExpDic.clear();
         if(StringHelper.isNullOrEmpty(skills))
         {
            return;
         }
         var _loc2_:Array = skills.split("|");
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc4_].split(",");
            _loc5_ = int(_loc1_[0]);
            _loc3_ = int(_loc1_[1]);
            _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc5_);
            skillTempDic.add(_loc6_.Index,_loc6_);
            skillExpDic.add(_loc6_.Index,_loc3_);
            _loc4_++;
         }
      }
      
      public function get addLive() : int
      {
         return liveGrade * 1500;
      }
      
      public function get addDefence() : int
      {
         return defenseGrade * 200;
      }
      
      public function get addMagicDefence() : int
      {
         return magicDefenseGrade * 200;
      }
      
      public function get addAttack() : int
      {
         return attackGrade * 200;
      }
      
      public function get childData() : ChildData
      {
         return ChildManager.instance.model.getChildById(childId);
      }
      
      public function get childTemp() : ChildTempInfo
      {
         if(childData)
         {
            return childData.childTempInfo;
         }
         return null;
      }
      
      public function get profileGrade() : int
      {
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(stageGrade,157);
         return _loc1_ ? _loc1_.ActiveObject : 0;
      }
   }
}


package mvc.module.monster
{
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MonsterTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.MonsterManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class MonsterInfo
   {
      
      public var monsterId:int;
      
      public var name:String;
      
      public var isExist:Boolean;
      
      public var enterWar:Boolean;
      
      public var firstValue:int;
      
      public var isLock:Boolean;
      
      public var type:int;
      
      public var star:int;
      
      public var grade:int;
      
      public var curExp:int;
      
      public var fightPower:Number;
      
      public var stageGrade:int;
      
      public var stageExp:int;
      
      public var skillExpValue:String;
      
      public var isFollow:Boolean;
      
      public var skillIds:Array;
      
      public var skillExps:Array;
      
      public var maxExp:int;
      
      public var stageMaxExp:int;
      
      public function MonsterInfo()
      {
         super();
      }
      
      public function get typeIndex() : int
      {
         var _loc5_:Array = null;
         var _loc1_:Array = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(232);
         var _loc2_:int = -1;
         loop0:
         for each(var _loc3_:GoodsTemplateInfo in _loc1_)
         {
            if(_loc2_ > 0)
            {
               break;
            }
            _loc5_ = _loc3_.Job.split(",");
            var _loc7_:int = 0;
            var _loc6_:Array = _loc5_;
            do
            {
               for each(var _loc4_:int in _loc6_)
               {
               }
               continue loop0;
            }
            while(type != _loc4_);
            _loc2_ = _loc3_.Property6;
         }
         return _loc2_;
      }
      
      public function setOtherData() : void
      {
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         var _loc2_:Array = null;
         skillIds = [];
         skillExps = [];
         if(!StringHelper.isNullOrEmpty(skillExpValue))
         {
            _loc1_ = skillExpValue.split("|");
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc2_ = _loc1_[_loc3_].split(",");
               skillIds.push(_loc2_[0]);
               skillExps.push(_loc2_[1]);
               _loc3_++;
            }
         }
      }
      
      public function get tempInfo() : MonsterTempInfo
      {
         return TempleteManager.instance.monsterTempCate.getTemplateByTypeAndStar(type,star);
      }
      
      public function get skillAry() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:SkillTempInfo = null;
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < skillIds.length)
         {
            _loc2_ = int(skillIds[_loc3_]);
            _loc4_ = TempleteManager.instance.skillTemplateDic[_loc2_];
            _loc1_.push(_loc4_);
            _loc3_++;
         }
         _loc1_.sortOn("SonType",16);
         return _loc1_;
      }
      
      public function get activeSkillAry() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:SkillTempInfo = null;
         if(!tempInfo)
         {
            return [];
         }
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < skillIds.length)
         {
            _loc2_ = int(skillIds[_loc3_]);
            _loc4_ = TempleteManager.instance.skillTemplateDic[_loc2_];
            if(tempInfo.SkillSonTypes.indexOf(_loc4_.SonType + "") != -1)
            {
               _loc1_.push(_loc4_);
            }
            _loc3_++;
         }
         _loc1_.sortOn("SonType",16);
         return _loc1_;
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
   }
}


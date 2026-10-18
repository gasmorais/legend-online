package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ChildPveBossTempInfo;
   
   public class ChildPveBossTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var skills:Array;
      
      public function ChildPveBossTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateById(param1:int) : ChildPveBossTempInfo
      {
         var _loc3_:* = null;
         var _loc2_:XML = null;
         if(param1 <= 0)
         {
            return null;
         }
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@id == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,ChildPveBossTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getAllSkillId() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(!skills)
         {
            skills = [];
            if(_list)
            {
               _loc2_ = 0;
               while(_loc2_ < _list.length())
               {
                  _loc1_ = int(_list[_loc2_].@activeSkill);
                  if(_loc1_ != 0)
                  {
                     if(!isContains(skills,_loc1_))
                     {
                        skills.push(_loc1_);
                     }
                  }
                  _loc2_++;
               }
            }
         }
         return skills;
      }
      
      public function getChildPveSkillUnlockGrade(param1:int) : int
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 999;
         if(_list)
         {
            _loc5_ = 0;
            while(_loc5_ < _list.length())
            {
               _loc3_ = int(_list[_loc5_].@activeSkill);
               _loc4_ = int(_list[_loc5_].@grade);
               if(_loc3_ != 0)
               {
                  if(param1 == _loc3_ && _loc4_ < _loc2_)
                  {
                     _loc2_ = _loc4_;
                  }
               }
               _loc5_++;
            }
         }
         return _loc2_;
      }
      
      private function isContains(param1:Array, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param2 == param1[_loc3_])
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
   }
}


package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusTreasureCoreInfo;
   
   public class TheseusTreasureCoreCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusTreasureCoreCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TemplateId + "";
               _dic[_loc2_] = createNode(_loc1_,TheseusTreasureCoreInfo,_tempXml) as TheseusTreasureCoreInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfoByLevel(param1:int) : TheseusTreasureCoreInfo
      {
         var _loc2_:TheseusTreasureCoreInfo = null;
         for each(var _loc3_:TheseusTreasureCoreInfo in _dic)
         {
            if(_loc3_.Level == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function getSkillGrade(param1:int) : int
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         for each(var _loc4_:TheseusTreasureCoreInfo in _dic)
         {
            if(!(_loc4_.CoreSkills == "" || _loc4_.CoreSkills == "0"))
            {
               _loc2_ = _loc4_.CoreSkills.split(",");
               if(_loc2_.length == param1)
               {
                  if(_loc3_ == 0 || _loc3_ > _loc4_.Level)
                  {
                     _loc3_ = _loc4_.Level;
                  }
               }
            }
         }
         return _loc3_;
      }
   }
}


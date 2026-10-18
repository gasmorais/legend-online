package yishi.datas.templates.cate
{
   import yishi.datas.templates.GodTreasureTemInfo;
   import yishi.utils.SimpleDictionary;
   
   public class GodTreasureTemplateCate extends TemplateCate
   {
      
      private var _dic:SimpleDictionary;
      
      private var _tempXml:XML;
      
      private var _grades:Array;
      
      public function GodTreasureTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new SimpleDictionary();
      }
      
      public function getTemplates() : SimpleDictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Grade;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,GodTreasureTemInfo,_tempXml);
               }
            }
         }
         _loc2_ = null;
         return _dic;
      }
      
      public function get grades() : Array
      {
         if(!_grades)
         {
            _grades = [];
            getTemplates();
            for each(var _loc1_:GodTreasureTemInfo in _dic)
            {
               if(_loc1_.phase >= 1)
               {
                  _grades.push(_loc1_);
               }
            }
         }
         return _grades;
      }
      
      public function getItemByGrade(param1:int) : GodTreasureTemInfo
      {
         var _loc3_:String = null;
         if(_list)
         {
            for each(var _loc2_:XML in _list)
            {
               _loc3_ = _loc2_.@Grade;
               if(!_dic[_loc3_])
               {
                  _dic[_loc3_] = createNode(_loc2_,GodTreasureTemInfo,_tempXml);
               }
            }
         }
         _loc3_ = null;
         return _dic[param1];
      }
   }
}


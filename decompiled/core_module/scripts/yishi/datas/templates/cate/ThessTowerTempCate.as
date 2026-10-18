package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ThessTowerTempInfo;
   
   public class ThessTowerTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _maxLevel:int;
      
      public function ThessTowerTempCate(param1:XMLList)
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
               if(int(_loc1_.@LevelId) > _maxLevel)
               {
                  _maxLevel = int(_loc1_.@LevelId);
               }
               _loc2_ = _loc1_.@LevelId + "";
               _dic[_loc2_] = createNode(_loc1_,ThessTowerTempInfo,_tempXml) as ThessTowerTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTemplateById(param1:int) : ThessTowerTempInfo
      {
         return _dic[param1 + ""];
      }
      
      public function get maxLevel() : int
      {
         return _maxLevel;
      }
   }
}


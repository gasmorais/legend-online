package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.WarSoulTowerLevelTempInfo;
   
   public class WarSoulTowerLevelTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function WarSoulTowerLevelTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@LevelId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,WarSoulTowerLevelTempInfo,_tempXml);
               }
            }
         }
         _list = null;
         return _dic;
      }
      
      public function get max() : int
      {
         var _loc3_:Dictionary = getTemplates();
         var _loc1_:int = 0;
         for each(var _loc2_:WarSoulTowerLevelTempInfo in _loc3_)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function getTempInfoByLevelId(param1:int) : WarSoulTowerLevelTempInfo
      {
         var _loc3_:Dictionary = getTemplates();
         for each(var _loc2_:WarSoulTowerLevelTempInfo in _loc3_)
         {
            if(_loc2_.LevelId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}


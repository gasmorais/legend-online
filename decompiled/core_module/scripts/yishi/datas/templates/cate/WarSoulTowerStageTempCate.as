package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.WarSoulTowerStageTempInfo;
   
   public class WarSoulTowerStageTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function WarSoulTowerStageTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,WarSoulTowerStageTempInfo,_tempXml);
               }
            }
         }
         _list = null;
         return _dic;
      }
      
      public function getInfoArr() : Array
      {
         var _loc2_:Dictionary = getTemplates();
         var _loc1_:Array = [];
         for each(var _loc3_:WarSoulTowerStageTempInfo in _loc2_)
         {
            _loc1_.push(_loc3_);
         }
         _loc1_.sortOn("LevelId",16);
         return _loc1_;
      }
      
      public function getTempInfoByLevelId(param1:int) : WarSoulTowerStageTempInfo
      {
         var _loc3_:Dictionary = getTemplates();
         for each(var _loc2_:WarSoulTowerStageTempInfo in _loc3_)
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


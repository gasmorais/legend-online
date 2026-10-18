package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   
   public class ChristmasActivitiesTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ChristmasActivitiesTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : ChristmasActivitiesTempInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Id == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,ChristmasActivitiesTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTemplatesByType(param1:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_:ChristmasActivitiesTempInfo in getTemplates())
         {
            if(_loc2_.MasterType == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sortOn("Id",16);
         return _loc3_;
      }
      
      public function getRewardByType(param1:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_:ChristmasActivitiesTempInfo in getTemplates())
         {
            if(_loc2_.MasterType == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sortOn("Id",16);
         return _loc3_;
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
                  _dic[_loc2_] = createNode(_loc1_,ChristmasActivitiesTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}


package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ForbiddenBossTempInfo;
   
   public class ForbiddenBossTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ForbiddenBossTempCate(param1:XMLList)
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
                  _dic[_loc2_] = createNode(_loc1_,ForbiddenBossTempInfo,_tempXml);
               }
            }
         }
         _list = null;
         return _dic;
      }
      
      public function getTempInfoByCategory(param1:int) : Array
      {
         var _loc4_:Dictionary = getTemplates();
         var _loc2_:Array = [];
         for each(var _loc3_:ForbiddenBossTempInfo in _loc4_)
         {
            if(_loc3_.Category == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("BAV",16);
         return _loc2_;
      }
      
      public function getTempInfoById(param1:int) : ForbiddenBossTempInfo
      {
         var _loc3_:Dictionary = getTemplates();
         for each(var _loc2_:ForbiddenBossTempInfo in _loc3_)
         {
            if(_loc2_.Id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getTempInfoByCampaignId(param1:int) : ForbiddenBossTempInfo
      {
         var _loc3_:Dictionary = getTemplates();
         for each(var _loc2_:ForbiddenBossTempInfo in _loc3_)
         {
            if(_loc2_.CampaignId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}


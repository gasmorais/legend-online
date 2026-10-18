package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SpiritExpeditionTempInfo;
   
   public class SpiritExpeditionTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SpiritExpeditionTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByAreaAndNode(param1:int, param2:int) : SpiritExpeditionTempInfo
      {
         var _loc4_:* = null;
         var _loc3_:XML = null;
         if(param1 == 0 || param2 == 0)
         {
            return null;
         }
         var _loc5_:String = param1 + "_" + param2;
         if(_list)
         {
            if(!_dic[_loc5_])
            {
               _loc3_ = _list.(@AreaId == param1 && @NodeId == param2)[0];
               if(_loc3_)
               {
                  _dic[_loc5_] = createNode(_loc3_,SpiritExpeditionTempInfo,_tempXml);
               }
            }
         }
         return _dic[_loc5_];
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@AreaId + "_" + _loc1_.@NodeId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,SpiritExpeditionTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getChapterListByAreaId(param1:int) : Array
      {
         var _loc4_:Dictionary = getTemplates();
         var _loc2_:Array = [];
         for each(var _loc3_:SpiritExpeditionTempInfo in _loc4_)
         {
            if(_loc3_.AreaId == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("NodeId",16);
         return _loc2_;
      }
   }
}


package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropSortInfo;
   import yishi.datas.templates.GamehallEastDropTemplate;
   
   public class GamehallEastShopTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GamehallEastShopTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesAry() : Array
      {
         var _loc5_:CommonDropSortInfo = null;
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc2_:GamehallEastDropTemplate in getTemplates())
         {
            if(!_loc3_[_loc2_.para2])
            {
               _loc5_ = new CommonDropSortInfo();
               _loc1_.push(_loc5_);
               _loc3_[_loc2_.para2] = _loc5_;
            }
            else
            {
               _loc5_ = _loc3_[_loc2_.para2];
            }
            _loc4_ = int(_loc2_.para2.split(",")[0]);
            _loc5_.sort = _loc4_;
            _loc5_.rankTitle = _loc2_.para2;
            _loc5_.dropAry.push(_loc2_);
         }
         _loc1_.sortOn("sort",16);
         return _loc1_;
      }
      
      public function getTemplateByID(param1:int) : GamehallEastDropTemplate
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@id == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,GamehallEastDropTemplate,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,GamehallEastDropTemplate,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}


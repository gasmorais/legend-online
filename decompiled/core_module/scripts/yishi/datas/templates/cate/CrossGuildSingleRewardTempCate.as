package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropSortInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class CrossGuildSingleRewardTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function CrossGuildSingleRewardTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesAry() : Array
      {
         var _loc4_:CommonDropSortInfo = null;
         var _loc1_:Array = [];
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc2_:CommonDropTempInfo in getTemplates())
         {
            if(_loc2_.site != 1)
            {
               if(!_loc3_[_loc2_.site])
               {
                  _loc4_ = new CommonDropSortInfo();
                  _loc1_.push(_loc4_);
                  _loc3_[_loc2_.site] = _loc4_;
               }
               else
               {
                  _loc4_ = _loc3_[_loc2_.site];
               }
               _loc4_.sort = _loc2_.site;
               _loc4_.rankTitle = _loc2_.site + "";
               _loc4_.dropAry.push(_loc2_);
            }
         }
         _loc1_.sortOn("sort",16);
         return _loc1_;
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
                  _dic[_loc2_] = createNode(_loc1_,CommonDropTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}


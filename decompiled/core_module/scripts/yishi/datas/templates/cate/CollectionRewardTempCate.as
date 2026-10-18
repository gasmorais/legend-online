package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CollectionRewardTemplateInfo;
   
   public class CollectionRewardTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var arr:Array;
      
      public function CollectionRewardTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         arr = [];
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Id + "";
               _dic[_loc2_] = createNode(_loc1_,CollectionRewardTemplateInfo,_tempXml) as CollectionRewardTemplateInfo;
               arr.push(_dic[_loc2_]);
            }
         }
      }
      
      public function getallGoods() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:CollectionRewardTemplateInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("Level",16);
         return _loc1_;
      }
      
      public function getTemplateByID(param1:int) : CollectionRewardTemplateInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Id == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,CollectionRewardTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1] as CollectionRewardTemplateInfo;
      }
   }
}


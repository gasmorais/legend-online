package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import mvc.module.theseus.TheseusCollectionStarInfo;
   
   public class CollectionTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var arr:Array;
      
      public function CollectionTempCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,TheseusCollectionStarInfo,_tempXml) as TheseusCollectionStarInfo;
               arr.push(_dic[_loc2_]);
            }
         }
      }
      
      public function getTempArray() : Array
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,TheseusCollectionStarInfo,_tempXml);
               }
               arr.push(_loc2_);
            }
         }
         return arr;
      }
      
      public function getTemplateByProfile(param1:int) : Array
      {
         var _loc2_:XML = null;
         var _loc3_:Array = [];
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Quality == param1)[0];
               if(_loc2_)
               {
                  _loc3_.push(createNode(_loc2_,TheseusCollectionStarInfo,_tempXml));
               }
            }
         }
         return _loc3_;
      }
      
      public function getTemplateByID(param1:int, param2:int) : TheseusCollectionStarInfo
      {
         var _loc3_:XML = null;
         var _loc4_:String = param1 * 1000 + param2 + "";
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc3_ = _list.(@TemplateID == param1 && @Star == param2)[0];
               if(_loc3_)
               {
                  _dic[param1] = createNode(_loc3_,TheseusCollectionStarInfo,_tempXml);
               }
            }
         }
         return _dic[_loc4_];
      }
   }
}


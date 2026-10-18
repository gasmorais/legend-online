package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import mvc.module.theseus.TheseusCollectionSuitInfo;
   
   public class CollectionSuitTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var arr:Array;
      
      public function CollectionSuitTempCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,TheseusCollectionSuitInfo,_tempXml) as TheseusCollectionSuitInfo;
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
                  _dic[_loc2_] = createNode(_loc1_,TheseusCollectionSuitInfo,_tempXml);
               }
               arr.push(_dic[_loc2_]);
            }
         }
         return arr;
      }
      
      public function getTemplateByID(param1:int) : TheseusCollectionSuitInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@Id == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,TheseusCollectionSuitInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}


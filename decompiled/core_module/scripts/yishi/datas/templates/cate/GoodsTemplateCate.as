package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GoodsTemplateInfo;
   
   public class GoodsTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GoodsTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TemplateId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,GoodsTemplateInfo,_tempXml);
               }
            }
         }
         _loc2_ = null;
      }
      
      public function getTemplates() : Dictionary
      {
         return _dic;
      }
      
      public function getTemplateByID(param1:int) : GoodsTemplateInfo
      {
         var _loc2_:XML = null;
         if(param1 == 0)
         {
            return null;
         }
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,GoodsTemplateInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getGoodsTemplatesBySonType(param1:int) : Array
      {
         var _loc2_:Array = [];
         if(_dic)
         {
            for each(var _loc3_:GoodsTemplateInfo in _dic)
            {
               if(_loc3_.SonType == param1)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getGoodsTemplatesBySonTypeAndP2(param1:int) : Array
      {
         var _loc2_:Array = [];
         if(_dic)
         {
            for each(var _loc3_:GoodsTemplateInfo in _dic)
            {
               if(_loc3_.SonType == param1 && _loc3_.Property2 == 1)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getGoodsTemplatesBySonTypeAndProperty1(param1:int, param2:int) : GoodsTemplateInfo
      {
         var _loc4_:GoodsTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc3_:Array = getGoodsTemplatesBySonType(param1);
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc5_] as GoodsTemplateInfo;
            if(_loc4_.Property1 == param2)
            {
               return _loc4_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function getGoodsTemplatesBySonTypeAndProperty2(param1:int, param2:int) : GoodsTemplateInfo
      {
         var _loc4_:GoodsTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc3_:Array = getGoodsTemplatesBySonType(param1);
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc5_] as GoodsTemplateInfo;
            if(_loc4_.Property2 == param2)
            {
               return _loc4_;
            }
            _loc5_++;
         }
         return null;
      }
   }
}


package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.StelaResistTemplateInfo;
   import yishi.utils.SimpleDictionary;
   
   public class StelaResistTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function StelaResistTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc4_:String = null;
         var _loc1_:String = null;
         var _loc3_:SimpleDictionary = null;
         var _loc5_:StelaResistTemplateInfo = null;
         if(_list)
         {
            for each(var _loc2_:XML in _list)
            {
               _loc4_ = _loc2_.@StelaId + "";
               _loc3_ = _dic[_loc4_];
               if(_loc3_ == null)
               {
                  _loc3_ = new SimpleDictionary();
                  _dic[_loc4_] = _loc3_;
               }
               _loc1_ = _loc2_.@StelaId + "_" + _loc2_.@StrengthLevel;
               _loc5_ = createNode(_loc2_,StelaResistTemplateInfo,_tempXml) as StelaResistTemplateInfo;
               _loc3_.add(_loc1_,_loc5_);
            }
         }
         _list = null;
      }
      
      public function getTemplateById(param1:int, param2:int) : StelaResistTemplateInfo
      {
         var _loc3_:String = param1 + "";
         var _loc4_:String = param1 + "_" + param2;
         var _loc5_:SimpleDictionary = _dic[_loc3_];
         if(_loc5_)
         {
            return _loc5_[_loc4_];
         }
         return null;
      }
      
      public function getListById(param1:int) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:String = param1 + "";
         var _loc4_:SimpleDictionary = _dic[_loc3_];
         if(_loc4_)
         {
            _loc2_ = _loc4_.getList();
            _loc2_.sortOn("StrengthLevel",16);
         }
         return _loc2_;
      }
   }
}


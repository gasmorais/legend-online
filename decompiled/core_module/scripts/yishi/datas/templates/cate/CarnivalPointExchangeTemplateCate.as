package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CarnivalPointExchangeTemplateInfo;
   
   public class CarnivalPointExchangeTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _isInit:Boolean;
      
      private var _typeDic:Dictionary;
      
      public function CarnivalPointExchangeTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _typeDic = new Dictionary();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         _isInit = true;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = "" + _loc1_.@Id;
               _dic[_loc2_] = createNode(_loc1_,CarnivalPointExchangeTemplateInfo,_tempXml) as CarnivalPointExchangeTemplateInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfo(param1:int) : CarnivalPointExchangeTemplateInfo
      {
         if(!_isInit)
         {
            initTemplates();
         }
         var _loc2_:String = "" + param1;
         return _dic[_loc2_];
      }
      
      public function getTempListByType(param1:int) : Array
      {
         if(!_isInit)
         {
            initTemplates();
         }
         if(_typeDic[param1])
         {
            return _typeDic[param1];
         }
         var _loc2_:Array = [];
         _typeDic[param1] = _loc2_;
         for each(var _loc3_:CarnivalPointExchangeTemplateInfo in _dic)
         {
            if(_loc3_.Type == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("Sort",16);
         return _loc2_;
      }
   }
}


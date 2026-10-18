package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.MagicSpringFormulaTempInfo;
   
   public class MagicSpringFormulaTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function MagicSpringFormulaTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesArray() : Array
      {
         var _loc3_:Array = [];
         var _loc2_:Dictionary = getTemplates();
         for each(var _loc1_:MagicSpringFormulaTempInfo in _loc2_)
         {
            if(_loc1_.IsActive)
            {
               _loc3_.push(_loc1_);
            }
         }
         _loc3_.sortOn(["NeedGrade","TemplateId"],[16,16]);
         return _loc3_;
      }
      
      public function getTemplateById(param1:int) : MagicSpringFormulaTempInfo
      {
         var _loc2_:XML = null;
         if(!_dic[param1] && _list)
         {
            _loc2_ = _list.(@TemplateId == param1)[0];
            if(_loc2_)
            {
               _dic[param1] = createNode(_loc2_,MagicSpringFormulaTempInfo,_tempXml);
            }
         }
         return _dic[param1] as MagicSpringFormulaTempInfo;
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TemplateId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,MagicSpringFormulaTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}


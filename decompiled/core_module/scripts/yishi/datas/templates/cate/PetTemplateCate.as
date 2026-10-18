package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.PetTemplate;
   
   public class PetTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _group:Dictionary;
      
      private var _tempXml:XML;
      
      public function PetTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _group = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               if(!_dic[String(_loc1_.@TemplateId)])
               {
                  _dic[String(_loc1_.@TemplateId)] = createNode(_loc1_,PetTemplate,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateById(param1:int) : PetTemplate
      {
         var _loc3_:* = null;
         if(param1 <= 0)
         {
            return null;
         }
         if(!_dic[param1] && _list)
         {
            _loc3_ = _list.(@TemplateId == param1);
            var _loc9_:int = 0;
            var _loc8_:* = _loc3_;
            for each(var _loc2_:XML in _loc8_)
            {
               _dic[String(_loc2_.@TemplateId)] = createNode(_loc2_,PetTemplate,_tempXml);
            }
         }
         return _dic[param1];
      }
      
      public function getQualityGradeTemplate(param1:PetTemplate, param2:int) : PetTemplate
      {
         if(!param1)
         {
            return null;
         }
         var _loc4_:Vector.<PetTemplate> = getPetTemplatesByType(param1.PetType);
         for each(var _loc3_:PetTemplate in _loc4_)
         {
            if(_loc3_.TemplateName == param1.TemplateName && _loc3_.Quality == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getPetTemplatesByType(param1:int) : Vector.<PetTemplate>
      {
         var _loc3_:Dictionary = getTemplates();
         var _loc5_:String = "type:" + param1;
         var _loc4_:Vector.<PetTemplate> = _group[_loc5_];
         if(!_loc4_)
         {
            _loc4_ = new Vector.<PetTemplate>();
            for each(var _loc2_:PetTemplate in _loc3_)
            {
               if(_loc2_.PetType == param1)
               {
                  _loc4_.push(_loc2_);
               }
            }
            _group[_loc5_] = _loc4_;
         }
         return _loc4_;
      }
      
      public function getTemplateByTNQ(param1:int, param2:int, param3:int) : PetTemplate
      {
         var _loc4_:* = null;
         if(!_dic)
         {
            getTemplates();
         }
         for each(_loc4_ in _dic)
         {
            if(_loc4_.PetType == param1 && _loc4_.NeedGrade == param2 && _loc4_.Quality == param3 && _loc4_.Property2 == 0)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getPetTemplatesBySonType(param1:int) : Vector.<PetTemplate>
      {
         var _loc3_:Dictionary = getTemplates();
         var _loc5_:String = "sonType:" + param1;
         var _loc4_:Vector.<PetTemplate> = _group[_loc5_];
         if(!_loc4_)
         {
            _loc4_ = new Vector.<PetTemplate>();
            for each(var _loc2_:PetTemplate in _loc3_)
            {
               if(_loc2_.SonType == param1)
               {
                  _loc4_.push(_loc2_);
               }
            }
            _group[_loc5_] = _loc4_;
         }
         return _loc4_;
      }
      
      public function getPetTemplatesBySontypeAndQuality(param1:int, param2:int) : PetTemplate
      {
         var _loc4_:Dictionary = getTemplates();
         for each(var _loc3_:PetTemplate in _loc4_)
         {
            if(_loc3_.SonType == param1 && _loc3_.Quality == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}


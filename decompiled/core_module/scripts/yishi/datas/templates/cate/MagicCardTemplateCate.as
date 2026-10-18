package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import yishi.datas.templates.MagicCardTemplateInfo;
   
   public class MagicCardTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _typeCount:int = 0;
      
      private var _maxGP:int;
      
      private var _maxPos:int;
      
      public function MagicCardTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _tempXml = describeType(MagicCardTemplateInfo);
      }
      
      public function get maxPos() : int
      {
         return _maxPos;
      }
      
      public function get maxGP() : int
      {
         return _maxGP;
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TemplateId + _loc1_.@Grades;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,MagicCardTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function get typeCount() : int
      {
         var _loc2_:int = 0;
         if(_typeCount == 0)
         {
            _loc2_ = 0;
            for each(var _loc1_:MagicCardTemplateInfo in getTemplates())
            {
               if(_loc1_.Types > _loc2_)
               {
                  _loc2_ = _loc1_.Types;
               }
               if(_loc1_.Grades > _maxGP)
               {
                  _maxGP = _loc1_.Grades;
               }
               if(_loc1_.Pos > _maxPos)
               {
                  _maxPos = _loc1_.Pos;
               }
            }
            _typeCount = _loc2_;
         }
         return _typeCount;
      }
      
      public function get cardCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 1;
         while(_loc2_ <= typeCount)
         {
            _loc1_ += getMaxPosByType(_loc2_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getTempInfoByTypePosGrades(param1:int, param2:int, param3:int) : MagicCardTemplateInfo
      {
         var _loc5_:MagicCardTemplateInfo = null;
         for each(var _loc4_:MagicCardTemplateInfo in getTemplates())
         {
            if(_loc4_.Types == param1 && _loc4_.Pos == param2 && _loc4_.Grades == param3)
            {
               _loc5_ = _loc4_;
               break;
            }
         }
         return _loc5_;
      }
      
      public function getInfoByIdAndGardes(param1:int, param2:int) : MagicCardTemplateInfo
      {
         var _loc4_:MagicCardTemplateInfo = null;
         for each(var _loc3_:MagicCardTemplateInfo in getTemplates())
         {
            if(_loc3_.TemplateId == param1 && _loc3_.Grades == param2)
            {
               _loc4_ = _loc3_;
               break;
            }
         }
         return _loc4_;
      }
      
      public function getTemplateByID(param1:int) : MagicCardTemplateInfo
      {
         var _loc2_:XML = null;
         if(!_dic[param1] && _list)
         {
            _loc2_ = _list.(@TemplateId == param1)[0];
            if(_loc2_)
            {
               _dic[param1] = createNode(_loc2_,MagicCardTemplateInfo,_tempXml);
            }
         }
         return _dic[param1] as MagicCardTemplateInfo;
      }
      
      public function getMaxPosByType(param1:int) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_:MagicCardTemplateInfo in getTemplates())
         {
            if(_loc3_.Types == param1 && _loc3_.Pos > _loc2_)
            {
               _loc2_ = _loc3_.Pos;
            }
         }
         return _loc2_;
      }
   }
}


package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.StelaPropertyTemplateInfo;
   
   public class StelaPropertyTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function StelaPropertyTemplateCate(param1:XMLList)
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
               _loc2_ = _loc1_.@StelaId + "_" + _loc1_.@StrengthLevel;
               _dic[_loc2_] = createNode(_loc1_,StelaPropertyTemplateInfo,_tempXml) as StelaPropertyTemplateInfo;
            }
         }
         _list = null;
      }
      
      public function getTemplateById(param1:int, param2:int) : StelaPropertyTemplateInfo
      {
         var _loc3_:String = param1 + "_" + param2;
         return _dic[_loc3_];
      }
      
      public function getCeilLvByExp(param1:int, param2:int, param3:int) : int
      {
         var _loc7_:StelaPropertyTemplateInfo = null;
         var _loc6_:String = null;
         var _loc4_:int = param2;
         var _loc5_:Boolean = true;
         while(_loc5_)
         {
            _loc6_ = param1 + "_" + (_loc4_ + 1);
            _loc7_ = _dic[_loc6_];
            if(_loc7_ == null)
            {
               _loc5_ = false;
            }
            else if(_loc7_.Exp > param3)
            {
               _loc5_ = false;
            }
            else if(_loc7_.Exp == param3)
            {
               _loc5_ = false;
               _loc4_++;
            }
            else
            {
               _loc4_++;
            }
         }
         return _loc4_;
      }
   }
}


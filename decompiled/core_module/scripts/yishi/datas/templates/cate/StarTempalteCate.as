package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.StarTemplate;
   
   public class StarTempalteCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function StarTempalteCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : StarTemplate
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,StarTemplate,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getStarTemplatesByPoint(param1:int, param2:Boolean = false) : Array
      {
         var _loc6_:* = null;
         var _loc7_:String = null;
         var _loc3_:Array = [];
         checkFirst();
         if(_list)
         {
            _loc6_ = _list.(@StarPoint > param1);
            for each(var _loc4_:XML in _loc6_)
            {
               _loc7_ = _loc4_.@TemplateId;
               if(!_dic[_loc7_])
               {
                  _dic[_loc7_] = createNode(_loc4_,StarTemplate,_tempXml);
               }
               _loc3_.push(_dic[_loc7_]);
            }
         }
         else
         {
            for each(var _loc5_:StarTemplate in _dic)
            {
               if(_loc5_.StarPoint > param1)
               {
                  _loc3_.push(_loc5_);
               }
            }
         }
         _loc3_.sort(tempCompare);
         return _loc3_;
      }
      
      private function tempCompare(param1:StarTemplate, param2:StarTemplate) : int
      {
         if(!param1 || !param2)
         {
            return 0;
         }
         if(param1.Profile == 6 || param1.Profile > param2.Profile)
         {
            return -1;
         }
         return 1;
      }
   }
}


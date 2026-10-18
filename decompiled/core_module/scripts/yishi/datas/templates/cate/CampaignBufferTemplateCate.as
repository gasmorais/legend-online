package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CampaignBufferTemp;
   
   public class CampaignBufferTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function CampaignBufferTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : CampaignBufferTemp
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,CampaignBufferTemp,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
      
      public function getTemplateByType(param1:int) : Array
      {
         var _loc4_:* = null;
         var _loc5_:String = null;
         checkFirst();
         var _loc2_:Array = [];
         if(_list)
         {
            _loc4_ = _list.(@Types == param1);
            for each(var _loc3_:XML in _loc4_)
            {
               _loc5_ = _loc3_.@TemplateId;
               if(!_dic[_loc5_])
               {
                  _dic[_loc5_] = createNode(_loc3_,CampaignBufferTemp,_tempXml);
               }
               _loc2_.push(_dic[_loc5_]);
            }
         }
         return _loc2_;
      }
      
      public function getTemplateByTypeAndGrades(param1:int, param2:int) : CampaignBufferTemp
      {
         var _loc5_:CampaignBufferTemp = null;
         var _loc4_:* = null;
         var _loc6_:String = null;
         checkFirst();
         if(_list)
         {
            _loc4_ = _list.(@Types == param1);
            for each(var _loc3_:XML in _loc4_)
            {
               _loc6_ = _loc3_.@TemplateId;
               if(!_dic[_loc6_])
               {
                  _dic[_loc6_] = createNode(_loc3_,CampaignBufferTemp,_tempXml);
               }
               if((_dic[_loc6_] as CampaignBufferTemp).Types == param1 && (_dic[_loc6_] as CampaignBufferTemp).Grades == param2)
               {
                  _loc5_ = _dic[_loc6_] as CampaignBufferTemp;
               }
            }
         }
         return _loc5_;
      }
   }
}


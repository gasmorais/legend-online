package yishi.datas.templates.cate
{
   import com.road.pb.helper.army.ThaneInfoHelper;
   import yishi.datas.templates.FirstChargeTemplate;
   
   public class FirstPayDropTempalteCate extends TemplateCate
   {
      
      private var _dic:Array;
      
      public function FirstPayDropTempalteCate(param1:XMLList)
      {
         super(param1);
         _dic = [];
      }
      
      public function getTemplatesListByJob(param1:int) : Array
      {
         var _loc3_:* = null;
         var _loc4_:FirstChargeTemplate = null;
         if(_list && _dic.length <= 0)
         {
            _loc3_ = _list.(@job == ThaneInfoHelper.getJob(param1));
            for each(var _loc2_:XML in _loc3_)
            {
               _loc4_ = new FirstChargeTemplate();
               _loc4_.ItemId = _loc2_.@itemid;
               _loc4_.Job = _loc2_.@job;
               _loc4_.Count = _loc2_.@counts;
               _dic.push(_loc4_);
            }
         }
         return _dic;
      }
   }
}


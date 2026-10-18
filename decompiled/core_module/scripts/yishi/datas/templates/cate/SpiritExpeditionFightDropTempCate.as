package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class SpiritExpeditionFightDropTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SpiritExpeditionFightDropTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByAreaAndNode(param1:int, param2:int) : Array
      {
         var _loc4_:CommonDropTempInfo = null;
         var _loc5_:String = param1 + "_" + param2;
         if(_list)
         {
            if(!_dic[_loc5_])
            {
               _dic[_loc5_] = [];
               for each(var _loc3_:XML in _list)
               {
                  if(int(_loc3_.@site) == param1 && int(_loc3_.@para2) == param2)
                  {
                     _loc4_ = createNode(_loc3_,CommonDropTempInfo) as CommonDropTempInfo;
                     _dic[_loc5_].push(_loc4_);
                  }
               }
            }
         }
         return _dic[_loc5_];
      }
   }
}


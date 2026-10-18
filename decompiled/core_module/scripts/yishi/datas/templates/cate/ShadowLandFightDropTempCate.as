package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   
   public class ShadowLandFightDropTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ShadowLandFightDropTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByAreaDiffNode(param1:int, param2:int, param3:int) : Array
      {
         var _loc6_:CommonDropTempInfo = null;
         var _loc4_:String = null;
         var _loc7_:String = param1 + "_" + param2 + "_" + param3;
         if(_list)
         {
            if(!_dic[_loc7_])
            {
               _dic[_loc7_] = [];
               _loc4_ = param1 + "," + param3;
               for each(var _loc5_:XML in _list)
               {
                  if(int(_loc5_.@site) == param2 && _loc5_.@para2 == _loc4_)
                  {
                     _loc6_ = createNode(_loc5_,CommonDropTempInfo) as CommonDropTempInfo;
                     _dic[_loc7_].push(_loc6_);
                  }
               }
            }
         }
         return _dic[_loc7_];
      }
   }
}


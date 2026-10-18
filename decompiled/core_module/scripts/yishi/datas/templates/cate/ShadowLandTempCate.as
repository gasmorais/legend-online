package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ShadowLandTempInfo;
   
   public class ShadowLandTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ShadowLandTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         getTemplates();
      }
      
      public function getTemplateByAreaDiffNode(param1:int, param2:int, param3:int) : ShadowLandTempInfo
      {
         var _loc5_:* = null;
         var _loc4_:XML = null;
         if(param1 == 0 || param2 == 0 || param3 == 0)
         {
            return null;
         }
         var _loc6_:String = param1 + "_" + param2 + "_" + param3;
         if(_list)
         {
            if(!_dic[_loc6_])
            {
               _loc4_ = _list.(@AreaId == param1 && @Difficulty == param2 && @NodeId == param3)[0];
               if(_loc4_)
               {
                  _dic[_loc6_] = createNode(_loc4_,ShadowLandTempInfo,_tempXml);
               }
            }
         }
         return _dic[_loc6_];
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@AreaId + "_" + _loc1_.@Difficulty + "_" + _loc1_.@NodeId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,ShadowLandTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getChapterListByAreaIdDiff(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:ShadowLandTempInfo in _dic)
         {
            if(_loc4_.AreaId == param1 && _loc4_.Difficulty == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         _loc3_.sortOn("NodeId",16);
         return _loc3_;
      }
   }
}


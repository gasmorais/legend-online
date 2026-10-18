package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ApexRewardDropTemp;
   import yishi.utils.HashMap;
   
   public class ApexRewardDropTempCate extends TemplateCate
   {
      
      private var _tempDroplist:Array;
      
      private var _rankDic:Dictionary;
      
      private var _tempXml:XML;
      
      private var gradeMap:HashMap;
      
      private var turnMap:HashMap;
      
      public function ApexRewardDropTempCate(param1:XMLList)
      {
         super(param1);
         _tempDroplist = [];
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc1_:Array = null;
         var _loc3_:ApexRewardDropTemp = null;
         if(_list)
         {
            gradeMap = new HashMap();
            turnMap = new HashMap();
            for each(var _loc2_:XML in _list)
            {
               _loc3_ = createNode(_loc2_,ApexRewardDropTemp,_tempXml) as ApexRewardDropTemp;
               _tempDroplist.push(_loc3_);
               if(_loc3_.isGradeData)
               {
                  _loc1_ = gradeMap.getValue(_loc3_.site) as Array;
                  if(!_loc1_)
                  {
                     _loc1_ = [];
                  }
                  _loc1_.push(_loc3_);
                  gradeMap.put(_loc3_.site,_loc1_);
               }
               else
               {
                  _loc1_ = turnMap.getValue(_loc3_.site) as Array;
                  if(!_loc1_)
                  {
                     _loc1_ = [];
                  }
                  _loc1_.push(_loc3_);
                  turnMap.put(_loc3_.site,_loc1_);
               }
            }
         }
         _list = null;
      }
      
      public function getGradeDrop(param1:int) : Array
      {
         return gradeMap.getValue(param1) as Array;
      }
      
      public function getTurnDrop(param1:int, param2:int) : Array
      {
         return turnMap.getValue(param1 + "" + param2) as Array;
      }
   }
}

